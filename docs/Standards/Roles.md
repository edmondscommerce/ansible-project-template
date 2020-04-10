# Roles and Dependencies

Where possible, roles should not be forked or extended, instead composition should be used to wrap all written roles. This prevents changes being made that breaks roles for other projects as is the case at the moment.

Forking repositories should be a last resort.

Composition can be accomplished using role dependencies.

[https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-dependencies](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-dependencies)

This allows Ansible Galaxy to function much like Composer in that dependencies can have dependencies, this also reduces the amount of work required to get projects bootstrapped.

For example:

A Magento 2 role will have dependencies on:
*   Geerling.mysql
*   Geerling.php-fpm
*   Etc

The role would set some sensible defaults and allow easy updates to variables in the client ansible project.

## Standard Roles for Standard Tasks

We should stick to using the same roles for certain tasks where possible, the sign of a good role for a task is it’s level of customization.

We will need to define a list of vendors that meet the quality level we expect.

For example:
*   Geerling Guy
*   Lean Machine
