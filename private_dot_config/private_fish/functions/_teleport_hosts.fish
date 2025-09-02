function _teleport_hosts
    set -f cache_file ~/.cache/teleport_server_cache.txt
    if not command -q tsh
        # tsh is not installed; let's do nothing.
    else if test -e $cache_file
        # use the old cache file
        cat $cache_file
        # update hosts cache in a non-blocking way
        nohup tsh ls --format=names > $cache_file &
    else
        # no cache; update hosts now and wait for it
        tsh ls --format=names > $cache_file
        cat $cache_file
    end
end
