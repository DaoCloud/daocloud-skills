# Catalog Protocol

Use the runtime catalog as the source of truth. Generated references are a fast index; command execution details come from the CLI itself.

## Search

Run `dce search "<intent>" --json` to find candidate commands. Use `--limit` to control result count. Treat search output as candidates only.

## Full Catalog

Run `dce commands --json` to inspect the generated command catalog. Use `--include-hidden` only when hidden commands are relevant.

The catalog is static: it reflects every module `dce` was built with, **not** what is installed on the target host. Presence in the catalog does not mean the module is deployed. A module-level `404` (the API route does not exist) is ambiguous — module not installed, or wrong path/version. On such a `404`, actively confirm by running `dce global-management about list-g-product-versions -o json`: if the module is absent from the list it is not installed (don't retry sibling commands; report it as not installed); if it is present, the module exists and the `404` is a wrong path/version or resource-level not-found, so re-check with `dce commands show <path...> --json`. A resource-level `404` (specific ID/name) on a working module is a normal "object not found", not a missing module.

Key fields:

- `path`: command path to pass to `commands show` or execute after the CLI name.
- `http`: HTTP method and path template.
- `flags`: CLI flags, parameter location, type, required state, defaults, enum values, format, and help.
- `body`: request body requirement and media type.
- `auth`: whether auth is required and which scopes are declared.
- `output`: list path, default columns, response media type, pagination, and streaming hints.

## Command Detail

Run `dce commands show <path...> --json` before executing an unfamiliar command. This is the source of truth for flags, body, auth, HTTP path, and output hints.

## Schema

Run `dce commands schema --json` to read the catalog schema version before parsing catalog JSON with durable tooling.

## Request Bodies

- `--file path`: read a JSON body from a file.
- `--file -`: read a JSON body from stdin.
- `--set key.path=value`: build JSON with type inference for booleans, null, integers, and floats.
- `--set-str key.path=value`: build JSON while forcing the value to remain a string.

## Output

Use `-o json` for machine-readable command output. Other supported formats are `table`, `yaml`, and `raw`.

## Auth

If command detail returns `auth.required=true`, run `dce auth status --hostname <host>` before execution. If no matching host is logged in, stop and ask the user to authenticate.
