
istrue() {
	case "$1" in
		yes|yeah|on|true|1|y)
			return 0;;
	esac
	return 1;
}

in_array() {
	local needle=$1
	shift
	arr=( "${@}" )
	(( $arr[(i)$needle] != ${#arr} + 1 ))
}
