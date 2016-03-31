class nginx {
  case $::osfamily {
    'redhat','debian' : {
      $pacjage = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'
    }
    default : {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }

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
