Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ] }

$system_packages     = ['vim','curl','git']
$additional_packages = ['php5','php5-cli','php5-curl']
$moodle_packages     = ['graphviz', 'aspell', 'php5-pspell', 'php5-gd', 'php5-intl', 'php5-mysql', 'php5-xmlrpc', 'php5-ldap']

#first thing must be apt-get update
exec { 'apt-get update':
  command => 'apt-get update'
}

package { 'python-software-properties':
  ensure  => "installed",
  require => Exec['apt-get update']
}

exec { 'add-repository':
  command => "add-apt-repository ppa:ondrej/php5 -y",
  require => Package['python-software-properties'],
}

exec { 'install composer':
  command => 'curl -sS https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer',
  require => Package['curl','php5'],
}

package { $system_packages:
  ensure  => "installed",
  require => Exec['apt-get update'],
}

exec { 'apt-update-refresh':
  command => 'apt-get update',
  require => Exec['add-repository'],
  before  => Class['apache']
}

class { 'apache':
  server_name  => $ipaddress_eth1,
  doc_root     => '/vagrant/web',
  additional_packages => $additional_packages,
}

class { 'mysql':
  root_password => 'abc123',
}

class { 'moodle':
  moodle_packages => $moodle_packages,
}
