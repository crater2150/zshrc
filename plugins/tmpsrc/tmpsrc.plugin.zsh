#!/bin/zsh

tmpsrc() {
    if [[ -z $1 ]]; then
	echo "Usage: tmpsrc <LANGUAGE>"
	return 1
    fi
    local confdir="${XDG_CONFIG_HOME:-$HOME/.config}/tmpsrc"
    local template=$1
    local templatepath=$confdir/$template
    shift

    local tempname=$(mktemp -u -t tmpsrc-XXXXXXXX)

    if [[ -d $templatepath ]]; then
	cp -r $templatepath $tempname
	if [[ ! -v TMUX ]]; then
	    tmux new-session -d -s $tempname -c $tempname -- $EDITOR $(realpath $tempname/tmpsrc-mainfile)
	    if [[ -x $templatepath/tmpsrc-compiler ]]; then
		tmux split -h -c $tempname -t $tempname $templatepath/tmpsrc-compiler "$@"
		tmux select-pane -L -t $tempname
	    fi
	    tmux attach -t $tempname
	else
	    pushd $tempname
	    if [[ -x $templatepath/tmpsrc-compiler ]]; then
		tmux split -h -c $tempname $templatepath/tmpsrc-compiler "$@"
		tmux select-pane -L
	    fi
	    $EDITOR $(realpath $tempname/tmpsrc-mainfile)
	    popd
	fi
    elif [[ -x $templatepath ]]; then
	mkdir $tempname
	pushd $tempname
	if [[ ! -v TMUX ]]; then
	    tmux new-session -s $tempname -- $templatepath "$@"
	else
	    $templatepath "$@"
	fi
	popd
    elif [[ -e $templatepath ]]; then
	cp $templatepath $tempname
	$EDITOR $tempname
    else
	echo "No template for $template"
	return 1
    fi

    rm -rf $tempname
}

