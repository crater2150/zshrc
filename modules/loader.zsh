#################################################################################
# ZSH modular config
#################################################################################
#
# Helps you split up your config into modules and reuse modules from other
# people.
#
# Modules are stored in the "modules" folder in your configuration directory
# (default: /etc/zsh, if you want to use this in a user configuration file, set
# the variable $ZDOTDIR to your zsh configuration directory in ~/.zshenv)
#
# Each module should have a file called "init". This file is sourced, when the
# module is loaded and is responsible for sourcing any other files needed by the
# module. 
#
# The module can use $MPATH variable, which contains the module's directory.


#################################
# INTERNAL MODULE LOADING STUFF #
#################################

# Path to module directory
ZMODPATH=${ZMODPATH:-"${ZDOTDIR:-/etc/zsh}/modules"}
. $ZMODPATH/helpers.zsh
errdetails=""

modqueue=( )

# Adds a module to the loading queue
#
# This function adds a module for later loading, if it is not already queued.
# It calls mod_deps for dependency checking. If dependencies are not satisfied,
# the module is not loaded.
#
# Parameters:
# 1: module name
# 2: if loaded as a dependency: is_dep
#    otherwise empty
# 3: if loaded as a dependency: the depending module
#
mod_queue() {
	local module="$1"
	local modsource="$ZMODPATH/$module"

	if [[ "$2" == "is_dep" ]]; then
		if ! [ -e "$modsource" ] ; then
			echo "$3: Unsatisfied dependency \"$module\"";
			return 1
		fi
	fi

	in_array "$module" "${(@)modqueue}" && return 0

	if mod_deps "$modsource"; then
		modqueue=( "${(@)modqueue}" "$module" )
	else
		case $? in
			1) echo "module $module not loaded because of missing dependencies: $errdetails";;
			2) echo "module $module not loaded because of blocking module: $errdetails";;
		esac
	fi
}

# Checks for module dependencies
#
# Reads the "depend" file for a module and tries to queue all dependencies for
# loading. If any fails, it returns 1;
#
# Parameters:
# 1: Path to module
#
mod_deps() {
	modpath=$1
	! [ -e $modpath/depend ] && return 0;

	while read relation dep; do
		mod_check_dep $modpath $relation $dep
		[ $? -gt 0 ] && return $?;
	done < "$modpath/depend"
	return 0;
}

mod_check_dep() {
	modpath=$1
	relation=$2
	dep=$3
	
	#legacy entry compatibility
	if [ -z "$dep" ]; then
		dep="$relation"
		relation="need"
	fi
	
	if in_array "$dep" "${(@)modqueue}" && [[ "$relation" != "block" ]]; then
		return 0;
	fi

	case "$relation"; in
		"need")
			if ! mod_queue "$dep" is_dep ${modpath}; then
				errdetails="$dep"
				return 1;
			fi
			;;
		"after")
			if ([ -z "$ZMODLOAD_ONLY" ] \
				|| in_array "$dep" "${(@)ZMODLOAD_ONLY}") \
				&& ! in_array "$dep" "${(@)ZMODLOAD_BLACKLIST}"; then
				mod_queue "$dep" is_dep ${modpath};
			fi ;;
		"block")
			if in_array "$dep" "${(@)ZMODLOAD_ONLY}" \
				|| in_array "$dep" "${(@)modqueue}"; then
				errdetails="$dep"
				return 2
			fi;;
	esac
}

# Loads all queued modules
#
# After queueing all modules and dependency modules, this function calls their
# init-scripts, if existent (if not, the module is ignored for now)
#
mod_load() {
	local MPATH
	for module in "${(@)modqueue}"; do
		MPATH="$ZMODPATH/$module"
		[ -e "$ZMODPATH/$module/init" ] && . "$ZMODPATH/$module/init" 
	done
}

# Begins module loading procedure
#
# Queues all modules in the module directory or, if set, only modules listed in 
# $ZMODLOAD_ONLY

mod_init() {

	if [ -n "$ZMODLOAD_ONLY" ]; then
		for module in "${(@)ZMODLOAD_ONLY}"; do
			[ -d "$ZMODPATH/$module" ] && mod_queue "$module"
		done
	else
		for module in $ZMODPATH/*(/N); do
			if [ -z "$ZMODLOAD_BLACKLIST" ] \
			|| ! in_array ${module:t} ${(@)ZMODLOAD_BLACKLIST}; then
				mod_queue "${module:t}"
			fi
		done
	fi

	mod_load
}

# return 0 if all given modules were loaded (i.e. in the load queue)
mod_loaded() {
	for i in "$@"; do
		in_array $i ${(@)modqueue} || return 1
	done
	return 0
}

#################################################################################
# Utility functions for modules
#################################################################################

#
# Register hook functions
# see 'SPECIAL FUNCTIONS' section in zshmisc(1) for more information
#

precmd_hook() {
	[[ -z $precmd_functions ]] && precmd_functions=()
	precmd_functions=($precmd_functions $*)
}

chpwd_hook() {
	[[ -z $chpwd_functions ]] && chpwd_functions=()
	chpwd_functions=($chpwd_functions $*)
}

preexec_hook() {
	[[ -z $preexec_functions ]] && preexec_functions=()
	preexec_functions=($preexec_functions $*)
}

zshaddhistory_hook() {
	[[ -z $zshaddhistory_functions ]] && zshaddhistory_functions=()
	zshaddhistory_functions=($zshaddhistory_functions $*)
}

zshexit_hook() {
	[[ -z $zshexit_functions ]] && zshexit_functions=()
	zshexit_functions=($zshexit_functions $*)
}

