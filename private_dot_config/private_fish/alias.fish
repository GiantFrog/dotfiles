alias bye='exit'
alias ls='ls -G'
alias ll='eza -lh --git --no-user'
alias la='eza -lah@ --git --icons'
alias yaml='yq'

abbr --add cc cd ~/ai-hell-jailcell\; and claude
abbr --add jf jellyfin-tui
abbr --add k kubectl
abbr --add kns kubectl config set-context --current --namespace
abbr --add kube tsh kube login
abbr --add mdb tsh db connect --db-user=db-admin --db-name=mysql
abbr --add pdb tsh db connect --db-user=db-admin --db-name=postgres
abbr --add pfssh ssh -L 1337:localhost:
abbr --add reglogin "echo \$REGISTRY_TOKEN | docker login $REGISTRY -u $EMAIL --password-stdin"
abbr --add tflogin "echo yes | terraform login spacelift.io"
abbr --add vpcssh ssh -F none -i ~/.ssh/aws_keys/id_ops_key -l ubuntu
