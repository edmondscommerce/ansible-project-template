#Set the machine name
$machineName="CHANGEME"

#https://app.vagrantup.com/
$vagrantBox="magneticone/centos-7"

#Provide BASH commands to do basic provisioning
$script = <<BASH
echo "Run any commands you want with this script"
BASH

Vagrant.require_version ">= 1.7.0"
# Possible options: virtualbox, libvirt, lxc
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

$memory = 8192
$cpuCores = 2

Vagrant.configure("2") do |config|

    # Box config
    config.vm.box = $vagrantBox
    config.vm.hostname=$machineName

    # Disable mounted /vagrant folder
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.define $machineName do |t|
        t.vm.host_name=$machineName
    end

    config.vm.network "private_network", type: "dhcp"

    # Virtualbox Specific Configuration (Windows)
    config.vm.provider :virtualbox do | virtualbox, override|
       override.vm.network "private_network", ip: "192.168.100.126"
    end

    # Libvirt specific
    config.vm.provider 'libvirt' do |lv|
        lv.cpu_mode = 'host-passthrough'
        lv.memory = $memory
        lv.cpus = $cpuCores
    end

    # LXC Specific configuration
    config.vm.provider :lxc do |lxc, override|
      override.vm.provision "shell", inline: "mount -o remount,size=5G /tmp"
      lxc.container_name = :machine
    end

    config.vm.provision "shell", inline: $script
end