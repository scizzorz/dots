unsetopt beep                      # disable beeps
bindkey -e                         # switch to emacs bindings
autoload -U colors && colors       # enable colors

bindkey -s '^g' '~/dots/bin/quickgoose\n'  # add ^s binding to launch a quick goose
bindkey -s '^f' '~/dots/bin/vf\n'  # add ^f binding to launch skim and open in vim
bindkey -s '^o' 'nvim\n'  # add ^o binding to launch vim
