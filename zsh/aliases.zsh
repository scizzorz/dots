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

# open todo list
l() {
  file=~/todo/$(date +%m-%d-%Y).todo
  # if today exists, just open the list
  if [ -f $file ]; then
  else

    # try to find the previous day's list (only goes back 4 weeks)
    back=1
    while [ $back -lt 28 ]; do
      oldfile=~/todo/$(date -v-${back}d +%m-%d-%Y).todo
      if [ -f $oldfile ]; then
        break
      else
        back=$(expr $back + 1)
      fi
    done

    # if the previous day exists, filter it into the new file and then open both
    if [ -f $oldfile ]; then
      # sed -n -e '/^ *[\*\?\!-]/p' $oldfile > $file
      nvim -o $oldfile ~/todo/soon.todo ~/todo/eventually.todo
      sed -n -e '/^ *[<>!-]/p' $oldfile ~/todo/soon.todo ~/todo/eventually.todo | sed -e 's/^ *[<>]/*/' | sort > $file
      sed -i -e '/^ *[<>!-]/d' ~/todo/soon.todo
      sed -i -e '/^ *[<>!-]/d' ~/todo/eventually.todo
    fi
  fi

  nvim -o $file ~/todo/soon.todo ~/todo/eventually.todo
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

# open review
r() {
  if [ "$2" != "" ]; then
    file=~/reviews/$2.review
    cp ~/reviews/$1.review $file
  elif [ "$1" != "" ]; then
    file=~/reviews/$1.review
  else
    file=~/reviews/
  fi
  nvim $file
}
