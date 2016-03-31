class profile::wordpress {
  class { '::mysql::server' :
    root_password => 'supersecurepassword',
  }

  class { '::wordpress' :
    wp_owner    => 'wordpress',
    wp_group    => 'wordpress',
  }

  class { '::apache' : }

  user { 'wordpress' :
    ensure => present,
    gid    => 'wordpress',
  {

  group { 'wordpress' :
    ensure => present,
  }
}
