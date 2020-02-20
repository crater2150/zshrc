source $(zdotfile zplug/init.zsh)

zplug "MichaelAquilina/zsh-you-should-use"
zplug 'jreese/zsh-titles'

zplug 'crater2150-zsh/fzf-widgets'
zplug 'crater2150-zsh/conf'
zplug 'crater2150-zsh/chroma-z', as:theme

zplug $ZDOTDIR/plugins/autoloader, from:local

zplug 'molovo/revolver', \
  as:command, \
  use:revolver
zplug 'zunit-zsh/zunit', \
  as:command, \
  use:zunit, \
  hook-build:'./build.zsh'

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug $ZDOTDIR/plugins/highlight-config, from:local, defer:3

zplug "plugins/ng", from:oh-my-zsh

zplug "zpm-zsh/colors"

zplug "clvv/fasd", as:command, use:fasd
zplug "plugins/fasd", from:oh-my-zsh, if:"(( $+commands[fasd] ))", on:"clvv/fasd"

zplug "xuhdev/k", at:gnu-ls-color
zplug "urbainvaes/fzf-marks"

zplug "crater2150-zsh/tmsu-fzf", as:plugin

zplug load

if zplug check 'crater2150-zsh/fzf-widgets'; then
  # Map widgets to key
  bindkey '\ec' fzf-change-directory
  bindkey '^r'  fzf-insert-history
  bindkey '^xf' fzf-insert-files
  bindkey '^xd' fzf-insert-directory
  bindkey '^xn' fzf-insert-named-directory

  # Start fzf in a tmux pane
  FZF_WIDGET_TMUX=1

  # use fd for finding directories and files
  FZF_CHANGE_DIR_FIND_COMMAND="fd -t d"
  FZF_INSERT_DIR_COMMAND="fd -t d"
  FZF_INSERT_FILES_COMMAND="fd -t f"
  FZF_EDIT_FILES_COMMAND="fd -t f"

  # modify history command to remove duplicates
  FZF_HISTORY_COMMAND="fc -l 1 | sed  's/ *[0-9]*  //g' | awk '!seen[\$0]++'"
fi
