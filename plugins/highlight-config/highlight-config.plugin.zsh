typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

if [[ "`tput colors`" == "256" ]] || [[ "`tput colors`" == "88" ]] ; then

ZSH_HIGHLIGHT_STYLES[command]='fg=74'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=74'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=74'
ZSH_HIGHLIGHT_STYLES[function]='fg=74'
ZSH_HIGHLIGHT_STYLES[alias]='fg=74,underline'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=74,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=120'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=215,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=215,bold'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=203,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=203'


ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=33'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=51'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=40'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=35'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='bold,bg=75'

ZSH_HIGHLIGHT_PATTERNS+=('${*}' 'fg=215')

else

ZSH_HIGHLIGHT_PATTERNS+=('${*}' 'fg=yellow')

fi
