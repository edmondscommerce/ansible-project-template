# Environment Management

## Default Environment

Setting default environment to Vagrant ensure that production updates require explicitly passing it as environment
flag with `-i environment/prod`

This is enforced by the Ansible configuration file.


## How to handle SSH keys and SSH Config

### Development

Development keys can be the developer’s own key as it will not be used to interact with any production systems

### Production

A unique key specifically for the production environment(s) will need to be generated and setup with the target
machine(s).

The key must be encrypted in the Ansible vault for the appropriate host. Ansible can then use this to connect when
the vault secret is in place correctly.

Each key corresponds to one target, revoking these keys becomes much easier if only one key has one machine it
will authenticate with.

This concept also applies to remote services, for example:

*   Github
*   Bitbucket

## Connection Types

Ansible provides many different ways of defining hosts, this includes static configuration (for production servers)
and executable files that will output configuration (good for development).

### SSH

This is the most common way that you will connect to a machine using ansible. Almost all of the live machines will use
this, and it is the way we connect to development machines created using Vagrant.

You will need to configure the connection for the live machines that you are going to connect to. The basic details can 
be found in the [connection.yml](../../environment/prod/host_vars/remote-server/connection.yml) file in the `prod` 
environment. This should cover most situations, however there are additional options details on the 
[configuration page](https://docs.ansible.com/ansible/latest/plugins/connection/ssh.html#ssh-connection)

The local connection is configured using the [hosts.bash](../../environment/vagrant/hosts.bash) file. This uses the
`vagrant ssh-config` command to pull out the connection details and then returns a JSON blob with the correct values.
This should work for all different vagrant machines, however it will hit problems if you create more than one.

### LXC

There is a LXC module for ansible that can use the LXC exec command, however this has proved to be temperamental in the
past, so the SSH connection is now used instead. However it can be used if you want to ensure that the container does
not have SSH running

### LXD

Ansible provides a dedicated LXD module that allows you to create containers on the fly without the use of
Vagrant. This is being explored as a possibility for the future but is not currently supported.

The possibilities of spinning up infrastructure and provisioning in a similar fashion to Docker open up many doors.

### Docker

It is possible to use Docker locally with Ansible, this has not been explored and is unlikely to be used in any
practical sense. This is not supported by the company.
