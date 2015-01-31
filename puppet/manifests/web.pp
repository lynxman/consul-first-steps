class { '::apt':
  update_timeout => 60,
  update_tries   => 5,
}
exec { 'apt-update':
  command => '/usr/bin/apt-get update',
}
ensure_packages(['nagios-plugins','jq'])
include dnsmasq
dnsmasq::conf { 'consul':
  ensure  => present,
  content => 'server=/consul/127.0.0.1#8600',
}
class { '::consul':
  config_hash => {
      'datacenter'     => 'vagrant',
      'data_dir'       => '/var/lib/consul',
      'log_level'      => 'DEBUG',
      'node_name'      => $::hostname,
      'client_addr'    => '0.0.0.0',
      'advertise_addr' => $::ipaddress_eth1,
      'server'         => false,
      'encrypt'        => 'mcuIFd6yWUx9jSOCiBSFrQ==',
      'enable_syslog'  => true,
  }
}
consul::service { 'web':
  port           => '80',
  check_script   => '/usr/lib/nagios/plugins/check_http -H localhost -w 20 -c 60 -t 20',
  check_interval => '30s',
}
class { 'nginx': }
file { '/var/www/':
  ensure => directory,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}
file { '/var/www/index.html':
  ensure  => present,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  content => 'Hello World',
  require => File['/var/www/'],
}
nginx::resource::vhost { 'localhost':
    ensure   => present,
    www_root => '/var/www/',
}
