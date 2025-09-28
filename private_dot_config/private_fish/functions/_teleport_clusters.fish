function _teleport_clusters
    set -f cache_minutes 600
    set -fx cache_file ~/.cache/teleport_cluster_cache.txt

    if not command -q tsh
        # tsh is not installed; let's do nothing.
    else
        if not test -e $cache_file
            # no cache; update hosts now and wait for it
            string match --all -r '^\S+' (tsh kube ls -q --format=text) >$cache_file 2>/dev/null
            cat $cache_file
        else
            # use the old cache file
            cat $cache_file
            # if it's time, update the hosts cache in a non-blocking way
            if test (date +%s) -gt (math (date -r $cache_file +%s) + 60 x $cache_minutes)
                # we want to use ifne to prevent clobbering the cache in the event tsh returns nothing
                nohup sh -c "string match --all -r '^\S+' (tsh kube ls -q --format=text) 2>/dev/null | ifne tee $cache_file >/dev/null" >/dev/null 2>&1 &
            end
        end
    end
end
