function sp
    set -q $argv[1]
    and string length -q $argv[1]
    and set -gx AWS_PROFILE $argv[1]
    or set -gx AWS_PROFILE main
    aws sso login
end
