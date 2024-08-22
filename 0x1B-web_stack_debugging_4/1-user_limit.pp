# This Puppet manifest ensures the holberton user can log 

user { 'holberton':
  ensure     => present,
  managehome => true,
  password   => 'your_encrypted_password_here',  # Use encrypted password
}

group { 'sudo':
  ensure => present,
}

user { 'holberton':
  groups => ['sudo', 'www-data'],
}

file { '/path/to/file':
  ensure  => file,
  owner   => 'holberton',
  group   => 'holberton',
  mode    => '0644',
}

file { '/path/to/directory':
  ensure  => directory,
  owner   => 'holberton',
  group   => 'holberton',
  mode    => '0755',
}