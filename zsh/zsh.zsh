unsetopt beep                      # disable beeps
bindkey -e                         # switch to emacs bindings
autoload -U colors && colors       # enable colors

bindkey -s '^f' '~/dots/bin/vf\n'  # add ^f binding to launch skim and open in vim

# set up completion system
zstyle :compinstall filename '/home/john/.zshrc'
autoload -Uz compinit
compinit
