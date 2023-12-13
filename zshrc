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
export EXA_COLORS=$(cat ~/dots/exarc | grep -v '#' |tr '\n' ':')
export COMMA_PATH=./comma:./script:~/dots/comma

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
