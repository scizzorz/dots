# set up environment
export DNS=1.1.1.1
export TERM=xterm-256color
export EDITOR=nvim
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib  # for Rust
export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."
export FZF_DEFAULT_COMMAND="${SKIM_DEFAULT_COMMAND}"
export WINEARCH=win32
export EXA_COLORS=$(cat ~/dots/ezarc | grep -v '#' |tr '\n' ':')
export EZA_COLORS=$(cat ~/dots/ezarc | grep -v '#' |tr '\n' ':')
export COMMA_PATH=./comma:./script:~/dots/comma

# stop eating space before pipes
export ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'

if command -v moor &>/dev/null; then
  export MOOR='--quit-if-one-screen --terminal-fg'
  export PAGER=moor
fi
