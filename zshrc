# don't do any zsh config if there's no prompt
[[ -z "${PS1}" ]] && return

local zshd="${HOME}/dots/zsh.d"
for file in $(ls "${zshd}"); do
  source "${zshd}/${file}"
done
