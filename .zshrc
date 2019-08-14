source $HOME/.bashrc

export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

plugins=(
  git
  osx
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
alias la='ls -al'

function PS1HOST {
  echo "%{$fg[black]%}%{$bg[blue]%}%m%{$reset_color%}"
}

PS1='$(git_prompt_info)%n@$(PS1HOST)[%~]> '
RPS1=''

bindkey ^F forward-char

export LSCOLORS="exfxcxdxbxegedabagacad"

