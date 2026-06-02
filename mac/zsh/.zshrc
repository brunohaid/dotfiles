# Find the Oh My Posh theme from an explicit override or common install locations
_omp_theme=""

# Prefer an explicit theme path when set by the local machine
if [ -n "$OMP_THEME" ] && [ -f "$OMP_THEME" ]; then
	_omp_theme="$OMP_THEME"
fi

# Support installing the theme directly in the home directory
if [ -z "$_omp_theme" ] && [ -f "$HOME/brunoshell.omp.json" ]; then
	_omp_theme="$HOME/brunoshell.omp.json"
fi

# Support the standard per-user config location
if [ -z "$_omp_theme" ] && [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh/brunoshell.omp.json" ]; then
	_omp_theme="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-posh/brunoshell.omp.json"
fi

# Support using the theme directly from this dotfiles repository
if [ -z "$_omp_theme" ] && [ -f "$HOME/dotfiles/omp/brunoshell.omp.json" ]; then
	_omp_theme="$HOME/dotfiles/omp/brunoshell.omp.json"
fi

# Initialize Oh My Posh when installed and a theme was found
if command -v oh-my-posh >/dev/null 2>&1 && [ -n "$_omp_theme" ]; then
	eval "$(oh-my-posh init zsh --config "$_omp_theme")"
fi

# Clear the temporary theme lookup variable
unset _omp_theme

# Add Homebrew Python to PATH when installed
if [ -d /opt/homebrew/opt/python@3.13/libexec/bin ]; then
	export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
fi

# Initialize zsh completion system
autoload -Uz compinit
compinit

# Load zsh autosuggestions when installed through Homebrew or Oh My Zsh custom plugins
if [ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
	source "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
	source "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
	source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Load zsh syntax highlighting when installed through Homebrew or Oh My Zsh custom plugins
if [ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
	source "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [ -f "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
	source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
	source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Set zsh-autosuggestions faded suggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Load iTerm2 shell integration when installed
if [ -f "$HOME/.iterm2_shell_integration.zsh" ]; then
	source "$HOME/.iterm2_shell_integration.zsh"
fi

# Set CMake path when installed
if command -v cmake >/dev/null 2>&1; then
	export CMAKE_PATH="$(command -v cmake)"
fi

# Add Homebrew PostgreSQL tools to PATH when installed
if [ -d /opt/homebrew/opt/postgresql@15/bin ]; then
	export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
fi

# Add Postgres.app tools to PATH when installed
if [ -d /Applications/Postgres.app/Contents/Versions/latest/bin ]; then
	export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
fi

# Use the macOS Tailscale app binary when installed
if [ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]; then
	alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

# Add STM32CubeProgrammer path when installed
if [ -d /Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin ]; then
	export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
fi

# Add ARM GNU toolchain path when installed
if [ -d /Applications/ArmGNUToolchain/14.2.rel1/aarch64-none-elf/bin ]; then
	export PATH="$PATH:/Applications/ArmGNUToolchain/14.2.rel1/aarch64-none-elf/bin"
fi

# Load nrfutil zsh completions when installed
if [ -r "$HOME/.nrfutil/share/nrfutil-completion/scripts/zsh/setup.zsh" ]; then
	source "$HOME/.nrfutil/share/nrfutil-completion/scripts/zsh/setup.zsh"
fi

# Add STM32CubeMX resources path when installed
if [ -d /Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources ]; then
	export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources
fi

# Add local user binaries to PATH
if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi
