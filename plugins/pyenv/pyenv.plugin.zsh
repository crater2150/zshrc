export PYENV_ROOT=${XDG_DATA_HOME:-$HOME/.local/share}/pyenv
_init_pyenv() {
    export PATH="$PATH:$PYENV_ROOT/bin"
    eval "$(pyenv init -)"
    if pyenv commands | grep -q 'virtualenv'; then
	eval "$(pyenv virtualenv-init -)"
    fi
}
if [[ -d $PYENV_ROOT ]]; then
    _init_pyenv
else
    pyenv() {
	echo -n "pyenv is not installed. Install now? [yn] "; read -q || return
	git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
	_init_pyenv
    }
fi
