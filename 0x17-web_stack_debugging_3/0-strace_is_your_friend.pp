# This Puppet manifest ensures that Apache returns a 200 OK status
# and serves the correct index page.

# Ensure the Apache service is installed, running, and enabled
package { 'apache2':
  ensure => installed,
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => File['/var/www/html/index.html'], # Restart if the index file changes
}

# Ensure the main configuration file is correct
file { '/etc/apache2/sites-available/000-default.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template('apache/000-default.conf.erb'), # Use a template if needed
}

# Ensure the document root exists and has correct permissions
file { '/var/www/html':
  ensure => directory,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}

# Ensure the index.html file exists and contains the correct content
file { '/var/www/html/index.html':
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => '<html><body><h1>Hello, World!</h1></body></html>',
}

# Enable the default site
a2ensite { '000-default':
  notify => Service['apache2'],
}

# Ensure the Apache configuration is reloaded if anything changes
exec { 'apache-reload':
  command     => '/usr/sbin/apachectl graceful',
  refreshonly => true,
  subscribe   => File['/etc/apache2/sites-available/000-default.conf'],
}
