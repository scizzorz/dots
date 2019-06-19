[ -z "$PS1" ] && return

# set up environment
export TERM=xterm-256color
export EDITOR=vim
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib  # for Rust
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
export WINEARCH=win32
export EXA_COLORS=$(cat ~/dots/exarc | grep -v '#' |tr '\n' ':')

# source various personal extensions
source ~/dots/zsh/aliases.zsh
source ~/dots/zsh/docker.zsh
source ~/dots/zsh/fuck.zsh
source ~/dots/zsh/path.zsh
source ~/dots/zsh/prompt.zsh
source ~/dots/zsh/syntax.zsh
source ~/dots/zsh/tmux.zsh
source ~/dots/zsh/venv.zsh
source ~/dots/zsh/zsh.zsh # lol

# set up proxy variables in an untracked file
[ -f ~/.proxy.sh ] && source ~/.proxy.sh
