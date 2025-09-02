alias ls='ls -G'
alias ll='eza -lh --git --no-user'
alias la='eza -lah@ --git --icons'
alias yaml='yq'

abbr --add k kubectl
abbr --add kns kubectl config set-context --namespace=
abbr --add vpcssh ssh -F none -i ~/.ssh/aws_keys/id_ops_key -l ubuntu
