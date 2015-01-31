class { '::apt':
  update_timeout => 60,
  update_tries   => 5,
}
exec { 'apt-update':
  command => '/usr/bin/apt-get update',
}
Exec['apt-update'] -> Package <| |>
ensure_packages(['nagios-plugins','jq'])
include dnsmasq
dnsmasq::conf { 'consul':
  ensure  => present,
  content => 'server=/consul/127.0.0.1#8600',
}
class { '::consul':
  config_hash => {
      'datacenter'       => 'vagrant',
      'data_dir'         => '/var/lib/consul',
      'log_level'        => 'DEBUG',
      'node_name'        => $::hostname,
      'ui_dir'           => '/var/lib/consul/ui',
      'client_addr'      => '0.0.0.0',
      'advertise_addr'   => $::ipaddress_eth1,
      'server'           => true,
      'bootstrap_expect' => 3,
      'encrypt'          => 'mcuIFd6yWUx9jSOCiBSFrQ==',
      'enable_syslog'    => true,
  }
}
