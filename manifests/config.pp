# == Class basemodule::config
#
class basemodule::config {
  File {
    require => Class['::basemodule::install'],
    notify  => Service[$::basemodule::service_name],
    owner   => $::basemodule::config_user,
    group   => $::basemodule::config_group,
    mode    => $::basemodule::config_file_mode,
  }

  file {
    $::basemodule::config_dir:
      ensure  => directory,
      mode    => $::basemodule::config_dir_mode,
      purge   => $::basemodule::config_purge,
      recurse => $::basemodule::config_dir_recurse;

    $::basemodule::config_file:
      ensure  => present,
      content => template('basemodule/basemodule.conf.erb');

    $::basemodule::log_dir:
      ensure => directory,
      owner  => $::basemodule::daemon_user,
      group  => $::basemodule::daemon_group;
  }
}

