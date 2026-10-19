#!/usr/bin/env bash
# Install the sgpctl release binary for this machine from GitHub Releases.
#
#   SGPCTL_VERSION   release to install, e.g. 0.2.0 or v0.2.0 (default: latest)
#   INSTALL_DIR      directory to install into (default: /usr/local/bin)
#
# The download is checked against the release's SHA256SUMS before anything is
# installed. When the target directory needs sudo, the binary is installed
# owned by root with mode 0755, so it stays readable by everyone and writable
# by no one but root. To check provenance as well, use the GitHub CLI:
#   gh attestation verify sgpctl-<platform> --repo scaleapi/sgpctl
set -euo pipefail

REPO="scaleapi/sgpctl"
BINARY_NAME="sgpctl"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
CURL=(curl -fsSL --proto '=https' --tlsv1.2 --retry 3)

fail() {
  echo "Error: $*" >&2
  exit 1
}

# Only the platforms that have a published binary.
case "$(uname -s)-$(uname -m)" in
  Darwin-arm64)
    ASSET_NAME="${BINARY_NAME}-darwin-arm64"
    OWNER="root"
    GROUP="wheel"
    ;;
  Linux-x86_64 | Linux-amd64)
    ASSET_NAME="${BINARY_NAME}-linux-amd64"
    OWNER="root"
    GROUP="root"
    ;;
  *)
    fail "no prebuilt ${BINARY_NAME} for $(uname -s)/$(uname -m); see https://github.com/${REPO}#installation"
    ;;
esac

# Resolve the release tag.
TAG="${SGPCTL_VERSION:-latest}"
if [ "$TAG" = "latest" ]; then
  TAG="$("${CURL[@]}" "https://api.github.com/repos/${REPO}/releases/latest" \
    | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' | head -1)"
  [ -n "$TAG" ] || fail "could not determine the latest release"
fi
case "$TAG" in
  v*) ;;
  *) TAG="v${TAG}" ;;
esac
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || fail "unexpected release tag '${TAG}'"

BASE_URL="https://github.com/${REPO}/releases/download/${TAG}"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "Downloading ${ASSET_NAME} ${TAG}..."
"${CURL[@]}" -o "${WORK}/${ASSET_NAME}" "${BASE_URL}/${ASSET_NAME}" \
  || fail "could not download ${ASSET_NAME} from release ${TAG}"
"${CURL[@]}" -o "${WORK}/SHA256SUMS" "${BASE_URL}/SHA256SUMS" \
  || fail "release ${TAG} has no SHA256SUMS; refusing to install an unverified binary"

# Verify the checksum.
grep -q " ${ASSET_NAME}\$" "${WORK}/SHA256SUMS" \
  || fail "SHA256SUMS in release ${TAG} has no entry for ${ASSET_NAME}"
verify_checksum() {
  cd "$WORK"
  if command -v sha256sum >/dev/null 2>&1; then
    grep " ${ASSET_NAME}\$" SHA256SUMS | sha256sum -c -
  else
    grep " ${ASSET_NAME}\$" SHA256SUMS | shasum -a 256 -c -
  fi
}
(verify_checksum) || fail "checksum mismatch for ${ASSET_NAME}"

# Install.
TARGET="${INSTALL_DIR}/${BINARY_NAME}"
[ -d "$INSTALL_DIR" ] || fail "${INSTALL_DIR} does not exist; create it or set INSTALL_DIR"
if [ -w "$INSTALL_DIR" ]; then
  install -m 0755 "${WORK}/${ASSET_NAME}" "$TARGET"
else
  command -v sudo >/dev/null 2>&1 \
    || fail "${INSTALL_DIR} is not writable and sudo is not available; set INSTALL_DIR to a writable directory"
  echo "Installing to ${INSTALL_DIR} (requires sudo)..."
  sudo install -o "$OWNER" -g "$GROUP" -m 0755 "${WORK}/${ASSET_NAME}" "$TARGET"
fi

echo "Installed ${TARGET}"
"$TARGET" 2>&1 | head -1 || true
