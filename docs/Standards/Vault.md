# Vault

### Variables

An example of a vault file can be seen in the [vault.yml](../../environment/vagrant/host_vars/vagrant-machine/vault.yml) file in the vagrant environment. It hold some example composer values that are read in the [composer.yml](../../environment/vagrant/host_vars/vagrant-machine/composer.yml) file.

To view these create a `vault.secret` file and put in a password of `password123` and then use the following command

```bash
ansible-vault view environment/vagrant/host_vars/vagrant-machine/vault.yml
```

### CI and Vault Data

It is essential that all vault data is kept in an encrypted state when being pushed to Git.
This should be enforced by both the [pre-commit hook](./QA-CI.md#pre-commit-hook-client) and post-receive hooks.

### Generating Passwords and Vaulted Variables

For development environments, as much as possible passwords should not be vaulted but created on the fly using the
lookup [password module](https://docs.ansible.com/ansible/latest/plugins/lookup/password.html). These should be
saved into the environment directory where they will be git ignored by default. This can be used for things like
MySql database password that are only used within the environment.

They should use the variable name as the filename that they will be saved to.

An example of this can be seen in the in the
[password.yml](../../environment/vagrant/host_vars/vagrant-machine/passwords.yml) file where the `admin_password`
variable is generated this way

As these will be generated differently on each machine, it is not possible to use these for the production deployment.
In this case, a vaulted password has to be used as seen in the prod version of the 
[password.yml](../../environment/prod/host_vars/remote-server/passwords.yml) file


### Secret

Using vault password file - not tracked by git, store the password in a secure location eg info sharing project.

The vault secret can be generated by any decent password generator.

[Diceware](https://www.rempe.us/diceware/#eff) is a popular one to use.

### Command Line

Ansible provides the ansible-vault command to work with encrypted data.

The command allows viewing and editing the encrypted data.

The Vault command provides all the necessary functionality to work with encrypted data providing you have the
vault secret in place correctly.


#### Command List



*   create
*   Decrypt
    *   Do not use this, use edit/view
    *   Can potentially allow unencrypted data to be committed
*   edit
*   view
*   encrypt
*   encrypt_string
*   rekey

Refer to the [official documentation](https://docs.ansible.com/ansible/latest/cli/ansible-vault.html) for more
information


