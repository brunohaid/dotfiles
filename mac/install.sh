#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
stamp="$(date +%Y%m%d%H%M%S)"

backup_file() {
	local path="$1"
	if [ -e "$path" ] && [ ! -L "$path" ]; then
		cp "$path" "$path.backup-$stamp"
	fi
}

if command -v brew >/dev/null 2>&1; then
	brew bundle --file "$repo_dir/mac/Brewfile"
fi

mkdir -p "$config_dir/oh-my-posh"
cp "$repo_dir/omp/brunoshell.omp.json" "$config_dir/oh-my-posh/brunoshell.omp.json"

backup_file "$HOME/.zshrc"
cp "$repo_dir/mac/zsh/.zshrc" "$HOME/.zshrc"

if [ ! -e "$HOME/.zprofile" ]; then
	cp "$repo_dir/mac/zsh/.zprofile.example" "$HOME/.zprofile"
fi

mkdir -p "$HOME/Library/Fonts"
cp "$repo_dir/fonts/otf"/*.otf "$HOME/Library/Fonts/"

mkdir -p "$HOME/.iterm2"
cp "$repo_dir/mac/iterm2/com.googlecode.iterm2.plist" "$HOME/.iterm2/com.googlecode.iterm2.plist"

if command -v zsh >/dev/null 2>&1; then
	if ! grep -q "$(command -v zsh)" /etc/shells; then
		echo "Add $(command -v zsh) to /etc/shells before running chsh."
	fi
	if [ "$SHELL" != "$(command -v zsh)" ]; then
		echo "Run chsh -s $(command -v zsh) to make zsh your login shell."
	fi
fi
