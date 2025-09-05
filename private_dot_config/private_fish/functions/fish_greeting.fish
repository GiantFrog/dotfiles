function fish_greeting
    set -f weather_cache_hours 0.5
    set -f cache_file ~/.cache/weather.txt

    # if the cache exists and has been touched less than $weather_cache_hours ago, just use that!
    if test -e $cache_file -a (date +%s) -lt (math (date -r $cache_file +%s 2> /dev/null) + 60 x 60 x $weather_cache_hours)
        set -f weather (cat $cache_file | string split ' - ')

    # if not, let's pull our location and fetch the weather.
    else
        if command -q CoreLocationCLI
            set -f city (CoreLocationCLI --format %locality,%isoCountryCode)
        else
            set -f city Seattle,WA
        end
        set -f weather (ansiweather -l $city -u imperial -a false -s true -h false -H true -d true | tee $cache_file | string split ' - ')
    end

    # we re-format the columns every time, even if cached, so it can react to the current terminal width.
    echo $weather[1]
    printf "    %s\n" $weather[2..-1] | column
end
