# 0-fix_nginx.pp
# This Puppet manifest fixes Nginx configuration to handle high load.

file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content => template('nginx/nginx.conf.erb'),
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/nginx.conf'],
}

exec { 'increase system limits':
  command => 'echo "* soft nofile 65536" >> /etc/security/limits.conf && echo "* hard nofile 65536" >> /etc/security/limits.conf',
  unless  => 'grep -q "65536" /etc/security/limits.conf',
}

exec { 'increase somaxconn':
  command => '/sbin/sysctl -w net.core.somaxconn=65535',
  unless  => '/sbin/sysctl -a | grep "net.core.somaxconn = 65535"',
}

exec { 'increase tcp_max_syn_backlog':
  command => '/sbin/sysctl -w net.ipv4.tcp_max_syn_backlog=4096',
  unless  => '/sbin/sysctl -a | grep "net.ipv4.tcp_max_syn_backlog = 4096"',
}
