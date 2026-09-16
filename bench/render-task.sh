#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

# dce auth login --with-token expects the JWT itself. Accept the conventional
# Authorization header form in the environment for easier copy-paste.
render_dce_token="${DCE_TOKEN#Bearer }"
export DCE_TOKEN="${render_dce_token}"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
template_dir="${script_dir}/task-template/dce-create-pod"
destination="${1:-${script_dir}/.runtime/tasks/dce-create-pod}"

if [[ ! -d "${template_dir}" ]]; then
  echo "task template not found: ${template_dir}" >&2
  exit 1
fi

mkdir -p "${destination}"
cp "${template_dir}/task.yaml" "${destination}/task.yaml"
cp "${template_dir}/verify.sh" "${destination}/verify.sh"
cp "${template_dir}/cleanup.sh" "${destination}/cleanup.sh"
chmod 755 "${destination}/verify.sh" "${destination}/cleanup.sh"

python3 - "${template_dir}/prompt.template" "${destination}/prompt.txt" <<'PY'
import os
import sys
from pathlib import Path

source = Path(sys.argv[1])
target = Path(sys.argv[2])
content = source.read_text(encoding="utf-8")
for name in ("DCE_HOST", "DCE_TOKEN"):
    content = content.replace("${" + name + "}", os.environ[name])
target.write_text(content, encoding="utf-8")
PY

printf 'Rendered task: %s\n' "${destination}"
