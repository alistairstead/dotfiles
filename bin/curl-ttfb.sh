#!/bin/bash
#
# Report time to first byte for the provided URL using a cache buster to ensure
# that we're measuring full cold-cache performance
#
# Thanks to https://josephscott.org/archives/2011/10/timing-details-with-curl/
# and https://gist.github.com/acdha/1402514
#
# Usage bash ./curl-ttfb.sh http://example.com

while (($#)); do
    echo $1
    curl -so /dev/null -H "Pragma: no-cache" -H "Cache-Control: no-cache" \
        -w "
                http status:  %{http_code}
            time_namelookup:  %{time_namelookup}
               time_connect:  %{time_connect}
            time_appconnect:  %{time_appconnect}
           time_pretransfer:  %{time_pretransfer}
              time_redirect:  %{time_redirect}
         time_starttransfer:  %{time_starttransfer}
                    --------  ----------
                 time_total:  %{time_total}
           bytes downloaded:  %{size_download}" \
        "$1?`date +%s`"
    shift
done
