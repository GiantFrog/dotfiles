# rewrite of https://gist.github.com/RichardBronosky/56d8f614fab2bacdd8b048fb58d0c0c7
function cb
    function LINUX_copy
        cat | xclip -selection clipboard
    end
    function LINUX_paste
        xclip -selection clipboard -o
    end
    function MAC_copy
        cat | pbcopy
    end
    function MAC_paste
        pbpaste
    end
    function WSL_copy
        cat | /mnt/c/Windows/System32/clip.exe
    end
    function WSL_paste
        /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe Get-Clipboard | sed 's/\r//'
    end
    function CYGWIN_copy
        cat > /dev/clipboard
    end
    function CYGWIN_paste
        cat /dev/clipboard
    end

    function stdin_is_pipelike
        test -p /dev/stdin -o ! -t 0
    end
    function stdout_is_pipelike
        not test -t 1
    end
    function enable_teelike_chaining -a open_ended
        if stdout_is_pipelike; or test "$open_ended" = '-'
            set -f our_function $(string join '' $os _paste)
            $our_function
        end
    end

    # MAIN - detect the OS
    if grep -iq Microsoft /proc/version &> /dev/null
         set -f os WSL
    else
        switch $(uname -s)
            case 'Linux*'
                set -fx os LINUX
            case 'Darwin*'
                set -fx os MAC
            case 'CYGWIN*'
                set -fx os CYGWIN
            case '*'
                echo "OS (uname -s) not recognized!" >&2
                exit 1
        end
    end
    if stdin_is_pipelike    # copy if piped to and paste if piped from.
        set -f our_function $(string join '' $os _copy)
        $our_function
        enable_teelike_chaining $argv[1]
    else                    # paste if none of the above.
        set -f our_function $(string join '' $os _paste)
        $our_function
    end
end
