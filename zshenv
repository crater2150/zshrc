export ZDOTDIR="${$(readlink $HOME/.zshenv):h:a}"

exists() { command -v "$@" >/dev/null }
for i in $ZDOTDIR/env/*.zsh; do
	. $i
done

