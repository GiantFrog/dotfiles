fish_add_path $HOME/.rd/bin

if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

if status is-interactive
    fzf_configure_bindings --directory=\cf --git_status=\cg --git_log=\cl --processes=\cp
end
