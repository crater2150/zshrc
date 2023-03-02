export PYENV_ROOT=${XDG_DATA_HOME:-$HOME/.local/share}/pyenv
_init_pyenv() {
    unfunction pyenv
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    source $(pyenv root)/completions/pyenv.zsh
    if pyenv commands | grep -q 'virtualenv'; then
	eval "$(pyenv virtualenv-init -)"
    fi
}
if [[ -d $PYENV_ROOT ]]; then
    pyenv() {
	_init_pyenv
	pyenv $@
    }
else
    pyenv() {
	echo -n "pyenv is not installed. Install now? [yn] "; read -q || return
	git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
	git clone https://github.com/pyenv/pyenv-update.git $PYENV_ROOT/plugins/pyenv-update
	git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
	git clone https://github.com/jawshooah/pyenv-default-packages.git $PYENV_ROOT/plugins/pyenv-default-packages
	git clone https://github.com/fizista/pyenv-choice.git $PYENV_ROOT/plugins/pyenv-choice
	echo ptpython > $PYENV_ROOT/default-packages
	_init_pyenv
    }
fi
