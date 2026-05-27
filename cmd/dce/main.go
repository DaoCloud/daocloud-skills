package main

import (
	"errors"
	"fmt"
	"os"

	"github.com/lathe-cli/lathe/pkg/config"
	"github.com/lathe-cli/lathe/pkg/lathe"
	"github.com/lathe-cli/lathe/pkg/runtime"

	dceskills "github.com/DaoCloud/daocloud-skills"
	generated "github.com/DaoCloud/daocloud-skills/internal/generated"
)

var (
	Version = "dev"
	Commit  = "none"
	Date    = "unknown"
)

func main() {
	m, err := config.Load(dceskills.CLIConfig)
	if err != nil {
		fmt.Fprintln(os.Stderr, "error:", err)
		os.Exit(1)
	}
	config.Bind(m)

	lathe.Version = Version
	lathe.Commit = Commit
	lathe.Date = Date

	root := lathe.NewApp(m)
	if err := generated.MountModules(root); err != nil {
		fmt.Fprintln(os.Stderr, "error:", err)
		os.Exit(1)
	}

	if err := root.Execute(); err != nil {
		if errors.Is(err, runtime.ErrNotAuthenticated) {
			fmt.Fprintf(os.Stderr, "not logged in — run: dce auth login --hostname <host>\n")
			os.Exit(2)
		}
		os.Exit(1)
	}
}
