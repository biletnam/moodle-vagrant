class apache(
  $server_name = 'localhost',
  $doc_root = '/vagrant',
  $additional_packages = ['php5-curl', 'php5-cli']
) {

  package { ['apache2']:
    ensure => 'installed'
  }

  service { 'apache2':
    ensure => running,
    enable => true,
  }

  file { "/etc/apache2/sites-available/000-default.conf":
    ensure  => 'present',
    content => template("apache/vhost.conf.erb"),
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  package { $additional_packages:
    ensure => "installed"
  }

}
