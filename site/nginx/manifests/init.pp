class nginx (
  $package = $nginx::params::package,
  $owner   = $nginx::params::owner,
  $group   = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = /$nginx::params::confdir,
  $logdir  = $nginx::params::logdir,
){

  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  } 
  
  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }

  package { 'nginx' :
    ensure => present,
    name   => $package,
  }

  service { 'nginx' :
    ensure    => running,
    enable    => true,
  }

  file { [ $docroot, "${confdir}/conf.d"] :
    ensure => directory,
  }

  file { "${docroot}/index.html" :
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  file { "${confdir}/nginx.conf" :
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { "${confdir}/conf.d/default.conf" :
    ensure  => file,
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
}
