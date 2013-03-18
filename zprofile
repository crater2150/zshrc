# gentoo specific
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

if [ -e "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

export EDITOR=${EDITOR:-/usr/bin/vim}
export PAGER=${PAGER:-/usr/bin/less}
export XDG_CONFIG_HOME="$HOME/.config"

# 077 would be more secure, but 022 is generally quite realistic
umask 022

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${ROOTPATH}:$PATH"

PATH="/usr/lib/colorgcc/bin/:${PATH}"

export PATH
unset ROOTPATH

shopts=$-
setopt nullglob

#more gentoo specific stuff
for sh in /etc/profile.d/*.sh ; do
	[ -r "$sh" ] && . "$sh"
done

unsetopt nullglob
set -$shopts
unset sh shopts
