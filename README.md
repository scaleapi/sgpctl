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

### Linux / Windows

Download the binary for your platform from the [latest release](https://github.com/scaleapi/sgpctl/releases/latest) and add it to your `PATH`.

| Platform | Binary |
|----------|--------|
| macOS (ARM) | `sgpctl-darwin-arm64` |
| Linux (x86_64) | `sgpctl-linux-amd64` |
| Windows (x86_64) | `sgpctl-windows-amd64.exe` |

## Usage

```bash
sgpctl --help
```
