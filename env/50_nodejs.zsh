export NPM_PACKAGES="${XDG_DATA_HOME}/npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH}:$NPM_PACKAGES/share/man"
