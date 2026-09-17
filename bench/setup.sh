#!/usr/bin/env bash
set -euo pipefail

version="${K8S_AI_BENCH_VERSION:-v0.1.1-rc.1}"
repository="${K8S_AI_BENCH_REPOSITORY:-DaoCloud/ai-skills-bench}"
dce_version="${DCE_CLI_VERSION:-v0.2.0-rc.4}"
dce_repository="${DCE_CLI_REPOSITORY:-DaoCloud/daocloud-skills}"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
destination="${1:-${script_dir}/.build/bin}"

case "$(uname -s)" in
  Darwin) os=darwin ;;
  Linux) os=linux ;;
  *)
    echo "unsupported operating system: $(uname -s); download the Windows zip from the release page" >&2
    exit 1
    ;;
esac

install_package() {
  local package="$1"
  if command -v brew >/dev/null 2>&1; then
    brew install "${package}"
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y "${package}"
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y "${package}"
  else
    echo "missing ${package}; install it and rerun setup.sh" >&2
    exit 1
  fi
}

ensure_command() {
  local command_name="$1"
  local package_name="$2"
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "${command_name} not found; installing ${package_name}"
    install_package "${package_name}"
  fi
}

ensure_command curl curl
ensure_command tar tar

case "$(uname -m)" in
  arm64|aarch64) arch=arm64 ;;
  amd64|x86_64) arch=amd64 ;;
  *)
    echo "unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

release_version="${version#v}"
archive="k8s-ai-bench_${release_version}_${os}_${arch}.tar.gz"
download_url="https://github.com/${repository}/releases/download/${version}/${archive}"
archive_path="$(mktemp -t k8s-ai-bench-release)"
dce_archive="dce-${dce_version}-${os}-${arch}.tar.gz"
dce_download_url="https://github.com/${dce_repository}/releases/download/${dce_version}/${dce_archive}"
trap 'rm -f "${archive_path}"' EXIT

mkdir -p "${destination}"
echo "Downloading ${download_url}"
curl --fail --location --silent --show-error "${download_url}" -o "${archive_path}"
tar -xzf "${archive_path}" -C "${destination}"

if command -v dce >/dev/null 2>&1; then
  echo "Using existing dce CLI: $(command -v dce)"
else
  echo "dce CLI not found; downloading a local copy"
  echo "Downloading ${dce_download_url}"
  dce_archive_path="$(mktemp -t dce-cli-release)"
  dce_extract_dir="$(mktemp -d -t dce-cli-release)"
  trap 'rm -f "${archive_path}" "${dce_archive_path}"; rm -rf "${dce_extract_dir}"' EXIT
  curl --fail --location --silent --show-error "${dce_download_url}" -o "${dce_archive_path}"
  tar -xzf "${dce_archive_path}" -C "${dce_extract_dir}"
  cp "${dce_extract_dir}/dce-${dce_version}-${os}-${arch}/dce" "${destination}/dce"
fi

chmod 755 \
  "${destination}/k8s-ai-bench" \
  "${destination}/k8s-ai-agent-bridge" \
  "${destination}/generic-llm-agent" \
  "${destination}/k8s-ai-hermes-bridge"

if [[ -f "${destination}/dce" ]]; then
  chmod 755 "${destination}/dce"
fi

echo "Installed k8s-ai-bench ${version} binaries in ${destination}"
