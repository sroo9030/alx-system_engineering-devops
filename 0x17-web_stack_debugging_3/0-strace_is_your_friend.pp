# This Puppet manifest ensures that the Apache configuration file is present and has the correct permissions.

file { '/etc/apache2/sites-available/000-default.conf':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/apache/000-default.conf',
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/apache2/sites-available/000-default.conf'],
}

