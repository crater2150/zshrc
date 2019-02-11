source $(zdotfile zplug/init.zsh)

zplug "MichaelAquilina/zsh-you-should-use"

zplug 'molovo/revolver', \
  as:command, \
  use:revolver
zplug 'zunit-zsh/zunit', \
  as:command, \
  use:zunit, \
  hook-build:'./build.zsh'

zplug load

