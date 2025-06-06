
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:git:*' formats '(%b%u)'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr ' %{$fg[magenta]%}*%{$reset_color%}'
zstyle ':vcs_info:git:*' actionformats '(%b|%a)'
zstyle ':vcs_info:git:*' hooks git-local-changes

function +vi-git-local-changes() {
  if (( gitstaged || gitunstaged )) {
    gitunstaged=1
  }
}

add-zsh-hook precmd venv_info

function venv_info {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    psvar[1]=$(basename "$VIRTUAL_ENV")
  fi
}

precmd() {
  vcs_info
  print '';
  print -rP "%{$fg[yellow]%}%m:%{$fg[blue]%}%2~ %{$fg[cyan]%}${vcs_info_msg_0_}%{$reset_color%}"
}

export PROMPT="%(?.%{$fg[magenta]%}.%{$fg[red]%})-> %f"
export RPROMPT="%{$fg[cyan]%}%1v%{$reset_color%}"

