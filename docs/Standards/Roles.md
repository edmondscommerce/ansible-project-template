# Roles and Dependencies

## Composition over forking
Where possible, roles should not be forked or extended, instead composition should be used to wrap all written roles. This prevents changes being made that breaks roles for other projects as is the case at the moment.

Forking repositories should be a last resort.

Composition can be accomplished using role dependencies.
This allows Ansible Galaxy to function much like Composer in that dependencies can have dependencies, this also reduces the amount of work required to get projects bootstrapped.

[https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-dependencies](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-dependencies)

A Magento 2 role might have:
```yaml
dependencies:
    - role: geerlingguy.nginx
      vars: #....
    - role: lean_delivery.mysql
      vars: #....
    - role: geerlingguy.php-versions
      vars: #....
# .....
```

The role would set some sensible defaults and allow easy updates to variables in the client ansible project.

## Installation

Using the command line tool does not automatically update the requirements file, so you must add the role to the file
and then run

```bash
ansible-galaxy install -r requirements.yml --force
``` 

to ensure that this stays up to date

## Standard Roles for Standard Tasks
Overtime we have worked with several Role vendors, here is a short list of different roles that we use.

### Web Services
* [Nginx: Geerling Guy](https://galaxy.ansible.com/geerlingguy/nginx)
* [Nginx: Official Role](https://github.com/nginxinc/ansible-role-nginx)
* [Mysql: Lean Delivery](https://galaxy.ansible.com/lean_delivery/mysql)
* [Certbot for Lets Encrypt: Geerling Guy](https://galaxy.ansible.com/geerlingguy/certbot)

### PHP
* [PHP: Geerling Guy](https://galaxy.ansible.com/geerlingguy/php)
* [PHP Versions: Geerling Guy](https://galaxy.ansible.com/geerlingguy/php-versions)
* [Composer: Geerling Guy](https://galaxy.ansible.com/geerlingguy/composer)

### Testing
* [Mailhog: Geerling Guy](https://galaxy.ansible.com/geerlingguy/mailhog)

### Frontend
* [NodeJS: Geerling Guy](https://galaxy.ansible.com/geerlingguy/nodejs)
* [Yarn: Ocha](https://galaxy.ansible.com/ocha/yarn)

### Other
* [Remi Repo: Geerling Guy](https://galaxy.ansible.com/geerlingguy/repo-remi)
* [Epel Repo: Geerling Guy](https://github.com/geerlingguy/ansible-role-repo-epel)
