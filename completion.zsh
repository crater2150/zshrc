# autoload completions
fpath=( "${ZDOTDIR:+$ZDOTDIR/compdef}" "/etc/zsh/compdef" $fpath )

[[ -n $(echo /etc/zsh/compdef/*(N:t)) ]] && autoload -U /etc/zsh/compdef/*(N:t)
[[ -n $(echo $ZDOTDIR/compdef/*(N:t)) ]] && autoload -U $ZDOTDIR/compdef/*(N:t)

autoload -Uz compinit && compinit -u

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format ‘%B%d%b’
zstyle ':completion:*:messages' format ‘%d’
zstyle ':completion:*:warnings' format ‘No matches for: %d’


# completion for programs with standard gnu --help
for prog in amm tapestry; do
	compdef _gnu_generic $prog
done

# custom compdefs

compdef _xbps xi=xbps-install
