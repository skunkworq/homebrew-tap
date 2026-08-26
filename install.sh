#!/usr/bin/env bash
set -euo pipefail

version="${AEGIS_VERSION:-0.1.4}"
prefix="${AEGIS_INSTALL_PREFIX:-${HOME}/.local}"
release_url="https://github.com/skunkworq/homebrew-tap/releases/download/aegis-v${version}/aegis-cli-${version}.tar.gz"
expected_sha256="be71b6f074e71061b8928a23aed84194aa51e35f189c3706a0f2a91cc32bacd0"
temporary_root="$(mktemp -d "${TMPDIR:-/tmp}/aegis-install.XXXXXX")"

cleanup() {
  rm -rf -- "${temporary_root}"
}
trap cleanup EXIT

if ! command -v node >/dev/null 2>&1; then
  echo "aegis installer: Node.js 22 or newer is required" >&2
  exit 1
fi

node_major="$(node -p 'Number(process.versions.node.split(".")[0])')"
if [[ "${node_major}" -lt 22 ]]; then
  echo "aegis installer: Node.js 22 or newer is required (found $(node --version))" >&2
  exit 1
fi

archive="${temporary_root}/aegis-cli.tar.gz"
curl --fail --silent --show-error --location "${release_url}" --output "${archive}"

if command -v shasum >/dev/null 2>&1; then
  actual_sha256="$(shasum -a 256 "${archive}" | awk '{print $1}')"
elif command -v sha256sum >/dev/null 2>&1; then
  actual_sha256="$(sha256sum "${archive}" | awk '{print $1}')"
else
  echo "aegis installer: shasum or sha256sum is required" >&2
  exit 1
fi

if [[ "${actual_sha256}" != "${expected_sha256}" ]]; then
  echo "aegis installer: downloaded archive failed checksum verification" >&2
  exit 1
fi

tar -xzf "${archive}" -C "${temporary_root}"
install_root="${prefix}/lib/aegis"
binary_path="${prefix}/bin/aegis"
mkdir -p "${prefix}/bin" "${prefix}/lib"
rm -rf -- "${install_root}"
mv "${temporary_root}/aegis-cli-${version}" "${install_root}"
chmod 755 "${install_root}/cli.js"
ln -sfn "${install_root}/cli.js" "${binary_path}"

echo "Installed Aegis CLI at ${binary_path}"
case ":${PATH}:" in
  *":${prefix}/bin:"*) echo "Run: aegis login" ;;
  *) echo "Add ${prefix}/bin to PATH, then run: aegis login" ;;
esac
