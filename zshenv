export ZDOTDIR="${$(readlink $HOME/.zshenv):h:a}"

exists() { command -v "$@" >/dev/null }
function(){
	local i
	for i in $ZDOTDIR/env/*.zsh; do
		. $i
	done
}
