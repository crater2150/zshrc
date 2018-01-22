# autoload completions
fpath+=( "${ZDOTDIR:+ZDOTDIR}/compdef" )
fpath+=( "/etc/zsh/compdef" )
autoload -U /etc/zsh/compdef/*(:t)

if [[ -d $ZDOTDIR/compdef ]]; then
	autoload -U /etc/zsh/compdef/*(N:t)
fi

autoload -Uz compinit && compinit

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
