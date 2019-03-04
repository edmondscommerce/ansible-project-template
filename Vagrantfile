#Set the machine name
$machineName="CHANGEME"

#https://app.vagrantup.com/
$vagrantBox="centos/7"

#Provide BASH commands to do basic provisioning
$script = <<BASH
echo "run any commands you want with this script"
BASH

Vagrant.require_version ">= 1.7.0"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
Vagrant.configure("2") do |config|
  config.vm.box = $vagrantBox
  config.vm.provider 'libvirt' do |lv|
    lv.cpu_mode = 'host-passthrough'
  end
  config.vm.hostname=$machineName
  config.vm.network "private_network", type: "dhcp"
  config.vm.define $machineName do |t|
    t.vm.host_name=$machineName
    config.vm.provider :libvirt do |v|
      v.memory = 8192
      v.cpus = 2
    end
  end
  config.vm.provision "shell",
    inline: $script
end



## Below is an example of how this can be set out
#Set the machine name
#$machineName="office-fedora-test"

#https://app.vagrantup.com/generic/boxes/fedora29
#$vagrantBox="generic/fedora29"

#Provide BASH commands to do basic provisioning
#$script = <<BASH
#echo "run any commands you want with this script"
#BASH



#Vagrant.require_version ">= 1.7.0"
#ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
#Vagrant.configure("2") do |config|
#  config.vm.box = $vagrantBox
#  config.vm.provider 'libvirt' do |lv|
#    lv.cpu_mode = 'host-passthrough'
#  end
#  config.vm.hostname=$machineName
#  config.vm.network "private_network", type: "dhcp"
#  config.vm.define $machineName do |t|
#    t.vm.host_name=$machineName
#    config.vm.provider :libvirt do |v|
#      v.memory = 8192
#      v.cpus = 2
#    end
#  end
#  config.vm.provision "shell",
#    inline: $script
#end
