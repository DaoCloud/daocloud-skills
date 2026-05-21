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
- Example: `# rule.source 必填（METRIC_TPL | PROMQL | LOG_TPL | EVENT_TPL），见 create-group 说明 echo '{ "rule": { "name": "HighMem", "source": "PROMQL", "severity": "WARNING", "duration": "5m", "expr": "node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes < 0.1", "description": "memory low", "labels": {"team":"ops"}, "annotations": {"summary":"low memory on {{ $labels.instance }}"} } }' | dc insight alert add-group-rule --id <gid> --file -`

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
- Example: `# ⚠️ --start 与 --end（unix 秒）必填，缺失返回 HTTP 400 "value must be greater than 0" # --step 单位为分钟，0 表示返回时间范围内的总数（不分桶） END=$(date +%s); START=$((END - 86400)) dc insight alert count-alert \ --cluster-name kpanda-global-cluster \ --severity CRITICAL \ --start $START --end $END --step 60 \ --group-by-type=true -o json`

### `dc insight alert create-group`

- Summary: Create an alert group (with rules / receivers)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/groups`
- Auth: required
- Body: required
- Flags: none
- Output: list path `notifyRepeatConfig`; columns `interval`, `severity`
- Example: `# ⚠️ 关键字段： # clusterName 必填 # rules[].source 必填，枚举：METRIC_TPL | PROMQL | LOG_TPL | EVENT_TPL # - METRIC_TPL 从指标模板派生（rules[].metricTpl 等） # - PROMQL 自定义 PromQL 表达式（最常用，rules[].expr） # - LOG_TPL 日志告警（额外字段：rules[].logTpl 等） # - EVENT_TPL 事件告警 # 缺少 source 会创建失败（典型表现：rule source unknown） echo '{ "name": "node-health", "clusterName": "kpanda-global-cluster", "namespace": "insight-system", "description": "Node health alerts", "targetType": "NODE", "targets": ["*"], "receivers": [ {"type": "email", "names": ["ops-mail"]} ], "notifyRepeatConfig": [ {"severity": "CRITICAL", "interval": 300} ], "rules": [ { "name": "NodeDown", "source": "PROMQL", "description": "node unreachable for 5m", "severity": "CRITICAL", "duration": "5m", "expr": "up{job=\"node-exporter\"} == 0", "labels": {"team": "ops"}, "annotations": {"summary": "Node {{ $labels.instance }} down"} } ] }' | dc insight alert create-group --file -`

### `dc insight alert create-inhibition`

- Summary: Create an inhibition rule (source matchers suppress target matchers)
- HTTP: `POST /apis/insight.io/v1alpha1/alert/inhibitions`
- Auth: required
- Body: required
- Flags: none
- Output: list path `equal`
- Example: `echo '{ "name": "cluster-down-suppresses-node", "clusterName": "prod-1", "namespace": "insight-system", "description": "if cluster is down, suppress node-level alerts", "equal": ["clusterName"], "sourceMatchers": [{"type":"EQUAL","key":"alertname","value":"ClusterDown"}], "targetMatchers": [{"type":"EQUAL","key":"severity","value":"WARNING"}] }' | dc insight alert create-inhibition --file - # matches/sourceMatchers/targetMatchers 的 type 同 silence：EQUAL / NOT_EQUAL / REGEXP`

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
- Example: `# ⚠️ matches[].type 是枚举字符串，不是 "=" / "=~"。可选： # EQUAL | NOT_EQUAL | REGEXP | MATCH_TYPE_UNSPECIFIED echo '{ "name": "maint-window", "clusterName": "kpanda-global-cluster", "namespace": "insight-system", "description": "weekly maintenance", "matches": [ {"type": "EQUAL", "key": "alertname", "value": "HighCPU"}, {"type": "REGEXP", "key": "instance", "value": "node-.*"} ], "activeTimeInterval": { "weekdayRange": [0], "timeRanges": [{"start":"02:00","end":"04:00"}] } }' | dc insight alert create-silence --file -`

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

- Summary: Get a receiver by name + type
- HTTP: `GET /apis/insight.io/v1alpha1/alert/receivers/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--type` (query, default `RECEIVER_TYPE_UNSPECIFIED`, one of: RECEIVER_TYPE_UNSPECIFIED|webhook|email|dingtalk|wecom|sms|message|lark): Required. webhook | email | dingtalk | wecom | sms | message | lark
- Example: `# ⚠️ --type 必填（proto enum.defined_only），缺失返回 HTTP 400 "type cannot be empty" # type 取值：webhook | email | dingtalk | wecom | sms | message | lark dc insight alert get-receiver --name ops-mail --type email -o json dc insight alert get-receiver --name my-bot --type lark -o json`

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
- Example: `# rule.source 必填（同 create-group / add-group-rule）；params 时间为 unix 秒字符串 END=$(date +%s); START=$((END - 3600)) echo '{ "group": {"clusterName":"kpanda-global-cluster","targetType":"CLUSTER","targets":["*"]}, "rule": {"source":"PROMQL","expr":"vector(1)","duration":"1m","severity":"WARNING"}, "params":{"start":"'"$START"'","end":"'"$END"'","step":60} }' | dc insight alert preview-rule --file -`

### `dc insight alert preview-silence`

- Summary: Preview which alerts a silence definition would match
- HTTP: `POST /apis/insight.io/v1alpha1/alert/silences/preview`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `namespace`, `id`, `builtin`, `clusterName`, `description`, `groupId`
- Example: `# matches[].type 同 create-silence：EQUAL / NOT_EQUAL / REGEXP echo '{ "clusterName": "kpanda-global-cluster", "namespace": "insight-system", "size": "20", "matches": [{"type":"EQUAL","key":"alertname","value":"HighCPU"}] }' | dc insight alert preview-silence --file -`

### `dc insight alert preview-template`

- Summary: Render a notification template against sample alert data
- HTTP: `POST /apis/insight.io/v1alpha1/alert/templates/preview`
- Auth: required
- Body: required
- Flags: none
- Example: `# ⚠️ data 字段使用 commonLabels（驼峰），不是 labels；alerts[] 必填 # 模板里 {{ .CommonLabels.X }} 对应 body 输入的 data.commonLabels.X echo '{ "body": {"email":{"subject":"[T] {{ .CommonLabels.alertname }}","body":"x"}}, "data": { "status": "firing", "commonLabels": {"alertname":"HighCPU"}, "alerts": [{"status":"firing","labels":{"instance":"node1"},"annotations":{"summary":"cpu hot"}}] } }' | dc insight alert preview-template --file -`

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
- Example: `echo '{ "source": "PROMQL", "severity": "CRITICAL", "duration": "10m", "expr": "rate(http_requests_total{code=~\"5..\"}[5m]) > 1", "description": "5xx rate too high" }' | dc insight alert update-group-rule --id <gid> --name HighErr --file -`

### `dc insight alert update-inhibition`

- Summary: Update an inhibition rule
- HTTP: `PUT /apis/insight.io/v1alpha1/alert/inhibitions/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Output: list path `equal`
- Example: `echo '{ "description": "updated suppression", "equal": ["clusterName", "namespace"], "sourceMatchers": [{"type":"EQUAL", "key":"alertname","value":"ClusterDown"}], "targetMatchers": [{"type":"REGEXP","key":"severity","value":"WARNING|INFO"}] }' | dc insight alert update-inhibition --id <iid> --file -`

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
- Example: `echo '{ "description": "extended maintenance window", "matches": [ {"type": "EQUAL", "key": "alertname", "value": "HighCPU"}, {"type": "REGEXP", "key": "instance", "value": "node-.*"} ], "activeTimeInterval": { "weekdayRange": [0, 6], "timeRanges": [{"start":"01:00","end":"05:00"}] } }' | dc insight alert update-silence --id <sid> --file -`

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
- Example: `dc insight event get-reasons -o json # 返回字段（每项为字符串数组）： # node / daemonSet / deployment / job / pod / statefulSet`

### `dc insight event query-event-context`

- Summary: Fetch surrounding events around a specific timestamp (context view)
- HTTP: `GET /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/context`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--timestamp` (query): timestamp e.g. 2023-06-20T16:05:16.887681657Z
  - `--namespace` (query): Optional.
  - `--filter.type` (query, default `TYPE_UNSPECIFIED`, one of: TYPE_UNSPECIFIED|Normal|Warning): 此接口忽略；仅 involve-object-kind/involve-object-name 生效
  - `--filter.involve-object-kind` (query): filter.involveObjectKind
  - `--filter.reason` (query): filter.reason
  - `--filter.involve-object-name` (query): fuzzy search
  - `--filter.message` (query): fuzzy search
  - `--before` (query, default `50`, int32): Optional.
  - `--after` (query, default `50`, int32): Optional.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `action`, `clusterName`; pagination `cursor`
- Example: `# 重要：filter.involve-object-kind 或 filter.involve-object-name 至少传一个， # 否则后端返回 HTTP 400。filter 在该接口只识别这两个字段。 # # 推荐流程：先用 query-events 取锚点，再用 jq 提取 timestamp / involveObject 作参数 EVENT=$(dc insight event query-events \ --cluster-name kpanda-global-cluster --namespace insight-system \ --start-time 2026-05-21T17:00:00Z --end-time 2026-05-21T18:00:00Z \ --filter.type Warning --page 1 --page-size 1 -o json) TS=$(echo "$EVENT" | jq -r '.items[0].timestamp') NS=$(echo "$EVENT" | jq -r '.items[0].metadata.namespace') KIND=$(echo "$EVENT" | jq -r '.items[0].involveObject.kind') NAME=$(echo "$EVENT" | jq -r '.items[0].involveObject.name') dc insight event query-event-context \ --cluster-name kpanda-global-cluster --namespace "$NS" \ --timestamp "$TS" \ --filter.involve-object-kind "$KIND" \ --filter.involve-object-name "$NAME" \ --before 20 --after 20 -o json`

### `dc insight event query-event-count`

- Summary: Aggregate event counts in a time range (POST body supports multiple filters)
- HTTP: `POST /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/count`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `items`
- Example: `# filters 列表：每项对应一个聚合通道；响应 items 是与 filters 等长的 int64 计数数组。 # 字段说明（每个 filter）： # type Normal | Warning（可省，省略表示不限） # involveObjectKind 关联对象类型，如 Pod / Node / Deployment # reason 事件原因（精确） # involveObjectName 关联对象名（模糊） # message 消息体（模糊） # 若 filters 省略，服务端使用默认 6 个通道： # imagePullFail / healthyCheckFail / podFailed / # podFailedScheduling / containerRestartingFailed / podFailedMount echo '{ "namespace": "insight-system", "startTime": "2026-05-21T17:00:00Z", "endTime": "2026-05-21T18:00:00Z", "filters": [ {"type":"Warning","involveObjectKind":"Pod","reason":"FailedScheduling"}, {"type":"Warning","involveObjectKind":"Node"} ] }' | dc insight event query-event-count --cluster-name kpanda-global-cluster --file - # 使用默认 filters（不传 filters 字段） echo '{ "namespace": "insight-system", "startTime": "2026-05-21T17:00:00Z", "endTime": "2026-05-21T18:00:00Z" }' | dc insight event query-event-count --cluster-name kpanda-global-cluster --file -`

### `dc insight event query-event-filter-options`

- Summary: List available filter options (object kinds / reasons) for the event UI
- HTTP: `GET /apis/insight.io/v1alpha1/event/cluster/{clusterName}/events/filter-options`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--start-time` (query): startTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--end-time` (query): endTime e.g. 2006-01-02T15:04:05.999999999Z07:00
  - `--namespace` (query): Optional.
- Output: list path `involvedObjectKinds`
- Example: `dc insight event query-event-filter-options \ --cluster-name kpanda-global-cluster --namespace insight-system \ --start-time 2026-05-21T17:00:00Z --end-time 2026-05-21T18:00:00Z -o json # 返回字段： # involvedObjectKinds 当前窗口内出现过的对象类型（注意是 involvedObjectKinds，而事件对象本身用 involveObject） # reasons 当前窗口内出现过的 reason 列表`

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
- Example: `dc insight event query-event-histogram \ --cluster-name kpanda-global-cluster --namespace insight-system \ --start-time 2026-05-21T17:00:00Z --end-time 2026-05-21T18:00:00Z \ --interval 60s -o json # 返回结构： # items[].timestamp 桶起点 (RFC3339) # items[].normalCount Normal 事件数 # items[].warningCount Warning 事件数 # totalNormal 窗口内 Normal 总数 # totalWarning 窗口内 Warning 总数`

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
  - `--sort` (query): timestamp,desc (默认) | timestamp,asc | type,desc | type,asc
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `type`, `metadata.creationTimestamp`, `action`, `clusterName`; pagination `offset`
- Example: `# 最近 1 小时 insight-system 命名空间内的 Warning 事件 dc insight event query-events \ --cluster-name kpanda-global-cluster --namespace insight-system \ --start-time 2026-05-21T17:00:00Z --end-time 2026-05-21T18:00:00Z \ --filter.type Warning \ --page 1 --page-size 50 -o json # 按 reason + involveObject + message 模糊过滤 dc insight event query-events \ --cluster-name kpanda-global-cluster --namespace insight-system \ --filter.reason FailedScheduling \ --filter.involve-object-kind Pod \ --filter.involve-object-name insight-server \ --filter.message 'insufficient memory' \ --sort 'timestamp,desc' # 返回结构（items 数组每条）： # timestamp 唯一主键，RFC3339Nano，可作 query-event-context 的 --timestamp # type Normal | Warning # reason / message / action / count / firstTimestamp / lastTimestamp # metadata.namespace 命名空间 # metadata.name / uid 事件资源元信息 # involveObject.kind 关联对象类型 (注意：不是 involvedObject) # involveObject.name # involveObject.namespace # clusterName / clusterUuid`

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
- Example: `KUBESYSTEMID=$(dc insight resource get-cluster --name kpanda-global-cluster -o json | jq -r .kubeSystemId) # 字段说明： # type 导出格式枚举：TEXT(默认) / CSV / JSON # maxLines 导出上限 [0,10000]，0 视为 2000 # fields 列枚举（TEXT/CSV 生效；JSON 输出完整记录），可选值： # Timestamp | Cluster | Namespace | Pod | Container | Node | File # sorts 仅支持 "time,desc"（默认）或 "time,asc" # timeZone 导出时间戳的 IANA 时区，如 "Asia/Shanghai" # queryLog 或 queryLogContext，二选一（结构同 query-log / query-log-context） echo '{ "type": "CSV", "maxLines": 5000, "fields": ["Timestamp", "Cluster", "Namespace", "Pod", "Container"], "sorts": ["time,asc"], "timeZone": "Asia/Shanghai", "queryLog": { "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "sorts": ["time,asc"], "resource": { "clusterFilter": ["'"$KUBESYSTEMID"'"], "namespaceFilter": ["insight-system"], "workloadFilter": ["insight-server"] } } }' | dc insight log download-log --file - # 导出某条日志的上下文窗口 echo '{ "type": "TEXT", "maxLines": 200, "fields": ["Timestamp", "Pod", "Container"], "queryLogContext": { "before": 100, "after": 100, "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "nanotimestamp": "2026-05-21T00:30:12.123456789Z", "resource": { "cluster": "'"$KUBESYSTEMID"'", "namespace": "insight-system", "pod": "insight-server-0", "container": "insight-server" } } }' | dc insight log download-log --file -`

### `dc insight log list-log-file-paths`

- Summary: List system log file paths discovered on a node
- HTTP: `GET /apis/insight.io/v1alpha1/log/filepaths`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
  - `--node` (query): node
- Output: list path `paths`
- Example: `# 用集群名（服务端解析为 UUID） dc insight log list-log-file-paths --cluster-name kpanda-global-cluster --node node-1 # 或直接传 UUID KUBESYSTEMID=$(dc insight resource get-cluster --name kpanda-global-cluster -o json | jq -r .kubeSystemId) dc insight log list-log-file-paths --cluster "$KUBESYSTEMID" --node node-1 -o json`

### `dc insight log query-log`

- Summary: Query container or system logs with filters and pagination
- HTTP: `POST /apis/insight.io/v1alpha1/log/query`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `log`, `timestamp`
- Example: `# 1) 先拿到集群 UUID KUBESYSTEMID=$(dc insight resource get-cluster --name kpanda-global-cluster -o json | jq -r .kubeSystemId) # 2) 容器日志：在 kpanda-global-cluster / insight-system 中检索包含 "error" 的日志 # 字段说明（resource filter）： # clusterFilter 集群 UUID 列表，必填且只能 1 个 # namespaceFilter 命名空间精确匹配（需配合 clusterFilter） # workloadFilter 工作负载精确匹配；workloadSearch 为模糊 # podFilter Pod 精确匹配；podSearch 为模糊 # containerFilter 容器精确匹配；containerSearch 为模糊 # logSearch 日志正文关键字（多值 AND） # traceIdSearch 精确匹配 trace_id # luceneFilter Lucene DSL，可选键： # kubernetes.namespace_name.keyword / kubernetes.pod_name.keyword / # kubernetes.container_name.keyword / trace_id.keyword / log # 顶层字段： # startTime/endTime RFC3339Nano，可空表示无界 # page/pageSize 分页（默认 1/10，pageSize 软上限 100） # sorts 仅支持 time 字段；格式 "time,desc" 或 "time,asc"，默认 "time,desc" echo '{ "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "page": 1, "pageSize": 100, "sorts": ["time,desc"], "resource": { "clusterFilter": ["'"$KUBESYSTEMID"'"], "namespaceFilter": ["insight-system"], "workloadFilter": ["insight-server"], "podSearch": ["insight-server"], "logSearch": ["error"], "luceneFilter": "kubernetes.container_name.keyword:insight-server AND log:error" } }' | dc insight log query-log --file - # 3) 系统日志（节点 syslog） # system filter 支持键：nodeFilter / fileFilter / logSearch / luceneFilter # luceneFilter 可用键：syslog.host.keyword / syslog.file.keyword / syslog.ident.keyword / log echo '{ "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "system": { "clusterFilter": ["'"$KUBESYSTEMID"'"], "nodeFilter": ["node-1"], "fileFilter": ["/var/log/messages"], "logSearch": ["oom"] } }' | dc insight log query-log --file - # 返回结构（items 数组每条）： # timestamp RFC3339Nano，可直接作为 query-log-context 的 nanotimestamp # log 日志正文 # labels.cluster 集群 UUID # labels.namespace 命名空间（resource filter 时） # labels.pod Pod 名称 # labels.container 容器名称 # labels.node / labels.file 节点 / 文件（system filter 时）`

### `dc insight log query-log-context`

- Summary: Fetch lines before/after a specific log entry (context view)
- HTTP: `POST /apis/insight.io/v1alpha1/log/context`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `log`, `timestamp`
- Example: `KUBESYSTEMID=$(dc insight resource get-cluster --name kpanda-global-cluster -o json | jq -r .kubeSystemId) # 容器日志上下文 # 字段说明： # before/after 锚点前/后行数，范围 [0,10000]，至少一个 > 0 # nanotimestamp 锚点行的 RFC3339Nano 时间戳（必填） # startTime/endTime 搜索窗口（可选） # resource filter (全部必填)：cluster=集群 UUID, namespace, pod, container # # 推荐流程：先用 query-log 取锚点，再用 jq 提取 timestamp 与 labels.* 作为参数 LOG_RESULT=$(echo '{ "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "page": 1, "pageSize": 1, "resource": { "clusterFilter": ["'"$KUBESYSTEMID"'"], "logSearch": ["error"] } }' | dc insight log query-log --file - -o json) TS=$(echo "$LOG_RESULT" | jq -r '.items[0].timestamp') NS=$(echo "$LOG_RESULT" | jq -r '.items[0].labels.namespace') POD=$(echo "$LOG_RESULT" | jq -r '.items[0].labels.pod') CT=$(echo "$LOG_RESULT" | jq -r '.items[0].labels.container') echo '{ "before": 50, "after": 50, "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "nanotimestamp": "'"$TS"'", "resource": { "cluster": "'"$KUBESYSTEMID"'", "namespace": "'"$NS"'", "pod": "'"$POD"'", "container": "'"$CT"'" } }' | dc insight log query-log-context --file - # 系统日志上下文（system filter 三字段全部必填：cluster / node / file） echo '{ "before": 30, "after": 30, "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "nanotimestamp": "2026-05-21T00:30:12.123456789Z", "system": { "cluster": "'"$KUBESYSTEMID"'", "node": "node-1", "file": "/var/log/messages" } }' | dc insight log query-log-context --file -`

### `dc insight log query-log-histogram`

- Summary: Bucket log counts over time (histogram)
- HTTP: `POST /apis/insight.io/v1alpha1/log/histogram`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `count`, `timestamp`
- Example: `KUBESYSTEMID=$(dc insight resource get-cluster --name kpanda-global-cluster -o json | jq -r .kubeSystemId) # 字段说明： # startTime/endTime RFC3339Nano（必填） # interval ES date_histogram 间隔，如 "1m"/"5m"/"1h"（必填） # resource/system 与 query-log 相同的 filter 二选一 echo '{ "startTime": "2026-05-21T00:00:00.000000000Z", "endTime": "2026-05-21T01:00:00.000000000Z", "interval": "1m", "resource": { "clusterFilter": ["'"$KUBESYSTEMID"'"], "namespaceFilter": ["insight-system"], "logSearch": ["error"] } }' | dc insight log query-log-histogram --file -`

### `dc insight log search-log`

- Summary: Raw Elasticsearch DSL passthrough (advanced)
- HTTP: `GET /apis/insight.io/v1alpha1/log/search`
- Auth: required
- Body: none
- Flags:
  - `--index` (query): index
  - `--query` (query): query
- Example: `# --index 传 ILM 索引后缀（服务端会补前缀），常用 "insight-logs-*" # --query 必须是合法的 ES DSL JSON 字符串 dc insight log search-log \ --index 'insight-logs-*' \ --query '{"query":{"match":{"log":"timeout"}}}' # 在 insight-system 命名空间内查最近 1h 含 "error" 的日志 dc insight log search-log \ --index 'insight-logs-*' \ --query '{ "size": 100, "sort": [{"@timestamp":"desc"}], "query": { "bool": { "must": [{"match": {"log": "error"}}], "filter": [ {"term": {"kubernetes.namespace_name.keyword": "insight-system"}}, {"range": {"@timestamp": {"gte": "now-1h", "lte": "now"}}} ] } } }' -o json`

## Metric

### `dc insight metric batch-query-metric`

- Summary: Run multiple PromQL instant queries in one call (shared label match)
- HTTP: `POST /apis/insight.io/v1alpha1/metric/query`
- Auth: required
- Body: required
- Flags: none
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# matchLabel 字段说明： # clusterName 集群名（与 cluster 二选一） # cluster 集群 UUID（与 clusterName 二选一） # namespace 可选 # extraLabel 附加 label 过滤（map<string,string>），会注入到每条 query # param.time unix 秒 # queryList PromQL 数组，非空 echo '{ "matchLabel": { "clusterName": "kpanda-global-cluster", "namespace": "insight-system" }, "param": {"time": '"$(date +%s)"'}, "queryList": [ "up", "sum(rate(container_cpu_usage_seconds_total[5m]))" ] }' | dc insight metric batch-query-metric --file - -o json # 返回结构： # data[].data.vector[] 与 query-metric 同结构 # data[].status SUCCESS | FAIL # data[].errorMessage 失败时的错误信息 # data 数组按 queryList 顺序一一对应。`

### `dc insight metric batch-query-range-metric`

- Summary: Run multiple PromQL range queries in one call (shared label match)
- HTTP: `POST /apis/insight.io/v1alpha1/metric/queryrange`
- Auth: required
- Body: required
- Flags: none
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# param.start/end 为 unix 秒，step 为秒 (double) END=$(date +%s); START=$((END - 3600)) echo '{ "matchLabel": { "clusterName": "kpanda-global-cluster", "namespace": "insight-system" }, "param": {"start": '"$START"', "end": '"$END"', "step": 60}, "queryList": [ "up", "sum(rate(container_cpu_usage_seconds_total[5m]))" ] }' | dc insight metric batch-query-range-metric --file - -o json # 返回结构： # data[].data.matrix[] 与 query-range-metric 同结构 # data[].status SUCCESS | FAIL # data[].errorMessage # data 数组按 queryList 顺序一一对应。`

### `dc insight metric format-query`

- Summary: Pretty-print / normalize a PromQL expression (server-side formatter)
- HTTP: `POST /apis/insight.io/v1alpha1/metric/format_query`
- Auth: required
- Body: required
- Flags: none
- Example: `echo '{"query":"sum(rate(http_requests_total{code=~\"5..\"}[5m]))/sum(rate(http_requests_total[5m]))"}' \ | dc insight metric format-query --file - -o json # 返回结构：{ "query": "<格式化后的 PromQL>" }（对象，非数组）`

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
- Example: `# 用集群名 - 当前所有 targets 的 up 状态 dc insight metric query-metric \ --cluster-name kpanda-global-cluster \ --query 'up' -o json # 用集群 UUID（与 --cluster-name 二选一） KUBESYSTEMID=$(dc insight resource get-cluster --name kpanda-global-cluster -o json | jq -r .kubeSystemId) dc insight metric query-metric --cluster "$KUBESYSTEMID" --query 'up' -o json # 指定命名空间 + 时间戳（unix 秒）的瞬时 CPU 查询 dc insight metric query-metric \ --cluster-name kpanda-global-cluster \ --namespace insight-system \ --query 'sum(rate(container_cpu_usage_seconds_total{namespace="insight-system"}[5m])) by (pod)' \ --time 1747850400 -o json # 返回结构：vector 数组，每项 { metric: {labels}, values: { timestamp, value } }`

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
- Example: `# 最近 1 小时 up 指标，30s 采样 END=$(date +%s); START=$((END - 3600)) dc insight metric query-range-metric \ --cluster-name kpanda-global-cluster \ --query 'up' \ --start $START --end $END --step 30 -o json # insight-system 命名空间内 Pod CPU 使用率 dc insight metric query-range-metric \ --cluster-name kpanda-global-cluster \ --namespace insight-system \ --query 'sum(rate(container_cpu_usage_seconds_total[5m])) by (pod)' \ --start $START --end $END --step 60 -o json # 字段说明： # --start/--end unix 秒 (int64) # --step 采样间隔秒 (double)，可传小数 # 返回结构：matrix 数组，每项 { metric: {labels}, values: [{timestamp,value}, ...] }`

## Overview

### `dc insight overview get-resources-count`

- Summary: Get global resource counts (clusters / nodes / pods / deployments / GPU / log / trace)
- HTTP: `GET /apis/insight.io/v1alpha1/overview/resources/count`
- Auth: required
- Body: none
- Flags:
  - `--time` (query, int64): time unix timestamp .e.g. 1697597347
  - `--filters` (query): 可重复传入。可选值： CLUSTER_TOTAL | CLUSTER_NORMAL_TOTAL NODE_TOTAL | NODE_NORMAL_TOTAL DEPLOYMENT_TOTAL | DEPLOYMENT_NORMAL_TOTAL STATEFULSET_TOTAL | STATEFULSET_NORMAL_TOTAL DAEMONSET_TOTAL | DAEMONSET_NORMAL_TOTAL JOB_TOTAL | JOB_NORMAL_TOTAL POD_TOTAL | POD_NORMAL_TOTAL GPU_COUNT | GPU_ALLOCATED_COUNT LOG_TOTAL | TRACE_TOTAL 省略时返回上述全部 16 项。
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# 默认返回 16 个资源类型 dc insight overview get-resources-count -o json # 指定时间点（unix 秒）+ 仅查集群与节点 dc insight overview get-resources-count \ --time $(date +%s) \ --filters CLUSTER_TOTAL --filters CLUSTER_NORMAL_TOTAL \ --filters NODE_TOTAL --filters NODE_NORMAL_TOTAL -o json`

### `dc insight overview get-resources-range`

- Summary: Get resource counts over a time range (sparkline data)
- HTTP: `GET /apis/insight.io/v1alpha1/overview/resources/range`
- Auth: required
- Body: none
- Flags:
  - `--filters` (query): 可重复传入。可选值： NODE_TOTAL | POD_TOTAL | POD_NORMAL_TOTAL | POD_ABNORMAL_TOTAL 省略时默认 [NODE_TOTAL, POD_NORMAL_TOTAL, POD_ABNORMAL_TOTAL]。
  - `--start` (query, int64): start unix timestamp .e.g. 1697597347
  - `--end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--step` (query, double): 采样间隔秒 (double)。默认 60。
- Output: list path `data`; columns `errorMessage`, `status`
- Example: `# 最近 1 小时，60s 采样 END=$(date +%s); START=$((END - 3600)) dc insight overview get-resources-range \ --start $START --end $END --step 60 \ --filters NODE_TOTAL --filters POD_NORMAL_TOTAL --filters POD_ABNORMAL_TOTAL -o json`

### `dc insight overview get-resources-usage`

- Summary: Get top-N resource usage time series (CPU / memory / disk) for clusters or nodes
- HTTP: `GET /apis/insight.io/v1alpha1/overview/resources/usage`
- Auth: required
- Body: none
- Flags:
  - `--filters` (query): 可重复传入。可选值： CLUSTER_CPU_USAGE | CLUSTER_MEM_USAGE | CLUSTER_DISK_USAGE NODE_CPU_USAGE | NODE_MEM_USAGE | NODE_DISK_USAGE 省略时默认 [CLUSTER_CPU_USAGE, NODE_CPU_USAGE]。
  - `--limit` (query, int64): Top-N 上限（按值降序）。默认 5。
  - `--start` (query, int64): start unix timestamp .e.g. 1697597347
  - `--end` (query, int64): end unix timestamp .e.g. 1697597347
  - `--step` (query, double): 采样间隔秒 (double)。默认 60。
- Output: list path `data`; columns `errorMessage`, `status`; pagination `cursor`
- Example: `END=$(date +%s); START=$((END - 3600)) # 节点 CPU 使用率 Top 5 dc insight overview get-resources-usage \ --start $START --end $END --step 60 \ --filters NODE_CPU_USAGE --limit 5 -o json # 集群级 CPU 使用率 dc insight overview get-resources-usage \ --start $START --end $END --step 60 \ --filters CLUSTER_CPU_USAGE --limit 10 -o json`

### `dc insight overview get-services-monitor`

- Summary: Get a snapshot of service-level APM signals (avg latency / error rate)
- HTTP: `GET /apis/insight.io/v1alpha1/overview/services/monitor`
- Auth: required
- Body: none
- Flags:
  - `--filters` (query): 可重复传入。可选值： AVG_LATENCY 返回值单位 ms ERR_RATE 返回值为百分比 省略时默认 [AVG_LATENCY, ERR_RATE]。
  - `--limit` (query, int64): Top-N 上限（按值降序）。默认 5。
  - `--time` (query, int64): timestamp unix timestamp .e.g. 1697597347
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
- Output: list path `data`; columns `errorMessage`, `status`; pagination `cursor`
- Example: `# 默认 - 平均延迟 + 错误率，Top 5 dc insight overview get-services-monitor -o json # 限制返回 10 条 dc insight overview get-services-monitor --limit 10 -o json # 指定时间点 + 仅统计 SERVER span dc insight overview get-services-monitor \ --time $(date +%s) --limit 5 \ --span-kinds SPAN_KIND_SERVER -o json`

## Probe

### `dc insight probe add-probe`

- Summary: Create a probe (PrometheusOperator Probe / blackbox-exporter)
- HTTP: `POST /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
- Example: `# 1) 先查可用 prober + module dc insight probe list-probers --cluster-name kpanda-global-cluster -o json # 2) 用上一步返回的 prober.url / 选定 module 创建 # 字段说明（probe / ProbeSpec）： # jobName 必填，^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$，1~63 # module 必填，须在该 prober 的 modules 列表中 # 常见: http_2xx | HTTP_GET | HTTP_POST | TCP | POP3S | SSH # interval 抓取间隔（go duration），如 "30s" # scrapeTimeout 抓取超时 # prober { name, url, scheme(http/https), path(/probe), proxyUrl } # targets.staticConfig.static 目标地址列表 # targets.staticConfig.labels 附加 label（map<string,string>） # 可选：proxyUrl / enableHttp2 / followRedirects / sampleLimit / # honorTimestamps / honorLabels / relabelings / metricRelabelings echo '{ "probe": { "jobName": "web-check", "module": "http_2xx", "interval": "30s", "scrapeTimeout": "10s", "prober": { "name": "insight-agent-prometheus-blackbox-exporter", "url": "insight-agent-prometheus-blackbox-exporter.insight-system:9115", "scheme": "http", "path": "/probe" }, "targets": { "staticConfig": { "static": [ "https://example.com", "https://api.example.com/health" ], "labels": {"team": "ops"} } } } }' | dc insight probe add-probe \ --cluster-name kpanda-global-cluster --namespace insight-system --file -`

### `dc insight probe delete-probe`

- Summary: Delete a probe by cluster + namespace + jobName
- HTTP: `DELETE /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes/{jobName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--job-name` (path, required): jobName
- Example: `dc insight probe delete-probe \ --cluster-name kpanda-global-cluster --namespace insight-system \ --job-name web-check`

### `dc insight probe get-probe`

- Summary: Get a probe by cluster + namespace + jobName
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes/{jobName}`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--job-name` (path, required): jobName
- Example: `dc insight probe get-probe \ --cluster-name kpanda-global-cluster --namespace insight-system \ --job-name web-check -o json # 资源不存在时返回 HTTP 404。`

### `dc insight probe list-probers`

- Summary: List blackbox-exporter probers available in a cluster
- HTTP: `GET /apis/insight.io/v1alpha1/clusters/{clusterName}/probers`
- Auth: required
- Body: none
- Flags:
  - `--cluster-name` (path, required): clusterName
- Output: list path `probers`
- Example: `dc insight probe list-probers --cluster-name kpanda-global-cluster -o json # 返回结构： # probers[].prober ProberSpec { name, url, scheme, path, proxyUrl } # probers[].modules 该 prober 支持的模块名数组，例如： # [http_2xx, HTTP_GET, HTTP_POST, TCP, POP3S, SSH] # probers[].configmapMeta { clusterName, namespace, name, data } 模块定义来源`

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
  - `--sorts` (query): 单一排序字段，格式 "<field>[,asc|desc]"，仅省略方向时默认 desc。 支持：job_name,desc | job_name,asc | create_at,desc | create_at,asc 默认：create_at,desc
- Output: list path `items`; columns `metadata.name`, `metadata.namespace`, `status.phase`, `kind`, `metadata.creationTimestamp`, `apiVersion`; pagination `offset`
- Example: `dc insight probe list-probes \ --cluster-name kpanda-global-cluster --namespace insight-system -o json # 模糊搜索 + 分页 + 排序 dc insight probe list-probes \ --cluster-name kpanda-global-cluster --namespace insight-system \ --fuzzy-name http --sorts 'create_at,desc' \ --page 1 --page-size 50 -o json # 返回 items[] 每条结构： # kind / apiVersion / metadata # spec { jobName, module, prober, targets, interval, scrapeTimeout, ... } # status.phase Pending | Running | Failed`

### `dc insight probe update-probe`

- Summary: Update a probe's interval / scrapeTimeout / module / targets
- HTTP: `PUT /apis/insight.io/v1alpha1/clusters/{clusterName}/namespaces/{namespace}/probes/{jobName}`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): clusterName
  - `--namespace` (path, required): namespace
  - `--job-name` (path, required): jobName
- Example: `# 只能更新这 4 个字段；其他 spec 字段（prober/relabelings/...) 需删了重建。 echo '{ "interval": "60s", "scrapeTimeout": "15s", "module": "http_2xx", "targets": { "staticConfig": { "static": ["https://example.com"], "labels": {"team": "ops", "tier": "edge"} } } }' | dc insight probe update-probe \ --cluster-name kpanda-global-cluster --namespace insight-system \ --job-name web-check --file -`

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
- Example: `# 时间格式：--start / --end 同时接受 unix 秒 (int) 或 RFC3339 字符串 # --step 单位为秒 END=$(date +%s); START=$((END - 3600)) # 最近 1 小时，30s 步长 dc insight resource get-pod-metrics \ --cluster kpanda-global-cluster --namespace kube-system \ --name coredns-6d4d6f8c7-x8zvw \ --start $START --end $END --step 30 -o json # 指定 metric 子集（PromQL-like keys，服务端定义） dc insight resource get-pod-metrics \ --cluster kpanda-global-cluster --namespace kube-system \ --name coredns-6d4d6f8c7-x8zvw \ --start $START --end $END --step 30 \ --query-list cpuUsage --query-list memoryUsage -o json # 输出：.metrics 字段（按 metric key 分组的时序数据）`

### `dc insight resource get-server-component-summary`

- Summary: Get insight-server-side component status summary (cluster-agnostic)
- HTTP: `GET /apis/insight.io/v1alpha1/server/component`
- Auth: required
- Body: none
- Flags: none
- Output: list path `summary`; columns `name`, `phase`, `creationTimestamp`, `availability`, `message`, `version`
- Example: `# 不需要 --cluster 参数；查询 Insight 服务端各组件健康状态。 dc insight resource get-server-component-summary -o json`

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
- Example: `dc insight resource list-deployments --cluster kpanda-global-cluster dc insight resource list-deployments --cluster kpanda-global-cluster --namespace kube-system \ --phase WORKLOAD_STATE_NOT_READY -o json # 输出：.items[] 主要字段 name / namespace / tracingEnabled # （Deployment 详情通过 get-deployment 获取，含 conditions / metadata 等完整字段）`

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
- Example: `# --cluster 必填（集群名或 UUID） dc insight resource list-namespaces --cluster kpanda-global-cluster -o json # 备注：返回的 items 仅包含被 Insight 监控覆盖的命名空间； # 如果为空，可能是该集群 insight-agent 未启用或采集尚未生效。`

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
- Example: `dc insight resource list-services --cluster kpanda-global-cluster dc insight resource list-services --cluster kpanda-global-cluster \ --namespace kube-system --name coredns -o json # 输出：.items[] 主要字段 name / namespace / tracingEnabled`

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
- Example: `# 时间用毫秒：bash 拼接示例 END=$(date +%s)000; START=$(($(date +%s) - 3600))000 # 基础查询（必填：clusterNames + start + end） echo '{ "clusterNames": ["kpanda-global-cluster"], "start": "'"$START"'", "end": "'"$END"'" }' | dc insight servicegraph get-graph --file - -o json # 按命名空间过滤 echo '{ "clusterNames": ["kpanda-global-cluster"], "namespaces": ["insight-system"], "start": "'"$START"'", "end": "'"$END"'" }' | dc insight servicegraph get-graph --file - -o json # 带 graphType / layer / 依赖深度过滤 # 注意：graphType / layer 是大写枚举字符串（非 "service" / "L7"），传错值会返回 HTTP 400 echo '{ "clusterNames": ["kpanda-global-cluster"], "namespaces": ["insight-system"], "services": ["insight-server"], "workloads": ["insight-server"], "start": "'"$START"'", "end": "'"$END"'", "graphType": "SERVICE_SCOPE", "layer": "KUBERNETES", "showUpDownRelatedNode": true, "filters": { "aggType": "INTERSECTION", "dependencyMaxDepth": 3, "clauses": [ {"dataType":"NODE_DATA","field":"SERVICE_NAME","operation":"CONTAIN","stringValue":"insight"} ] } }' | dc insight servicegraph get-graph --file - -o json # 请求体字段（BaseGraphQuery）： # clusterNames 集群名数组，必填 # clusters 集群 UUID 数组（与 clusterNames 二选一/并存） # start / end unix 毫秒字符串（必填） # namespaces / services / workloads 作用域过滤（可选） # extensionLabels 形如 "skoala_registry=ireg-1,instance_name=xxx" # layer 枚举 KUBERNETES | MESH | OS_LINUX(=VM) | INFRA | GENERAL # graphType 枚举 CLUSTER_SCOPE | NAMESPACE_SCOPE | SERVICE_SCOPE | # WORKLOAD_SCOPE | INSTANCE_SCOPE | MIXED # showVirtualNode 默认 false # showUpDownRelatedNode 默认 false；true 时展示上下游 # filters.aggType INTERSECTION（UNION 暂未支持） # filters.dependencyMaxDepth 依赖深度，默认 1 # filters.clauses[] { dataType=NODE_DATA, field, operation, stringValue|floatValue } # field=SERVICE_NAME 支持 CONTAIN/NOT_CONTAIN/EQUAL/NOT_EQUAL/REGEX_PATTERN # field=STATUS_ERROR_RATE 支持 LE/GE，使用 floatValue # field=STATUS_LATENCY 支持 LE/GE，使用 floatValue（单位 ms） # # 返回结构（Graph）： # nodes[] { id, parent, type(NodeType), metadata, position, statuses[] } # edges[] { id, source, target, statuses[], properties } # layer / graphType # Status.name 约定：requestsPerMinute / errorRate(%) / avgLatency(ms) / # replicas / availableReplicas / healthyStatus(0~3) ... # # ────────────────────────────────────────────────────────────────── # 数据分析指南 # ────────────────────────────────────────────────────────────────── # Edge.statuses 上的常见指标名： # request_total 总请求数 # request_failed_total 失败请求数 # request_per_second QPS # request_avg_latency 平均延迟（秒，展示时按需换算成 ms） # # 第一步：Node 数据分析 # 1.1 服务类型分布：按 nodes[].type 分组计数 # jq '.nodes | group_by(.type) # | map({type: .[0].type, count: length})' # # 1.2 服务依赖数 TOP5（作为 edge.source 出现的次数） # jq '.edges | group_by(.source) # | map({source: .[0].source, count: length}) # | sort_by(.count) | reverse | .[:5]' # # 1.3 服务被依赖数 TOP5（作为 edge.target 出现的次数） # jq '.edges | group_by(.target) # | map({target: .[0].target, count: length}) # | sort_by(.count) | reverse | .[:5]' # # 第二步：Edge 指标 TOP5 # 2.1 错误数 TOP5：按 statuses[name=request_failed_total].value 降序 # jq '.edges # | map(select(.statuses[]? # | .name == "request_failed_total" and .value > 0)) # | sort_by(.statuses[] | select(.name == "request_failed_total") | .value) # | reverse | .[:5] # | map({source, target, # failed: (.statuses[] | select(.name == "request_failed_total") | .value)})' # # 2.2 请求数 TOP5：按 statuses[name=request_total].value 降序 # jq '.edges # | sort_by(.statuses[] | select(.name == "request_total") | .value) # | reverse | .[:5] # | map({source, target, # total: (.statuses[] | select(.name == "request_total") | .value)})' # # 2.3 平均延迟 TOP5：按 statuses[name=request_avg_latency].value 降序 # jq '.edges # | sort_by(.statuses[] | select(.name == "request_avg_latency") | .value) # | reverse | .[:5] # | map({source, target, # latency: (.statuses[] | select(.name == "request_avg_latency") | .value)})' # 展示时给延迟带单位（ms / s）。 # # 第三步：汇总异常服务 # 综合上述结果，按严重度排序输出 service / issue 列表： # 请求错误 > 请求延迟高 > 请求太多 > 其他 # # 注意：node.id / edge.source / edge.target 中可能含集群 UUID。 # 展示给用户时应替换为集群名： # dc insight resource list-clusters -o json # | jq -r '.items[] | .kubeSystemId + " " + .name' # 用上面映射把 UUID 替换回名字再输出表格。`

### `dc insight servicegraph get-node-metrics`

- Summary: Get aggregated metrics for a node (service/workload) on the topology graph
- HTTP: `GET /apis/insight.io/v1alpha1/service-graph/node-metrics`
- Auth: required
- Body: none
- Flags:
  - `--cluster` (query): 集群 UUID（与 --cluster-name 二选一，至少传一个）
  - `--namespace` (query): namespace
  - `--service` (query): service
  - `--extension-filters` (query): extension_filters eg. skoala_registry=ire-111,instance=xxx
  - `--end-time` (query, int64): end_time 结束时间 unix timestamp，单位 ms
  - `--lookback` (query, int64): 回退时长 ms（必填）
  - `--step` (query, int64): 采样步长 ms（必填）
  - `--rate-per` (query, int64): ratePer 变化率计算步长 unix timestamp，单位 ms
  - `--cluster-name` (query): Required. e.g. clusterName=kpanda-global-cluster must give one of
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the
- Output: list path `errorsRateMetrics`
- Example: `END=$(date +%s)000 # 单个服务节点 30 分钟指标（endTime/lookback/step/rate-per 单位都是 ms） dc insight servicegraph get-node-metrics \ --cluster-name kpanda-global-cluster --namespace insight-system \ --service insight-server \ --end-time $END --lookback 1800000 \ --step 60000 --rate-per 60000 \ --span-kinds SPAN_KIND_SERVER -o json # 用 extension-filters 做 label 选择 dc insight servicegraph get-node-metrics \ --cluster-name kpanda-global-cluster --namespace insight-system \ --service insight-server \ --extension-filters 'skoala_registry=ire-111,instance=10.0.0.1' \ --end-time $END --lookback 1800000 --step 60000 --rate-per 60000 -o json`

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
- Example: `# 必填：--trace-id / --cluster-name / --namespace dc insight tracing find-jaeger-trace --trace-id <traceId> \ --cluster-name kpanda-global-cluster --namespace insight-system -o json # 非法 trace id 时后端返回 "uninitialized TraceID is not allowed"`

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
- Example: `# 最近 1 小时某服务的全部 trace dc insight tracing find-jaeger-traces \ --cluster-name kpanda-global-cluster --namespace ghippo-system \ --service-name ghippo-apiserver \ --start "$(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ)" \ --end "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \ --limit 50 -o json # 慢 trace（>500ms）+ 指定 operation dc insight tracing find-jaeger-traces \ --cluster-name kpanda-global-cluster --namespace ghippo-system \ --service-name ghippo-apiserver --operation-name 'GET /api/v1/orders' \ --duration-min 500ms --duration-max 5s \ --start "$(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ)" \ --end "$(date -u +%Y-%m-%dT%H:%M:%SZ)" -o json # 输出：.traces[] 含 duration / method / operationName / protocol / spanCount / startTime`

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
- Example: `END=$(date +%s)000 # 必填：--cluster-name --namespace --service-name dc insight tracing get-operation-detail \ --cluster-name kpanda-global-cluster --namespace ghippo-system \ --service-name ghippo-apiserver \ --end-time $END --lookback 1800000 \ --step 60000 --rate-per 60000 \ --span-kinds SPAN_KIND_SERVER \ --sort 'p99,desc' --page 1 --page-size 50 -o json # 输出：.metrics[] per-operation 的速率 / 错误率 / 延迟分位`

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
- Example: `END=$(date +%s)000 # 必填：--cluster-name --namespace --service-names dc insight tracing get-service-detail \ --cluster-name kpanda-global-cluster --namespace insight-system \ --service-names insight-agent --group-by-operation=true \ --end-time $END --lookback 1800000 \ --step 60000 --rate-per 60000 \ --span-kinds SPAN_KIND_SERVER -o json # 输出（皆为 SampleStream 时序数组）： # .reqRateMetric 吞吐 # .errorsRateMetrics 错误率 # .p50Metrics / .p75Metrics / .p95Metrics 延迟分位`

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
- Example: `END=$(date +%s)000 # 必填：--name --cluster-name --namespace dc insight tracing get-service-pods --name ghippo-apiserver \ --cluster-name kpanda-global-cluster --namespace ghippo-system \ --end-time $END --lookback 1800000 \ --sort 'reqPercentage,desc' --page 1 --page-size 50 -o json # 输出：.items[] 含 podName / namespace / clusterName / reqPercentage`

### `dc insight tracing get-services`

- Summary: List APM services with rate / latency / error metrics
- HTTP: `GET /apis/insight.io/v1alpha1/traces/services`
- Auth: required
- Body: none
- Flags:
  - `--namespace` (query): Optional.
  - `--extension-filters` (query): Support extension search
  - `--end-time` (query, int64): end_time is the ending time of the time series query range.
  - `--lookback` (query, int64): 回退时长 ms
  - `--span-kinds` (query): spanKinds is the list of span kinds to include (logical OR) in the resulting metrics aggregation.
  - `--page` (query, default `1`, int32): Page is current page.
  - `--page-size` (query, default `20`, int32): Size is the data number shown per page.
  - `--sort` (query): sorts determines the data list order.
  - `--cluster` (query): cluster
  - `--cluster-name` (query): clusterName
- Output: list path `items`; columns `namespace`, `errorRate`, `repLatency`, `reqRate`, `serviceName`; pagination `offset`
- Example: `END=$(date +%s)000 # 默认全 namespace；可加 --namespace 过滤 dc insight tracing get-services \ --cluster-name kpanda-global-cluster \ --end-time $END --lookback 1800000 \ --span-kinds SPAN_KIND_SERVER --sort 'reqRate,desc' \ --page 1 --page-size 50 -o json # 输出：.items[] 含 namespace / serviceName / errorRate / repLatency / reqRate`

### `dc insight tracing get-slow-sql-spans`

- Summary: List individual slow-SQL spans (drill-down from statement-top-k)
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/spans`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `items`; columns `duration`, `sourcePod`, `spanId`, `startTime`, `status`, `traceId`
- Example: `# sort 支持：startTimeMillis,desc | startTimeMillis,asc | duration,desc | duration,asc echo '{ "namespace": "ghippo-system", "startTime": "2026-05-21T07:00:00.000Z", "endTime": "2026-05-21T08:00:00.000Z", "sort": "duration,desc", "page": 1, "pageSize": 50, "clauses": [ {"field":"db.statement","operation":"CONTAIN","stringValue":"SELECT"}, {"field":"duration","operation":"GT","floatValue":1000} ] }' | dc insight tracing get-slow-sql-spans \ --cluster-name kpanda-global-cluster --file - -o json # 输出：.items[] 含 duration / sourcePod / spanId / startTime / status / traceId`

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
- Example: `# 必填：--name (tag key) --cluster --namespace dc insight tracing get-tag-values --name http.status_code \ --cluster kpanda-global-cluster --namespace ghippo-system \ --service-names ghippo-apiserver --limit 100 -o json # 输出：.values[]`

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
- Example: `# 必填：--cluster --namespace；--start / --end 默认 [now-15m, now] dc insight tracing get-tags \ --cluster kpanda-global-cluster --namespace ghippo-system \ --service-names ghippo-apiserver --limit 500 \ --start 2026-05-21T07:00:00Z --end 2026-05-21T08:00:00Z -o json # 输出：.tags[]`

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
- Example: `# ⚠️ --namespace 必填，缺失返回 HTTP 400 dc insight tracing list-service-names \ --cluster-name kpanda-global-cluster --namespace insight-system -o json # 输出：.services[]`

### `dc insight tracing query-metadata`

- Summary: List slow-SQL metadata (DB address / system / statement) for a cluster
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/type/{type}/metadata`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
  - `--type` (path, required, one of: DATABASE_ADDRESS|DATABASE_SYSTEM|SQL_STATEMENT): type
- Output: list path `items`
- Example: `# --type 必填，枚举：DATABASE_ADDRESS | DATABASE_SYSTEM | SQL_STATEMENT echo '{ "namespace": "ghippo-system", "startTime": "2026-05-21T07:00:00.000Z", "endTime": "2026-05-21T08:00:00.000Z", "limit": 100, "clauses": [ {"field":"db.system","operation":"EQUAL","stringValue":"mysql"} ] }' | dc insight tracing query-metadata \ --cluster-name kpanda-global-cluster --type SQL_STATEMENT --file - -o json # 输出：.items[]`

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
- Example: `# 必填：--cluster-name --namespace --service-name dc insight tracing query-operations \ --cluster-name kpanda-global-cluster --namespace ghippo-system \ --service-name ghippo-apiserver --max-size 200 -o json # 输出：.operations[]`

### `dc insight tracing query-span-histogram`

- Summary: Bucket span counts over time (normal / error / total)
- HTTP: `POST /apis/insight.io/v1alpha1/jaeger/v2/spans/histogram`
- Auth: required
- Body: required
- Flags: none
- Output: list path `countItems`; columns `error`, `normal`, `timestamp`, `total`
- Example: `# ⚠️ start/end 必须 RFC3339；传 unix ms 会导致分桶数异常（实测 60001 桶） echo '{ "clusterName": "kpanda-global-cluster", "namespace": "ghippo-system", "serviceName": ["ghippo-apiserver"], "start": "2026-05-21T07:00:00.000Z", "end": "2026-05-21T08:00:00.000Z", "interval": "1m", "onlyErrorSpans": false }' | dc insight tracing query-span-histogram --file - -o json # 输出： # .countItems[] { timestamp(ms), normal, error, total } # .durationItems[] { timestamp(ms), p75Duration, p95Duration, p99Duration, avgDuration (ns) }`

### `dc insight tracing query-spans`

- Summary: Query spans with rich filters (tags, error-only, sort, pagination)
- HTTP: `POST /apis/insight.io/v1alpha1/jaeger/v2/spans`
- Auth: required
- Body: required
- Flags: none
- Output: list path `items`; columns `duration`, `method`, `operationName`, `protocol`, `serviceName`, `spanId`
- Example: `# ⚠️ POST body 中 start / end 必须是 RFC3339(Nano) 字符串，不是 unix ms # sort 支持：startTime,desc | startTime,asc | duration,desc | duration,asc（默认 startTime,desc） echo '{ "clusterName": "kpanda-global-cluster", "namespace": "ghippo-system", "serviceName": ["ghippo-apiserver"], "operationName": ["GET /api/v1/orders"], "start": "2026-05-21T07:00:00.000Z", "end": "2026-05-21T08:00:00.000Z", "durationMin": "200ms", "onlyErrorSpans": true, "sort": "duration,desc", "page": 1, "pageSize": 50, "tags": [ {"key":"http.status_code","operation":"EQUAL","value":"500"} ] }' | dc insight tracing query-spans --file - -o json # 字段说明： # clusterName / cluster 二选一 # namespace 必填 # serviceName / operationName 字符串数组 # durationMin/durationMax go duration: ns/us/ms/s/m/h # tags[].operation FilterOperator # CONTAIN/NOT_CONTAIN/EQUAL/NOT_EQUAL/REGEX_PATTERN/ # LT/LE/GT/GE/EQ/NE # onlyErrorSpans 仅返回错误 span # spanKinds 可选，默认 [SPAN_KIND_SERVER, SPAN_KIND_CLIENT] # 输出：.items[] 含 duration / method / operationName / protocol / serviceName / spanId`

### `dc insight tracing statement-histogram`

- Summary: Histogram of SQL statement durations (cluster scoped, slow-SQL)
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/statement/histogram`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `duration`; columns `timestamp`, `value`
- Example: `# sort 支持（proto canonical，逗号分隔，默认 request_count,desc）： # request_count,desc | request_count,asc # avg_duration,desc | avg_duration,asc # error_requests,desc| error_requests,asc # error_rate,desc | error_rate,asc # @timestamp,desc | @timestamp,asc echo '{ "namespace": "ghippo-system", "startTime": "2026-05-21T07:00:00.000Z", "endTime": "2026-05-21T08:00:00.000Z", "interval": "1m", "topN": 10, "sort": "avg_duration,desc", "clauses": [ {"field":"db.system","operation":"EQUAL","stringValue":"mysql"} ] }' | dc insight tracing statement-histogram \ --cluster-name kpanda-global-cluster --file - -o json # 输出（按时间桶的 BucketHistogram 数组）： # .total 调用次数 # .duration 平均耗时（ns） # .errors 错误次数 # .errorRate 错误率 # .sourcePods 调用容器组`

### `dc insight tracing statement-top-k`

- Summary: Top-K slowest SQL statements aggregated by source service
- HTTP: `POST /apis/insight.io/v1alpha1/traces/slow-sql/clusters/{clusterName}/statement/topk`
- Auth: required
- Body: required
- Flags:
  - `--cluster-name` (path, required): Required.
- Output: list path `items`; columns `address`, `avgDuration`, `errorRate`, `sourceCluster`, `sourceNamespace`, `sourceService`
- Example: `echo '{ "namespace": "ghippo-system", "startTime": "2026-05-21T07:00:00.000Z", "endTime": "2026-05-21T08:00:00.000Z", "topN": 20, "sort": "avg_duration,desc" }' | dc insight tracing statement-top-k \ --cluster-name kpanda-global-cluster --file - -o json # 输出：.items[] 含 address / system / sourceCluster / sourceNamespace / # sourceService / statement / totalCount / avgDuration(ns) / errorRate`

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

