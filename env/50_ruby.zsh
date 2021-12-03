if exists gem; then
	RUBY_VERSION=${$(gem environment gemdir):t}
	export PATH="$PATH:$HOME/.gem/ruby/$RUBY_VERSION/bin"
fi

if [[ -d $HOME/.rvm/bin ]]; then
	export PATH="$PATH:$HOME/.rvm/bin"
fi
