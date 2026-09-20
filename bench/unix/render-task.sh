#!/usr/bin/env bash
set -euo pipefail

: "${DCE_HOST:?DCE_HOST is required}"
: "${DCE_TOKEN:?DCE_TOKEN is required}"

# dce auth login --with-token expects the JWT itself. Accept the conventional
# Authorization header form in the environment for easier copy-paste.
render_dce_token="${DCE_TOKEN#Bearer }"
export DCE_TOKEN="${render_dce_token}"

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
template_root="${script_dir}/task-template"

render_task() {
  local task="$1"
  local template_dir="${template_root}/${task}"
  local destination="${script_dir}/.runtime/tasks/${task}"

  if [[ ! -d "${template_dir}" ]]; then
    echo "task template not found: ${template_dir}" >&2
    echo "usage: $0 [task-name]   # templates: $(cd "${template_root}" && ls -1 | tr '\n' ' ')" >&2
    return 1
  fi
  mkdir -p "${destination}"
  cp "${template_dir}/task.yaml" "${destination}/task.yaml"
  cp "${template_dir}/verify.sh" "${destination}/verify.sh"
  cp "${template_dir}/cleanup.sh" "${destination}/cleanup.sh"
  chmod 755 "${destination}/verify.sh" "${destination}/cleanup.sh"
  if [[ -f "${template_dir}/setup.sh" ]]; then
    cp "${template_dir}/setup.sh" "${destination}/setup.sh"
    chmod 755 "${destination}/setup.sh"
  fi

  while IFS= read -r line || [[ -n "${line}" ]]; do
    line="${line//\$\{DCE_HOST\}/${DCE_HOST}}"
    line="${line//\$\{DCE_TOKEN\}/${DCE_TOKEN}}"
    printf '%s\n' "${line}"
  done < "${template_dir}/prompt.template" > "${destination}/prompt.txt"

  printf 'Rendered task: %s\n' "${destination}"
}

# With no arguments, render every template under task-template/. Pass a task
# name to render a single task. Which rendered tasks a matrix run executes is
# selected by its runs.taskPattern regex.
if (( $# == 0 )); then
  for template_dir in "${template_root}"/*/; do
    [[ -d "${template_dir}" ]] || continue
    render_task "$(basename "${template_dir}")"
  done
else
  render_task "$1"
fi
