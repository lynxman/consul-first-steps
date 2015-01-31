# -*- mode: ruby -*-
# vi: set ft=ruby :
# Have to install dnsmasq in shell due to https://bugs.launchpad.net/ubuntu/+source/dnsmasq/+bug/1247803

Vagrant.configure(2) do |config|
  config.vm.box = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.define :consul1 do |consul1_config|
      consul1_config.vm.host_name = "consul1"
      consul1_config.vm.network "private_network", ip:"10.27.44.5"
      consul1_config.vm.provider :virtualbox do |vb|
          vb.memory = 256
          vb.cpus = 1
      end
      consul1_config.vm.provision "shell", :inline => <<-SHELL
          sudo apt-get install -y dnsmasq wget
          sleep 5
          wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
          sudo dpkg -i puppetlabs-release-precise.deb
          sudo rm -f puppetlabs-release-precise.deb
          sudo apt-get update
          sudo apt-get install -y puppet facter hiera
        SHELL
      consul1_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'consul.pp'
        puppet.module_path = 'puppet/modules'
      end
      consul1_config.vm.provision "shell", :inline => <<-SHELL
          sudo consul join 10.27.44.5 10.27.44.6 10.27.44.7
        SHELL
  end

  config.vm.define :consul2 do |consul2_config|
      consul2_config.vm.host_name = "consul2"
      consul2_config.vm.network "private_network", ip:"10.27.44.6"
      consul2_config.vm.provider :virtualbox do |vb|
          vb.memory = 256
          vb.cpus = 1
      end
      consul2_config.vm.provision "shell", :inline => <<-SHELL
          sudo apt-get install -y dnsmasq wget
          sleep 5
          wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
          sudo dpkg -i puppetlabs-release-precise.deb
          sudo rm -f puppetlabs-release-precise.deb
          sudo apt-get update
          sudo apt-get install -y puppet facter hiera
        SHELL
      consul2_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'consul.pp'
        puppet.module_path = 'puppet/modules'
      end
      consul2_config.vm.provision "shell", :inline => <<-SHELL
          sudo consul join 10.27.44.5 10.27.44.6 10.27.44.7
        SHELL
  end

  config.vm.define :consul3 do |consul3_config|
      consul3_config.vm.host_name = "consul3"
      consul3_config.vm.network "private_network", ip:"10.27.44.7"
      consul3_config.vm.provider :virtualbox do |vb|
          vb.memory = 256
          vb.cpus = 1
      end
      consul3_config.vm.provision "shell", :inline => <<-SHELL
          sudo apt-get install -y dnsmasq wget
          sleep 5
          wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
          sudo dpkg -i puppetlabs-release-precise.deb
          sudo rm -f puppetlabs-release-precise.deb
          sudo apt-get update
          sudo apt-get install -y puppet facter hiera
        SHELL
      consul3_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'consul.pp'
        puppet.module_path = 'puppet/modules'
      end
      consul3_config.vm.provision "shell", :inline => <<-SHELL
          sudo consul join 10.27.44.5 10.27.44.6 10.27.44.7
        SHELL
  end

  config.vm.define :web do |web_config|
      web_config.vm.host_name = "web"
      web_config.vm.network "private_network", ip:"10.27.44.10"
      web_config.vm.network "forwarded_port", guest: 80, host:8080
      web_config.vm.provider :virtualbox do |vb|
          vb.memory = 512
          vb.cpus = 1
      end
      web_config.vm.provision "shell", :inline => <<-SHELL
          sudo apt-get install -y dnsmasq wget
          sleep 5
          wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
          sudo dpkg -i puppetlabs-release-precise.deb
          sudo rm -f puppetlabs-release-precise.deb
          sudo apt-get update
          sudo apt-get install -y puppet facter hiera
        SHELL
      web_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'web.pp'
        puppet.module_path = 'puppet/modules'
      end
      web_config.vm.provision "shell", :inline => <<-SHELL
          sudo consul join 10.27.44.5 10.27.44.6 10.27.44.7
        SHELL
  end

end
