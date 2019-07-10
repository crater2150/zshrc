export ZDOTDIR="${$(readlink $HOME/.zshenv):h:a}"

for i in $ZDOTDIR/env/*.zsh; do
	. $i
done

