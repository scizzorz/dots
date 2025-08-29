# set up completion system
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit

local compdir="${HOME}/dots/zsh.d/completions.d"
for file in $(ls "${compdir}"); do
  source "${compdir}/${file}"
done
