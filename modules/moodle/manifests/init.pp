class moodle(
  $moodle_packages = ['php5-mysql']
) {

  package { $moodle_packages:
    ensure => 'installed'
  }

  file { "/vagrant/web":
    ensure => 'directory',
    owner  => 'www-data',
    mode   => 0755,
  }

  file { "/vagrant/moodledata":
    ensure => 'directory',
    owner  => 'www-data',
    mode   => 777,
  }

  exec { "clone-moodle-repo":
    command => "git clone --depth=1 -b MOODLE_28_STABLE --single-branch git://git.moodle.org/moodle.git /vagrant/web",
    require => File['/vagrant/web'],
    onlyif => "[ \"$(ls -A  /vagrant/web)\" ] && exit 1 || exit 0"
  }
}
