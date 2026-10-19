# sgpctl

A CLI tool for managing SGP services, including System Manager and Agentex Cloud.

## Installation

### macOS (Homebrew)

```bash
brew tap scaleapi/sgpctl https://github.com/scaleapi/sgpctl
brew install sgpctl
```

The explicit URL is required because the tap repo isn't named `homebrew-sgpctl` (the Homebrew convention for auto-discovery). No GitHub token needed — this repo and its releases are public.

To upgrade to the latest version:

```bash
brew update
brew upgrade sgpctl
```

### Linux / macOS (install script)

`install.sh` downloads the binary for your platform from the latest release, checks it against the release's `SHA256SUMS`, and installs it root-owned with mode 0755 into `/usr/local/bin` (using `sudo` if needed). Download it, read it, then run it:

```bash
curl -fsSL --proto '=https' -o install.sh https://raw.githubusercontent.com/scaleapi/sgpctl/main/install.sh
less install.sh
bash install.sh
```

`SGPCTL_VERSION=0.2.0` selects a release and `INSTALL_DIR=~/.local/bin` changes the destination.

### Manual download

Download the binary for your platform from the [latest release](https://github.com/scaleapi/sgpctl/releases/latest), verify it, and put it on your `PATH`:

```bash
sha256sum -c --ignore-missing SHA256SUMS                 # shasum -a 256 -c on macOS
gh attestation verify sgpctl-linux-amd64 --repo scaleapi/sgpctl
sudo install -m 0755 sgpctl-linux-amd64 /usr/local/bin/sgpctl
```

| Platform | Binary |
|----------|--------|
| macOS (ARM) | `sgpctl-darwin-arm64` |
| Linux (x86_64) | `sgpctl-linux-amd64` |
| Windows (x86_64) | `sgpctl-windows-amd64.exe` |

## Usage

```bash
sgpctl --help
```
