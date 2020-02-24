#!/bin/zsh
# This zsh plugin loads compdefs bundled with packages, that are not usually
# installed into fpath

if (( $+commands[bloop] )); then
    fpath+=${$(realpath $commands[bloop]):h}/zsh
fi
