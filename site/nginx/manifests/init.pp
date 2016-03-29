class nginx {
  package { 'nginx' :
    ensure => present,
  }

  service { 'nginx' :
    ensure    => running,
    enable    => true,
  }

  file { '/var/www' :
    ensure => directory,
  }

  file { '/var/www/index.html' :
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  file { '/etc/nginx/nginx.conf' :
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf' :
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => File['/etc/nginx/nginx.conf'],
    notify  => Service['nginx'],
  }
}
