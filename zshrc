HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
unsetopt histsavenodups


setopt autocd extendedglob notify correct autonamedirs
setopt list_ambiguous autopushd  pushd_ignore_dups
setopt hist_ignore_space share_history 
#setopt hist_ignore_all_dups
setopt no_auto_remove_slash auto_param_slash
setopt completeinword
setopt chase_links
setopt short_loops
setopt cdable_vars
WORDCHARS=${WORDCHARS//\/}

export ZDOTDIR=${ZDOTDIR:-$HOME/.zsh}

function exists { command -v "$@" >/dev/null }

# get a file from ZDOTDIR, return file in /etc/zsh if it does not exist
zdotfile() {
	if [[ -e $ZDOTDIR/$1 ]]; then
		echo $ZDOTDIR/$1
	else
		echo /etc/zsh/$1
	fi
}
try-source() {
    local i=0
    for i in "$@"; do
	if [[ -e "$i" ]]; then
	    source $i
	fi
    done
}

# run hash -r after the given command. Useful for package manager commands that
# change installed packages
hashafter () {
	local fname=$1
	eval "
	function $fname() {
		command $fname \"\$@\"
		hash -r
	}
	"
}

exists() { command -v "$@" >/dev/null }

function(){
    try-source $(zdotfile dirs)
}

. $(zdotfile completion.zsh)

source $(zdotfile zplug.zsh)

. $(zdotfile bindings.zsh)

stty -ixon

function(){
    local i=0
    for i in  ${ZDOTDIR:+$ZDOTDIR/aliases/*~*.zwc(N)} /etc/zsh/aliases/*~*.zwc(N); do
	. $i
    done
}

if ! (grep -q 'local' <<<$PATH && grep -q 'sbin'  <<<$PATH); then
    . /etc/zsh/zprofile
fi

FZF_ALT_C_COMMAND="fd -t d"

if exists stack; then
	eval "$(stack --bash-completion-script stack)"
fi

exists todo && todo
exists thefuck && eval $(thefuck --alias)
