unsetopt beep                      # disable beeps
bindkey -e                         # switch to emacs bindings
autoload -U colors && colors       # enable colors

bindkey -s '^g' '~/dots/bin/quickgoose\n'  # add ^s binding to launch a quick goose
bindkey -s '^f' '~/dots/bin/vf\n'  # add ^f binding to launch skim and open in vim
bindkey -s '^o' 'nvim\n'  # add ^o binding to launch vim

# set up completion system
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit

for x in $(ls ~/dots/zsh/completions.d); do
  . ~/dots/zsh/completions.d/$x
done

# stop eating space before pipes
ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'
