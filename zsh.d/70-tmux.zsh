# manage tmux sessions
t() {
  # Docker-based attach
  if [[ "$1" == *'/'* ]]; then
    arr=("${(s:/:)1}")
    local SSH=(d $arr[1])
    local SESS=$arr[2]

  # SSH-based attach
  elif [[ "$1" == *':'* ]]; then
    arr=("${(s/:/)1}")
    local SSH=(ssh -t $arr[1])
    local SESS=$arr[2]

  # Local attach
  else
    local SSH=
    local SESS="$1"
  fi

  # List sessions
  if [ -z "$SESS" ]; then
    $SSH tmux ls

  elif [ -n "$TMUX" ]; then
    if tmux switch-client -t "$SESS"; then
    else
      tmux new-session -d -s "$SESS"
      tmux switch-client -t "$SESS"
    fi

  # New binding to existing session
  elif [[ "$SESS" == '+'* ]]; then
    origin="${SESS: 1}"
    num=$($SSH tmux ls | grep "^$origin" | wc -l)
    num=$(($num + 1))
    $SSH tmux new-session -t $origin -s $origin$num

  # Attach or create session
  else
    # this can probably be optimized better... docker exec is kinda slow.
    if $SSH tmux attach-session -t "$SESS"; then
    else
      $SSH tmux new-session -s "$SESS"
    fi
  fi
}

_t() {
  compadd $(tmux ls -F '#S')
}

compdef _t t
