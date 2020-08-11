# set up alises
alias :e='vim'
alias :q='exit'
alias :sp="tmux split-window -v -c '#{pane_current_path}' vim"
alias :vs="tmux split-window -h -c '#{pane_current_path}' vim"
alias :wq='exit'
alias c='cargo'
alias g='git'
alias grep='grep -I'
alias im='vim'
alias it='git'
alias ls='exa -F'
alias lt='exa -F --tree'
alias m='mold'
alias p2='python2'
alias p3='python3'
alias p='python'
alias i='ipython'
alias pe='pipenv'
alias po='poetry'
alias q='exit'
alias tf='terraform'
alias v='nvim'

# python calculator
pc() {
  python -c "print($1)"
}

# copy things to clipboard
x() {
  input="$@"
  if [ ! -t 0 ]; then
    input=/dev/stdin
  fi
  cat "$input" | xsel -b
}
