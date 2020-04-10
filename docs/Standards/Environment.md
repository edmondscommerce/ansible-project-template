# Environment Management


## Default Environment

Setting default environment to Vagrant ensure that production updates require explicitly passing it as environment flag with `-i environment/prod`

This is enforced by the Ansible configuration file.


## How to handle SSH keys and SSH Config


### Development

Development keys can be the developer’s own key as it will not be used to interact with any production systems


### Production

A unique key specifically for the production environment(s) will need to be generated and setup with the target machine(s).

The key must be encrypted in the Ansible vault for the appropriate host. Ansible can then use this to connect when the vault secret is in place correctly.

Each key corresponds to one target, revoking these keys becomes much easier if only one key has one machine it will authenticate with.

This concept also applies to remote services, for example:



*   Github
*   Bitbucket


## Connection Types

Ansible provides many different ways of defining hosts, this includes static configuration (for production servers) and executable files that will output configuration (good for development).


### LXC

This makes use of hosts.bash file to output the correct access details, this is determined by the container name. Through the use of an executable file (such as bash) you can output a JSON payload that tells Ansible what it needs to connect to a container.


### LXD

Ansible provides a dedicated LXD module that allows you to create containers on the fly without the use of Vagrant. This is being explored as a possibility for the future but is not currently supported.

The possibilities of spinning up infrastructure and provisioning in a similar fashion to Docker open up many doors.


### Docker

It is possible to use Docker locally with Ansible, this has not been explored and is unlikely to be used in any practical sense. This is not supported by the company.


### Vagrant


### SSH

