#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
command -v python3 >/dev/null || { printf 'python3 is required\n' >&2; exit 127; }
exec python3 "$SCRIPT_DIR/collect_rca.py" "$@"
