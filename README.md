# sgpctl

A CLI tool for managing SGP services, including System Manager and Agentex Cloud.

## Installation

### macOS (Homebrew)

Since this is a private repo, you need a GitHub personal access token with `repo` scope.

Generate one via the CLI:

```bash
gh auth token
```

Or create one manually at https://github.com/settings/tokens.

Then install:

```bash
export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
brew tap scaleapi/sgpctl https://github.com/scaleapi/sgpctl
brew install sgpctl
```

You can add the `export` line to your `~/.zshrc` or `~/.bashrc` to persist it.

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
