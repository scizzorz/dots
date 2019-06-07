# vim: set ft=zsh:
export PROMPT_COLOR=$'\033[96m' # bright cyan
export PROMPT_PREFIX='%{$fg_no_bold[white]%}%m ' # hostname

# skip the host if we're in tmux
if [ -n "$TMUX" ]; then
  export PROMPT_PREFIX=''
fi
