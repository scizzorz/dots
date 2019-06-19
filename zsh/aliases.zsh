# set up alises
alias ls='exa -F'
alias lt='exa -F --tree'
alias grep='grep -I'
alias it='git'
alias g='git'
alias im='vim'
alias v='vim'
alias :e='vim'
alias :sp="tmux split-window -v -c '#{pane_current_path}' vim"
alias :vs="tmux split-window -h -c '#{pane_current_path}' vim"
alias :q='exit'
alias q='exit'
alias :wq='exit'
alias p='python'
alias p2='python2'
alias p3='python3'
alias pe='pipenv'

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
