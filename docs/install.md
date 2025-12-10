# Installation Guide (Neovim 0.12+)

This guide covers installing Neovim 0.12 or newer, prerequisites, cloning the config, and authenticating GitHub Copilot.

## Prerequisites
- Git
- ripgrep (for Telescope)
- Node.js 18+ (recommended for Copilot)

---

## Ubuntu (using Neovim Unstable PPA)

Install Neovim from the official unstable PPA and required tools:

```bash
sudo apt update
sudo apt install -y software-properties-common curl git ripgrep

# Add the Neovim unstable PPA
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Optional: Node.js (recommended for Copilot)
sudo apt install -y nodejs npm
```

Reference: Neovim Unstable PPA `neovim-ppa/unstable` (see: https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable)

Verify version:

```bash
nvim --version | head -n1
```

---

## macOS (Homebrew)

Install Neovim and tools using Homebrew:

```bash
# Ensure Command Line Tools are installed
xcode-select --install 2>/dev/null || true

# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages
brew install neovim ripgrep node
```

Verify version:

```bash
nvim --version | head -n1
```

---

## Clone the Configuration

Clone the public config into your Neovim config directory:

```bash
# Replace <your-repo-url> with your public repo URL
git clone <your-repo-url> ~/.config/nvim
```

First launch will automatically install plugins.

---

## Copilot Authentication

If you enabled Copilot (default in this config), authenticate once:

1. Open Neovim
2. Run:

```vim
:Copilot auth
```

3. A browser will open; complete GitHub authentication
4. Back in Neovim, verify:

```vim
:Copilot status
```

If the command is not found, ensure the Copilot plugin is installed (open Neovim, wait for the plugins to finish installing, then try again).

---
## VSCode Neovim: jj composite key

If you use VSCode (or Cursor) with the Neovim extension, add the composite key mapping so "jj" acts as Escape. Edit your VSCode settings (for example [`config/Code - OSS/User/settings.json`](config/Code - OSS/User/settings.json:1) or [`config/Cursor/User/settings.json`](config/Cursor/User/settings.json:1)) and add:

```json
{
  "vscode-neovim.compositeKeys": {
    "jj": {
      "command": "vscode-neovim.escape"
    }
  }
}
```

This repository already includes that setting at the paths above; syncing or copying those settings into your VSCode user settings will enable `jj` to act as Escape when using the Neovim extension.

Note: Install the VSCode Neovim extension (Marketplace ID: `asvetliakov.vscode-neovim`). Open Extensions (Ctrl+Shift+X) and search for "Neovim", or install from the command line:

```bash
code --install-extension asvetliakov.vscode-neovim
```

After installing the extension, ensure it points to your Neovim executable and init file (see [`config/Code - OSS/User/settings.json`](config/Code - OSS/User/settings.json:1) for an example).

## Troubleshooting

- If plugins don't install on first launch, restart Neovim and check `:messages` for errors
- Run `:checkhealth` for environment checks
- Ensure ripgrep is installed and on your PATH
