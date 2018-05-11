#!/bin/sh                                                                                                                                                
set -e

sed -i -e 's@$baseurl="http://my.site/resourcespace";@$baseurl="'"$BASEURL"'";@' /var/www/resourcespace/include/config.default.php

echo "#!/bin/sh" >> /etc/cron.daily/resourcespace
echo "wget -q -r "$BASEURL"/pages/tools/cron_copy_hitcount.php" >> /etc/cron.daily/resourcespace

/usr/sbin/apache2ctl -D FOREGROUND 