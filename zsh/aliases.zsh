# set up alises
alias :e='nvim'
alias :q='exit'
alias :sp="tmux split-window -v -c '#{pane_current_path}' vim"
alias :vs="tmux split-window -h -c '#{pane_current_path}' vim"
alias :wq='exit'
alias c='cargo'
alias g='git'
alias grep='grep -I'
alias im='nvim'
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

hm() {
  zsh -c '. bin/activate-hermit; exec zsh -i'
}

# python calculator
pc() {
  python -c "print($1)"
}

# copy things to clipboard
x() {
  local cmd
  local input="$@"
  if [ ! -t 0 ]; then
    input=/dev/stdin
  fi
  if which pbcopy &>/dev/null; then
    cat "$input" | pbcopy
  elif which xsel &>/dev/null; then
    cmd=xsel
    cat "$input" | xsel -b
  else
    echo "no suitable clipboard helper found"
    return 1
  fi
}

# open notepad
n() {
  if [ "$1" != "" ]; then
    file=~/notes/$1.note
  else
    file=~/notes/
  fi
  nvim $file
}

h() {
  local repo=$(basename $1)
  if [ ! -d ~/dev/$repo ]; then
    if [ "$repo" = "$1" ]; then
      echo "Local repo does not exist and '$1' isn't qualified to clone. Please use a '<owner>/<repo>' format."
      return 1
    else
      git clone git@github.com:$1.git ~/dev/$repo
    fi
  fi
  cd ~/dev/$1
}

_h() {
  compadd $(ls ~/dev/)
}

compdef _h h

sqh() {
  if [ ! -d ~/dev/$1 ]; then
    git clone org-49461806@github.com:squareup/$1 ~/dev/$1
  fi
  cd ~/dev/$1
}

compdef _h sqh
