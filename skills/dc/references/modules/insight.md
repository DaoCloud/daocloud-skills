# Module `insight`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `4bc92dd4c0c1637b4257f69e26eb8dd6cdd269f3`
- Files: `docs/openapi/insight/v0.41.0.json`
- Resolved SHA: `4bc92dd4c0c1637b4257f69e26eb8dd6cdd269f3`

## Alert

### `dc insight alert add-group-rule`

- Summary: Add a rule to an existing group
- HTTP: `POST /apis/insight.io/v1alpha1/alert/groups/{id}/rules`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): required;
- Example: `echo '{ "rule": { "name": "HighMem", "severity": "WARNING", "duration": "5m", "expr": "node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes < 0.1", "description": "memory low", "labels": {"team":"ops"}, "annotations": {"summary":"low memory on {{ $labels.instance }}"} } }' | dc insight alert add-group-rule --id <gid> --file -`

### `dc insight alert clean-alert-history`

- Summary: Trigger cleanup of alert history (respects retention config)
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/history/clean`
- Auth: required
- Body: none
- Flags: none
- Example: `dc insight alert clean-alert-history`

### `dc insight alert count-alert`

- Summary: Count alerts grouped by time/severity/target
- HTTP: `GET /apis/insight.io/v1alpha1/alert/alertcount`
- Auth: required
- Body: none
- Flags:
  - `--resolved` (query): resolved
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): namespace
  - `--target-type` (query, default `TARGET_TYPE_UNSPECIFIED`, one of: TARGET_TYPE_UNSPECIFIED|GLOBAL|CLUSTER|NAMESPACE|NODE|DEPLOYMENT|STATEFULSET|DAEMONSET|POD): targetType
  - `--target` (query): target
  - `--severity` (query, default `SEVERITY_UNSPECIFIED`, one of: SEVERITY_UNSPECIFIED|CRITICAL|WARNING|INFO): severity
  - `--start` (query, int64): start == 0 means from 1970.01.01
  - `--end` (query, int64): end
  - `--step` (query, int64): step unit is minute
  - `--group-by-type` (query): groupByType
- Output: list path `data`; columns `end`, `start`
- Example: `# Count CRITICAL alerts in cluster within a time range (unix seconds) dc insight alert count-alert \ --cluster-name prod-1 \ --severity CRITICAL \ --start 1700000000 --end 1700600000 --step 60 \ --group-by-type=true`

### `dc insight alert create-group`

- Summary: Create an alert group (with rules / receivers)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/groups`
- Auth: required
- Body: required
- Flags: none
- Output: list path `notifyRepeatConfig`; columns `interval`, `severity`
- Example: `echo '{ "name": "node-health", "clusterName": "prod-1", "namespace": "insight-system", "description": "Node health alerts", "targetType": "NODE", "targets": ["*"], "receivers": [ {"type": "email", "names": ["ops-mail"]} ], "notifyRepeatConfig": [ {"severity": "CRITICAL", "interval": 300} ], "rules": [ { "name": "NodeDown", "description": "node unreachable for 5m", "severity": "CRITICAL", "duration": "5m", "expr": "up{job=\"node-exporter\"} == 0", "labels": {"team": "ops"}, "annotations": {"summary": "Node {{ $labels.instance }} down"} } ] }' | dc insight alert create-group --file -`

### `dc insight alert create-inhibition`

- Summary: Create an inhibition rule (source matchers suppress target matchers)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/inhibitions`
- Auth: required
- Body: required
- Flags: none
- Output: list path `equal`
- Example: `echo '{ "name": "cluster-down-suppresses-node", "clusterName": "prod-1", "namespace": "insight-system", "description": "if cluster is down, suppress node-level alerts", "equal": ["clusterName"], "sourceMatchers": [{"type":"=","key":"alertname","value":"ClusterDown"}], "targetMatchers": [{"type":"=","key":"severity","value":"WARNING"}] }' | dc insight alert create-inhibition --file -`

### `dc insight alert create-provider`

- Summary: Create an SMS provider
- HTTP: `POST /apis/insight.io/v1alpha1/alert/providers`
- Auth: required
- Body: required
- Flags: none
- Example: `echo '{ "name": "aliyun-sms", "type": "aliyun", "template": "default", "aliyun": { "accessKeyId": "AKID...", "accessKeySecret": "SECRET...", "signName": "MyCompany", "templateCode": "SMS_123" } }' | dc insight alert create-provider --file -`

### `dc insight alert create-receiver`

- Summary: Create a notification receiver (email/dingtalk/wecom/webhook/lark/sms/message)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/receivers`
- Auth: required
- Body: required
- Flags: none
- Example: `# Email receiver echo '{ "name": "ops-mail", "type": "email", "description": "ops mailing list", "email": {"to": ["ops@example.com"]} }' | dc insight alert create-receiver --file - # Webhook receiver with bearer token echo '{ "name": "my-webhook", "type": "webhook", "webhook": { "url": "https://hooks.example.com/insight", "httpConfig": { "bearerToken": "xxx", "tlsConfig": {"insecureSkipVerify": false} } } }' | dc insight alert create-receiver --file -`

### `dc insight alert create-rule-template`

- Summary: Create a rule template (bundle of rules)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/rule-templates`
- Auth: required
- Body: required
- Flags: none
- Output: list path `rules`; columns `name`, `description`, `duration`, `expr`, `logFilterCondition`, `logQueryString`
- Example: `echo '{ "name": "node-basics", "description": "basic node alerts", "targetType": "NODE", "rules": [ {"name":"NodeDown","severity":"CRITICAL","duration":"5m","expr":"up == 0"}, {"name":"NodeHighLoad","severity":"WARNING","duration":"10m","expr":"node_load5 > 8"} ] }' | dc insight alert create-rule-template --file -`

### `dc insight alert create-silence`

- Summary: Create an alert silence (label matchers + optional schedule)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/silences`
- Auth: required
- Body: required
- Flags: none
- Output: list path `matches`; columns `type`, `key`, `value`
- Example: `echo '{ "name": "maint-window", "clusterName": "prod-1", "namespace": "insight-system", "description": "weekly maintenance", "matches": [ {"type": "=", "key": "alertname", "value": "HighCPU"}, {"type": "=~", "key": "instance", "value": "node-.*"} ], "activeTimeInterval": { "weekdayRange": [0], "timeRanges": [{"start":"02:00","end":"04:00"}] } }' | dc insight alert create-silence --file -`

### `dc insight alert create-template`

- Summary: Create a notification template (body per channel)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/templates`
- Auth: required
- Body: required
- Flags: none
- Example: `echo '{ "name": "crit-email", "description": "critical alert template", "body": { "email": { "subject": "[CRITICAL] {{ .CommonLabels.alertname }}", "body": "{{ range .Alerts }}{{ .Annotations.summary }}\n{{ end }}" }, "dingtalk": "**[CRITICAL]** {{ .CommonLabels.alertname }}", "wecom": "[CRITICAL] {{ .CommonLabels.alertname }}" } }' | dc insight alert create-template --file -`

### `dc insight alert delete-group`

- Summary: Delete an alert group
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/groups/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Example: `dc insight alert delete-group --id <gid>`

### `dc insight alert delete-group-rule`

- Summary: Delete a rule from a group
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/groups/{id}/rules/{name}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): required; id is group id
  - `--name` (path, required): required; name is rule name
- Example: `dc insight alert delete-group-rule --id <gid> --name HighCPU`

### `dc insight alert delete-inhibition`

- Summary: Delete an inhibition rule
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/inhibitions/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Example: `dc insight alert delete-inhibition --id <iid>`

### `dc insight alert delete-provider`

- Summary: Delete an SMS provider
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/providers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dc insight alert delete-provider --name aliyun-sms`

### `dc insight alert delete-receiver`

- Summary: Delete a notification receiver
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/receivers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dc insight alert delete-receiver --name ops-mail`

### `dc insight alert delete-rule-template`

- Summary: Delete a rule template
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/rule-templates/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Example: `dc insight alert delete-rule-template --id <rtid>`

### `dc insight alert delete-silence`

- Summary: Delete an alert silence
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/silences/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Example: `dc insight alert delete-silence --id <sid>`

### `dc insight alert delete-template`

- Summary: Delete a notification template
- HTTP: `DELETE /apis/insight.io/v1alpha1/alert/templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dc insight alert delete-template --name crit-email`

### `dc insight alert get-alert`

- Summary: Get a single alert by ID
- HTTP: `GET /apis/insight.io/v1alpha1/alert/alerts/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int64): id
  - `--resolved` (query): resolved
- Example: `dc insight alert get-alert --id <alertId> dc insight alert get-alert --id <alertId> --resolved=true`

### `dc insight alert get-group`

- Summary: Get an alert group by ID
- HTTP: `GET /apis/insight.io/v1alpha1/alert/groups/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Output: list path `notifyRepeatConfig`; columns `interval`, `severity`
- Example: `dc insight alert get-group --id <gid> dc insight alert get-group --id <gid> -o json`

### `dc insight alert get-group-rule`

- Summary: Get a single rule by group id + rule name
- HTTP: `GET /apis/insight.io/v1alpha1/alert/groups/{id}/rules/{name}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): required; id is group id
  - `--name` (path, required): required; name is rule name
- Example: `dc insight alert get-group-rule --id <gid> --name HighCPU`

### `dc insight alert get-inhibition`

- Summary: Get an inhibition by ID
- HTTP: `GET /apis/insight.io/v1alpha1/alert/inhibitions/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Output: list path `equal`
- Example: `dc insight alert get-inhibition --id <iid> dc insight alert get-inhibition --id <iid> -o json`

### `dc insight alert get-provider`

- Summary: Get an SMS provider by name
- HTTP: `GET /apis/insight.io/v1alpha1/alert/providers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dc insight alert get-provider --name aliyun-sms dc insight alert get-provider --name aliyun-sms -o json`

### `dc insight alert get-receiver`

- Summary: Get a receiver by name
- HTTP: `GET /apis/insight.io/v1alpha1/alert/receivers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--type` (query, default `RECEIVER_TYPE_UNSPECIFIED`, one of: RECEIVER_TYPE_UNSPECIFIED|webhook|email|dingtalk|wecom|sms|message|lark): type
- Example: `dc insight alert get-receiver --name ops-mail # Disambiguate when same name exists across types dc insight alert get-receiver --name ops-mail --type email -o json`

### `dc insight alert get-rule-template`

- Summary: Get a rule template by ID
- HTTP: `GET /apis/insight.io/v1alpha1/alert/rule-templates/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Output: list path `rules`; columns `name`, `description`, `duration`, `expr`, `logFilterCondition`, `logQueryString`
- Example: `dc insight alert get-rule-template --id <rtid> dc insight alert get-rule-template --id <rtid> -o json`

### `dc insight alert get-silence`

- Summary: Get a silence by ID
- HTTP: `GET /apis/insight.io/v1alpha1/alert/silences/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Output: list path `matches`; columns `type`, `key`, `value`
- Example: `dc insight alert get-silence --id <sid> dc insight alert get-silence --id <sid> -o json`

### `dc insight alert get-smtp-status`

- Summary: Check whether SMTP is configured (required for email receivers)
- HTTP: `GET /apis/insight.io/v1alpha1/alert/smtp`
- Auth: required
- Body: none
- Flags: none
- Example: `dc insight alert get-smtp-status dc insight alert get-smtp-status -o json`

### `dc insight alert get-template`

- Summary: Get a notification template by name
- HTTP: `GET /apis/insight.io/v1alpha1/alert/templates/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dc insight alert get-template --name crit-email dc insight alert get-template --name crit-email -o json`

### `dc insight alert list-alerts`

- Summary: List alerts (active or historical)
- HTTP: `GET /apis/insight.io/v1alpha1/alert/alerts`
- Auth: required
- Body: none
- Flags:
  - `--resolved` (query): set resolved to True shows alert histories
  - `--group-name` (query): filter alerts by group name fuzzily
  - `--group-id` (query): filter alerts by group id
  - `--rule-name` (query): filter alerts by rule name fuzzily
  - `--rule-id` (query): filter alerts by rule id
  - `--cluster-name` (query): filter alerts by cluster name
  - `--namespace` (query): filter alerts by namespace
  - `--severity` (query, default `SEVERITY_UNSPECIFIED`, one of: SEVERITY_UNSPECIFIED|CRITICAL|WARNING|INFO): SEVERITY_UNSPECIFIED | CRITICAL | WARNING | INFO
  - `--target-type` (query, default `TARGET_TYPE_UNSPECIFIED`, one of: TARGET_TYPE_UNSPECIFIED|GLOBAL|CLUSTER|NAMESPACE|NODE|DEPLOYMENT|STATEFULSET|DAEMONSET|POD): TARGET_TYPE_UNSPECIFIED | GLOBAL | CLUSTER | NAMESPACE | NODE | DEPLOYMENT | STATEFULSET | DAEMONSET | POD
  - `--target` (query): filter alerts by target
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
  - `--status` (query): filter by alert's status
- Output: list path `items`; columns `namespace`, `id`, `builtin`, `clusterName`, `description`, `groupId`; pagination `offset`
- Example: `# Active alerts in a cluster dc insight alert list-alerts --cluster-name prod-1 --severity CRITICAL # Alert history (resolved=true) dc insight alert list-alerts --resolved=true --page 1 --page-size 50 -o json # Filter by group / rule dc insight alert list-alerts --group-id <gid> --rule-name "HighCPU"`

### `dc insight alert list-group-rules`

- Summary: List rules under an alert group
- HTTP: `GET /apis/insight.io/v1alpha1/alert/groups/{id}/rules`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--name` (query): filter rule by name
  - `--severity` (query, default `SEVERITY_UNSPECIFIED`, one of: SEVERITY_UNSPECIFIED|CRITICAL|WARNING|INFO): SEVERITY_UNSPECIFIED | CRITICAL | WARNING | INFO
  - `--status` (query, default `UNSPECIFIED`, one of: UNSPECIFIED|FIRING|ENABLED): UNSPECIFIED | FIRING | ENABLED
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
- Output: list path `items`; columns `name`, `id`, `createAt`, `description`, `duration`, `expr`; pagination `offset`
- Example: `# All rules in a group dc insight alert list-group-rules --id <gid> # Filter by name + severity dc insight alert list-group-rules --id <gid> --name HighCPU --severity CRITICAL # Only firing rules, paged dc insight alert list-group-rules --id <gid> --status FIRING --page 1 --page-size 50 -o json`

### `dc insight alert list-groups`

- Summary: List alert groups
- HTTP: `GET /apis/insight.io/v1alpha1/alert/groups`
- Auth: required
- Body: none
- Flags:
  - `--builtin` (query): builtin
  - `--name` (query): filter group by name
  - `--cluster-name` (query): filter alerts by cluster name
  - `--namespace` (query): filter alerts by namespace
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
- Output: list path `items`; columns `name`, `namespace`, `id`, `builtin`, `clusterName`, `createAt`; pagination `offset`
- Example: `# All alert groups dc insight alert list-groups # Filter by name (fuzzy) within a cluster + namespace dc insight alert list-groups --name node --cluster-name prod-1 --namespace insight-system # Only built-in groups, page through results dc insight alert list-groups --builtin=true --page 1 --page-size 50 -o json`

### `dc insight alert list-inhibitions`

- Summary: List inhibition rules
- HTTP: `GET /apis/insight.io/v1alpha1/alert/inhibitions`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): name
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): namespace
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
- Output: list path `items`; columns `name`, `namespace`, `id`, `clusterName`, `createAt`, `description`; pagination `offset`
- Example: `dc insight alert list-inhibitions dc insight alert list-inhibitions --cluster-name prod-1 --namespace insight-system dc insight alert list-inhibitions --name cluster-down --page 1 --page-size 50 -o json`

### `dc insight alert list-providers`

- Summary: List SMS providers (Aliyun / Tencent / custom)
- HTTP: `GET /apis/insight.io/v1alpha1/alert/providers`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): filter template by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
  - `--exact-search` (query): exact search by name
- Output: list path `items`; columns `name`, `type`, `createAt`, `template`, `updateAt`; pagination `offset`
- Example: `dc insight alert list-providers dc insight alert list-providers --name aliyun --exact-search=true dc insight alert list-providers --page 1 --page-size 50 -o json`

### `dc insight alert list-receivers`

- Summary: List notification receivers
- HTTP: `GET /apis/insight.io/v1alpha1/alert/receivers`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): name
  - `--type` (query, default `RECEIVER_TYPE_UNSPECIFIED`, one of: RECEIVER_TYPE_UNSPECIFIED|webhook|email|dingtalk|wecom|sms|message|lark): RECEIVER_TYPE_UNSPECIFIED | webhook | email | dingtalk | wecom | sms | message | lark
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
  - `--exact-search` (query): exact search by name
- Output: list path `items`; columns `name`, `type`, `createAt`, `description`, `updateAt`; pagination `offset`
- Example: `# All receivers dc insight alert list-receivers # Only email receivers, exact name match dc insight alert list-receivers --type email --name ops-mail --exact-search=true # Paged JSON output dc insight alert list-receivers --page 1 --page-size 50 -o json`

### `dc insight alert list-rule-template-summary`

- Summary: List rule template summaries (id/name/targetType only)
- HTTP: `GET /apis/insight.io/v1alpha1/alert/rule-template-summary`
- Auth: required
- Body: none
- Flags:
  - `--target-type` (query, default `TARGET_TYPE_UNSPECIFIED`, one of: TARGET_TYPE_UNSPECIFIED|GLOBAL|CLUSTER|NAMESPACE|NODE|DEPLOYMENT|STATEFULSET|DAEMONSET|POD): filter by target type
- Output: list path `items`; columns `name`, `id`, `targetType`
- Example: `dc insight alert list-rule-template-summary dc insight alert list-rule-template-summary --target-type CLUSTER -o json`

### `dc insight alert list-rule-templates`

- Summary: List alert rule templates (reusable rule bundles)
- HTTP: `GET /apis/insight.io/v1alpha1/alert/rule-templates`
- Auth: required
- Body: none
- Flags:
  - `--builtin` (query): builtin
  - `--name` (query): filter group by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
  - `--target-type` (query, default `TARGET_TYPE_UNSPECIFIED`, one of: TARGET_TYPE_UNSPECIFIED|GLOBAL|CLUSTER|NAMESPACE|NODE|DEPLOYMENT|STATEFULSET|DAEMONSET|POD): TARGET_TYPE_UNSPECIFIED | GLOBAL | CLUSTER | NAMESPACE | NODE | DEPLOYMENT | STATEFULSET | DAEMONSET | POD
- Output: list path `items`; columns `name`, `id`, `count`, `createAt`, `description`, `targetType`; pagination `offset`
- Example: `dc insight alert list-rule-templates dc insight alert list-rule-templates --target-type NODE --builtin=false dc insight alert list-rule-templates --name node --page 1 --page-size 50 -o json`

### `dc insight alert list-silences`

- Summary: List alert silences
- HTTP: `GET /apis/insight.io/v1alpha1/alert/silences`
- Auth: required
- Body: none
- Flags:
  - `--expired` (query): set "expired" to false show silences that vaild for now, otherwise show
  - `--name` (query): name
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): namespace
- Output: list path `items`; columns `name`, `namespace`, `id`, `clusterName`, `createAt`, `description`
- Example: `# All silences (active and expired) dc insight alert list-silences # Only currently-active silences dc insight alert list-silences --expired=false # Filter by cluster + namespace dc insight alert list-silences --cluster-name prod-1 --namespace insight-system -o json`

### `dc insight alert list-template-summary`

- Summary: List notification template summaries (lightweight)
- HTTP: `GET /apis/insight.io/v1alpha1/alert/template-summary`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): filter template by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
  - `--exact-search` (query): exact search by name
  - `--builtin` (query): search builtin only
- Output: list path `items`; columns `name`, `builtin`, `description`, `updateAt`; pagination `offset`
- Example: `dc insight alert list-template-summary dc insight alert list-template-summary --builtin=true -o json`

### `dc insight alert list-templates`

- Summary: List notification templates
- HTTP: `GET /apis/insight.io/v1alpha1/alert/templates`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): filter template by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, support multiple sort option.
  - `--exact-search` (query): exact search by name
  - `--builtin` (query): search builtin only
- Output: list path `items`; columns `name`, `builtin`, `createAt`, `description`, `updateAt`; pagination `offset`
- Example: `dc insight alert list-templates dc insight alert list-templates --name crit --exact-search=false dc insight alert list-templates --builtin=true --page 1 --page-size 50 -o json`

### `dc insight alert preview-rule`

- Summary: Preview a rule's evaluation (matrix output) before saving
- HTTP: `POST /apis/insight.io/v1alpha1/alert/rules/preview`
- Auth: required
- Body: required
- Flags: none
- Output: list path `matrix`
- Example: `echo '{ "group": {"clusterName":"prod-1","targetType":"CLUSTER","targets":["*"]}, "rule": {"expr":"vector(1)","duration":"1m","severity":"WARNING"}, "params":{"start":"1700000000","end":"1700001000","step":60} }' | dc insight alert preview-rule --file -`

### `dc insight alert preview-silence`

- Summary: Preview which alerts a silence definition would match
- HTTP: `POST /apis/insight.io/v1alpha1/alert/silences/preview`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `namespace`, `id`, `builtin`, `clusterName`, `description`, `groupId`
- Example: `echo '{ "clusterName": "prod-1", "namespace": "insight-system", "size": "20", "matches": [{"type":"=","key":"alertname","value":"HighCPU"}] }' | dc insight alert preview-silence --file -`

### `dc insight alert preview-template`

- Summary: Render a notification template against sample alert data
- HTTP: `POST /apis/insight.io/v1alpha1/alert/templates/preview`
- Auth: required
- Body: required
- Flags: none
- Example: `echo '{ "body": {"email":{"subject":"[T] {{ .CommonLabels.alertname }}","body":"x"}}, "data": { "status": "firing", "commonLabels": {"alertname":"HighCPU"}, "alerts": [{"status":"firing","labels":{"instance":"node1"},"annotations":{"summary":"cpu hot"}}] } }' | dc insight alert preview-template --file -`

### `dc insight alert test-receiver`

- Summary: Send a test message to a receiver definition
- HTTP: `POST /apis/insight.io/v1alpha1/alert/receivers/test`
- Auth: required
- Body: required
- Flags: none
- Example: `echo '{ "name": "ops-mail", "type": "email", "email": {"to": ["ops@example.com"]} }' | dc insight alert test-receiver --file -`

### `dc insight alert update-group`

- Summary: Update an alert group (description / receivers / notify only)
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/groups/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `notifyRepeatConfig`; columns `interval`, `severity`
- Example: `echo '{ "description": "updated", "notificationTemplate": "default", "receivers": [{"type":"email","names":["ops-mail"]}], "notifyRepeatConfig": [{"severity":"WARNING","interval":600}] }' | dc insight alert update-group --id <gid> --file -`

### `dc insight alert update-group-rule`

- Summary: Update a rule in a group
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/groups/{id}/rules/{name}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): required; id is group id
  - `--name` (path, required): required;
- Example: `echo '{ "severity": "CRITICAL", "duration": "10m", "expr": "rate(http_requests_total{code=~\"5..\"}[5m]) > 1", "description": "5xx rate too high" }' | dc insight alert update-group-rule --id <gid> --name HighErr --file -`

### `dc insight alert update-inhibition`

- Summary: Update an inhibition rule
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/inhibitions/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `equal`
- Example: `echo '{ "description": "updated suppression", "equal": ["clusterName", "namespace"], "sourceMatchers": [{"type":"=","key":"alertname","value":"ClusterDown"}], "targetMatchers": [{"type":"=~","key":"severity","value":"WARNING|INFO"}] }' | dc insight alert update-inhibition --id <iid> --file -`

### `dc insight alert update-provider`

- Summary: Update an SMS provider
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/providers/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Example: `echo '{ "type": "aliyun", "template": "default", "aliyun": { "accessKeyId": "AKID...", "accessKeySecret": "NEW_SECRET", "signName": "MyCompany", "templateCode": "SMS_456" } }' | dc insight alert update-provider --name aliyun-sms --file -`

### `dc insight alert update-receiver`

- Summary: Update a notification receiver
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/receivers/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Example: `echo '{ "name": "ops-mail", "type": "email", "description": "updated mailing list", "email": {"to": ["ops@example.com", "oncall@example.com"]} }' | dc insight alert update-receiver --name ops-mail --file -`

### `dc insight alert update-rule-template`

- Summary: Update a rule template
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/rule-templates/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `rules`; columns `name`, `description`, `duration`, `expr`, `logFilterCondition`, `logQueryString`
- Example: `echo '{ "description": "updated node basics", "rules": [ {"name":"NodeDown","severity":"CRITICAL","duration":"10m","expr":"up == 0"}, {"name":"NodeHighLoad","severity":"WARNING","duration":"15m","expr":"node_load5 > 10"} ] }' | dc insight alert update-rule-template --id <rtid> --file -`

### `dc insight alert update-silence`

- Summary: Update an alert silence
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/silences/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `matches`; columns `type`, `key`, `value`
- Example: `echo '{ "description": "extended maintenance window", "matches": [ {"type": "=", "key": "alertname", "value": "HighCPU"}, {"type": "=~", "key": "instance", "value": "node-.*"} ], "activeTimeInterval": { "weekdayRange": [0, 6], "timeRanges": [{"start":"01:00","end":"05:00"}] } }' | dc insight alert update-silence --id <sid> --file -`

### `dc insight alert update-template`

- Summary: Update a notification template
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/templates/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Example: `echo '{ "description": "updated critical template", "body": { "email": { "subject": "[CRITICAL] {{ .CommonLabels.alertname }}", "body": "{{ range .Alerts }}{{ .Annotations.summary }}\n{{ end }}" } } }' | dc insight alert update-template --name crit-email --file -`

### `dc insight alert validate-group`

- Summary: Validate a group definition (PrometheusRule YAML)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/groups/validate`
- Auth: required
- Body: required
- Flags: none
- Output: list path `errors`; columns `code`, `message`
- Example: `echo '{ "clusterName": "prod-1", "namespace": "insight-system", "yamlString": "groups:\n- name: my\n rules:\n - alert: A\n expr: vector(1)\n" }' | dc insight alert validate-group --file -`

## Event

### `dc insight event get-reasons`

- Summary: Get the predefined event reason vocabulary grouped by object kind
- HTTP: `GET /apis/insight.io/v1alpha1/event/reasons`
- Auth: required
- Body: none
- Flags: none
- Output: list path `daemonSet`
- Example: `dc insight event get-reasons dc insight event get-reasons -o json`

### `dc insight event query-event-context`

- Summary: Fetch surrounding events around a specific timestamp (context view)
- HTTP: `GET /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/context`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--timestamp` (query): timestamp e.g. 2023-06-20T16:05:16.887681657Z
  - `--namespace` (query): Optional.
  - `--filter.type` (query, default `TYPE_UNSPECIFIED`, one of: TYPE_UNSPECIFIED|Normal|Warning): TYPE_UNSPECIFIED | Normal | Warning
  - `--filter.involve-object-kind` (query): filter.involveObjectKind
  - `--filter.reason` (query): filter.reason
  - `--filter.involve-object-name` (query): fuzzy search
  - `--filter.message` (query): fuzzy search
  - `--before` (query, int32): Optional.
  - `--after` (query, int32): Optional.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `action`, `clusterName`; pagination `cursor`
- Example: `# 20 events before and 20 after a specific timestamp dc insight event query-event-context \ --cluster-name prod-1 --namespace default \ --timestamp 2024-06-24T07:15:32.123456789Z \ --filter.type Warning --filter.involve-object-kind Pod \ --before 20 --after 20 -o json`

### `dc insight event query-event-count`

- Summary: Aggregate event counts in a time range (POST body supports multiple filters)
- HTTP: `POST /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/count`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `items`
- Example: `echo '{ "namespace": "default", "startTime": "2024-06-24T07:00:00Z", "endTime": "2024-06-24T08:00:00Z", "filters": [ {"type":"Warning","involveObjectKind":"Pod","reason":"FailedScheduling"}, {"type":"Warning","involveObjectKind":"Node"} ] }' | dc insight event query-event-count --cluster-name prod-1 --file -`

### `dc insight event query-event-filter-options`

- Summary: List available filter options (object kinds / reasons / etc.) for the event UI
- HTTP: `GET /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/filter-options`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--start-time` (query): startTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--end-time` (query): endTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--namespace` (query): Optional.
- Output: list path `involvedObjectKinds`
- Example: `dc insight event query-event-filter-options \ --cluster-name prod-1 --namespace default \ --start-time 2024-06-24T07:00:00Z --end-time 2024-06-24T08:00:00Z`

### `dc insight event query-event-histogram`

- Summary: Bucket event counts over time (normal vs warning)
- HTTP: `GET /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/histogram`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--start-time` (query): startTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--end-time` (query): endTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--interval` (query): interval e.g 1440s
  - `--namespace` (query): Optional.
- Output: list path `items`; columns `normalCount`, `timestamp`, `warningCount`
- Example: `dc insight event query-event-histogram \ --cluster-name prod-1 --namespace default \ --start-time 2024-06-24T07:00:00Z --end-time 2024-06-24T08:00:00Z \ --interval 60s -o json`

### `dc insight event query-events`

- Summary: Query K8s events of a cluster with filters and pagination
- HTTP: `GET /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--start-time` (query): startTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--end-time` (query): endTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--namespace` (query): Optional.
  - `--filter.type` (query, default `TYPE_UNSPECIFIED`, one of: TYPE_UNSPECIFIED|Normal|Warning): TYPE_UNSPECIFIED | Normal | Warning
  - `--filter.involve-object-kind` (query): filter.involveObjectKind
  - `--filter.reason` (query): filter.reason
  - `--filter.involve-object-name` (query): fuzzy search
  - `--filter.message` (query): fuzzy search
  - `--sort` (query): sort determines the data list order.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `action`, `clusterName`; pagination `offset`
- Example: `# All Warning events in a namespace in the last hour dc insight event query-events \ --cluster-name prod-1 --namespace default \ --start-time 2024-06-24T07:00:00Z --end-time 2024-06-24T08:00:00Z \ --filter.type Warning \ --page 1 --page-size 50 -o json # Fuzzy search by reason + involved object + message dc insight event query-events \ --cluster-name prod-1 --namespace default \ --filter.reason FailedScheduling \ --filter.involve-object-kind Pod \ --filter.involve-object-name my-app \ --filter.message 'insufficient memory' \ --sort 'metadata.creationTimestamp:desc'`

## FeatureGate

### `dc insight featuregate get-feature-gate-by-id`

- Summary: Get a single feature gate by ID
- HTTP: `GET /apis/insight.io/v1alpha1/feature-gates/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, one of: METRICS|LOGGING|TRACING|GRAPH_VIRTUAL_NODE|LOG_ALERT|NET_FLOW|EVENT|SLOW_SQL): id
- Example: `# id must be one of: # METRICS | LOGGING | TRACING | GRAPH_VIRTUAL_NODE # LOG_ALERT | NET_FLOW | EVENT | SLOW_SQL dc insight featuregate get-feature-gate-by-id --id METRICS dc insight featuregate get-feature-gate-by-id --id SLOW_SQL -o json`

### `dc insight featuregate get-feature-gates`

- Summary: List all Insight feature gates and their enabled status
- HTTP: `GET /apis/insight.io/v1alpha1/feature-gates`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `id`, `description`, `enabled`, `status`
- Example: `dc insight featuregate get-feature-gates dc insight featuregate get-feature-gates -o json`

## Insight

### `dc insight insight get-global-config`

- Summary: Get Insight global configuration (retention, thresholds)
- HTTP: `GET /apis/insight.io/v1alpha1/config`
- Auth: required
- Body: none
- Flags: none
- Output: list path `errorRateThresholds`
- Example: `dc insight insight get-global-config dc insight insight get-global-config -o json`

### `dc insight insight get-helm-install-config`

- Summary: Generate Helm install parameters for the Insight agent chart
- HTTP: `POST /apis/insight.io/v1alpha1/agentinstallparam`
- Auth: required
- Body: required
- Flags: none
- Example: `# Get install params for insight-agent chart dc insight insight get-helm-install-config \ --set chartName=insight-agent \ --set version=0.30.0 # With extra overrides echo '{ "chartName": "insight-agent", "version": "0.30.0", "extra": { "global.exporters.logging.enabled": true, "global.exporters.metrics.enabled": true } }' | dc insight insight get-helm-install-config --file -`

### `dc insight insight get-userinfo`

- Summary: Get current user's Insight permissions and accessible resource types
- HTTP: `GET /apis/insight.io/v1alpha1/userinfo`
- Auth: required
- Body: none
- Flags: none
- Output: list path `resourceTypes`
- Example: `dc insight insight get-userinfo dc insight insight get-userinfo -o json`

### `dc insight insight get-version`

- Summary: Get Insight server version info
- HTTP: `GET /apis/insight.io/v1alpha1/version`
- Auth: required
- Body: none
- Flags: none
- Example: `dc insight insight get-version dc insight insight get-version -o json`

### `dc insight insight update-global-config`

- Summary: Update Insight global configuration (retention, thresholds)
- HTTP: `PUT /apis/insight.io/v1alpha1/config`
- Auth: required
- Body: required
- Flags: none
- Output: list path `errorRateThresholds`
- Example: `# Update retention windows and APM thresholds dc insight insight update-global-config \ --set logRetentionTime=7d \ --set k8sEventLogRetentionTime=7d \ --set skoalaLogRetentionTime=7d \ --set traceDataRetentionTime=15d \ --set vmStorageRetentionTime=30d \ --set alertHistoryRetentionTime=90 \ --set traceApdexThreshold=500ms \ --set slowSqlThreshold=1000 \ --set-str 'latencyThresholds[0]=500' \ --set-str 'latencyThresholds[1]=1000' \ --set-str 'errorRateThresholds[0]=0.01' \ --set-str 'errorRateThresholds[1]=0.05' # Or pass the full body via stdin echo '{ "logRetentionTime": "7d", "k8sEventLogRetentionTime": "7d", "skoalaLogRetentionTime": "7d", "traceDataRetentionTime": "15d", "vmStorageRetentionTime": "30d", "alertHistoryRetentionTime": 90, "traceApdexThreshold": "500ms", "slowSqlThreshold": 1000, "latencyThresholds": [500, 1000], "errorRateThresholds": [0.01, 0.05] }' | dc insight insight update-global-config --file -`

## Log

### `dc insight log download-log`

- Summary: Export logs (or a context window) to a downloadable file
- HTTP: `POST /apis/insight.io/v1alpha1/log/export`
- Auth: required
- Body: required
- Flags: none
- Example: `# Export up to 100k resource log lines as a file (response contains download info) echo '{ "maxLines": 100000, "fields": ["timestamp", "log", "kubernetes.pod_name", "kubernetes.container_name"], "queryLog": { "startTime": "1700000000000", "endTime": "1700003600000", "sorts": ["timestamp:asc"], "resource": { "clusterFilter": ["prod-1"], "namespaceFilter": ["default"], "workloadFilter": ["my-app"] } } }' | dc insight log download-log --file - # Export a context window around one log line echo '{ "maxLines": 200, "fields": ["timestamp", "log"], "queryLogContext": { "before": 100, "after": 100, "startTime": "1700000000000", "endTime": "1700003600000", "nanotimestamp": "1700001234567890000", "type": "resource", "resource": {"cluster":"prod-1","namespace":"default","pod":"my-app-abc","container":"app"} } }' | dc insight log download-log --file -`

### `dc insight log list-log-file-paths`

- Summary: List available system log file paths on a node
- HTTP: `GET /apis/insight.io/v1alpha1/log/filepaths`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--node` (query): node
- Output: list path `paths`
- Example: `# Files on a specific node dc insight log list-log-file-paths --cluster-name prod-1 --node node-1 dc insight log list-log-file-paths --cluster prod-1 --node node-1 -o json`

### `dc insight log query-log`

- Summary: Query logs (resource / event / system) with filters and pagination
- HTTP: `POST /apis/insight.io/v1alpha1/log/query`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `log`, `timestamp`
- Example: `# Resource (container) logs in a cluster + namespace echo '{ "startTime": "1700000000000", "endTime": "1700003600000", "page": 1, "pageSize": 100, "sorts": ["timestamp:desc"], "resource": { "clusterFilter": ["prod-1"], "namespaceFilter": ["default"], "workloadFilter": ["my-app"], "podSearch": ["my-app-"], "logSearch": ["error"], "luceneFilter": "level:ERROR AND NOT path:\"/health\"" } }' | dc insight log query-log --file - # System (node) logs echo '{ "startTime": "1700000000000", "endTime": "1700003600000", "system": { "clusterFilter": ["prod-1"], "nodeFilter": ["node-1"], "fileFilter": ["/var/log/syslog"], "logSearch": ["oom"] } }' | dc insight log query-log --file - # K8s event logs echo '{ "startTime": "1700000000000", "endTime": "1700003600000", "event": { "clusterFilter": ["prod-1"], "logSearch": ["FailedScheduling"] } }' | dc insight log query-log --file -`

### `dc insight log query-log-context`

- Summary: Fetch surrounding log lines around a specific timestamp (context view)
- HTTP: `POST /apis/insight.io/v1alpha1/log/context`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `log`, `timestamp`
- Example: `# Get 50 lines before and 50 lines after a specific resource log entry echo '{ "before": 50, "after": 50, "startTime": "1700000000000", "endTime": "1700003600000", "nanotimestamp": "1700001234567890000", "type": "resource", "resource": { "cluster": "prod-1", "namespace": "default", "pod": "my-app-abc123", "container": "app" } }' | dc insight log query-log-context --file - # Context around a system log on a node echo '{ "before": 30, "after": 30, "startTime": "1700000000000", "endTime": "1700003600000", "nanotimestamp": "1700001234567890000", "type": "system", "system": {"cluster":"prod-1","node":"node-1","file":"/var/log/syslog"} }' | dc insight log query-log-context --file -`

### `dc insight log query-log-histogram`

- Summary: Bucket log counts over time (histogram) for a query
- HTTP: `POST /apis/insight.io/v1alpha1/log/histogram`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `count`, `timestamp`
- Example: `# 1-minute buckets of error logs across a namespace echo '{ "startTime": "1700000000000", "endTime": "1700003600000", "interval": "1m", "resource": { "clusterFilter": ["prod-1"], "namespaceFilter": ["default"], "logSearch": ["error"] } }' | dc insight log query-log-histogram --file -`

### `dc insight log search-log`

- Summary: Search logs by Elasticsearch index + ES DSL query
- HTTP: `GET /apis/insight.io/v1alpha1/log/search`
- Auth: required
- Body: none
- Flags:
  - `--index` (query): index
  - `--query` (query): query
- Example: `# --query must be a valid Elasticsearch DSL JSON body (passed as a query-string value). # Match a single field: dc insight log search-log \ --index insight-log \ --query '{"query":{"match":{"log":"timeout"}}}' # Bool query with filters + size/sort, against a namespace: dc insight log search-log \ --index insight-log \ --query '{ "size": 100, "sort": [{"@timestamp":"desc"}], "query": { "bool": { "must": [{"match": {"log": "error"}}], "filter": [ {"term": {"kubernetes.namespace_name": "default"}}, {"range": {"@timestamp": {"gte": "now-1h", "lte": "now"}}} ] } } }' -o json`

## Metric

### `dc insight metric batch-query-metric`

- Summary: Run multiple PromQL instant queries in one call (shared label match)
- HTTP: `POST /apis/insight.io/v1alpha1/metric/query`
- Auth: required
- Body: required
- Flags: none
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# Instant snapshot of several SLO metrics, scoped to a cluster + namespace echo '{ "matchLabel": { "clusterName": "prod-1", "namespace": "default", "extraLabel": {"app": "my-app"} }, "param": {"time": "1700000000"}, "queryList": [ "sum(rate(http_requests_total[5m]))", "sum(rate(http_requests_total{code=~\"5..\"}[5m]))", "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))" ] }' | dc insight metric batch-query-metric --file -`

### `dc insight metric batch-query-range-metric`

- Summary: Run multiple PromQL range queries in one call (shared label match)
- HTTP: `POST /apis/insight.io/v1alpha1/metric/queryrange`
- Auth: required
- Body: required
- Flags: none
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# 1-hour range of QPS, error rate, p99 latency in a single call echo '{ "matchLabel": { "clusterName": "prod-1", "namespace": "default", "extraLabel": {"app": "my-app"} }, "param": {"start": "1700000000", "end": "1700003600", "step": 30}, "queryList": [ "sum(rate(http_requests_total[5m]))", "sum(rate(http_requests_total{code=~\"5..\"}[5m])) / sum(rate(http_requests_total[5m]))", "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))" ] }' | dc insight metric batch-query-range-metric --file -`

### `dc insight metric format-query`

- Summary: Pretty-print / normalize a PromQL expression (server-side formatter)
- HTTP: `POST /apis/insight.io/v1alpha1/metric/format_query`
- Auth: required
- Body: required
- Flags: none
- Example: `echo '{"query":"sum(rate(http_requests_total{code=~\"5..\"}[5m]))/sum(rate(http_requests_total[5m]))"}' \ | dc insight metric format-query --file -`

### `dc insight metric query-metric`

- Summary: Run a PromQL instant query (Prometheus /api/v1/query)
- HTTP: `GET /apis/insight.io/v1alpha1/metric/query`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): namespace
  - `--query` (query): query
  - `--time` (query, int64): Optional, current server time is used if the time parameter is omitted.
- Output: list path `vector`
- Example: `# Current up-status of all targets in a cluster dc insight metric query-metric \ --cluster-name prod-1 \ --query 'up' # Per-pod CPU usage in a namespace at a specific timestamp (unix seconds) dc insight metric query-metric \ --cluster-name prod-1 \ --namespace default \ --query 'sum(rate(container_cpu_usage_seconds_total{namespace="default"}[5m])) by (pod)' \ --time 1700000000 -o json`

### `dc insight metric query-range-metric`

- Summary: Run a PromQL range query (Prometheus /api/v1/query_range)
- HTTP: `GET /apis/insight.io/v1alpha1/metric/queryrange`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): namespace
  - `--query` (query): query
  - `--start` (query, int64): start
  - `--end` (query, int64): end
  - `--step` (query, double): step
- Output: list path `matrix`
- Example: `# 1-hour CPU usage range, 30s step dc insight metric query-range-metric \ --cluster-name prod-1 \ --query 'sum(rate(container_cpu_usage_seconds_total[5m])) by (pod)' \ --start 1700000000 --end 1700003600 --step 30 -o json # Node memory utilization for a single node dc insight metric query-range-metric \ --cluster-name prod-1 \ --query 'node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes' \ --start 1700000000 --end 1700003600 --step 60`

## Overview

### `dc insight overview get-resources-count`

- Summary: Get global resource counts (clusters / nodes / pods / deployments) for the dashboard
- HTTP: `GET /apis/insight.io/v1alpha1/overview/resources/count`
- Auth: required
- Body: none
- Flags:
  - `--time` (query, int64): time unix timestamp .e.g. 1697597347
  - `--filters` (query): default [CLUSTER_NORMAL_TOTAL, CLUSTER_TOTAL, NODE_NORMAL_TOTAL, NODE_TOTAL, DEPLOYMENT_NORMAL_TOTAL, DEPLOYMENT_TOTAL
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# All defaults dc insight overview get-resources-count # At a specific point in time, only cluster + node totals dc insight overview get-resources-count \ --time 1700000000 \ --filters CLUSTER_TOTAL --filters CLUSTER_NORMAL_TOTAL \ --filters NODE_TOTAL --filters NODE_NORMAL_TOTAL -o json`

### `dc insight overview get-resources-range`

- Summary: Get resource counts over a time range (sparkline data)
- HTTP: `GET /apis/insight.io/v1alpha1/overview/resources/range`
- Auth: required
- Body: none
- Flags:
  - `--filters` (query): default [NODE_TOTAL, POD_NORMAL_TOTAL, POD_ABNORMAL_TOTAL]
  - `--start` (query, int64): start unix timestamp .e.g. 1697597347
  - `--end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--step` (query, double): step time step in second, default 60
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# 1-hour range with 60s step dc insight overview get-resources-range \ --start 1700000000 --end 1700003600 --step 60 \ --filters NODE_TOTAL --filters POD_NORMAL_TOTAL --filters POD_ABNORMAL_TOTAL -o json`

### `dc insight overview get-resources-usage`

- Summary: Get top-N resource usage time series (CPU / memory) for clusters or nodes
- HTTP: `GET /apis/insight.io/v1alpha1/overview/resources/usage`
- Auth: required
- Body: none
- Flags:
  - `--filters` (query): default [CLUSTER_CPU_USAGE, NODE_CPU_USAGE]
  - `--limit` (query, int64): limit The max element of result in desc order
  - `--start` (query, int64): start unix timestamp .e.g. 1697597347
  - `--end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--step` (query, double): step time step in second, default 60
- Output: list path `data`; columns `errorMessage`, `status`; pagination `cursor`
- Example: `# Top 5 nodes by CPU usage over the last hour dc insight overview get-resources-usage \ --start 1700000000 --end 1700003600 --step 60 \ --filters NODE_CPU_USAGE --limit 5 -o json # Cluster-level CPU usage dc insight overview get-resources-usage \ --start 1700000000 --end 1700003600 --step 60 \ --filters CLUSTER_CPU_USAGE --limit 10`

### `dc insight overview get-services-monitor`

- Summary: Get a snapshot of service-level APM signals for the overview dashboard
- HTTP: `GET /apis/insight.io/v1alpha1/overview/services/monitor`
- Auth: required
- Body: none
- Flags:
  - `--filters` (query): filter
  - `--limit` (query, int64): limit The max element of result in desc order
  - `--time` (query, int64): timestamp unix timestamp .e.g. 1697597347
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
- Output: list path `data`; columns `errorMessage`, `status`; pagination `cursor`
- Example: `dc insight overview get-services-monitor \ --time 1700003600 --limit 10 \ --span-kinds SPAN_KIND_SERVER -o json`

## Probe

### `dc insight probe add-probe`

- Summary: Create a probe (PrometheusOperator Probe / blackbox-exporter)
- HTTP: `POST /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
- Example: `# HTTP 2xx probe against two URLs, scraped every 30s echo '{ "probe": { "jobName": "web-check", "module": "http_2xx", "interval": "30s", "scrapeTimeout": "10s", "prober": { "name": "blackbox-exporter", "url": "blackbox-exporter.insight-system.svc:9115", "scheme": "http", "path": "/probe" }, "targets": { "staticConfig": { "static": [ "https://example.com", "https://api.example.com/health" ], "labels": {"team": "ops"} } } } }' | dc insight probe add-probe \ --cluster-name prod-1 --namespace insight-system --file -`

### `dc insight probe delete-probe`

- Summary: Delete a probe by cluster + namespace + jobName
- HTTP: `DELETE /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes/{jobName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--job-name` (path, required): jobName
- Example: `dc insight probe delete-probe \ --cluster-name prod-1 --namespace insight-system --job-name web-check`

### `dc insight probe get-probe`

- Summary: Get a probe by cluster + namespace + jobName
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes/{jobName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--job-name` (path, required): jobName
- Example: `dc insight probe get-probe \ --cluster-name prod-1 --namespace insight-system --job-name web-check`

### `dc insight probe list-probers`

- Summary: List blackbox-exporter probers available in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{clusterName}/probers`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
- Output: list path `probers`
- Example: `dc insight probe list-probers --cluster-name prod-1 dc insight probe list-probers --cluster-name prod-1 -o json`

### `dc insight probe list-probes`

- Summary: List probes in a cluster + namespace
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--fuzzy-name` (query): FuzzyName is used to fuzzy search by multiple parameters including name.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sorts` (query): sorts determines the data list order, do not support multiple sort option.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `kind`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`
- Example: `dc insight probe list-probes --cluster-name prod-1 --namespace insight-system dc insight probe list-probes --cluster-name prod-1 --namespace insight-system \ --fuzzy-name web --sort 'metadata.creationTimestamp:desc' \ --page 1 --page-size 50 -o json`

### `dc insight probe update-probe`

- Summary: Update a probe's interval / module / targets
- HTTP: `PUT /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes/{jobName}`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--job-name` (path, required): jobName
- Example: `echo '{ "interval": "60s", "scrapeTimeout": "15s", "module": "http_2xx", "targets": { "staticConfig": { "static": ["https://example.com","https://api.example.com/health"], "labels": {"team": "ops", "tier": "edge"} } } }' | dc insight probe update-probe \ --cluster-name prod-1 --namespace insight-system --job-name web-check --file -`

## Resource

### `dc insight resource get-agent-summary`

- Summary: Get the insight-agent component summary for a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/agent`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): use cluster_name
- Example: `dc insight resource get-agent-summary --cluster prod-1 dc insight resource get-agent-summary --cluster prod-1 -o json`

### `dc insight resource get-cluster`

- Summary: Get cluster details by name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Example: `dc insight resource get-cluster --name prod-1 dc insight resource get-cluster --name prod-1 -o json`

### `dc insight resource get-cronjob`

- Summary: Get a CronJob by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `conditions`; columns `type`, `lastTransitionTime`, `lastUpdateTime`, `message`, `reason`, `status`
- Example: `dc insight resource get-cronjob --cluster prod-1 --namespace default --name nightly-backup`

### `dc insight resource get-cronjob-pods`

- Summary: List pods spawned by a CronJob
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/cronjobs/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--pod` (query): pod
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `phase`, `cpuUsage`, `memoryUsage`, `nodeName`; pagination `offset`
- Example: `dc insight resource get-cronjob-pods \ --cluster prod-1 --namespace default --name nightly-backup \ --page 1 --page-size 50 -o json`

### `dc insight resource get-daemonset`

- Summary: Get a DaemonSet by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `conditions`; columns `type`, `lastTransitionTime`, `lastUpdateTime`, `message`, `reason`, `status`
- Example: `dc insight resource get-daemonset --cluster prod-1 --namespace kube-system --name fluent-bit`

### `dc insight resource get-daemonset-pods`

- Summary: List pods belonging to a DaemonSet
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/daemonsets/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--pod` (query): pod
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `phase`, `cpuUsage`, `memoryUsage`, `nodeName`; pagination `offset`
- Example: `dc insight resource get-daemonset-pods \ --cluster prod-1 --namespace kube-system --name fluent-bit \ --page 1 --page-size 50 -o json`

### `dc insight resource get-deployment`

- Summary: Get a Deployment by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `conditions`; columns `type`, `lastTransitionTime`, `lastUpdateTime`, `message`, `reason`, `status`
- Example: `dc insight resource get-deployment --cluster prod-1 --namespace default --name my-app`

### `dc insight resource get-deployment-pods`

- Summary: List pods belonging to a Deployment
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/deployments/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--pod` (query): pod
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `phase`, `cpuUsage`, `memoryUsage`, `nodeName`; pagination `offset`
- Example: `dc insight resource get-deployment-pods \ --cluster prod-1 --namespace default --name my-app dc insight resource get-deployment-pods \ --cluster prod-1 --namespace default --name my-app \ --pod my-app-abc --page 1 --page-size 50 -o json`

### `dc insight resource get-job`

- Summary: Get a Job by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/jobs/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `conditions`; columns `type`, `lastTransitionTime`, `lastUpdateTime`, `message`, `reason`, `status`
- Example: `dc insight resource get-job --cluster prod-1 --namespace default --name backup-20240101`

### `dc insight resource get-job-pods`

- Summary: List pods belonging to a Job
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/jobs/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--pod` (query): pod
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `phase`, `cpuUsage`, `memoryUsage`, `nodeName`; pagination `offset`
- Example: `dc insight resource get-job-pods \ --cluster prod-1 --namespace default --name backup-20240101 \ --page 1 --page-size 50 -o json`

### `dc insight resource get-namespace`

- Summary: Get a namespace by cluster + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
- Example: `dc insight resource get-namespace --cluster prod-1 --name kube-system`

### `dc insight resource get-node`

- Summary: Get node details by cluster + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/nodes/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
- Example: `dc insight resource get-node --cluster prod-1 --name node-1 dc insight resource get-node --cluster prod-1 --name node-1 -o json`

### `dc insight resource get-node-gpu-dashboards`

- Summary: Get GPU dashboard URLs for a node
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/nodes/{name}/dashboards/gpu`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--name` (path, required): name
- Output: list path `urls`; columns `en`, `vendor`, `zh`
- Example: `dc insight resource get-node-gpu-dashboards --cluster prod-1 --name node-1 dc insight resource get-node-gpu-dashboards --cluster prod-1 --name node-1 -o json`

### `dc insight resource get-pod`

- Summary: Get pod details by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `conditions`; columns `type`, `lastTransitionTime`, `lastUpdateTime`, `message`, `reason`, `status`
- Example: `dc insight resource get-pod --cluster prod-1 --namespace default --name my-app-abc123 dc insight resource get-pod --cluster prod-1 --namespace default --name my-app-abc123 -o json`

### `dc insight resource get-pod-gpu-dashboards`

- Summary: Get GPU dashboard URLs for a pod
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}/dashboards/gpu`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `urls`; columns `en`, `vendor`, `zh`
- Example: `dc insight resource get-pod-gpu-dashboards \ --cluster prod-1 --namespace default --name my-gpu-pod`

### `dc insight resource get-pod-jvm-dashboards`

- Summary: Get JVM dashboard URLs for a pod (Java workloads)
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}/dashboards/jvm`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Required.
  - `--namespace` (path, required): required;
  - `--name` (path, required): required;
  - `--start` (query, int64): start
  - `--end` (query, int64): end
  - `--step` (query, double): step
- Example: `dc insight resource get-pod-jvm-dashboards \ --cluster prod-1 --namespace default --name my-java-pod \ --start 1700000000 --end 1700003600 --step 30`

### `dc insight resource get-pod-metrics`

- Summary: Get pod metrics over a time range (CPU / memory / network)
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}/metrics`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): Required.
  - `--namespace` (path, required): Required;
  - `--name` (path, required): Required, Pod's name;
  - `--start` (query, int64): start=<rfc3339 | unix_timestamp> Start timestamp, inclusive.
  - `--end` (query, int64): start=<rfc3339 | unix_timestamp> End timestamp, inclusive. Optional.
  - `--step` (query, double): Query resolution step width in duration format or float number of seconds. Optional.
  - `--query-list` (query): Query list. support below metrics:
- Output: list path `metrics`; columns `errorMessage`, `status`
- Example: `# Last hour of pod metrics, 30s step dc insight resource get-pod-metrics \ --cluster prod-1 --namespace default --name my-app-abc123 \ --start 1700000000 --end 1700003600 --step 30 # With a specific metric list (PromQL-like keys, server-defined) dc insight resource get-pod-metrics \ --cluster prod-1 --namespace default --name my-app-abc123 \ --start 1700000000 --end 1700003600 --step 30 \ --query-list cpuUsage --query-list memoryUsage -o json`

### `dc insight resource get-server-component-summary`

- Summary: Get insight-server-side component status summary
- HTTP: `GET /apis/insight.io/v1alpha1/server/component`
- Auth: required
- Body: none
- Flags: none
- Output: list path `summary`; columns `name`, `phase`, `creationTimestamp`, `availability`, `message`, `version`
- Example: `dc insight resource get-server-component-summary dc insight resource get-server-component-summary -o json`

### `dc insight resource get-service`

- Summary: Get a Service (with linked workloads) by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/services/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `workloadData`; columns `name`, `workloadKind`
- Example: `dc insight resource get-service --cluster prod-1 --namespace default --name my-app`

### `dc insight resource get-statefulset`

- Summary: Get a StatefulSet by cluster + namespace + name
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
- Output: list path `conditions`; columns `type`, `lastTransitionTime`, `lastUpdateTime`, `message`, `reason`, `status`
- Example: `dc insight resource get-statefulset --cluster prod-1 --namespace default --name my-db`

### `dc insight resource get-statefulset-pods`

- Summary: List pods belonging to a StatefulSet
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/statefulsets/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
  - `--namespace` (path, required): namespace
  - `--name` (path, required): name
  - `--pod` (query): pod
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `namespace`, `phase`, `cpuUsage`, `memoryUsage`, `nodeName`; pagination `offset`
- Example: `dc insight resource get-statefulset-pods \ --cluster prod-1 --namespace default --name my-db \ --page 1 --page-size 50 -o json`

### `dc insight resource list-cluster-summary`

- Summary: List clusters with status/version/role summary
- HTTP: `GET /apis/insight.io/v1alpha1/clustersummary`
- Auth: required
- Body: none
- Flags:
  - `--name` (query): filter cluster by name
  - `--version` (query): filter cluster by k8s version
  - `--phase` (query, default `CLUSTER_PHASE_UNSPECIFIED`, one of: CLUSTER_PHASE_UNSPECIFIED|UNKNOWN|CREATING|RUNNING|UPDATING|DELETING|FAILED): CLUSTER_PHASE_UNSPECIFIED | UNKNOWN | CREATING | RUNNING | UPDATING | DELETING | FAILED
  - `--show-all-cluster` (query): show_all_cluster default is false, will only return cluster with
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `phase`, `accessScope`, `kubeSystemId`, `role`; pagination `offset`
- Example: `dc insight resource list-cluster-summary dc insight resource list-cluster-summary --phase RUNNING --version v1.28 \ --page 1 --page-size 50 -o json`

### `dc insight resource list-clusters`

- Summary: List all clusters known to Insight
- HTTP: `GET /apis/insight.io/v1alpha1/clusters`
- Auth: required
- Body: none
- Flags:
  - `--show-all-cluster` (query): show_all_cluster default is false, will only return cluster with
- Output: list path `items`; columns `name`, `phase`, `accessScope`, `kubeSystemId`, `role`
- Example: `dc insight resource list-clusters # Include clusters that have not enabled monitoring dc insight resource list-clusters --show-all-cluster=true -o json`

### `dc insight resource list-cronjobs`

- Summary: List CronJobs in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/cronjobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter jobs by cluster
  - `--namespace` (query): filter jobs by namespace
  - `--phase` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|JOB_STATE_WAITING|JOB_STATE_RUNNING|JOB_STATE_COMPLETED|JOB_STATE_DELETING|JOB_STATE_FAILED): JOB_STATE_UNSPECIFIED | JOB_STATE_WAITING | JOB_STATE_RUNNING | JOB_STATE_COMPLETED | JOB_STATE_DELETING | JOB_STATE_FAILED
  - `--name` (query): filter jobs by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `phase`; pagination `offset`
- Example: `dc insight resource list-cronjobs --cluster prod-1 dc insight resource list-cronjobs --cluster prod-1 --namespace default \ --phase JOB_STATE_RUNNING -o json`

### `dc insight resource list-daemonsets`

- Summary: List DaemonSets in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/daemonsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter workloads by cluster
  - `--namespace` (query): filter workloads by namespace
  - `--name` (query): filter workloads by name
  - `--phase` (query, default `WORKLOAD_STATE_UNKNOWN`, one of: WORKLOAD_STATE_UNKNOWN|WORKLOAD_STATE_RUNNING|WORKLOAD_STATE_DELETING|WORKLOAD_STATE_NOT_READY|WORKLOAD_STATE_STOPPED|WORKLOAD_STATE_WAITING): WORKLOAD_STATE_UNKNOWN | WORKLOAD_STATE_RUNNING | WORKLOAD_STATE_DELETING | WORKLOAD_STATE_NOT_READY | WORKLOAD_STATE_STOPPED | WORKLOAD_STATE_WAITING
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `phase`; pagination `offset`
- Example: `dc insight resource list-daemonsets --cluster prod-1 dc insight resource list-daemonsets --cluster prod-1 --namespace kube-system \ --phase WORKLOAD_STATE_NOT_READY -o json`

### `dc insight resource list-deployments`

- Summary: List Deployments in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/deployments`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter workloads by cluster
  - `--namespace` (query): filter workloads by namespace
  - `--name` (query): filter workloads by name
  - `--phase` (query, default `WORKLOAD_STATE_UNKNOWN`, one of: WORKLOAD_STATE_UNKNOWN|WORKLOAD_STATE_RUNNING|WORKLOAD_STATE_DELETING|WORKLOAD_STATE_NOT_READY|WORKLOAD_STATE_STOPPED|WORKLOAD_STATE_WAITING): WORKLOAD_STATE_UNKNOWN | WORKLOAD_STATE_RUNNING | WORKLOAD_STATE_DELETING | WORKLOAD_STATE_NOT_READY | WORKLOAD_STATE_STOPPED | WORKLOAD_STATE_WAITING
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `phase`; pagination `offset`
- Example: `dc insight resource list-deployments --cluster prod-1 dc insight resource list-deployments --cluster prod-1 --namespace default \ --phase WORKLOAD_STATE_NOT_READY -o json`

### `dc insight resource list-jobs`

- Summary: List Jobs in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/jobs`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter jobs by cluster
  - `--namespace` (query): filter jobs by namespace
  - `--phase` (query, default `JOB_STATE_UNSPECIFIED`, one of: JOB_STATE_UNSPECIFIED|JOB_STATE_WAITING|JOB_STATE_RUNNING|JOB_STATE_COMPLETED|JOB_STATE_DELETING|JOB_STATE_FAILED): JOB_STATE_UNSPECIFIED | JOB_STATE_WAITING | JOB_STATE_RUNNING | JOB_STATE_COMPLETED | JOB_STATE_DELETING | JOB_STATE_FAILED
  - `--name` (query): filter jobs by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `status.phase`; pagination `offset`
- Example: `dc insight resource list-jobs --cluster prod-1 dc insight resource list-jobs --cluster prod-1 --namespace default \ --phase JOB_STATE_FAILED -o json`

### `dc insight resource list-namespaces`

- Summary: List namespaces in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): cluster
- Output: list path `namespaces`; columns `name`, `role`
- Example: `dc insight resource list-namespaces --cluster prod-1 dc insight resource list-namespaces --cluster prod-1 -o json`

### `dc insight resource list-nodes`

- Summary: List nodes in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/nodes`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter nodes by cluster
  - `--phase` (query, default `NODE_PHASE_UNSPECIFIED`, one of: NODE_PHASE_UNSPECIFIED|NODE_PHASE_READY|NODE_PHASE_NOT_READY|NODE_PHASE_UNKNOWN): NODE_PHASE_UNSPECIFIED | NODE_PHASE_READY | NODE_PHASE_NOT_READY | NODE_PHASE_UNKNOWN
  - `--name` (query): filter nodes by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `phase`; pagination `offset`
- Example: `dc insight resource list-nodes --cluster prod-1 dc insight resource list-nodes --cluster prod-1 --phase NODE_PHASE_NOT_READY -o json dc insight resource list-nodes --cluster prod-1 --name node- --page 1 --page-size 50`

### `dc insight resource list-pod-containers`

- Summary: List containers within a pod
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/namespaces/{namespace}/pods/{name}/containers`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter nodes by cluster
  - `--namespace` (path, required): filter nodes by namespace
  - `--name` (path, required): filter containers by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `phase`; pagination `offset`
- Example: `dc insight resource list-pod-containers \ --cluster prod-1 --namespace default --name my-app-abc123 dc insight resource list-pod-containers \ --cluster prod-1 --namespace default --name my-app-abc123 \ --page 1 --page-size 50 -o json`

### `dc insight resource list-pods`

- Summary: List pods in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/pods`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter nodes by cluster
  - `--namespace` (query): filter nodes by namespaces
  - `--phase` (query, default `POD_PHASE_UNSPECIFIED`, one of: POD_PHASE_UNSPECIFIED|POD_PHASE_UNKNOWN|POD_PHASE_PENDING|POD_PHASE_RUNNING|POD_PHASE_SUCCEED|POD_PHASE_FAILED): POD_PHASE_UNSPECIFIED | POD_PHASE_UNKNOWN | POD_PHASE_PENDING | POD_PHASE_RUNNING | POD_PHASE_SUCCEED | POD_PHASE_FAILED
  - `--name` (query): filter pods by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `phase`, `cpuUsage`, `memoryUsage`, `nodeName`; pagination `offset`
- Example: `dc insight resource list-pods --cluster prod-1 dc insight resource list-pods --cluster prod-1 --namespace default --phase POD_PHASE_RUNNING dc insight resource list-pods --cluster prod-1 --name my-app --page 1 --page-size 50 -o json`

### `dc insight resource list-services`

- Summary: List Services in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/services`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter services by cluster
  - `--namespace` (query): filter services by namespaces
  - `--name` (query): filter services by name
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `tracingEnabled`; pagination `offset`
- Example: `dc insight resource list-services --cluster prod-1 dc insight resource list-services --cluster prod-1 --namespace default --name my-app -o json`

### `dc insight resource list-statefulsets`

- Summary: List StatefulSets in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{cluster}/statefulsets`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (path, required): filter workloads by cluster
  - `--namespace` (query): filter workloads by namespace
  - `--name` (query): filter workloads by name
  - `--phase` (query, default `WORKLOAD_STATE_UNKNOWN`, one of: WORKLOAD_STATE_UNKNOWN|WORKLOAD_STATE_RUNNING|WORKLOAD_STATE_DELETING|WORKLOAD_STATE_NOT_READY|WORKLOAD_STATE_STOPPED|WORKLOAD_STATE_WAITING): WORKLOAD_STATE_UNKNOWN | WORKLOAD_STATE_RUNNING | WORKLOAD_STATE_DELETING | WORKLOAD_STATE_NOT_READY | WORKLOAD_STATE_STOPPED | WORKLOAD_STATE_WAITING
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `name`, `namespace`, `phase`; pagination `offset`
- Example: `dc insight resource list-statefulsets --cluster prod-1 dc insight resource list-statefulsets --cluster prod-1 --namespace default \ --phase WORKLOAD_STATE_RUNNING -o json`

## ServiceGraph

### `dc insight servicegraph get-graph`

- Summary: Get service / workload / namespace topology graph
- HTTP: `POST /apis/insight.io/v1alpha1/service-graph/graph`
- Auth: required
- Body: required
- Flags: none
- Output: list path `edges`; columns `id`, `source`, `target`
- Example: `# Service-level graph for a namespace in the last hour echo '{ "clusterNames": ["prod-1"], "namespaces": ["default"], "start": "1700000000000", "end": "1700003600000", "graphType": "service", "layer": "L7", "showUpDownRelatedNode": true, "showVirtualNode": false }' | dc insight servicegraph get-graph --file - # Workload graph filtered by a specific service, with a 3-hop dependency depth echo '{ "clusterNames": ["prod-1"], "namespaces": ["default"], "services": ["my-app"], "workloads": ["my-app"], "start": "1700000000000", "end": "1700003600000", "graphType": "workload", "filters": { "aggType": "p99", "dependencyMaxDepth": 3, "clauses": [ {"field":"http.status_code","operation":"=","dataType":"string","stringValue":"500"} ] } }' | dc insight servicegraph get-graph --file -`

### `dc insight servicegraph get-node-metrics`

- Summary: Get aggregated metrics for a node (service/workload) on the topology graph
- HTTP: `GET /apis/insight.io/v1alpha1/service-graph/node-metrics`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Required. e.g. cluster = 7760a3f4-bfca-4c1e-8731-aea80838525f
  - `--namespace` (query): namespace
  - `--service` (query): service
  - `--extension-filters` (query): extension_filters eg. skoala_registry=ire-111,instance=xxx
  - `--end-time` (query, int64): end_time 结束时间 unix timestamp，单位 ms
  - `--lookback` (query, int64): lookback 回退时间 unix timestamp，单位 ms
  - `--step` (query, int64): step 时间步长 unix timestamp，单位 ms
  - `--rate-per` (query, int64): ratePer 变化率计算步长 unix timestamp，单位 ms
  - `--cluster-name` (query): Required. e.g. clusterName=kpanda-global-cluster must give one of
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the
- Output: list path `errorsRateMetrics`
- Example: `# Last 30m of metrics for a single service node (endTime/lookback in unix ms) dc insight servicegraph get-node-metrics \ --cluster-name prod-1 --namespace default --service my-app \ --end-time 1700003600000 --lookback 1800000 \ --step 60000 --rate-per 60000 \ --span-kinds SPAN_KIND_SERVER -o json # With extension filters (label selectors) dc insight servicegraph get-node-metrics \ --cluster-name prod-1 --namespace default --service my-app \ --extension-filters 'skoala_registry=ire-111,instance=10.0.0.1' \ --end-time 1700003600000 --lookback 1800000 --step 60000`

## Tracing

### `dc insight tracing find-jaeger-trace`

- Summary: Get a single Jaeger trace by trace ID
- HTTP: `GET /apis/insight.io/v1alpha1/jaeger/v2/traces/{traceId}`
- Auth: required
- Body: none
- Flags:
  - `--trace-id` (path, required): traceId
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): only for auth
- Output: list path `traces`; columns `duration`, `method`, `operationName`, `protocol`, `spanCount`, `startTime`
- Example: `dc insight tracing find-jaeger-trace --trace-id <traceId> \ --cluster-name prod-1 --namespace default dc insight tracing find-jaeger-trace --trace-id <traceId> \ --cluster-name prod-1 --namespace default -o json`

### `dc insight tracing find-jaeger-traces`

- Summary: Search Jaeger traces by service / operation / duration window
- HTTP: `GET /apis/insight.io/v1alpha1/jaeger/v2/traces`
- Auth: required
- Body: none
- Flags:
  - `--service-name` (query): serviceName
  - `--operation-name` (query): operationName
  - `--start` (query): e.g. 2022-06-24T08:00:47.850Z
  - `--end` (query): e.g. 2022-06-24T08:00:47.850Z
  - `--duration-min` (query): Span min duration. such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h".
  - `--duration-max` (query): Span min duration. such as "300ms", "-1.5h" or "2h45m". Valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h".
  - `--limit` (query, int32): limit
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): only for auth
- Output: list path `traces`; columns `duration`, `method`, `operationName`, `protocol`, `spanCount`, `startTime`; pagination `cursor`
- Example: `# All traces of a service in the last hour dc insight tracing find-jaeger-traces \ --cluster-name prod-1 --namespace default \ --service-name my-app \ --start 2024-06-24T07:00:00Z --end 2024-06-24T08:00:00Z \ --limit 50 # Slow traces (>500ms) for a specific operation dc insight tracing find-jaeger-traces \ --cluster-name prod-1 --namespace default \ --service-name my-app --operation-name 'GET /api/v1/orders' \ --duration-min 500ms --duration-max 5s \ --start 2024-06-24T07:00:00Z --end 2024-06-24T08:00:00Z -o json`

### `dc insight tracing get-operation-detail`

- Summary: Get per-operation APM metrics for a service
- HTTP: `GET /apis/insight.io/v1alpha1/traces/operation-detail`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (query): Required.
  - `--namespace` (query): Required. namespace
  - `--service-name` (query): Required. At least one service name must be provided.
  - `--sort` (query): Optional.
  - `--page` (query, default `1`, int32): Optional. page is current page.
  - `--page-size` (query, default `20`, int32): Optional. size is the data number shown per page.
  - `--extension-filters` (query): Optional. support extension labels search
  - `--end-time` (query, int64): end_time is the ending time of the time series query range.
  - `--lookback` (query, int64): lookback is the duration from the end_time to look back on for metrics data points.
  - `--step` (query, int64): step size is the duration between data points of the query results.
  - `--rate-per` (query, int64): ratePer is the duration in which the per-second rate of change is calculated for a cumulative counter metric.
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
- Output: list path `metrics`; columns `operationName`, `spanKind`; pagination `offset`
- Example: `dc insight tracing get-operation-detail \ --cluster-name prod-1 --namespace default --service-name my-app \ --end-time 1700003600000000 --lookback 1800000000 \ --step 60000000 --rate-per 60000000 \ --span-kinds SPAN_KIND_SERVER \ --sort 'p99:desc' --page 1 --page-size 50 -o json`

### `dc insight tracing get-service-detail`

- Summary: Get per-service APM metrics (latency / errors / requests, optionally grouped by operation)
- HTTP: `GET /apis/insight.io/v1alpha1/traces/service-detail`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): Required.
  - `--instance-name` (query): Optional. not default
  - `--extension-filters` (query): Support extension search
  - `--service-names` (query): service_names are the service names to fetch metrics from.
  - `--group-by-operation` (query): groupByOperation determines if the metrics returned should be grouped by operation.
  - `--end-time` (query, int64): end_time is the ending time of the time series query range.
  - `--lookback` (query, int64): lookback is the duration from the end_time to look back on for metrics data points.
  - `--step` (query, int64): step size is the duration between data points of the query results.
  - `--rate-per` (query, int64): ratePer is the duration in which the per-second rate of change is calculated for a cumulative counter metric.
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
- Output: list path `errorsRateMetrics`
- Example: `dc insight tracing get-service-detail \ --cluster-name prod-1 --namespace default \ --service-names my-app --group-by-operation=true \ --end-time 1700003600000000 --lookback 1800000000 \ --step 60000000 --rate-per 60000000 \ --span-kinds SPAN_KIND_SERVER -o json`

### `dc insight tracing get-service-pods`

- Summary: List the pods backing a tracing service with per-pod request share
- HTTP: `GET /apis/insight.io/v1alpha1/traces/services/{name}/pods`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): Required.
  - `--cluster-name` (query): Required.
  - `--namespace` (query): Required.
  - `--sort` (query): sorts determines the data list order.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--extension-filters` (query): Support extension search
  - `--end-time` (query, int64): end_time is the ending time of the time series query range.
  - `--lookback` (query, int64): lookback is the duration from the end_time to look back on for metrics data points.
  - `--step` (query, int64): step size is the duration between data points of the query results.
  - `--rate-per` (query, int64): ratePer is the duration in which the per-second rate of change is calculated for a cumulative counter metric.
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
- Output: list path `items`; columns `namespace`, `clusterName`, `podName`, `reqPercentage`; pagination `offset`
- Example: `dc insight tracing get-service-pods --name my-app \ --cluster-name prod-1 --namespace default \ --end-time 1700003600000000 --lookback 1800000000 \ --sort 'reqPercentage:desc' --page 1 --page-size 50 -o json`

### `dc insight tracing get-services`

- Summary: List APM services with rate / latency / error metrics
- HTTP: `GET /apis/insight.io/v1alpha1/traces/services`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (query): Optional.
  - `--extension-filters` (query): Support extension search
  - `--end-time` (query, int64): end_time is the ending time of the time series query range.
  - `--lookback` (query, int64): lookback is the duration from the end_time to look back on for metrics data points.
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sort` (query): sorts determines the data list order.
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
- Output: list path `items`; columns `namespace`, `errorRate`, `repLatency`, `reqRate`, `serviceName`; pagination `offset`
- Example: `# Top services by request rate in the last 30m (lookback = 30*60*1e6 us) dc insight tracing get-services \ --cluster-name prod-1 --namespace default \ --end-time 1700003600000000 --lookback 1800000000 \ --span-kinds SPAN_KIND_SERVER --sort 'reqRate:desc' \ --page 1 --page-size 50 -o json`

### `dc insight tracing get-slow-sql-spans`

- Summary: List individual slow-SQL spans (drill-down from statement-top-k)
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/spans`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `items`; columns `duration`, `sourcePod`, `spanId`, `startTime`, `status`, `traceId`
- Example: `echo '{ "namespace": "default", "startTime": "1700000000000", "endTime": "1700003600000", "sort": "duration:desc", "page": 1, "pageSize": 50, "clauses": [ {"field":"db.statement","operation":"contains","stringValue":"SELECT"}, {"field":"duration","operation":">","floatValue":1000} ] }' | dc insight tracing get-slow-sql-spans --cluster-name prod-1 --file -`

### `dc insight tracing get-tag-values`

- Summary: List values seen for a given tag key
- HTTP: `GET /apis/insight.io/v1alpha1/traces/tags/{name}/values`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): Required. not default
  - `--cluster` (query): Required. not default
  - `--namespace` (query): Required. not default
  - `--service-names` (query): Optional. not default
  - `--limit` (query, int32): Optional. Default = 1000.
  - `--search` (query): Optional not default
  - `--start` (query): e.g. 2022-06-24T08:00:47.850Z
  - `--end` (query): e.g. 2022-06-24T08:00:47.850Z
- Output: list path `values`; pagination `cursor`
- Example: `dc insight tracing get-tag-values --name http.status_code \ --cluster prod-1 --namespace default --service-names my-app \ --search 5 --limit 100 \ --start 2024-06-24T07:00:00Z --end 2024-06-24T08:00:00Z`

### `dc insight tracing get-tags`

- Summary: List span tag keys discovered for a service / namespace
- HTTP: `GET /apis/insight.io/v1alpha1/traces/tags`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): Required. not default
  - `--namespace` (query): Required. not default
  - `--service-names` (query): Optional. not default
  - `--limit` (query, int32): Optional. Default = 1000.
  - `--search` (query): Optional. not default
  - `--start` (query): e.g. 2022-06-24T08:00:47.850Z
  - `--end` (query): e.g. 2022-06-24T08:00:47.850Z
- Output: list path `tags`; pagination `cursor`
- Example: `dc insight tracing get-tags --cluster prod-1 --namespace default \ --service-names my-app --limit 500 \ --start 2024-06-24T07:00:00Z --end 2024-06-24T08:00:00Z`

### `dc insight tracing list-service-names`

- Summary: List service names known to the tracing backend
- HTTP: `GET /apis/insight.io/v1alpha1/traces/service-names`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--namespace` (query): namespace
  - `--max-size` (query, int32): Optional. Default = 1000.
  - `--start` (query): e.g. 2022-06-24T08:00:47.850Z
  - `--end` (query): e.g. 2022-06-24T08:00:47.850Z
- Output: list path `services`
- Example: `dc insight tracing list-service-names --cluster-name prod-1 --namespace default dc insight tracing list-service-names --cluster-name prod-1 --namespace default \ --start 2024-06-24T07:00:00Z --end 2024-06-24T08:00:00Z --max-size 500 -o json`

### `dc insight tracing query-metadata`

- Summary: List slow-SQL metadata (DB address / system / statement) for a cluster
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/type/{type}/metadata`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--type` (path, required, one of: DATABASE_ADDRESS|DATABASE_SYSTEM|SQL_STATEMENT): type
- Output: list path `items`
- Example: `# All SQL statements seen in the last hour for a namespace echo '{ "namespace": "default", "startTime": "1700000000000", "endTime": "1700003600000", "limit": 100, "clauses": [ {"field":"db.system","operation":"=","stringValue":"mysql"} ] }' | dc insight tracing query-metadata --cluster-name prod-1 --type SQL_STATEMENT --file - # type must be one of: DATABASE_ADDRESS | DATABASE_SYSTEM | SQL_STATEMENT echo '{ "namespace":"default", "startTime":"1700000000000","endTime":"1700003600000","limit":50 }' | dc insight tracing query-metadata --cluster-name prod-1 --type DATABASE_ADDRESS --file -`

### `dc insight tracing query-operations`

- Summary: List operations (endpoints) for a service in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/traces/clusters/{clusterName}/operations`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--namespace` (query): Required.
  - `--service-name` (query): Required.
  - `--max-size` (query, int32): Optional. Default = 1000.
  - `--start` (query): e.g. 2022-06-24T08:00:47.850Z
  - `--end` (query): e.g. 2022-06-24T08:00:47.850Z
- Output: list path `operations`
- Example: `dc insight tracing query-operations \ --cluster-name prod-1 --namespace default --service-name my-app \ --start 2024-06-24T07:00:00Z --end 2024-06-24T08:00:00Z --max-size 200`

### `dc insight tracing query-span-histogram`

- Summary: Bucket span counts over time (normal / error / total)
- HTTP: `POST /apis/insight.io/v1alpha1/jaeger/v2/spans/histogram`
- Auth: required
- Body: required
- Flags: none
- Output: list path `countItems`; columns `error`, `normal`, `timestamp`, `total`
- Example: `echo '{ "clusterName": "prod-1", "namespace": "default", "serviceName": ["my-app"], "start": "1700000000000", "end": "1700003600000", "interval": "1m", "onlyErrorSpans": false }' | dc insight tracing query-span-histogram --file -`

### `dc insight tracing query-spans`

- Summary: Query spans with rich filters (tags, error-only, sort, pagination)
- HTTP: `POST /apis/insight.io/v1alpha1/jaeger/v2/spans`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `duration`, `method`, `operationName`, `protocol`, `serviceName`, `spanId`
- Example: `# Error spans for a service in a time range, sorted by duration desc echo '{ "clusterName": "prod-1", "namespace": "default", "serviceName": ["my-app"], "operationName": ["GET /api/v1/orders"], "start": "1700000000000", "end": "1700003600000", "durationMin": "200ms", "onlyErrorSpans": true, "sort": "duration:desc", "page": 1, "pageSize": 50, "tags": [ {"key":"http.status_code","operation":"=","value":"500"} ] }' | dc insight tracing query-spans --file -`

### `dc insight tracing statement-histogram`

- Summary: Histogram of SQL statement durations (cluster scoped, slow-SQL)
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/statement/histogram`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `duration`; columns `timestamp`, `value`
- Example: `echo '{ "namespace": "default", "startTime": "1700000000000", "endTime": "1700003600000", "interval": "1m", "topN": "10", "sort": "duration:desc", "clauses": [ {"field":"db.system","operation":"=","stringValue":"mysql"} ] }' | dc insight tracing statement-histogram --cluster-name prod-1 --file -`

### `dc insight tracing statement-top-k`

- Summary: Top-K slowest SQL statements aggregated by source service
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/statement/topk`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `items`; columns `address`, `avgDuration`, `errorRate`, `sourceCluster`, `sourceNamespace`, `sourceService`
- Example: `echo '{ "namespace": "default", "startTime": "1700000000000", "endTime": "1700003600000", "interval": "5m", "topN": "20", "sort": "avgDuration:desc" }' | dc insight tracing statement-top-k --cluster-name prod-1 --file -`

## User

### `dc insight user list-users`

- Summary: List Insight users (Insight-side user view, not ghippo)
- HTTP: `GET /apis/insight.io/v1alpha1/users`
- Auth: required
- Body: none
- Flags:
  - `--search` (query): 搜索关键字
  - `--page-size` (query, default `20`, int32): 每页条数
  - `--page` (query, default `1`, int32): 当前页
- Output: list path `items`; columns `name`, `id`, `enabled`; pagination `offset`
- Example: `dc insight user list-users # Fuzzy search by name + paged JSON output dc insight user list-users --search alice --page 1 --page-size 50 -o json`

