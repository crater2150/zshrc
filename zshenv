export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh

for i in $ZDOTDIR/env/*.zsh; do
	. $i
done

