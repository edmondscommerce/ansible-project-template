# Setup

## New Projects
The template repository comes with a bash script that will automatically setup a new Ansible project.

To get started, first clone this repository and `cd` into the project root.

Run the following with the path replaced with the location you want for the project.
```bash
bash shellscripts/setup.bash /opt/Projects/my-ansible-project
```

The shell script does a number of things.
* Checks that we are placing the project in a safe place and not cloberring an existing project
* Removes the .git directory and re-initialises so there is a clean history.
* Ensures your environment has the pre-commit hooks plugin and installs it
* Installs the pre-commit hooks in to the git hooks

## Existing Projects
For existing projects there is an update shell script that will ensure your pre-commit hooks are working as they should.

If your project was not based on this one, there will be more steps for this to work, you will need to migrate your project
in this case.
 

## Ensure commit hooks are installed
Pre-commit hooks are used to verify that your Ansible passes Ansible Lint rules and that your vault is encrypted
at the time of commit.

The update script and setup script will setup your project with the hooks but you can also check this manually as well
with the following commands.

```bash
sudo bash;

# Install the pre-commit python plugin (run from your project root)
pip install pre-commit;

# Installs the pre-commit hook based on the `.pre-commit-config.yaml`
pre-commit install
```

## Create Vault Secret
The vault secret is required to authenticate against hosts.

New projects can create a vault secret (and store the secret some where safe for later).
Setting up an existing project will require the original secret to be retrieved and set.

The secret is stored in a file under `ansible-projects/vault.secret`. 
It is git ignored and should never end up in source control.

### New Secret
```bash
echo "Creating Vault Secret"
echo "vault-secret-$(openssl rand -base64 32)">./ansible-project/vault.secret
```

### Existing Secret
```bash
echo "YOURSECRETTEXT" > ansible-projects/vault.secret;
```

## Install Roles
Roles are dependencies of the project and need to be installed when first starting the project or when the roles change.

```bash
echo "Installing roles"
ansible-galaxy install -r requirements.yml
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