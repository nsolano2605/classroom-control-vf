class profile::wordpress {
  class { '::mysql::server' :  }
  
  class { '::mysql::client' :  }
  
  class { '::wordpress' : 
    install_dir => '/var/www/html',
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
