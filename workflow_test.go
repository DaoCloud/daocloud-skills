package dceskills_test

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"reflect"
	"testing"

	"github.com/lathe-cli/lathe/pkg/config"
	"github.com/lathe-cli/lathe/pkg/runtime"
)

func TestModelServingSummaryWorkflowContract(t *testing.T) {
	root := buildRoot(t)
	command, ok := runtime.FindCatalogCommand(root, []string{"model-serving-summary"}, runtime.CatalogOptions{})
	if !ok {
		t.Fatal("model-serving-summary workflow is not in the command catalog")
	}
	if command.Kind != "workflow" {
		t.Fatalf("catalog kind = %q, want workflow", command.Kind)
	}
	if command.Workflow == nil {
		t.Fatal("workflow metadata is missing from the command catalog")
	}
	if got, want := command.Workflow.OutputFrom, "${steps.servings}"; got != want {
		t.Fatalf("output_from = %q, want %q", got, want)
	}
	if got, want := command.Workflow.Steps, []runtime.CatalogWorkflowStep{
		{ID: "model", OperationID: "AdminModelManagement_GetModel", HTTP: runtime.CatalogHTTP{Method: "GET", PathTemplate: "/apis/admin.hydra.io/v1alpha1/models/{modelId}"}},
		{ID: "servings", OperationID: "AdminModelManagement_ListModelServingsByModel", HTTP: runtime.CatalogHTTP{Method: "GET", PathTemplate: "/apis/admin.hydra.io/v1alpha1/models/{modelId}/servings"}},
	}; !reflect.DeepEqual(got, want) {
		t.Fatalf("workflow steps = %#v, want %#v", got, want)
	}
}

func TestModelServingSummaryPassesModelIDBetweenSteps(t *testing.T) {
	var requests []string
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		requests = append(requests, r.Method+" "+r.URL.Path)
		if got, want := r.Header.Get("Authorization"), "Bearer test-token"; got != want {
			t.Errorf("Authorization = %q, want %q", got, want)
		}
		w.Header().Set("Content-Type", "application/json")
		switch r.URL.Path {
		case "/apis/admin.hydra.io/v1alpha1/models/requested-model":
			_, _ = w.Write([]byte(`{"modelId":"resolved-model"}`))
		case "/apis/admin.hydra.io/v1alpha1/models/resolved-model/servings":
			_, _ = w.Write([]byte(`{"items":[{"workspaceId":"workspace-1"}]}`))
		default:
			http.NotFound(w, r)
		}
	}))
	defer srv.Close()

	t.Setenv("DCE_CONFIG_DIR", t.TempDir())
	root := buildRoot(t)
	hosts, err := config.LoadHosts()
	if err != nil {
		t.Fatalf("load hosts: %v", err)
	}
	hosts.Set(srv.URL, config.HostEntry{AuthType: "bearer", OAuthToken: "test-token"})
	if err := hosts.Save(); err != nil {
		t.Fatalf("save test host: %v", err)
	}

	var stdout bytes.Buffer
	root.SetOut(&stdout)
	root.SetArgs([]string{"--hostname", srv.URL, "--output", "json", "model-serving-summary", "--model-id", "requested-model"})
	if err := root.Execute(); err != nil {
		t.Fatalf("execute workflow: %v", err)
	}

	if got, want := requests, []string{
		"GET /apis/admin.hydra.io/v1alpha1/models/requested-model",
		"GET /apis/admin.hydra.io/v1alpha1/models/resolved-model/servings",
	}; !reflect.DeepEqual(got, want) {
		t.Fatalf("requests = %#v, want %#v", got, want)
	}

	var output struct {
		Items []struct {
			WorkspaceID string `json:"workspaceId"`
		} `json:"items"`
	}
	if err := json.Unmarshal(stdout.Bytes(), &output); err != nil {
		t.Fatalf("decode workflow output %q: %v", stdout.String(), err)
	}
	if len(output.Items) != 1 || output.Items[0].WorkspaceID != "workspace-1" {
		t.Fatalf("workflow output = %s", stdout.String())
	}
}
