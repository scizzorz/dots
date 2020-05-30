unsetopt beep                      # disable beeps
bindkey -e                         # switch to emacs bindings
autoload -U colors && colors       # enable colors

bindkey -s '^f' '~/dots/bin/vf\n'  # add ^f binding to launch skim and open in vim
bindkey -s '^o' 'nvim\n'  # add ^o binding to launch vim

# set up completion system
zstyle :compinstall filename '/home/john/.zshrc'
autoload -Uz compinit
compinit

# stop eating space before pipes
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'
