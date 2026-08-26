# Catalog Protocol

Use the runtime catalog as the source of truth. Generated references are a fast index; command execution details come from the CLI itself.

## Search

Run `dce search "<intent>" --json` to find candidate commands. Use `--limit` to control result count. Treat search output as candidates only.

## Full Catalog

Run `dce commands --json` to inspect the generated command catalog. Use `--include-hidden` only when hidden commands are relevant.

Key fields:

- `path`: command path to pass to `commands show` or execute after the CLI name.
- `shortcuts`: root-level commands that execute the same operation with preset flag values.
- `http`: HTTP method and path template.
- `http.default_hostname`: optional source-level host used after `--hostname`, `$DCE_HOST`, and the host selected with `auth use`, and before the single-host fallback from `hosts.yml`.
- `flags`: CLI flags, parameter location, type, required state, defaults, enum values, format, input modes, and help.
- `body`: request body requirement, media type, and optional `runtime_schema` preflight source, including its active-context prerequisites.
- `auth`: whether auth is required and which scopes are declared.
- `mutation`: `read`, `write`, or `unknown`. Do not infer write vs read from the HTTP method alone. Treat any value other than `read` as requiring preview when `dry_run.mode` is `http_preview`, or explicit user confirmation when preview is unavailable.
- `dry_run`: preview contract. `http_preview` is declared only when the generated runner can preview; use `--<flag>` and print the resolved HTTP request JSON. `unsupported` means the command has no preview, including all workflow commands. A `--dry-run` flag on a custom command is not a preview contract.
- `examples`: runnable examples with optional body shape, output hints, and follow-up commands.
- `output`: list path, default columns, response media type, pagination, and streaming hints; a streaming policy describes collection, terminal outcomes, and optional live projection.
- `flags[].context`: an optional account-scoped default with explicit flag, declared environment, then stored-value precedence.
- `sets_context`: a successful operation persists its declared parameter as the selected host's active context.
- `notes`, `prerequisites`, and `known_errors`: overlay-provided operation context that is not inferred from the API spec.

## Command Detail

Run `dce commands show <path...> --json` before executing an unfamiliar command. This is the source of truth for flags, body, auth, HTTP path, `mutation`, `dry_run`, and output hints.

## Schema

Run `dce commands schema --json` to read `catalog_schema_version`, `surfaces`, and `dry_run.result` before parsing catalog JSON with durable tooling. `dry_run.result=http_preview` means a preview prints the resolved HTTP request JSON (`method`, `url`, `hostname`, `host_source`, `headers`, `body`, `auth`, `output`).

## Sensitive Flags

When a flag entry has `input_modes`, prefer safe modes over putting secrets directly in shell arguments.

- `flag`: pass the direct `--<flag>` value; keep this for compatibility or non-secret values.
- `env`: pass `--<flag>-env NAME` to read the value from an environment variable.
- `file`: pass `--<flag>-file path` to read the value from a file.
- `stdin`: pass `--<flag>-stdin` to read the value from stdin.
- Use only one input mode for the same flag.

## Request Bodies

- `--file path`: read a JSON body from a file.
- `--file -`: read a JSON body from stdin.
- `--set key.path=value`: build JSON with type inference for booleans, null, integers, and floats.
- `--set-str key.path=value`: build JSON while forcing the value to remain a string.

If `body.runtime_schema` is present, normal execution fetches that JSON Schema and validates the body before the target request. An `http_preview` dry-run does not fetch it.

## Output

Use `-o json` for machine-readable command output. Other supported formats are `table`, `yaml`, and `raw`. For collected streams, choose one mode: JSON or YAML for one document, `--stream` in the default output mode when `output.streaming.policy.live` is present, or raw for wire events.

On a non-zero exit with JSON or YAML output, read `error.code`, `error.message`, and `error.hint`; optional `error.http` contains only `status`. A configured pause exits zero and is represented by the field mapping in its stream collection policy.

## Auth

If command detail returns `auth.required=true`, run `dce auth status -o json` before execution and read `hostname` and `source`. Host resolution order: `--hostname` > `$DCE_HOST` > the selected host (`dce auth use <host>`) > `http.default_hostname` > the single host in `hosts.yml`. When more than one host is logged in and the host was chosen implicitly, the CLI also prints a `current host: <name>` line on stderr; read provenance from `auth status`, not from that line. If no matching host is logged in, stop and ask the user to authenticate.
