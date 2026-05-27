# Module `global-management`

## Source

- Backend: `swagger`
- Repository: https://github.com/DaoCloud/daocloud-api-docs.git
- Pinned tag: `4bc92dd4c0c1637b4257f69e26eb8dd6cdd269f3`
- Files: `docs/openapi/ghippo/v0.45.1.json`
- Resolved SHA: `4bc92dd4c0c1637b4257f69e26eb8dd6cdd269f3`

## About

### `dce global-management about list-developers`

- Summary: About_ListDevelopers
- HTTP: `GET /apis/ghippo.io/v1alpha1/about/developers`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `message`

### `dce global-management about list-g-product-versions`

- Summary: About_ListGProductVersions
- HTTP: `GET /apis/ghippo.io/v1alpha1/about/versions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `version`

### `dce global-management about list-open-sources`

- Summary: About_ListOpenSources
- HTTP: `GET /apis/ghippo.io/v1alpha1/about/opensources`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): page: 当前页码，默认值为1
  - `--page-size` (query, default `20`, int32): 每页数量,默认为 10
- Output: list path `items`; columns `name`, `license`; pagination `offset`

## Account

### `dce global-management account certify-check`

- Summary: Account_CertifyCheck
- HTTP: `POST /apis/ghippo.io/v1alpha1/current-user/certify/check`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account certify-init`

- Summary: Account_CertifyInit
- HTTP: `POST /apis/ghippo.io/v1alpha1/current-user/certify`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account create-access-token`

- Summary: Account_CreateAccessToken
- HTTP: `POST /apis/ghippo.io/v1alpha1/current-user/accesstoken`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account create-ssh-key`

- Summary: Account_CreateSSHKey
- HTTP: `POST /apis/ghippo.io/v1alpha1/current-user/sshkeys`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account delete-access-token`

- Summary: Account_DeleteAccessToken
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/current-user/accesstokens/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management account delete-ssh-key`

- Summary: Account_DeleteSSHKey
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/current-user/sshkeys/{sshkeyId}`
- Auth: required
- Body: none
- Flags:
  - `--sshkey-id` (path, required, int32): sshkeyId
  - `--id` (query): id

### `dce global-management account get-certify-info`

- Summary: Account_GetCertifyInfo
- HTTP: `GET /apis/ghippo.io/v1alpha1/current-user/certify`
- Auth: required
- Body: none
- Flags: none

### `dce global-management account get-global-permissions`

- Summary: Account_GetGlobalPermissions
- HTTP: `GET /apis/ghippo.io/v1alpha1/current-user/global-permissions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `permissions`

### `dce global-management account get-user`

- Summary: Get user details by ID
- HTTP: `GET /apis/ghippo.io/v1alpha1/current-user`
- Auth: required
- Body: none
- Flags: none

### `dce global-management account list-access-tokens`

- Summary: Account_ListAccessTokens
- HTTP: `GET /apis/ghippo.io/v1alpha1/current-user/accesstokens`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `id`, `createdAt`, `expiredAt`, `updatedAt`

### `dce global-management account list-ssh-keys`

- Summary: Account_ListSSHKeys
- HTTP: `GET /apis/ghippo.io/v1alpha1/current-user/sshkeys`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `id`, `createdAt`, `expiredAt`, `publicKey`, `sshKeyName`, `updatedAt`

### `dce global-management account password-description`

- Summary: Account_PasswordDescription
- HTTP: `GET /apis/ghippo.io/v1alpha1/current-user/password-description`
- Auth: required
- Body: none
- Flags: none

### `dce global-management account set-current-user-password`

- Summary: Account_SetCurrentUserPassword
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/set-password`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account update-email`

- Summary: Account_UpdateEmail
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/email`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account update-language`

- Summary: Account_UpdateLanguage
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/language`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account update-password`

- Summary: Account_UpdatePassword
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/password`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account update-phone`

- Summary: Account_UpdatePhone
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/phone`
- Auth: required
- Body: required
- Flags: none

### `dce global-management account update-ssh-key`

- Summary: Account_UpdateSSHKey
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/sshkeys/{sshkeyId}`
- Auth: required
- Body: required
- Flags:
  - `--sshkey-id` (path, required, int32): sshkeyId

### `dce global-management account update-user-first-and-last-name`

- Summary: Account_UpdateUserFirstAndLastName
- HTTP: `PUT /apis/ghippo.io/v1alpha1/current-user/name`
- Auth: required
- Body: required
- Flags: none

## Audit

### `dce global-management audit clear-audits-now`

- Summary: Audit_ClearAuditsNow
- HTTP: `POST /apis/ghippo.io/v1alpha3/audits/clear`
- Auth: required
- Body: required
- Flags: none

### `dce global-management audit clear-kube-audits-now`

- Summary: Audit_ClearKubeAuditsNow
- HTTP: `POST /apis/ghippo.io/v1alpha3/audits/kube/clear`
- Auth: required
- Body: required
- Flags: none

### `dce global-management audit export-audits`

- Summary: Audit_ExportAudits
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits/export`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): start
  - `--end` (query): end
  - `--audit-name` (query): auditName
  - `--source-type` (query): sourceType
  - `--source-name` (query): sourceName
  - `--cluster-name` (query): clusterName
  - `--gproduct` (query): gproduct
  - `--status` (query, default `all`, one of: all|succeeded|failed): status
  - `--search-type` (query, default `fuzzy`, one of: fuzzy|exact): searchType
  - `--search-user` (query): searchUser
  - `--export-type` (query, default `Csv`, one of: Csv|Excel): exportType
- Output: list path `extensions`; columns `@type`

### `dce global-management audit export-kube-audits`

- Summary: Audit_ExportKubeAudits
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits/kube/export`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): start
  - `--end` (query): end
  - `--audit-name` (query): auditName
  - `--source-type` (query): sourceType
  - `--source-name` (query): sourceName
  - `--cluster-name` (query): clusterName
  - `--status` (query, default `all`, one of: all|succeeded|failed): status
  - `--search-type` (query, default `fuzzy`, one of: fuzzy|exact): searchType
  - `--search-user` (query): searchUser
  - `--export-type` (query, default `Csv`, one of: Csv|Excel): exportType
- Output: list path `extensions`; columns `@type`

### `dce global-management audit external-audit`

- Summary: 来自外部传递进来的审计日志，用于不经过apiserver的请求，例如直接请求keycloak的请求，由前端埋点调用
- HTTP: `GET /apis/ghippo.io/v1alpha1/audits/external`
- Auth: required
- Body: none
- Flags:
  - `--external-type` (query, default `loginFailed`, one of: loginFailed|forgetPassword|resetPassword): externalType
  - `--resource-name` (query): resourceName
  - `--code` (query, int32): code

### `dce global-management audit get-audit-detail`

- Summary: Audit_GetAuditDetail
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management audit get-audit-resource-report`

- Summary: Audit_GetAuditResourceReport
- HTTP: `GET /apis/ghippo.io/v1alpha1/audits/reports/resources`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): start
  - `--end` (query): end
- Output: list path `items`; columns `Count`, `EventName`, `ResourceType`

### `dce global-management audit get-audit-user-report`

- Summary: Audit_GetAuditUserReport
- HTTP: `GET /apis/ghippo.io/v1alpha1/audits/reports/users`
- Auth: required
- Body: none
- Flags:
  - `--start` (query): start
  - `--end` (query): end
- Output: list path `items`; columns `FailedCount`, `SuccessCount`, `TotalCount`, `UserName`

### `dce global-management audit get-auto-clear-audit-time`

- Summary: Audit_GetAutoClearAuditTime
- HTTP: `GET /apis/ghippo.io/v1alpha1/audits/clear`
- Auth: required
- Body: none
- Flags: none

### `dce global-management audit get-export-uri`

- Summary: Audit_GetExportURI
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits/export/uri`
- Auth: required
- Body: none
- Flags:
  - `--module` (query, default `audit`, one of: audit|kube_audit): module

### `dce global-management audit get-kube-audit-detail`

- Summary: Audit_GetKubeAuditDetail
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits/kube/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management audit get-limit-range-time`

- Summary: Audit_GetLimitRangeTime
- HTTP: `GET /apis/ghippo.io/v1alpha1/audits/limit-range`
- Auth: required
- Body: none
- Flags: none

### `dce global-management audit list-audits`

- Summary: List audit log entries
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits`
- Auth: required
- Body: none
- Flags:
  - `--audit-name` (query): auditName
  - `--source-type` (query): sourceType
  - `--source-name` (query): sourceName
  - `--cluster-name` (query): clusterName
  - `--status` (query, default `all`, one of: all|succeeded|failed): status
  - `--search-type` (query, default `fuzzy`, one of: fuzzy|exact): searchType
  - `--search-user` (query): searchUser
  - `--gproduct` (query): gproduct
  - `--start` (query): start
  - `--end` (query): end
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `id`, `auditName`, `client`, `clusterName`, `createdAt`, `gproduct`; pagination `offset`
- Example: `dce global-management audit list-audits --page-size 100 -o json`

### `dce global-management audit list-csp-audits`

- Summary: Audit_ListCSPAudits
- HTTP: `GET /apis/ghippo.io/v1alpha1/csp-audits`
- Auth: required
- Body: none
- Flags:
  - `--account-name` (query): accountName
  - `--start` (query): start
  - `--end` (query): end
  - `--gproduct` (query): gproduct
  - `--resource-type` (query): resourceType
  - `--resource-name` (query): resourceName
  - `--verb` (query): verb
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `createdAt`, `gproduct`, `ip`, `operator`, `resourceName`, `resourceType`; pagination `offset`

### `dce global-management audit list-kube-audits`

- Summary: Audit_ListKubeAudits
- HTTP: `GET /apis/ghippo.io/v1alpha3/audits/kube`
- Auth: required
- Body: none
- Flags:
  - `--audit-name` (query): auditName
  - `--source-type` (query): sourceType
  - `--source-name` (query): sourceName
  - `--cluster-name` (query): clusterName
  - `--status` (query, default `all`, one of: all|succeeded|failed): status
  - `--search-type` (query, default `fuzzy`, one of: fuzzy|exact): searchType
  - `--search-user` (query): searchUser
  - `--start` (query): start
  - `--end` (query): end
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `id`, `auditName`, `client`, `clusterName`, `createdAt`, `ip`; pagination `offset`

### `dce global-management audit set-auto-clear-audit-setting`

- Summary: Audit_SetAutoClearAuditSetting
- HTTP: `PUT /apis/ghippo.io/v1alpha3/audits/set-auto-clear`
- Auth: required
- Body: required
- Flags: none

### `dce global-management audit set-auto-clear-kube-audit-setting`

- Summary: Audit_SetAutoClearKubeAuditSetting
- HTTP: `PUT /apis/ghippo.io/v1alpha3/audits/set-auto-clear/kube`
- Auth: required
- Body: required
- Flags: none

## Client

### `dce global-management client create-client`

- Summary: Client_CreateClient
- HTTP: `POST /apis/ghippo.io/v1alpha1/clients`
- Auth: required
- Body: required
- Flags: none

### `dce global-management client delete-client`

- Summary: Client_DeleteClient
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/clients/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management client get-client`

- Summary: Client_GetClient
- HTTP: `GET /apis/ghippo.io/v1alpha1/clients/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management client list-clients`

- Summary: Client_ListClients
- HTTP: `GET /apis/ghippo.io/v1alpha1/clients`
- Auth: required
- Body: none
- Flags:
  - `--client-id` (query): clientId
- Output: list path `items`; columns `name`, `id`, `baseUrl`, `clientId`, `secret`

### `dce global-management client update-client`

- Summary: Client_UpdateClient
- HTTP: `PUT /apis/ghippo.io/v1alpha1/clients/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id

## Domain

### `dce global-management domain create-domain`

- Summary: Domain_CreateDomain
- HTTP: `POST /apis/ghippo.io/v1alpha1/domain`
- Auth: required
- Body: required
- Flags: none

## FeatureGate

### `dce global-management featuregate list-feature-gates`

- Summary: FeatureGate_ListFeatureGates
- HTTP: `GET /apis/ghippo.io/v1alpha1/feature-gate`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `id`, `description`, `enabled`

## GProductLicenses

### `dce global-management gproductlicenses delete-g-product-licenses`

- Summary: GProductLicenses_DeleteGProductLicenses
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/gproduct-licenses/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management gproductlicenses get-g-product-licenses`

- Summary: GProductLicenses_GetGProductLicenses
- HTTP: `GET /apis/ghippo.io/v1alpha1/gproduct-licenses/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management gproductlicenses get-g-product-licenses-esn`

- Summary: GProductLicenses_GetGProductLicensesESN
- HTTP: `GET /apis/ghippo.io/v1alpha1/gproduct-licenses/esn`
- Auth: required
- Body: none
- Flags: none

### `dce global-management gproductlicenses get-g-product-licenses-expired`

- Summary: GProductLicenses_GetGProductLicensesExpired
- HTTP: `GET /apis/ghippo.io/v1alpha1/gproduct-licenses/expired`
- Auth: required
- Body: none
- Flags: none
- Output: list path `expireSoonLicenses`; columns `name`, `id`, `expiredAt`, `level`, `module`, `status`

### `dce global-management gproductlicenses get-g-product-licenses-yaml`

- Summary: GProductLicenses_GetGProductLicensesYaml
- HTTP: `GET /apis/ghippo.io/v1alpha1/gproduct-licenses/yaml`
- Auth: required
- Body: none
- Flags: none

### `dce global-management gproductlicenses update-g-product-licenses`

- Summary: GProductLicenses_UpdateGProductLicenses
- HTTP: `PUT /apis/ghippo.io/v1alpha1/gproduct-licenses`
- Auth: required
- Body: required
- Flags: none
- Output: list path `licenses`; columns `name`, `id`, `expiredAt`, `level`, `module`, `status`

## Group

### `dce global-management group add-user-to-group`

- Summary: Group_AddUserToGroup
- HTTP: `POST /apis/ghippo.io/v1alpha1/groups/{id}/members/{userId}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--user-id` (path, required): userId

### `dce global-management group create-group`

- Summary: Create a user group
- HTTP: `POST /apis/ghippo.io/v1alpha1/groups`
- Auth: required
- Body: required
- Flags: none
- Example: `dce global-management group create-group \ --set name=dev-team \ --set description="Development team"`

### `dce global-management group delete-group`

- Summary: Delete a user group
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/groups/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management group delete-user-from-group`

- Summary: Group_DeleteUserFromGroup
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/groups/{id}/members/{userId}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--user-id` (path, required): userId

### `dce global-management group get-group`

- Summary: Get group details
- HTTP: `GET /apis/ghippo.io/v1alpha1/groups/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management group group-members`

- Summary: Group_GroupMembers
- HTTP: `GET /apis/ghippo.io/v1alpha1/groups/{id}/members`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--search` (query): 搜索关键字
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `name`, `id`, `createdAt`, `description`, `email`, `updatedAt`; pagination `offset`

### `dce global-management group list-group-roles`

- Summary: Group_ListGroupRoles
- HTTP: `GET /apis/ghippo.io/v1alpha1/groups/{id}/roles`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--search` (query): 搜索关键字
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
  - `--type` (query): role type
  - `--authorized` (query): 是否授权
- Output: list path `items`; columns `name`, `type`, `authorized`, `createdAt`, `description`, `updatedAt`; pagination `offset`

### `dce global-management group list-group-subjects`

- Summary: Group_ListGroupSubjects
- HTTP: `GET /apis/ghippo.io/v1alpha1/groups/{id}/subjects`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--search` (query): search
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `type`, `id`, `roleId`, `roleName`, `subjectName`; pagination `offset`

### `dce global-management group list-groups`

- Summary: List user groups
- HTTP: `GET /apis/ghippo.io/v1alpha1/groups`
- Auth: required
- Body: none
- Flags:
  - `--search` (query): 搜索关键字
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `name`, `id`, `canAuthorize`, `createdAt`, `description`, `userCount`; pagination `offset`

### `dce global-management group update-group`

- Summary: Update a user group
- HTTP: `PUT /apis/ghippo.io/v1alpha1/groups/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Example: `dce global-management group update-group --id <id> \ --set name=dev-team-renamed \ --set description="Renamed team"`

### `dce global-management group update-group-roles`

- Summary: Group_UpdateGroupRoles
- HTTP: `PUT /apis/ghippo.io/v1alpha1/groups/{id}/roles`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id

## IDP

### `dce global-management idp create-idp`

- Summary: IDP_CreateIDP
- HTTP: `POST /apis/ghippo.io/v1alpha1/idp`
- Auth: required
- Body: required
- Flags: none

### `dce global-management idp delete-idp`

- Summary: IDP_DeleteIDP
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/idp/{alias}`
- Auth: required
- Body: none
- Flags:
  - `--alias` (path, required): alias

### `dce global-management idp get-idp`

- Summary: IDP_GetIDP
- HTTP: `GET /apis/ghippo.io/v1alpha1/idp/{alias}`
- Auth: required
- Body: none
- Flags:
  - `--alias` (path, required): alias

### `dce global-management idp get-redirect-url`

- Summary: IDP_GetRedirectUrl
- HTTP: `GET /apis/ghippo.io/v1alpha1/idp/{alias}/redirect-url`
- Auth: required
- Body: none
- Flags:
  - `--alias` (path, required): alias

### `dce global-management idp get-well-known-url`

- Summary: IDP_GetWellKnownUrl
- HTTP: `GET /apis/ghippo.io/v1alpha1/idp/wellknown-url`
- Auth: required
- Body: none
- Flags: none

### `dce global-management idp import-open-id-configuration`

- Summary: IDP_ImportOpenIdConfiguration
- HTTP: `GET /apis/ghippo.io/v1alpha1/idp/import-openid-configuration`
- Auth: required
- Body: none
- Flags:
  - `--url` (query): url

### `dce global-management idp list-id-ps`

- Summary: IDP_ListIDPs
- HTTP: `GET /apis/ghippo.io/v1alpha1/idp`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `alias`, `authorizationUrl`, `clientAuthentications`, `clientId`, `clientSecret`, `displayName`

### `dce global-management idp update-idp`

- Summary: IDP_UpdateIDP
- HTTP: `PUT /apis/ghippo.io/v1alpha1/idp/{alias}`
- Auth: required
- Body: required
- Flags:
  - `--alias` (path, required): alias

## KeycloakEvent

### `dce global-management keycloakevent keycloak-event`

- Summary: KeycloakEvent_KeycloakEvent
- HTTP: `POST /apis/ghippo.io/v1alpha1/keycloak-event`
- Auth: required
- Body: required
- Flags: none

## Ldap

### `dce global-management ldap create-ldap`

- Summary: Ldap_CreateLdap
- HTTP: `POST /apis/ghippo.io/v1alpha2/ldap`
- Auth: required
- Body: required
- Flags: none

### `dce global-management ldap create-ldap-group`

- Summary: Ldap_CreateLdapGroup
- HTTP: `POST /apis/ghippo.io/v1alpha2/ldaps/{id}/group`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id

### `dce global-management ldap delete-ldap`

- Summary: Ldap_DeleteLdap
- HTTP: `DELETE /apis/ghippo.io/v1alpha2/ldaps/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management ldap delete-ldap-group`

- Summary: Ldap_DeleteLdapGroup
- HTTP: `DELETE /apis/ghippo.io/v1alpha2/ldaps/{ldapId}/group/{id}`
- Auth: required
- Body: none
- Flags:
  - `--ldap-id` (path, required): ldapId
  - `--id` (path, required): id

### `dce global-management ldap get-ldap`

- Summary: Ldap_GetLdap
- HTTP: `GET /apis/ghippo.io/v1alpha2/ldaps/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management ldap get-ldap-group`

- Summary: Ldap_GetLdapGroup
- HTTP: `GET /apis/ghippo.io/v1alpha2/ldaps/{id}/group`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management ldap list-ldaps`

- Summary: Ldap_ListLdaps
- HTTP: `GET /apis/ghippo.io/v1alpha2/ldaps`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `name`, `id`, `enabled`, `vendor`

### `dce global-management ldap sync-ldap-groups`

- Summary: Ldap_SyncLdapGroups
- HTTP: `GET /apis/ghippo.io/v1alpha2/ldaps/{ldapId}/group/{id}/sync`
- Auth: required
- Body: none
- Flags:
  - `--ldap-id` (path, required): ldapId
  - `--id` (path, required): id

### `dce global-management ldap sync-users`

- Summary: Ldap_SyncUsers
- HTTP: `GET /apis/ghippo.io/v1alpha2/ldaps/{id}/sync`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management ldap test-ldap-authentication`

- Summary: Ldap_TestLdapAuthentication
- HTTP: `POST /apis/ghippo.io/v1alpha2/testLdapAuthentication`
- Auth: required
- Body: required
- Flags: none

### `dce global-management ldap test-ldap-connection`

- Summary: Ldap_TestLdapConnection
- HTTP: `POST /apis/ghippo.io/v1alpha2/testLdapConnection`
- Auth: required
- Body: required
- Flags: none

### `dce global-management ldap update-ldap`

- Summary: Ldap_UpdateLdap
- HTTP: `PUT /apis/ghippo.io/v1alpha2/ldaps/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id

### `dce global-management ldap update-ldap-group`

- Summary: Ldap_UpdateLdapGroup
- HTTP: `PUT /apis/ghippo.io/v1alpha2/ldaps/{ldapId}/group/{id}`
- Auth: required
- Body: required
- Flags:
  - `--ldap-id` (path, required): ldapId
  - `--id` (path, required): id

## Login

### `dce global-management login check-session-limit`

- Summary: Login_CheckSessionLimit
- HTTP: `POST /apis/ghippo.io/v1alpha1/session-limit`
- Auth: required
- Body: required
- Flags: none

### `dce global-management login oidc-login`

- Summary: Login_OIDCLogin
- HTTP: `POST /apis/ghippo.io/v1alpha1/login`
- Auth: required
- Body: required
- Flags: none

### `dce global-management login oidc-logout`

- Summary: Login_OIDCLogout
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/logout`
- Auth: required
- Body: none
- Flags: none

### `dce global-management login redirect-login`

- Summary: Login_RedirectLogin
- HTTP: `GET /apis/ghippo.io/v1alpha1/login`
- Auth: required
- Body: none
- Flags:
  - `--callback-url` (query): callbackUrl

### `dce global-management login refresh-token`

- Summary: Login_RefreshToken
- HTTP: `POST /apis/ghippo.io/v1alpha1/refresh-token`
- Auth: required
- Body: required
- Flags: none

## LoginPage

### `dce global-management loginpage get-info`

- Summary: LoginPage_GetInfo
- HTTP: `GET /apis/ghippo.io/v1alpha1/login-page/info`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage get-login-page-logo-redirect-url`

- Summary: LoginPage_GetLoginPageLogoRedirectURL
- HTTP: `GET /apis/ghippo.io/v1alpha1/login-page/logo-redirect-url`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage get-privacy-policy`

- Summary: LoginPage_GetPrivacyPolicy
- HTTP: `GET /apis/ghippo.io/v1alpha1/login-page/privacy`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage get-support-qr-code`

- Summary: LoginPage_GetSupportQRCode
- HTTP: `GET /apis/ghippo.io/v1alpha1/login-page/support_qrcode`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage get-terms-of-services`

- Summary: LoginPage_GetTermsOfServices
- HTTP: `GET /apis/ghippo.io/v1alpha1/login-page/terms`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage get-version`

- Summary: LoginPage_GetVersion
- HTTP: `GET /apis/ghippo.io/v1alpha1/login-page/version`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage reset-info`

- Summary: LoginPage_ResetInfo
- HTTP: `POST /apis/ghippo.io/v1alpha1/login-page/reset`
- Auth: required
- Body: none
- Flags: none

### `dce global-management loginpage update-info`

- Summary: LoginPage_UpdateInfo
- HTTP: `PUT /apis/ghippo.io/v1alpha1/login-page/info`
- Auth: required
- Body: required
- Flags: none

## Message

### `dce global-management message delete-messages`

- Summary: Message_DeleteMessages
- HTTP: `POST /apis/ghippo.io/v1alpha1/messages/delete`
- Auth: required
- Body: required
- Flags: none

### `dce global-management message get-message`

- Summary: Message_GetMessage
- HTTP: `GET /apis/ghippo.io/v1alpha1/messages/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management message get-messages-count`

- Summary: Message_GetMessagesCount
- HTTP: `GET /apis/ghippo.io/v1alpha1/messages/count`
- Auth: required
- Body: none
- Flags: none

### `dce global-management message get-system-message`

- Summary: Message_GetSystemMessage
- HTTP: `GET /apis/ghippo.io/v1alpha1/messages/system/system-message`
- Auth: required
- Body: none
- Flags: none

### `dce global-management message list-messages`

- Summary: List platform messages/notifications
- HTTP: `GET /apis/ghippo.io/v1alpha1/messages`
- Auth: required
- Body: none
- Flags:
  - `--unread-count` (query): 是否只返回统计未读数量
  - `--search` (query): 搜索关键字
  - `--read` (query, default `all`, one of: all|read|unread): 是否只返回已读或未读，传"read"或"unread"来区分，不传返回已读和未读的消息
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `type`, `id`, `createdAt`, `message`, `read`, `subject`; pagination `offset`

### `dce global-management message set-read-messages`

- Summary: Message_SetReadMessages
- HTTP: `POST /apis/ghippo.io/v1alpha1/read-messages`
- Auth: required
- Body: required
- Flags: none

### `dce global-management message toggle-unread-message`

- Summary: Message_ToggleUnreadMessage
- HTTP: `GET /apis/ghippo.io/v1alpha1/messages/toggle-unread`
- Auth: required
- Body: none
- Flags:
  - `--id` (query, int32): id
  - `--next` (query): next

## OIDC

### `dce global-management oidc oidc-logout`

- Summary: OIDC_OIDCLogout
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/oidc/logout`
- Auth: required
- Body: none
- Flags: none

### `dce global-management oidc oidc-token`

- Summary: OIDC_OIDCToken
- HTTP: `POST /apis/ghippo.io/v1alpha1/oidc/token`
- Auth: required
- Body: required
- Flags: none

### `dce global-management oidc oidc-user-info`

- Summary: OIDC_OIDCUserInfo
- HTTP: `GET /apis/ghippo.io/v1alpha1/oidc/userinfo`
- Auth: required
- Body: none
- Flags: none

### `dce global-management oidc redirect-frontend-logout`

- Summary: OIDC_RedirectFrontendLogout
- HTTP: `GET /apis/ghippo.io/v1alpha1/oidc/logout`
- Auth: required
- Body: none
- Flags: none

### `dce global-management oidc well-known`

- Summary: OIDC_WellKnown
- HTTP: `GET /apis/ghippo.io/v1alpha1/.well-known/openid-configuration`
- Auth: required
- Body: none
- Flags: none
- Output: list path `idTokenSigningAlgValuesSupported`

## Oauth2

### `dce global-management oauth2 create-oauth2`

- Summary: Oauth2_CreateOauth2
- HTTP: `POST /apis/ghippo.io/v1alpha1/oauth2`
- Auth: required
- Body: required
- Flags: none

### `dce global-management oauth2 delete-oauth2`

- Summary: Oauth2_DeleteOauth2
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/oauth2`
- Auth: required
- Body: none
- Flags:
  - `--provider-type` (query, default `wechatwork`, one of: wechatwork): providerType

### `dce global-management oauth2 get-oauth2`

- Summary: Oauth2_GetOauth2
- HTTP: `GET /apis/ghippo.io/v1alpha1/oauth2`
- Auth: required
- Body: none
- Flags: none

### `dce global-management oauth2 get-oauth2redirect-domain`

- Summary: Oauth2_GetOauth2RedirectDomain
- HTTP: `GET /apis/ghippo.io/v1alpha1/oauth2/redirect-domain`
- Auth: required
- Body: none
- Flags: none

### `dce global-management oauth2 update-oauth2`

- Summary: Oauth2_UpdateOauth2
- HTTP: `PUT /apis/ghippo.io/v1alpha1/oauth2`
- Auth: required
- Body: required
- Flags: none

## Openapi

### `dce global-management openapi auth-token`

- Summary: Openapi_AuthToken
- HTTP: `GET /apis/ghippo.io/v1alpha1/auth-token`
- Auth: required
- Body: none
- Flags: none

### `dce global-management openapi certs`

- Summary: Openapi_Certs
- HTTP: `GET /apis/ghippo.io/v1alpha1/certs`
- Auth: required
- Body: none
- Flags: none
- Output: list path `keys`; columns `alg`, `e`, `kid`, `kty`, `n`, `use`

## ProductNavigator

### `dce global-management productnavigator info`

- Summary: ProductNavigator_Info
- HTTP: `GET /apis/ghippo.io/v1alpha1/product-nav/info`
- Auth: required
- Body: none
- Flags: none
- Output: list path `categories`; columns `name`

## Publish

### `dce global-management publish publish-message`

- Summary: Publish_PublishMessage
- HTTP: `POST /apis/ghippo.io/v1alpha1/publish/messages`
- Auth: required
- Body: required
- Flags: none

## Register

### `dce global-management register redirect-register`

- Summary: Register_RedirectRegister
- HTTP: `GET /apis/ghippo.io/v1alpha1/register`
- Auth: required
- Body: none
- Flags:
  - `--callback-url` (query): callbackUrl
  - `--invite-code` (query): inviteCode

## Role

### `dce global-management role check-role-name`

- Summary: Role_CheckRoleName
- HTTP: `GET /apis/ghippo.io/v1alpha1/roles/check-role-name/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce global-management role create-role`

- Summary: Create a custom role
- HTTP: `POST /apis/ghippo.io/v1alpha1/roles`
- Auth: required
- Body: required
- Flags: none
- Example: `# scope: platform | folder | workspace echo '{ "name": "my-role", "description": "Custom role", "scope": "platform", "perms": [ {"gproduct": "ghippo", "resourceType": "User", "action": "get"} ] }' | dce global-management role create-role --file -`

### `dce global-management role delete-role`

- Summary: Delete a custom role
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/roles/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce global-management role get-role`

- Summary: Get role details
- HTTP: `GET /apis/ghippo.io/v1alpha1/roles/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
- Output: list path `gproductPerms`

### `dce global-management role get-role-member-count`

- Summary: Role_GetRoleMemberCount
- HTTP: `GET /apis/ghippo.io/v1alpha1/roles/role-member-count/{name}`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name

### `dce global-management role list-all-permissions`

- Summary: List all available permissions
- HTTP: `GET /apis/ghippo.io/v1alpha1/permissions`
- Auth: required
- Body: none
- Flags: none
- Output: list path `gproductPerms`

### `dce global-management role list-folder-role-names`

- Summary: Role_ListFolderRoleNames
- HTTP: `GET /apis/ghippo.io/v1alpha1/folderrolenames`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--search` (query): search
- Output: list path `items`; columns `name`, `authScope`, `description`; pagination `offset`

### `dce global-management role list-members-by-platform-role`

- Summary: Role_ListMembersByPlatformRole
- HTTP: `GET /apis/ghippo.io/v1alpha1/platformroles/{name}/members`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--search` (query): search
- Output: list path `items`; columns `name`, `type`, `id`; pagination `offset`

### `dce global-management role list-members-folders-by-folder-role`

- Summary: Role_ListMembersFoldersByFolderRole
- HTTP: `GET /apis/ghippo.io/v1alpha1/folderroles/{name}/members-folders`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--search` (query): search
- Output: list path `items`; columns `folderAlias`, `folderId`, `memberId`, `memberName`, `memberType`; pagination `offset`

### `dce global-management role list-members-workspaces-by-workspace-role`

- Summary: Role_ListMembersWorkspacesByWorkspaceRole
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaceroles/{name}/members-workspaces`
- Auth: required
- Body: none
- Flags:
  - `--name` (path, required): name
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--search` (query): search
- Output: list path `items`; columns `memberId`, `memberName`, `memberType`, `workspaceAlias`, `workspaceId`; pagination `offset`

### `dce global-management role list-roles`

- Summary: List platform roles
- HTTP: `GET /apis/ghippo.io/v1alpha1/roles`
- Auth: required
- Body: none
- Flags:
  - `--search` (query): 搜索关键字
  - `--page-size` (query, default `20`, int32): 每页条数
  - `--page` (query, default `1`, int32): 当前页
  - `--role-type` (query, default `query_all_role_type`, one of: query_all_role_type|query_system|query_custom): roleType
  - `--scope` (query, default `query_all_auth_scope`, one of: query_all_auth_scope|query_platform|query_folder|query_workspace): scope
- Output: list path `items`; columns `name`, `type`, `createdAt`, `description`, `scope`, `updatedAt`; pagination `offset`

### `dce global-management role list-workspace-role-names`

- Summary: Role_ListWorkspaceRoleNames
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspacerolenames`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--search` (query): search
- Output: list path `items`; columns `name`, `authScope`, `description`; pagination `offset`

### `dce global-management role update-role`

- Summary: Update a custom role
- HTTP: `PUT /apis/ghippo.io/v1alpha1/roles/{name}`
- Auth: required
- Body: required
- Flags:
  - `--name` (path, required): name
- Example: `echo '{ "description": "Updated description", "perms": [ {"gproduct": "ghippo", "resourceType": "User", "action": "get"} ] }' | dce global-management role update-role --name <name> --file -`

## SecurityPolicy

### `dce global-management securitypolicy get-account-lockout-policy`

- Summary: SecurityPolicy_GetAccountLockoutPolicy
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/accountlockout`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy get-logout-policy`

- Summary: SecurityPolicy_GetLogoutPolicy
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/logout`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy get-mfa`

- Summary: SecurityPolicy_GetMFA
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/mfa`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy get-password-policy`

- Summary: SecurityPolicy_GetPasswordPolicy
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/password`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`; columns `type`, `value`

### `dce global-management securitypolicy get-session-timeout`

- Summary: SecurityPolicy_GetSessionTimeout
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/sessiontimeout`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy get-system-session-limit`

- Summary: SecurityPolicy_GetSystemSessionLimit
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/sessionlimit/system`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy get-time-session-limit`

- Summary: SecurityPolicy_GetTimeSessionLimit
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/sessionlimit/time`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy get-user-session-limit`

- Summary: SecurityPolicy_GetUserSessionLimit
- HTTP: `GET /apis/ghippo.io/v1alpha1/securitypolicy/sessionlimit/user`
- Auth: required
- Body: none
- Flags: none

### `dce global-management securitypolicy set-account-lockout-policy`

- Summary: SecurityPolicy_SetAccountLockoutPolicy
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/accountlockout`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-logout-policy`

- Summary: SecurityPolicy_SetLogoutPolicy
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/logout`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-mfa`

- Summary: SecurityPolicy_SetMFA
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/mfa`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-password-policy`

- Summary: SecurityPolicy_SetPasswordPolicy
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/password`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-session-timeout`

- Summary: SecurityPolicy_SetSessionTimeout
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/sessiontimeout`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-system-session-limit`

- Summary: SecurityPolicy_SetSystemSessionLimit
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/sessionlimit/system`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-time-session-limit`

- Summary: SecurityPolicy_SetTimeSessionLimit
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/sessionlimit/time`
- Auth: required
- Body: required
- Flags: none

### `dce global-management securitypolicy set-user-session-limit`

- Summary: SecurityPolicy_SetUserSessionLimit
- HTTP: `PUT /apis/ghippo.io/v1alpha1/securitypolicy/sessionlimit/user`
- Auth: required
- Body: required
- Flags: none

## Sms

### `dce global-management sms batch-create-sms-templates-by-domain`

- Summary: Sms_BatchCreateSmsTemplatesByDomain
- HTTP: `POST /apis/ghippo.io/v1alpha1/sms/template/batch-by-domain`
- Auth: required
- Body: required
- Flags: none

### `dce global-management sms create-sms-template`

- Summary: Sms_CreateSmsTemplate
- HTTP: `POST /apis/ghippo.io/v1alpha1/sms/template`
- Auth: required
- Body: required
- Flags: none

### `dce global-management sms list-sms-template`

- Summary: Sms_ListSmsTemplate
- HTTP: `GET /apis/ghippo.io/v1alpha1/sms/template`
- Auth: required
- Body: none
- Flags:
  - `--template` (query): template
  - `--domain` (query): domain
  - `--channel` (query): channel
  - `--channel-template` (query): channelTemplate
- Output: list path `items`; columns `id`, `channel`, `channelTemplate`, `domain`, `enable`, `template`

### `dce global-management sms send-verification-code`

- Summary: Sms_SendVerificationCode
- HTTP: `POST /apis/ghippo.io/v1alpha1/sms/verification`
- Auth: required
- Body: required
- Flags: none

## SmtpSetting

### `dce global-management smtpsetting get-smtp-server`

- Summary: SmtpSetting_GetSmtpServer
- HTTP: `GET /apis/ghippo.io/v1alpha1/smtp-setting`
- Auth: required
- Body: none
- Flags: none

### `dce global-management smtpsetting set-smtp-server`

- Summary: SmtpSetting_SetSmtpServer
- HTTP: `PUT /apis/ghippo.io/v1alpha1/smtp-setting`
- Auth: required
- Body: required
- Flags: none

### `dce global-management smtpsetting smtp-server-conn-test`

- Summary: SmtpSetting_SmtpServerConnTest
- HTTP: `POST /apis/ghippo.io/v1alpha1/smtp-setting/conn-test`
- Auth: required
- Body: required
- Flags: none

## Theme

### `dce global-management theme get-footer-theme-config`

- Summary: Theme_GetFooterThemeConfig
- HTTP: `GET /apis/ghippo.io/v1alpha1/themes/footer-theme`
- Auth: required
- Body: none
- Flags: none

### `dce global-management theme get-login-theme-config`

- Summary: Theme_GetLoginThemeConfig
- HTTP: `GET /apis/ghippo.io/v1alpha1/themes/login_page`
- Auth: required
- Body: none
- Flags: none

### `dce global-management theme get-login-theme-css`

- Summary: Theme_GetLoginThemeCSS
- HTTP: `GET /apis/ghippo.io/v1alpha1/themes/login_page.css`
- Auth: required
- Body: none
- Flags: none
- Output: list path `extensions`; columns `@type`

### `dce global-management theme get-theme-config`

- Summary: Theme_GetThemeConfig
- HTTP: `GET /apis/ghippo.io/v1alpha1/themes/theme`
- Auth: required
- Body: none
- Flags: none

### `dce global-management theme get-theme-css`

- Summary: Theme_GetThemeCSS
- HTTP: `GET /apis/ghippo.io/v1alpha1/themes/theme.css`
- Auth: required
- Body: none
- Flags: none
- Output: list path `extensions`; columns `@type`

### `dce global-management theme reset-footer-theme-config`

- Summary: Theme_ResetFooterThemeConfig
- HTTP: `POST /apis/ghippo.io/v1alpha1/themes/footer/reset`
- Auth: required
- Body: none
- Flags: none

### `dce global-management theme reset-login-theme-config`

- Summary: Theme_ResetLoginThemeConfig
- HTTP: `POST /apis/ghippo.io/v1alpha1/themes/login_page/reset`
- Auth: required
- Body: none
- Flags: none

### `dce global-management theme reset-theme-config`

- Summary: Theme_ResetThemeConfig
- HTTP: `POST /apis/ghippo.io/v1alpha1/themes/theme/reset`
- Auth: required
- Body: none
- Flags: none

### `dce global-management theme set-footer-theme-config`

- Summary: Theme_SetFooterThemeConfig
- HTTP: `POST /apis/ghippo.io/v1alpha1/themes/footer-theme`
- Auth: required
- Body: required
- Flags: none

### `dce global-management theme set-login-theme-config`

- Summary: Theme_SetLoginThemeConfig
- HTTP: `POST /apis/ghippo.io/v1alpha1/themes/login_page`
- Auth: required
- Body: required
- Flags: none

### `dce global-management theme set-theme-config`

- Summary: Theme_SetThemeConfig
- HTTP: `POST /apis/ghippo.io/v1alpha1/themes/theme`
- Auth: required
- Body: required
- Flags: none

## TopNavigator

### `dce global-management topnavigator info`

- Summary: TopNavigator_Info
- HTTP: `GET /apis/ghippo.io/v1alpha1/top-nav/info`
- Auth: required
- Body: none
- Flags: none

### `dce global-management topnavigator reset-top-nav`

- Summary: TopNavigator_ResetTopNav
- HTTP: `POST /apis/ghippo.io/v1alpha1/top-nav/reset`
- Auth: required
- Body: none
- Flags: none

### `dce global-management topnavigator set-top-nav`

- Summary: TopNavigator_SetTopNav
- HTTP: `POST /apis/ghippo.io/v1alpha1/top-nav`
- Auth: required
- Body: required
- Flags: none

## Users

### `dce global-management users check-user`

- Summary: Users_CheckUser
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/check/{username}`
- Auth: required
- Body: none
- Flags:
  - `--username` (path, required): username

### `dce global-management users check-user-email`

- Summary: Users_CheckUserEmail
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/check-user-email/{username}`
- Auth: required
- Body: none
- Flags:
  - `--username` (path, required): username

### `dce global-management users create-user`

- Summary: Create a new platform user
- HTTP: `POST /apis/ghippo.io/v1alpha1/users`
- Auth: required
- Body: required
- Flags: none
- Example: `dce global-management users create-user \ --set name=alice \ --set password=changeme \ --set description="Alice from dev team" \ --set temporary=false`

### `dce global-management users create-user-access-token`

- Summary: Create an access token for a user
- HTTP: `POST /apis/ghippo.io/v1alpha1/users/{id}/accesstoken`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Example: `dce global-management users create-user-access-token --id <id> \ --set name=my-token \ --set expiredAt=2026-12-31T00:00:00Z`

### `dce global-management users create-user-without-password`

- Summary: Users_CreateUserWithoutPassword
- HTTP: `POST /apis/ghippo.io/v1alpha1/users/without-password`
- Auth: required
- Body: required
- Flags: none

### `dce global-management users delete-user`

- Summary: Delete a user by ID
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/users/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management users delete-user-access-token`

- Summary: Delete an access token
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/users/{id}/accesstokens/{aid}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--aid` (path, required): aid

### `dce global-management users get-user`

- Summary: Get user details by ID
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management users get-user-by-name`

- Summary: Users_GetUserByName
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/username/{username}`
- Auth: required
- Body: none
- Flags:
  - `--username` (path, required): username

### `dce global-management users list-user-access-tokens`

- Summary: List access tokens for a user
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/{id}/accesstokens`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
- Output: list path `items`; columns `name`, `id`, `createdAt`, `expiredAt`, `updatedAt`

### `dce global-management users list-user-groups`

- Summary: List groups a user belongs to
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/{id}/groups`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--search` (query): 搜索关键字
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `name`, `id`; pagination `offset`

### `dce global-management users list-user-roles`

- Summary: List roles assigned to a user
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/{id}/roles`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--search` (query): 搜索关键字
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
  - `--type` (query): role type
  - `--authorized` (query): 是否授权
- Output: list path `items`; columns `name`, `type`, `authorized`, `createdAt`, `description`, `updatedAt`; pagination `offset`

### `dce global-management users list-user-subjects`

- Summary: Users_ListUserSubjects
- HTTP: `GET /apis/ghippo.io/v1alpha1/users/{id}/subjects`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id
  - `--search` (query): search
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `type`, `id`, `roleName`, `subjectName`; pagination `offset`

### `dce global-management users list-users`

- Summary: List platform users
- HTTP: `GET /apis/ghippo.io/v1alpha1/users`
- Auth: required
- Body: none
- Flags:
  - `--search` (query): 搜索关键字
  - `--page-size` (query, default `20`, int32): Number of results per page
  - `--page` (query, default `1`, int32): 当前页, 大于等于 0，小于等于 1000
- Output: list path `items`; columns `name`, `id`, `canAuthorize`, `createdAt`, `description`, `email`; pagination `offset`
- Example: `dce global-management users list-users dce global-management users list-users --page-size 50 -o json`

### `dce global-management users reset-user-mfa`

- Summary: Users_ResetUserMFA
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/users/{id}/mfa`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required): id

### `dce global-management users set-user-password`

- Summary: Set or reset a user's password
- HTTP: `PUT /apis/ghippo.io/v1alpha1/users/{id}/password`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Example: `dce global-management users set-user-password --id <id> \ --set password=NewP@ssw0rd`

### `dce global-management users update-user`

- Summary: Update user profile
- HTTP: `PUT /apis/ghippo.io/v1alpha1/users/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Example: `dce global-management users update-user --id <id> \ --set email=newemail@example.com \ --set firstname=Alice \ --set lastname=Smith \ --set description="updated" \ --set enabled=true`

### `dce global-management users update-user-certify`

- Summary: Users_UpdateUserCertify
- HTTP: `PUT /apis/ghippo.io/v1alpha1/users/certify`
- Auth: required
- Body: required
- Flags: none

### `dce global-management users update-user-roles`

- Summary: Assign or update roles for a user
- HTTP: `PUT /apis/ghippo.io/v1alpha1/users/{id}/roles`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required): id
- Example: `# Add roles echo '{"addRoles":["Admin"],"removeRoles":[]}' | \ dce global-management users update-user-roles --id <id> --file - # Remove roles echo '{"addRoles":[],"removeRoles":["Editor"]}' | \ dce global-management users update-user-roles --id <id> --file -`

## Webhook

### `dce global-management webhook create-webhook`

- Summary: 接入管理
- HTTP: `POST /apis/ghippo.io/v1alpha1/webhook`
- Auth: required
- Body: required
- Flags: none

### `dce global-management webhook create-webhook-endpoint`

- Summary: Webhook_CreateWebhookEndpoint
- HTTP: `POST /apis/ghippo.io/v1alpha1/webhook-endpoint`
- Auth: required
- Body: required
- Flags: none

### `dce global-management webhook delete-webhook`

- Summary: Webhook_DeleteWebhook
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/webhook/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management webhook delete-webhook-endpoint`

- Summary: Webhook_DeleteWebhookEndpoint
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/webhook-endpoint/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management webhook get-webhook`

- Summary: Webhook_GetWebhook
- HTTP: `GET /apis/ghippo.io/v1alpha1/webhook/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management webhook get-webhook-record`

- Summary: Webhook_GetWebhookRecord
- HTTP: `GET /apis/ghippo.io/v1alpha1/webhook-record/{id}`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management webhook list-gproduct-webhook-events`

- Summary: Webhook_ListGproductWebhookEvents
- HTTP: `GET /apis/ghippo.io/v1alpha1/gproduct-webhook-events`
- Auth: required
- Body: none
- Flags: none
- Output: list path `gEvents`; columns `name`, `localizedName`

### `dce global-management webhook list-webhook-endpoint-events`

- Summary: Webhook_ListWebhookEndpointEvents
- HTTP: `GET /apis/ghippo.io/v1alpha1/webhook-endpoint/{id}/events`
- Auth: required
- Body: none
- Flags:
  - `--id` (path, required, int32): id
  - `--event-name` (query): eventName
  - `--gproduct` (query): gproduct
  - `--object-name` (query): objectName
  - `--page-size` (query, default `20`, int32): pageSize
  - `--page` (query, default `1`, int32): page
- Output: list path `items`; columns `body`, `eventName`, `gproduct`, `headers`, `method`, `objectName`; pagination `offset`

### `dce global-management webhook list-webhook-endpoints`

- Summary: Webhook_ListWebhookEndpoints
- HTTP: `GET /apis/ghippo.io/v1alpha1/webhook-endpoints`
- Auth: required
- Body: none
- Flags:
  - `--domain` (query): domain
  - `--url` (query): url
  - `--name` (query): name
  - `--enabled` (query): enabled
  - `--page-size` (query, default `20`, int32): pageSize
  - `--page` (query, default `1`, int32): page
- Output: list path `items`; columns `name`, `id`, `createdAt`, `domain`, `enabled`, `endpoint`; pagination `offset`

### `dce global-management webhook list-webhook-records-by-client-id`

- Summary: Webhook_ListWebhookRecordsByClientId
- HTTP: `GET /apis/ghippo.io/v1alpha1/webhook-record`
- Auth: required
- Body: none
- Flags:
  - `--client-id` (query): clientId
  - `--search` (query): search
  - `--status` (query, default `all`, one of: all|successful|failed): status
  - `--page-size` (query, default `20`, int32): pageSize
  - `--page` (query, default `1`, int32): page
- Output: list path `items`; columns `id`, `action`, `clientId`, `errMessage`, `eventData`, `eventTime`; pagination `offset`

### `dce global-management webhook list-webhooks-by-client-id`

- Summary: Webhook_ListWebhooksByClientId
- HTTP: `GET /apis/ghippo.io/v1alpha1/webhook`
- Auth: required
- Body: none
- Flags:
  - `--search` (query): search
  - `--page-size` (query, default `20`, int32): pageSize
  - `--page` (query, default `1`, int32): page
  - `--client-id` (query): clientId
- Output: list path `items`; columns `name`, `id`, `action`, `clientId`, `createdAt`, `headers`; pagination `offset`

### `dce global-management webhook update-webhook`

- Summary: Webhook_UpdateWebhook
- HTTP: `PUT /apis/ghippo.io/v1alpha1/webhook/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management webhook update-webhook-endpoint`

- Summary: Webhook_UpdateWebhookEndpoint
- HTTP: `PUT /apis/ghippo.io/v1alpha1/webhook-endpoint/{id}`
- Auth: required
- Body: required
- Flags:
  - `--id` (path, required, int32): id

### `dce global-management webhook webhook-endpoint-connectivity-test`

- Summary: Webhook_WebhookEndpointConnectivityTest
- HTTP: `POST /apis/ghippo.io/v1alpha1/webhook-endpoint/connectivity-test`
- Auth: required
- Body: required
- Flags: none

## Workspace

### `dce global-management workspace authorize`

- Summary: Grant a role to a user or group within a folder
- HTTP: `POST /apis/ghippo.io/v1alpha1/folders/{folderId}/authorize`
- Auth: required
- Body: required
- Flags:
  - `--folder-id` (path, required, int32): folderId
- Example: `dce global-management workspace authorize --folder-id <folderId> \ --set memberId=<userId> \ --set memberType=user \ --set memberName=alice \ --set-str 'roleNames[0]=Workspace Admin'`

### `dce global-management workspace bind-exclusive-resource-to-workspace`

- Summary: Workspace_BindExclusiveResourceToWorkspace
- HTTP: `POST /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/bind-exclusiveresource`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce global-management workspace bind-shared-resource-and-set-quota-hard-to-workspace`

- Summary: Workspace_BindSharedResourceAndSetQuotaHardToWorkspace
- HTTP: `POST /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/bind-sharedresource-setquota`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): cluster 资源 resource_scope 为空

### `dce global-management workspace bind-shared-resource-to-workspace`

- Summary: Workspace_BindSharedResourceToWorkspace
- HTTP: `POST /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/bind-sharedresource`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce global-management workspace create-folder`

- Summary: Create a folder
- HTTP: `POST /apis/ghippo.io/v1alpha1/folders`
- Auth: required
- Body: required
- Flags: none
- Example: `# alias is the display name; parentFolderId=0 places it under root dce global-management workspace create-folder \ --set alias=my-folder \ --set parentFolderId=0`

### `dce global-management workspace create-workspace`

- Summary: Create a workspace
- HTTP: `POST /apis/ghippo.io/v1alpha1/workspaces`
- Auth: required
- Body: required
- Flags: none
- Example: `# alias is the display name; parentFolderId=0 places it under root dce global-management workspace create-workspace \ --set alias=my-workspace \ --set parentFolderId=0`

### `dce global-management workspace deauthorize`

- Summary: Workspace_Deauthorize
- HTTP: `PUT /apis/ghippo.io/v1alpha1/folders/{folderId}/deauthorize`
- Auth: required
- Body: required
- Flags:
  - `--folder-id` (path, required, int32): folderId

### `dce global-management workspace delete-folder`

- Summary: Delete a folder
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/folders/{folderId}`
- Auth: required
- Body: none
- Flags:
  - `--folder-id` (path, required, int32): folderId

### `dce global-management workspace delete-workspace`

- Summary: Delete a workspace
- HTTP: `DELETE /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce global-management workspace folder-list-groups`

- Summary: Workspace_FolderListGroups
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders/{folderId}/groups`
- Auth: required
- Body: none
- Flags:
  - `--folder-id` (path, required, int32): folderId
  - `--search` (query): 搜索关键字
  - `--page` (query, default `1`, int32): 搜索偏移量
  - `--page-size` (query, default `20`, int32): 分页大小
- Output: list path `items`; columns `name`, `id`, `authorized`, `canAuthorize`, `createdAt`, `description`; pagination `offset`

### `dce global-management workspace folder-list-permissions`

- Summary: Workspace_FolderListPermissions
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders/{folderId}/permissions`
- Auth: required
- Body: none
- Flags:
  - `--folder-id` (path, required, int32): folderId
- Output: list path `permissions`

### `dce global-management workspace folder-list-users`

- Summary: Workspace_FolderListUsers
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders/{folderId}/users`
- Auth: required
- Body: none
- Flags:
  - `--folder-id` (path, required, int32): folderId
  - `--search` (query): 搜索关键字
  - `--page-size` (query, default `20`, int32): 每页条数
  - `--page` (query, default `1`, int32): 当前页
- Output: list path `items`; columns `name`, `id`, `authorized`, `canAuthorize`, `description`, `email`; pagination `offset`

### `dce global-management workspace get-folder`

- Summary: Get folder details
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders/{folderId}`
- Auth: required
- Body: none
- Flags:
  - `--folder-id` (path, required, int32): folderId

### `dce global-management workspace get-workspace`

- Summary: Get workspace details
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce global-management workspace get-workspace-shared-resource-quota`

- Summary: Workspace_GetWorkspaceSharedResourceQuota
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspace-sharedresource-quota`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (query, int32): workspaceId
  - `--resource-name` (query): resourceName
  - `--resource-type` (query): resourceType
  - `--not-formatted` (query): notFormatted

### `dce global-management workspace list-available-exclusive-resources-by-workspace`

- Summary: Workspace_ListAvailableExclusiveResourcesByWorkspace
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/available-exclusiveresources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--resource-name` (query): resourceName
  - `--resource-type` (query): resourceType
  - `--resource-scope` (query): resourceScope
- Output: list path `items`; columns `bound`, `clusterStatus`, `gproduct`, `resourceName`, `resourceScope`, `resourceType`; pagination `offset`

### `dce global-management workspace list-available-shared-resources-by-workspace`

- Summary: Workspace_ListAvailableSharedResourcesByWorkspace
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/available-sharedresources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--resource-name` (query): resourceName
  - `--resource-type` (query): resourceType
- Output: list path `items`; columns `bound`, `clusterStatus`, `gproduct`, `resourceName`, `resourceScope`, `resourceType`; pagination `offset`

### `dce global-management workspace list-exclusive-resource-types`

- Summary: Workspace_ListExclusiveResourceTypes
- HTTP: `GET /apis/ghippo.io/v1alpha1/exclusiveresource-types`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`

### `dce global-management workspace list-exclusive-resources-by-workspace`

- Summary: Workspace_ListExclusiveResourcesByWorkspace
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/exclusiveresources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--resource-name` (query): resourceName
  - `--resource-type` (query): resourceType
- Output: list path `items`; columns `clusterStatus`, `gproduct`, `module`, `resourceName`, `resourceScope`, `resourceType`; pagination `offset`

### `dce global-management workspace list-folder-tree`

- Summary: Workspace_ListFolderTree
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders-tree`
- Auth: required
- Body: none
- Flags: none

### `dce global-management workspace list-folders`

- Summary: List folders (namespaces within workspaces)
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `id`, `alias`; pagination `offset`

### `dce global-management workspace list-members-roles-by-folder`

- Summary: Workspace_ListMembersRolesByFolder
- HTTP: `GET /apis/ghippo.io/v1alpha1/folders/{folderId}/members-roles`
- Auth: required
- Body: none
- Flags:
  - `--folder-id` (path, required, int32): folderId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--member-name` (query): memberName
  - `--member-type` (query): memberType
  - `--role-name` (query): roleName
- Output: list path `items`; columns `folderId`, `memberId`, `memberName`, `memberType`, `roleName`; pagination `offset`

### `dce global-management workspace list-members-roles-by-workspace`

- Summary: Workspace_ListMembersRolesByWorkspace
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/members-roles`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--member-name` (query): memberName
- Output: list path `items`; columns `memberId`, `memberName`, `memberType`, `roleName`, `workspaceId`; pagination `offset`

### `dce global-management workspace list-resource-quota-types`

- Summary: Workspace_ListResourceQuotaTypes
- HTTP: `GET /apis/ghippo.io/v1alpha1/resourcequota-types`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`

### `dce global-management workspace list-shared-resource-types`

- Summary: Workspace_ListSharedResourceTypes
- HTTP: `GET /apis/ghippo.io/v1alpha1/sharedresource-types`
- Auth: required
- Body: none
- Flags: none
- Output: list path `items`

### `dce global-management workspace list-shared-resources-by-workspace`

- Summary: Workspace_ListSharedResourcesByWorkspace
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/sharedresources`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--resource-name` (query): resourceName
- Output: list path `items`; columns `clusterStatus`, `gproduct`, `module`, `resourceName`, `resourceScope`, `resourceType`; pagination `offset`

### `dce global-management workspace list-workspace-share-resource-quota-types`

- Summary: Workspace_ListWorkspaceShareResourceQuotaTypes
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/sharedresource/{resourceName}/quota-types`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--resource-name` (path, required): resourceName
- Output: list path `gpus`; columns `type`, `alias`, `isDynamic`

### `dce global-management workspace list-workspaces`

- Summary: List workspaces
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces`
- Auth: required
- Body: none
- Flags:
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
- Output: list path `items`; columns `name`, `id`, `alias`; pagination `offset`
- Example: `dce global-management workspace list-workspaces dce global-management workspace list-workspaces -o json`

### `dce global-management workspace move-workspace`

- Summary: Workspace_MoveWorkspace
- HTTP: `POST /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/move`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce global-management workspace move-workspace-folder-list`

- Summary: Workspace_MoveWorkspaceFolderList
- HTTP: `GET /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/move-folders`
- Auth: required
- Body: none
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId
  - `--page` (query, default `1`, int32): page
  - `--page-size` (query, default `20`, int32): pageSize
  - `--folder` (query): folder
- Output: list path `items`; columns `folderAlias`, `folderId`, `parentAlias`, `parentId`; pagination `offset`

### `dce global-management workspace reauthorize`

- Summary: Workspace_Reauthorize
- HTTP: `PUT /apis/ghippo.io/v1alpha1/folders/{folderId}/reauthorize`
- Auth: required
- Body: required
- Flags:
  - `--folder-id` (path, required, int32): folderId

### `dce global-management workspace set-quota-hard-for-workspace-shared-resource`

- Summary: Workspace_SetQuotaHardForWorkspaceSharedResource
- HTTP: `PUT /apis/ghippo.io/v1alpha1/workspace-sharedresource-quota-hard`
- Auth: required
- Body: required
- Flags: none

### `dce global-management workspace unbind-resource-from-workspace`

- Summary: Workspace_UnbindResourceFromWorkspace
- HTTP: `PUT /apis/ghippo.io/v1alpha1/workspaces/{workspaceId}/unbind-resource`
- Auth: required
- Body: required
- Flags:
  - `--workspace-id` (path, required, int32): workspaceId

### `dce global-management workspace update-folder`

- Summary: Update a folder
- HTTP: `PUT /apis/ghippo.io/v1alpha1/folders/{folderId}`
- Auth: required
- Body: required
- Flags:
  - `--folder-id` (path, required, int32): folderId
- Example: `dce global-management workspace update-folder --folder-id <id> \ --set alias=new-folder-name`

### `dce global-management workspace update-quota-check`

- Summary: Workspace_UpdateQuotaCheck
- HTTP: `POST /apis/ghippo.io/v1alpha1/update-quota-check`
- Auth: required
- Body: required
- Flags: none

