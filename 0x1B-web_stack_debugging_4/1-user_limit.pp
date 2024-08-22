# This Puppet manifest ensures the holberton user can log 

exec { '/usr/bin/env sed -i "s/holberton/foo/" /etc/security/limits.conf': }
