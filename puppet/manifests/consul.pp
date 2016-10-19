class { '::apt':
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
file { '/etc/ssl/consul':
  ensure  => directory,
  owner   => 'root',
  group   => 'root',
  mode    => '0555',
  source  => 'puppet:///modules/certs/',
  recurse => true,
  purge   => true,
  before  => Class['::consul'],
}

class { '::consul':
  version     => '0.7',
  config_hash => {
    'datacenter'          => 'vagrant',
    'data_dir'            => '/var/lib/consul',
    'log_level'           => 'DEBUG',
    'node_name'           => $::hostname,
    'acl_datacenter'      => 'vagrant',
    'acl_default_policy'  => 'deny',
    'acl_down_policy'     => 'extend-cache',
    'acl_master_token'    => 'b369bd0a-3bc9-45b9-bd99-040c6f4b3bf2',
    'acl_token'           => 'b369bd0a-3bc9-45b9-bd99-040c6f4b3bf2',
    'ui_dir'              => '/var/lib/consul/ui',
    'client_addr'         => '0.0.0.0',
    'advertise_addr'      => $::ipaddress_eth1,
    'rejoin_after_leave'  => true,
    'retry_join'          => ['10.27.44.5', '10.27.44.6', '10.27.44.7'],
    'retry_interval'      => '2s',
    'start_join'          => ['10.27.44.5', '10.27.44.6', '10.27.44.7'],
    'server'              => true,
    'bootstrap_expect'    => 3,
    'encrypt'             => 'mcuIFd6yWUx9jSOCiBSFrQ==',
    'enable_syslog'       => true,
    'ca_file'             => '/etc/ssl/consul/cacert.pem',
    'cert_file'           => '/etc/ssl/consul/consul-cert.pem',
    'key_file'            => '/etc/ssl/consul/consul-key.pem',
    'verify_incoming'     => false,
    'verify_outgoing'     => false,
    'disable_remote_exec' => true,
    'dns_config'          => {
      'service_ttl'     => {
        '*' => '3s',
      },
      'node_ttl'        => '3s',
      'allow_stale'     => true,
      'max_stale'       => '30s',
      'enable_truncate' => false,
    }
  }
}
