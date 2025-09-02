function _teleport_hosts
    set -f cache_file ~/.cache/teleport_server_cache.txt
    if test -e $cache_file
        cat $cache_file
        # update hosts cache in a non-blocking way
        nohup tsh ls --format=names > $cache_file &
    else
        # update hosts cache now and wait for it
        tsh ls --format=names > $cache_file
        cat $cache_file
    end
end
