# set up syntax highlighting.
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
