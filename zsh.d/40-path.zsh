PATH=~/.cargo/bin:$PATH
PATH=~/.local/bin:$PATH
PATH=~/.poetry/bin:$PATH
PATH=~/bin:$PATH
PATH=~/dots/bin:$PATH
PATH=~/pico-8:$PATH
PATH=~/scripts:$PATH
PATH="/opt/homebrew/bin:${PATH}"
PATH=./:$PATH

# Sometimes Hermit envs get lost in the middle of PATH and need to
# be brought to the front again
if [[ -n "${HERMIT_ENV}" && "${PATH}" =~ "${HERMIT_ENV}/bin" ]]; then
  PATH="${HERMIT_ENV}/bin:${PATH}"
fi

# Remove duplicates
typeset -U path manpath
