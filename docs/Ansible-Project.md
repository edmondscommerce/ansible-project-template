# Ansible Project Docs

This documentation is about working with this project template. Which is found here: 
https://github.com/edmondscommerce/ansible-project-template

1. [Setup](Setup.md)


## Vagrant
The root of this project is where the Vagrant related things happen.

### Vagrantfile

You should edit the Vagrantfile. There are two commonly edited variables at the top that you probably want to change to reflect your requirements

### Vagrant Up
Once you are happy with the config, then simply run `vagrant up` and it will build your Vagrant machine.

### Vagrant SSH
To enter your machine, simply run `vagrant ssh` and then to become root you can just run `sudo bash`

You will find that in the Vagrant machine, you have the ansible files deployed to `/vagrant/ansible-project` which you can then use if you want to test localhost based Ansible playbooks.

### Read More
https://www.edmondscommerce.co.uk/handbook/Development-Tools/Commandline/Vagrant/
 
## Folder and Files Structure Explained

### ansible-project
Within here should be everything you need for the Ansible project.

#### ansible-project/environment
This is where we find our hosts and variables that we will be passing through to Ansible. We create sub folders for each environment, for example `dev`, `prod`, `staging`, `vagrant`... etc

##### ansible-project/environment/prod/hosts
A list of the production hosts. Ansible will go through this list unless you specificy 
a single host with --limit nameofhost. For example `ansible-playbook playbook-main.yml -i environment/prod --limit simon` 

##### ansible-project/environment/prod/host_vars/
Production host variables will go inside of here. 

##### ansible-project/environment/vagrant
Vagrant hosts and variables belong in here. 

##### ansible-project/environment/vagrant/hosts
Your vagrant hosts list.

###### ansible-project/environment/vagrant/group_vars
None host specific variables that rely on being used with vagrant.

####### ansible-project/environment/vagrant/host_vars/example.yml
This file should be named to something relevant to the production host and then have connection variables within it. 
Such as an IP address or vaulted password.
 
#### ansible-project/plays
The plays folder is where we place all of our plays except for playbook-main

##### ansible-project/plays/ansible-dev
plays used for setting up development of the ansible project.

##### ansible-project/plays/ansible-dev/playbook-install-roles.yml
Used for installing your roles. This uses the requirements.yml file.

#### ansible-project/roles

You can find the ansible roles that are installed with the `playbook-install-roles.yml` file

#### ansible-project/shellscripts

Within this folder are scripts for development work. Not for carrying out any work on the target host itself.
 
##### ansible-project/shellscripts/createVaultedDataFromFile.bash

This script lets you create a vaulted variable from a file to send across to a target host.

##### ansible-project/shellscripts/createVaultedPassword.bash

Creates a vaulted password for you to use. You pass through a variable name to the script which it then echoes the real
and then the encrypted variable for you to place inside your project.

##### ansible-project/shellscripts/createVaultedSshPublicAndPrivateKey.bash

Creates a Public and Private ssh key to pass along to a target host.

#### ansible-project/Templates

Templates are where we hold files and folders that we are going to be passing along to a target host. Config for Nginx 
for example,

#### ansible-project/vars

The vars which are used across every environment. These will override environment vars but can use environment vars e.g.

`site_domain: "{{ host_site_domain | default('ec.ansible.com') }}"`

This will use the environment var `host_site_domain` if it is set or use the default.

#### ansible-project/.gitignore

Use this file to ignore anything we don't want to push with git.

#### ansible-project/ansible.cfg

Lets you configure ansible settings.

#### ansible-project/playbook-main.yml

The main playbook which will have other playbooks listed inside of it.

#### ansible-project/requirements.yml

The required roles that you will need to install. This will change what `playbook-install-roles.yml` installs.

### docs

For documentation of the project. 

### Vagrantfile

For building a vagrant machine. Specify in here the configuration of what you with vagrant to build vm wise.

### .gitignore

Use this file to ignore anything we don't want to push with git.

### README.md

Documentation of the project.


## to edit later for git

 886  git remote -v
  887  git init
  888  git remote add origin gitBare:/home/ec/repos/reg/reg-magento2-ansible/
  889  git status
  890  git add -A
  891  git commit -m "initial commit - project started"
  892  git push -u origin master 
  893  history


 6228  cd repos/reg
 6229  ll
 6230  git init --bare reg-magento2-ansible
 6231  history

