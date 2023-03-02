local function first-command() {
	while [[ -n $1 ]]; do
		if command -v $1 > /dev/null; then
			echo $1
			return 0
		fi
		shift
	done
	return 1
}

export PAGER=${PAGER:-$(first-command nvimpager vimpager less)}
export MANPAGER=${PAGER}
