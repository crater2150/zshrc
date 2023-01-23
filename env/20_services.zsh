if [[ $DISPLAY && $UID != 0 ]]; then
	export SVDIR="$HOME/.local/session_service"
	export SVDIR_TEMPLATES="$HOME/.service-available"
fi
