function _teleport_hosts
    set -f host_cache_minutes 2
    set -f cache_file ~/.cache/teleport_server_cache.txt

    if not command -q tsh
        # tsh is not installed; let's do nothing.
    else if test -e $cache_file -a (date +%s) -lt (math (date -r $cache_file +%s 2> /dev/null) + 60 x 60 x $host_cache_minutes)
        # use the old cache file
        cat $cache_file
        # update hosts cache in a non-blocking way
        nohup tsh ls --format=names >cache_file 2>/dev/null &
    else
        # no cache; update hosts now and wait for it
        tsh ls --format=names >cache_file 2>/dev/null
        cat $cache_file
    end
end
