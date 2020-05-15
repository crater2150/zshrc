# autoload completions
fpath=( "${ZDOTDIR:+$ZDOTDIR/compdef}" "/etc/zsh/compdef" $fpath )

[[ -n $(echo /etc/zsh/compdef/*(N:t)) ]] && autoload -U /etc/zsh/compdef/*(N:t)
[[ -n $(echo $ZDOTDIR/compdef/*(N:t)) ]] && autoload -U $ZDOTDIR/compdef/*(N:t)

autoload -Uz compinit
if [[ ${UID} -eq 0 ]] && [[ -n ${SUDO_USER} ]]; then
	compinit -u
else
	compinit
fi
autoload -U +X bashcompinit && bashcompinit

zstyle ':completion:*:descriptions' format ‘%B%d%b’
zstyle ':completion:*:messages' format ‘%d’
zstyle ':completion:*:warnings' format ‘No matches for: %d’
zstyle ':completion:*' use-cache on                                       
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _complete _ignored _match _approximate _correct 
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' squeeze-slashes true                           
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/etc/zsh/completion'


# completion for programs with standard gnu --help
for prog in amm tapestry virtualenv dragon; do
	compdef _gnu_generic $prog
done

# custom compdefs

compdef _xbps xi=xbps-install

{
	local _myhosts
	_myhosts=( $(awk '/^Host/ {for (i=2; i<=NF; i++) print $i}' ~/.ssh/config) )
	zstyle ':completion:*' hosts $_myhosts
}&>/dev/null

zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

compdef _command fork
compdef _command detach
compdef _command ontv
compdef _notmuch nmfind=notmuch-search
