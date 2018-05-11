#!/bin/sh                                                                                                                                                
set -e

sed -i -e 's@$baseurl="http://my.site/resourcespace";@$baseurl="'"$BASEURL"'";@' /var/www/resourcespace/include/config.default.php
sed -i -e "s@_BASEURL_@"$BASEURL"@g" /etc/cron.daily/resourcespace

/usr/sbin/apache2ctl -D FOREGROUND 