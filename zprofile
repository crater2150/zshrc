# /etc/zsh/zprofile
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/files/zprofile-1,v 1.1 2010/08/15 12:21:56 tove Exp $

# Load environment settings from profile.env, which is created by
# env-update from the files in /etc/env.d
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

setopt nullglob
for sh in /etc/profile.d/*.sh ; do
	[ -r "$sh" ] && . "$sh"
done
unsetopt nullglob

if [ -e "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

export EDITOR=${EDITOR:-/usr/bin/vim}
export PAGER=${PAGER:-/usr/bin/less}
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local"

# 077 would be more secure, but 022 is generally quite realistic
umask 022

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${ROOTPATH}:$PATH"

PATH="/usr/lib/colorgcc/bin/:${PATH}"

export PATH
unset ROOTPATH

shopts=$-
set -$shopts
unset sh shopts
