[ -z "$PS1" ] && return

# set up environment
export DNS=1.1.1.1
export TERM=xterm-256color
export EDITOR=nvim
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib  # for Rust
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
export WINEARCH=win32
export EXA_COLORS=$(cat ~/dots/ezarc | grep -v '#' |tr '\n' ':')
export EZA_COLORS=$(cat ~/dots/ezarc | grep -v '#' |tr '\n' ':')
export COMMA_PATH=./comma:./script:~/dots/comma

if command -v moor &>/dev/null; then
  export MOOR='--quit-if-one-screen --terminal-fg'
  export PAGER=moor
fi

# source various personal extensions
source ~/dots/zsh/zsh.zsh # needs to be first

source ~/dots/zsh/aliases.zsh
source ~/dots/zsh/docker.zsh
source ~/dots/zsh/fuck.zsh
source ~/dots/zsh/path.zsh
source ~/dots/zsh/prompt.zsh
source ~/dots/zsh/syntax.zsh
source ~/dots/zsh/tmux.zsh
source ~/dots/zsh/venv.zsh

# set up proxy variables in an untracked file
[ -f ~/.proxy.sh ] && source ~/.proxy.sh
[ -f ~/.dns.sh ] && source ~/.dns.sh

# set up syntax highlighting. needs to be last, I guess.
ZSH_SYNTAX_HIGHLIGHTING=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f "${ZSH_SYNTAX_HIGHLIGHTING}" ]]; then
  source "${ZSH_SYNTAX_HIGHLIGHTING}"
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'

  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[global-alias]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[path]='fg=green,bold'

  ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=white'
  ZSH_HIGHLIGHT_STYLES[comment]='fg=magenta'

  ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=white'

  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow,bold'
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow,bold'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow,bold'

  ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=red,bold'

  ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=red,bold'
fi

ZSH_AUTOSUGGESTIONS=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ -f "${ZSH_AUTOSUGGESTIONS}" ]]; then
  source "${ZSH_AUTOSUGGESTIONS}"
fi
