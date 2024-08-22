# 0-fix_nginx.pp
# This Puppet manifest fixes Nginx configuration to handle high load.

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/nginx.conf'],
}

exec { '/usr/bin/env sed -i s/15/1000/ /etc/default/nginx': }
-> exec { '/usr/bin/env service nginx restart': }
