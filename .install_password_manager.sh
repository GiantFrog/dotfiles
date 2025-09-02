#!/bin/sh

# exit immediately if password-manager-binary is already in $PATH
type rbw >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install rbw
    ;;
Linux)
    pacman -S rbw
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
