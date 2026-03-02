#!/bin/sh
set -e

REPO="scaleapi/sgpctl"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="sgpctl"

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)   PLATFORM="linux" ;;
  Darwin)  PLATFORM="darwin" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *) echo "Unsupported OS: $OS" >&2; exit 1 ;;
esac

case "$ARCH" in
  x86_64|amd64)  ARCH="amd64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac

if [ "$PLATFORM" = "windows" ]; then
  ASSET_NAME="${BINARY_NAME}-${PLATFORM}-${ARCH}.exe"
else
  ASSET_NAME="${BINARY_NAME}-${PLATFORM}-${ARCH}"
fi

# Get latest release tag if not specified
TAG="${SGPCTL_VERSION:-latest}"
if [ "$TAG" = "latest" ]; then
  TAG="$(curl -sL "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')"
fi

if [ -z "$TAG" ]; then
  echo "Error: could not determine latest release version." >&2
  exit 1
fi

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET_NAME}"

echo "Installing ${BINARY_NAME} ${TAG} (${PLATFORM}/${ARCH})..."

# Download binary
TMPFILE="$(mktemp)"
HTTP_CODE=$(curl -sL -w "%{http_code}" -o "$TMPFILE" "$DOWNLOAD_URL")

if [ "$HTTP_CODE" != "200" ]; then
  rm -f "$TMPFILE"
  echo "Error: failed to download ${ASSET_NAME} from release ${TAG} (HTTP ${HTTP_CODE})" >&2
  echo "URL: ${DOWNLOAD_URL}" >&2
  exit 1
fi

# Install
chmod +x "$TMPFILE"

if [ -w "$INSTALL_DIR" ]; then
  mv "$TMPFILE" "${INSTALL_DIR}/${BINARY_NAME}"
else
  echo "Installing to ${INSTALL_DIR} (requires sudo)..."
  sudo mv "$TMPFILE" "${INSTALL_DIR}/${BINARY_NAME}"
fi

echo "Installed ${BINARY_NAME} to ${INSTALL_DIR}/${BINARY_NAME}"
${BINARY_NAME} --version 2>/dev/null || true
