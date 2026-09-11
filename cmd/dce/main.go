package main

import (
	"os"

	"github.com/lathe-cli/lathe/pkg/lathe"

	dceskills "github.com/DaoCloud/daocloud-skills"
	generated "github.com/DaoCloud/daocloud-skills/internal/generated"
)

// Version, Commit, and Date are injected by the Makefile via -ldflags -X.
var (
	Version = "dev"
	Commit  = "none"
	Date    = "unknown"
)

func main() {
	os.Exit(lathe.Run(lathe.RunOptions{
		Manifest: dceskills.CLIConfig,
		Mount:    generated.MountModules,
		Version:  Version,
		Commit:   Commit,
		Date:     Date,
	}))
}
