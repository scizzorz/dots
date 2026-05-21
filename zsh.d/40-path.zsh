PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/.poetry/bin:${PATH}"
PATH="${HOME}/Developer/PlaydateSDK/bin:${PATH}"
PATH="${HOME}/Developer/Steam/sdk/tools/ContentBuilder/builder_osx:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${HOME}/dots/bin:${PATH}"
PATH="${HOME}/pico-8:${PATH}"
PATH="${HOME}/scripts:${PATH}"
PATH="/opt/homebrew/bin:${PATH}"
PATH="${HOME}/Library/Android/sdk/build-tools/34.0.0:${PATH}"
PATH="${HOME}/Library/Android/sdk/platform-tools:${PATH}"
PATH="./:${PATH}"

# Sometimes Hermit envs get lost in the middle of PATH and need to
# be brought to the front again
if [[ -n "${HERMIT_ENV}" && "${PATH}" =~ "${HERMIT_ENV}/bin" ]]; then
  PATH="${HERMIT_ENV}/bin:${PATH}"
fi

# Remove duplicates
typeset -U path manpath
