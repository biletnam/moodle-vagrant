class mysql(
  $root_password = 'abc123',
  $db_user       = 'moodle_user',
  $db_password   = 'moodle_password',
  $db_name       = 'moodle',
) {

  package { ['mysql-client', 'mysql-server']:
    ensure => 'installed'
  }

  service { 'mysql':
    ensure => running,
    require => Package['mysql-server'],
  }

  exec { 'set-mysql-password':
    unless  => "mysql -uroot -p $root_password",
    command => "mysqladmin -uroot password $root_password",
    require => Service['mysql'],
  }

  exec { 'create-database':
    unless  => "mysql -u $db_user -p $db_password $db_name",
    command => "mysql -uroot -p$root_password -e \"create database $db_name default character set utf8 collate utf8_unicode_ci; grant select,insert,update,delete,create,create temporary tables,drop,index,alter on $db_name.* to $db_user@localhost identified by '$db_password'; flush privileges;\"",
    require => Exec['set-mysql-password'],
  }
}
