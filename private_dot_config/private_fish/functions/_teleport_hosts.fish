function _teleport_hosts
    set -f cache_minutes 2
    set -fx cache_file ~/.cache/teleport_server_cache.txt

    if not command -q tsh
        # tsh is not installed; let's do nothing.
    else
        if not test -e $cache_file
            # no cache; update hosts now and wait for it
            tsh ls --format=names >$cache_file 2>/dev/null
            cat $cache_file
        else
            # use the old cache file
            cat $cache_file
            # if it's time, update the hosts cache in a non-blocking way
            if test (date +%s) -gt (math (date -r $cache_file +%s) + 60 x $cache_minutes)
                # we want to use ifne to prevent clobbering the cache in the event tsh returns nothing
                nohup sh -c "tsh ls --format=names 2>/dev/null | ifne tee $cache_file >/dev/null" >/dev/null 2>&1 &
            end
        end
    end
end
