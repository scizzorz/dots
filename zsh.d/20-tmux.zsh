# manage tmux sessions
t() {
  local session="$1"

  # list sessions
  if [[ -z "${session}" ]]; then
    tmux ls

  # we're already attached to a tmux session, so try switching to the target
  elif [ -n "${TMUX}" ]; then
    if tmux switch-client -t "${session}"; then
    else
      tmux new-session -d -s "${session}"
      tmux switch-client -t "${session}"
    fi

  # create a new binding to an existing session
  elif [[ "${session}" == '+'* ]]; then
    origin="${session: 1}"
    num=$(tmux ls | grep "^${origin}" | wc -l)
    num=$(($num + 1))
    tmux new-session -t "${origin}" -s "${origin}${num}"

  # attach or create session
  else
    if tmux attach-session -t "${session}"; then
    else
      tmux new-session -s "${session}"
    fi
  fi
}

_t() {
  compadd $(tmux ls -F '#S')
}

compdef _t t
