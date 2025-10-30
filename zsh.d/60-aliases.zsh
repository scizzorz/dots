# set up alises
alias :e='nvim'
alias :q='exit'
alias :sp="tmux split-window -v -c '#{pane_current_path}' vim"
alias :vs="tmux split-window -h -c '#{pane_current_path}' vim"
alias :wq='exit'
alias c='cargo'
alias g='git'
alias grep='grep -I'
alias i='ipython'
alias im='nvim'
alias it='git'
alias j='just'
alias ls="eza --classify=always"
alias lt="eza --classify=always --tree"
alias m='mold'
alias p2='python2'
alias p3='python3'
alias p='python'
alias pe='pipenv'
alias po='poetry'
alias q='exit'
alias tf='terraform'
alias v='nvim'

# activate Hermit env in a new shell that I can ^D out of
hm() {
  zsh -c '. bin/activate-hermit && exec zsh'
}

# copy things to clipboard
x() {
  local cmd
  local input="$@"
  if [[ ! -t 0 ]]; then
    input=/dev/stdin
  fi
  if command -v pbcopy &>/dev/null; then
    cat "$input" | pbcopy
  elif command -v xsel &>/dev/null; then
    cmd=xsel
    cat "$input" | xsel -b
  else
    echo "no suitable clipboard helper found"
    return 1
  fi
}

# open notepad
n() {
  local note_dir="${HOME}/notes"
  local files=()
  if [[ $# == 0 ]]; then
    files+=("${note_dir}")
  else
    while [[ $# > 0 ]]; do
      files+=("${note_dir}/$1.note")
      shift
    done
  fi

  nvim "${files[@]}"
}

# clone + cd into a repo
h() {
  if [[ $# == 0 ]]; then
    cd "${HOME}/dev/"
    return $?
  fi

  local repo=$(basename $1)
  local clone_path="${HOME}/dev/${repo}"
  if [[ ! -d "${clone_path}" ]]; then
    if [[ "${repo}" == "$1" ]]; then
      echo "Local repo does not exist and '$1' isn't qualified to clone. Please use a '<owner>/<repo>' format."
      return 1
    else
      git clone "git@github.com:$1.git" "${clone_path}"
    fi
  fi
  cd "${clone_path}"
}

_h() {
  compadd $(ls ~/dev/$1)
}

compdef _h h

# clone + cd into a squareup/ repo
sqh() {
  local clone_path="${HOME}/dev/$1"
  if [[ ! -d "${clone_path}" ]]; then
    git clone "org-49461806@github.com:squareup/$1" "${clone_path}"
  fi
  cd "${clone_path}"
}

compdef _h sqh

# create + cd into a temp dir
tmp() {
  local name="$1"
  if [[ -z "$name" ]]; then
    name=$(hexdump -n 2 -v -e '/1 "%02x"' /dev/urandom)
  fi

  local tmp_path="${HOME}/tmp/${name}"
  if [ ! -d "${tmp_path}" ]; then
    mkdir -p "${tmp_path}"
  fi

  cd "${tmp_path}"
}

_comma() {
  compadd $($=words --completion)
}

compdef _comma comma
compdef _comma ,
