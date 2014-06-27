
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
GPG_TTY=`tty`
export GPG_TTY

setopt autocd extendedglob notify correct autonamedirs
setopt list_ambiguous autopushd  pushd_ignore_dups
setopt hist_ignore_all_dups hist_ignore_space share_history 
setopt no_auto_remove_slash auto_param_slash
setopt completeinword
setopt chase_links
setopt short_loops
setopt cdable_vars

# autoload completions
fpath+=( "${ZDOTDIR:-/etc/zsh}/compdef" )
autoload -U ${ZDOTDIR:-/etc/zsh}/compdef/*(:t)

bindkey -v

autoload -Uz compinit && compinit
autoload -Uz zmv

zmodload zsh/zftp

function exists { command -v "$@" >/dev/null }

for i in  ${ZDOTDIR:-/etc/zsh}/aliases/*~${ZDOTDIR:-/etc/zsh}/aliases/*.zwc; do
    . $i
done

stty -ixon

. ${ZDOTDIR:-/etc/zsh}/modules/loader.zsh && mod_init

echo $PATH | grep -q 'local' || . /etc/zsh/zprofile
echo $PATH | grep -q 'sbin' || . /etc/zsh/zprofile


zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format ‘%B%d%b’
zstyle ':completion:*:messages' format ‘%d’
zstyle ':completion:*:warnings' format ‘No matches for: %d’

exists todo && todo
