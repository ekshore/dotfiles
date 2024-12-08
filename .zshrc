# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Jenv
# if which jenv > /dev/null; then eval "$(jenv init -)" fi
# Pyenv
# if which pyenv > /dev/null; then eval "$(pyenv init -)" fi

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[Z' autosuggest-accept
# Highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zoxide config
eval "$(zoxide init zsh)"
alias cd="z"

# Eza alias
alias ls="eza"

alias lg="lazygit"

alias refreshz="source ~/.zshrc"

# Created by `pipx` on 2024-05-30 20:18:03
export PATH="$PATH:/Users/ekshore/.local/bin"

source ~/.zshenv

eval "$(starship init zsh)"
