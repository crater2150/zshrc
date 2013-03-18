crater's zsh config
===================

Installation:
-------------

*system-wide config*: Put repository contents in `/etc/zsh`.

*user config*: copy `env_template` to $HOME/.zshenv. Change value of `$ZDOTDIR` in
that file to the path, where the repository resides.  
Note that this file is read before any other config files, so if any variables
you set in there have wrong values, they are probably overwritten in another
file.

modules:
--------

This zsh configuration is modular. A module consists of a folder in the modules/
directory, containing a script file named `init` and an optional `depend` file.
More files may be included in the folder, they will be ignored by the module
loader. The name of the module is the name of its directory.

The `init` file is executed, when a module is loaded. When and if a module is
loaded is determined by its `depend` file and the environment variables
`$ZMODLOAD_ONLY` and `$ZMODLOAD_BLACKLIST`.

`$ZMODLOAD_BLACKLIST` is a list of modules, that will not be loaded.

`$ZMODLOAD_ONLY` works as a whitelist. If it is set, only modules in this list
and modules required by them will be loaded.

A `depend` file contains the requirements for loading a module. It should
contain lines of the form `<type> <module>`. There are 3 types for
dependencies:

	- `depend <module>`: `<module>` will be loaded before the depending
	  module (the module whose `depend` file contains this rule), regardless
	of `$ZMODLOAD_ONLY`. If the module is blacklisted, it and the depending
	module are not loaded. Note that already queued dependencies of the depending
	module will be loaded anyways.

	- `after <module>`: `<module>` will be loaded before the depending
	  module, if it would be loaded anyways. If it is either blacklisted or
	`$ZMODLOAD_ONLY` is non-empty but does not contain `<module>`, it is not
	loaded. This does not affect loading of the depending module.

	- `block <module>`: abort loading of the depending module, if `<module>`
	  is already loaded or contained in `$ZMODLOAD_ONLY`.
