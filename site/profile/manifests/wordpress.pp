class profile::wordpress {
  class { '::mysql::server' :
    root_password => 'supersecurepassword',
  }

  class { '::wordpress' : 
    install_dir => '/var/www/wordpress',
  }

  class { '::apache' : }

  user { 'wordpress' :
    ensure => present,
    gid    => 'wordpress',
  }

  group { 'wordpress' :
    ensure => present,
  }
}
