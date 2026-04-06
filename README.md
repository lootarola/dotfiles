# dotfiles

Personal configuration files for the tools I use every day, managed with GNU Stow.

## Packages

- `aerospace`
- `claude`
- `ghostty`
- `nvim`
- `zsh`

## Requirements

- [Homebrew](https://brew.sh) — currently the only supported package manager, but support for others may be added in the future. Works on both macOS and Linux.

## Dependencies

- `stow`
- `zmx`

## Installation

Clone the repo and `cd` into it:

```sh
git clone <repo-url>
cd dotfiles
```

The installer will automatically install all dependencies via Homebrew.

Install a specific package:

```sh
make install-nvim
make install-ghostty
make install-aerospace
make install-claude
make install-zsh
```

Or install everything at once:

```sh
make install
```

You will be prompted for confirmation before any changes are made. Existing files at the target paths will be removed and replaced with symlinks.

## Uninstalling

Remove symlinks for a specific package:

```sh
make uninstall-nvim
```

Or remove all symlinks:

```sh
make uninstall
```
