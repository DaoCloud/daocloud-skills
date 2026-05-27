// Package dceskills embeds the root cli.yaml so cmd/dce/main.go can
// access it via a plain import without filesystem path traversal.
package dceskills

import _ "embed"

//go:embed cli.yaml
var CLIConfig []byte
