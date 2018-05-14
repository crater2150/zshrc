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

# get a file from ZDOTDIR, return file in /etc/zsh if it does not exist
zdotfile() {
	if [[ -e $ZDOTDIR/$1 ]]; then
		echo $ZDOTDIR/$1
	else
		echo /etc/zsh/$1
	fi
}

bindkey -v
autoload -Uz zmv

function exists { command -v "$@" >/dev/null }
ZMODLOAD_BLACKLIST=( ssh-agent )

stty -ixon

. $(zdotfile modules/loader.zsh) && mod_init

for i in  ${ZDOTDIR:+ZDOTDIR/aliases/*~*.zwc(N)} /etc/zsh/aliases/*~*.zwc(N); do
    . $i
done

echo $PATH | grep -q 'local' || . /etc/zsh/zprofile
echo $PATH | grep -q 'sbin' || . /etc/zsh/zprofile


typeset -A conf_locations
conf_locations=(
	vim         $XDG_CONFIG_HOME/vim
	awesome     $XDG_CONFIG_HOME/awesome
	mutt        $HOME/.mutt/muttrc
	xd          $XDG_CONFIG_HOME/xd.conf
	zsh         /etc/zsh
	offlineimap $XDG_CONFIG_HOME/offlineimap/config
	compose     $HOME/.XCompose.long
	vdirsyncer  $HOME/.vdirsyncer/config
	xd			$XDG_CONFIG_HOME/xd.conf
	ssh			$HOME/.ssh/config
)


. $(zdotfile completion.zsh)

FZF_ALT_C_COMMAND="fd -t d"
[[ -e /usr/share/doc/fzf/key-bindings.zsh ]] && . /usr/share/doc/fzf/key-bindings.zsh

exists todo && todo
