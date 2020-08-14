#Set the machine name
$machineName="template"

#https://app.vagrantup.com/
$vagrantBox="magneticone/centos-7"

Vagrant.require_version ">= 1.7.0"

# Possible options: virtualbox, libvirt, lxc
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

# IP Address for the new machine
$ipAddress="192.168.122.123"

#Provide BASH commands to do basic provisioning
$script = <<BASH
echo "Run any commands you want with this script"
BASH

Vagrant.configure("2") do |config|

    # Required plugins
    config.vagrant.plugins = ["vagrant-lxc", "vagrant-env", "vagrant-vbguest"]

    unless Vagrant.has_plugin?("vagrant-vbguest")
        raise 'vagrant-vbguest is not installed!, please run "vagrant plugin install vagrant-vbguest" '
    end

    unless Vagrant.has_plugin?("vagrant-env")
      raise 'vagrant-env is not installed!, please run "vagrant plugin install vagrant-env" '
    end

    # Box config
    config.vm.box = $vagrantBox
    config.vm.hostname=$machineName

    # Disable mounted /vagrant folder
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.define $machineName do |t|
        t.vm.host_name=$machineName
    end

#     config.vm.network "private_network", type: "dhcp"

    # Virtualbox Specific Configuration
    config.vm.provider :virtualbox do | virtualbox, override|
       override.vm.network "private_network", ip: $ipAddress
    end

    # Libvirt specific
    config.vm.provider 'libvirt' do |lv|
        lv.cpu_mode = 'host-passthrough'
        lv.memory = 8192
        lv.cpus = 4
    end

    # LXC Specific configuration
    config.vm.provider :lxc do |lxc, override|
      override.vm.provision "shell", inline: "mount -o remount,size=5G /tmp"
      lxc.container_name = :machine
    end

    config.vm.provision "shell", inline: $script
end