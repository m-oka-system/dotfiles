# Common
alias ss="source ~/.bashrc"

# Terraform
alias tf="terraform"
alias tfp="terraform plan"
alias tfv="terraform validate"
alias tff="terraform fmt -recursive"
alias tfa="terraform apply"

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
