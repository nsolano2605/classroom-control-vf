class profile::wordpress {
  class { '::mysql::server' :  }

  class { '::wordpress' : 
    install_dir => '/var/www/wordpress',
  }

  class { '::apache' : }
  
  class {'::apache::mod::php': }

  user { 'wordpress' :
    ensure => present,
    gid    => 'wordpress',
  }

  group { 'wordpress' :
    ensure => present,
  }
}
