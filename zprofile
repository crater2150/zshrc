# gentoo specific
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

for sh in /etc/profile.d/*.sh ; do
	[ -r "$sh" ] && . "$sh"
done

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
setopt nullglob


unsetopt nullglob
set -$shopts
unset sh shopts
