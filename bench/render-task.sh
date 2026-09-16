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

while IFS= read -r line || [[ -n "${line}" ]]; do
  line="${line//\$\{DCE_HOST\}/${DCE_HOST}}"
  line="${line//\$\{DCE_TOKEN\}/${DCE_TOKEN}}"
  printf '%s\n' "${line}"
done < "${template_dir}/prompt.template" > "${destination}/prompt.txt"

printf 'Rendered task: %s\n' "${destination}"
