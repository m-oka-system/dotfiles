# Common
alias ss="source ~/.bashrc"
alias c="cursor"
alias cc="claude"

# Terraform
alias tf="terraform"
alias tfp="terraform plan"
alias tfv="terraform validate"
alias tff="terraform fmt -recursive"
alias tfa="terraform apply"
alias tfd="terraform destroy"
alias tui="tftui"

# peco (Ctrl + R で history を検索) / ブランチ一覧を表示して切り替える
alias distinct='awk '\''!a[$0]++'\'
alias gco='git checkout $(git branch | sed -r "s/^[ \*]+//" | peco)'

function peco-select-history() {
    BUFFER=$(\history -n -r 1 | distinct | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# kubernetes
alias k='kubectl'
alias ka='kubectl apply'
alias kd='kubectl delete'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdc='kubectl describe configmap'
alias kpf='kubectl port-forward'
alias kc='kubectx | peco | xargs kubectx'
alias kn='kubens | peco | xargs kubens'

# direnv
export EDITOR=cursor
eval "$(direnv hook zsh)"

# tenv
export TENV_AUTO_INSTALL=true
