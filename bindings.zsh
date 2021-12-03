#!/bin/zsh

bindkey -v

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   yank
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-search
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-search
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" history-beginning-search-forward

bindkey "\ee"   expand-cmd-path        # A-e for expanding path of typed command.
bindkey " "     magic-space            # Do history expansion on space.
bindkey $'\177' backward-delete-char   # backspace
bindkey $'\10'  backward-delete-word   # C-backspace

bindkey -M vicmd ! edit-command-line-tmux

#unicode input
autoload -U insert-unicode-char
zle -N insert-unicode-char
bindkey "^Vu"  insert-unicode-char

bindkey "\e."  insert-last-word

bindkey "\e[1;5D" vi-backward-blank-word
bindkey "\e[1;5C" vi-forward-blank-word

bindkey "^P" push-line-or-edit

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
local function zle-line-init () {
    echoti smkx 2> /dev/null
}
local function zle-line-finish () {
    echoti rmkx 2> /dev/null
}
zle -N zle-line-init
zle -N zle-line-finish  

insert_sudo () { LBUFFER="sudo ${LBUFFER}" }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

local function accept-or-recall-and-infer-history() {
	if [[ -z $PREBUFFER$BUFFER ]]; then
		zle up-line-or-history
		zle infer-next-history

	else
		zle accept-and-infer-next-history -- "$@"
	fi
}
zle -N  accept-or-recall-and-infer-history
bindkey "\e^M" accept-or-recall-and-infer-history

if exists incstring; then
	local function inc-last-command() {
		if [[ -z $BUFFER ]]; then
		    BUFFER=$(incstring "$(history -n -1)");
		else
		    BUFFER=$(incstring "$BUFFER");
		fi
		zle vi-end-of-line
	}
	zle -N  inc-last-command
	bindkey "^A" inc-last-command
fi

if zle -l tmsu-fzf-change-directory; then
    bindkey "^t" tmsu-fzf-change-directory
fi

zle-venv() { zle push-line; BUFFER="venv"; zle accept-line }
zle -N zle-venv
bindkey "\ev" zle-venv
