#!/bin/sh
set -e 

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

sed -i -e 's@$baseurl="http://my.site/resourcespace";@$baseurl="'"$BASEURL"'";@' /var/www/resourcespace/include/config.default.php
sed -i -e "s@_BASEURL_@"$BASEURL"@g" /etc/cron.daily/resourcespace

exec /usr/sbin/apache2ctl -D FOREGROUND