#Ansible Project Docs

This documentation is about working with this project template. Which is found here: 
https://github.com/edmondscommerce/ansible-project-template

##Setting Up New Project
Use the following commands to set up a new project.
Rename the `projectName` Variable as required.

```bash
echo "Setting project name" 
projectName="my-infrastructure-project"

echo "Cloning Template Project" 
git clone git@github.com:edmondscommerce/ansible-project-template.git --depth=1

echo "Renaming Cloned Folder"  
mv ansible-project-template "$projectName"

echo "Entering The Project" 
cd "$projectName"

echo"Removing .git Folder"
rm -rf .git

echo "Creating Vault Secret"
echo "vault-secret-$(openssl rand -base64 32)">./ansible-project/vault-pass.secret 

echo "Fixing Readme Title"
sed -i "s/PROJECT_NAME/$projectName/g" README.md 
``` 

##Vagrant

The root of this project is where the Vagrant related things happen.

###Vagrantfile

You should edit the Vagrantfile. There are two commonly edited variables at the top that you probably want to change to reflect your requirements

###Vagrant Up
Once you are happy with the config, then simply run `vagrant up` and it will build your Vagrant machine.

###Vagrant SSH
To enter your machine, simply run `vagrant ssh` and then to become root you can just run `sudo bash`

You will find that in the Vagrant machine, you have the ansible files deployed to `/vagrant/ansible-project` which you can then use if you want to test localhost based Ansible playbooks.

###Read More
https://www.edmondscommerce.co.uk/handbook/Development-Tools/Commandline/Vagrant/
 
##Folder and Files Structure Explained

###ansible-project
Within here should be everything you need for the Ansible project.

####ansible-project/environment
This is where we find our hosts and variables that we will be passing through to Ansible. We create sub folders for each environment, for example `dev`, `prod`, `staging`, `vagrant`... etc

#####ansible-project/environment/_all
Used for variables that are designed to be resused across multiple environments. This is where the bulk of the generic configuration should reside.

In the other environemnts, symlinks are used to load files that are in this folder structure.

#####ansible-project/environment/_all/group_vars
FUsed for variables that are designed to be resused across multiple environments. Other files in here could be `php.yml` or anything else
that would make sense to be placed together so that each of these files container variables related to their file name.
For example, `php.yml` could have `php_version: 7.2` and other php related variables.  

######ansible-project/environment/_all/group_vars/all
Folder used for variables that are .

#######ansible-project/environment/_all/group_vars/all/vars.yml
Place in here variables that are not dependant on the target host. An example could be a repo you always need to clone from.
This file should be symlinked from other environments that require these variables.

#####ansible-project/environment/prod/hosts
A list of the production hosts. Ansible will go through this list unless you specificy 
a single host with --limit nameofhost. For example `ansible-playbook playbook-main.yml -i environment/prod --limit simon` 

#####ansible-project/environment/prod/host_vars/
Production host variables will go inside of here. 

#####ansible-project/environment/vagrant
Vagrant hosts and variables belong in here. 

#####ansible-project/environment/vagrant/hosts
Your vagrant hosts list.

######ansible-project/environment/vagrant/group_vars
None host specific variables that rely on being used with vagrant.

#######ansible-project/environment/vagrant/group_vars/all
For variables used with everything in the playbook. A username for a

#######ansible-project/environment/vagrant/group_vars/all/vars.yml
Should be a symlink from `ansible-project/environment/_all/group_vars/all/vars.yml`

#######ansible-project/environment/vagrant/host_vars/example.yml
This file should be named to something relevant to the production host and then have connection variables within it. 
Such as an IP address or vaulted password.
 
####ansible-project/plays
The plays folder is where we place all of our plays except for playbook-main

#####ansible-project/Plays/ansible-dev
plays used for setting up development of the ansible project.

#####ansible-project/Plays/ansible-dev/playbook-install-roles.yml
Used for installing your roles. This uses the requirements.yml file.

####ansible-project/roles
You can find the ansible roles that are installed with the `playbook-install-roles.yml` file

####ansible-project/Shellscripts
Within this folder are scripts for development work. Not for carrying out any work on the target host itself.
 
#####ansible-project/Shellscripts/createVaultedDataFromFile.bash
This script lets you create a vaulted variable from a file to send across to a target host.

#####ansible-project/Shellscripts/createVaultedPassword.bash
Creates a vaulted password for you to use. You pass through a variable name to the script which it then echoes the real
and then the encrypted variable for you to place inside your project.

#####ansible-project/Shellscripts/createVaultedSshPublicAndPrivateKey.bash
Creates a Public and Private ssh key to pass along to a target host.

####ansible-project/Templates
Templates are where we hold files and folders that we are going to be passing along to a target host. Config for Nginx 
for example,

####ansible-project/.gitignore
Use this file to ignore anything we don't want to push with git.

####ansible-project/ansible.cfg
Lets you configure ansible settings.

####ansible-project/playbook-main.yml
The main playbook which will have other playbooks listed inside of it.

####ansible-project/requirements.yml
The required roles that you will need to install. This will change what `playbook-install-roles.yml` installs.

###docs
For documentation of the project. 
###Vagrantfile
For building a vagrant machine. Specify in here the configuration of what you with vagrant to build vm wise.

###.gitignore
Use this file to ignore anything we don't want to push with git.

###README.md
Documentation of the project.

##symlinks
Make sure we have a symlink between between _all/group_vars/all/vars.yml and all other all/vars.yml.
If you need to create a symlink then do the following on the commandline replacing the paths to what is needed.
`ln -s /path/to/file /path/to/symlink`
