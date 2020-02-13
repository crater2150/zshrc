#!/bin/zsh

#################################################################################
# ZSH zle widget and custom function autloader 
#################################################################################
#
# Lets you load custom functions and zle widgets split into single files.
#
# zle widgets are stored in the "widgets" folder in your configuration directory
# (set with $ZDOTDIR, see manpage). The widgets in /etc/zsh/widgets are also
# considered.
#
# functions are stored in the "functions" folder analogous.
#

if [[ -z $ZWIDGETPATH ]]; then
	ZWIDGETPATH=( ${ZDOTDIR:+$ZDOTDIR/widgets} )
	[[ -d /etc/zsh/widgets ]] && ZWIDGETPATH+=/etc/zsh/widgets
fi

if [[ -z $ZFUNCTIONPATH ]]; then
	ZFUNCTIONPATH=( ${ZDOTDIR:+$ZDOTDIR/functions} )
	[[ -d /etc/zsh/functions ]] && ZFUNCTIONPATH+=/etc/zsh/functions
fi

fpath+=(${ZWIDGETPATH})
fpath+=(${ZFUNCTIONPATH})

for dir in $ZWIDGETPATH; do
	if [ -d $dir ]; then
		for i in $dir/*~*.zwc(N:t); do
			autoload -Uz  $i
			zle -N $i
		done
	fi
done

for dir in $ZFUNCTIONPATH; do
	if [ -d $dir ]; then
		for i in $dir/*~*.zwc(N:t); do
			autoload -Uz $i
		done
	fi
done