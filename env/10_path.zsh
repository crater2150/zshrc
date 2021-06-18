export PATH="$HOME/.local/bin:$PATH"
if [[ -d ${XDG_DATA_HOME:-$HOME/.local/share}/coursier/bin ]]; then
	export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/coursier/bin"
fi
