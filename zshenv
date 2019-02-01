export ZDOTDIR=$HOME/.config/zsh

ZMODLOAD_BLACKLIST=( ssh-agent )
export ZMODLOAD_BLACKLIST
if [ -n "$TMUX" ]; then export SHELL=/usr/bin/tmux; fi

export MAILDIR=$HOME/.maildir export NOTMUCH_CONFIG=$HOME/.config/notmuch-config
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export FZF_DEFAULT_COMMAND="fd"
export NPM_PACKAGES="${XDG_DATA_HOME}/npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
PATH="$PATH:$NPM_PACKAGES/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$XDG_DATA_HOME/android/sdk/tools"
export PATH

if command -v rustup &>/dev/null; then
	export RUST_SRC_PATH=$(rustup run stable rustc --print sysroot)/lib/rustlib/src/rust/src
fi

if [[ -e $ZDOTDIR/dirs ]]; then
	source $ZDOTDIR/dirs
fi
