# Setup

## New Projects
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

echo "Removing .git Folder"
rm -rf .git 

echo "Fixing Readme Title"
sed -i "s/PROJECT_NAME/$projectName/g" README.md 
``` 

## Create Vault Secret
The vault secret is required to authenticate against hosts.

New projects can create a vault secret (and store the secret some where safe).
Setting up an existing project will require the original secret to be retrieved and set.

The secret is stored in a file under `ansible-projects/vault-pass.secret`. 
It is gitignored.

### New Secret
```bash
echo "Creating Vault Secret"
echo "vault-secret-$(openssl rand -base64 32)">./ansible-project/vault-pass.secret
```

### Existing Secret
```bash
echo "YOURSECRETTEXT" > ansible-projects/vault-pass.secret;
```

## Install Roles
Roles are dependencies of the project and need to be installed when first starting the project or when the roles change.

```bash
echo "Installing roles"
(cd ansible-project && ansible-playbook plays/ansible-dev/playbook-install-roles.yml)
```

## Vagrant
There is a vagrant file in the root of the project.

**Be sure to set the `$machineName` variable in the `Vagrantfile` before continuing!**
It should correspond with the hostname set in the Ansible Project.

Ensure you have Vagrant installed on your system then we need to get the machine up and running.

```bash
vagrant up
```

Afterwards, we need to update SSH config to allow easy connection to the machine. This will copy the required details 
to your SSH config. 
```bash
vagrant ssh-config >> ~/.ssh/config
```

Finally, we need to chown the SSH private key to your current user.
By default the key is created with `root` permissions meaning it can not be read.
```bash
sudo chown <your-user>:<your-group> ../.vagrant/machines/<machine_name>/libvirt/private_key
```