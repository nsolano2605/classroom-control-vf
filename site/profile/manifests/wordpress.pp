class profile::wordpress {
  class { '::mysql::server' :
    root_password => 'supersecurepassword',
  }

  class { '::wordpress' : }

  class { '::apache' : }

  user { 'wordpress' :
    ensure => present,
    gid    => 'wordpress',
  }

  group { 'wordpress' :
    ensure => present,
  }
}
