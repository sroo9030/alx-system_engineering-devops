# 0-fix_nginx.pp
# This Puppet manifest fixes Nginx configuration to handle high load.

exec { '/usr/bin/env sed -i s/15/1000/ /etc/default/nginx': }
-> exec { '/usr/bin/env service nginx restart': }
