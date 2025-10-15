STARTUP=$(gdate "+%s.%N")
export PROFILE=true
local SOURCE_CAT=true

# don't do any zsh config if there's no prompt
[[ -z "${PS1}" ]] && return

local startfile="${HOME}/Library/Caches/zshstartup"
date +%s >> "${startfile}"

local zshd="${HOME}/dots/zsh.d"
if [[ "${SOURCE_CAT}" == "true" ]]; then
  source <(cat ${zshd}/*.zsh)
else
  for zshd_file in $(ls ${zshd}/*.zsh); do
    local start=$(gdate "+%s.%N")
    source "${zshd_file}"
    local now=$(gdate "+%s.%N")
    print -f "\033[37m%s: %.0fms\033[0m\n" "${zshd_file}" $(((now - start) * 1000))
  done
fi

NOW=$(gdate "+%s.%N")
[[ "${PROFILE}" == "true" ]] && print -f "\033[37mstartup: %.0fms\033[0m\n" $(((NOW - STARTUP) * 1000))
