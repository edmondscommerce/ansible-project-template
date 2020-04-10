# Quality Assurance and Continuous Integration

## Ansible Lint

Ansible Lint should be used with the default configuration to check that the project does not have any serious problems.

Ansible lint is also be run in a pre-commit hook and as a CI process.

Running Ansible Lint:
```bash
# From the project root
ansible-lint
```

## Pre-commit hooks

Ansible/Python provides a pre-commit hook plugin that will automatically run yaml based pre-commit hooks without the need to edit local git config.
The plugin must be installed when working with any Ansible project to ensure that the hooks fire and perform the necessary checks.

Pre commit hooks are handled by the [pre-commit library](https://pre-commit.com/) that is used with most open source Ansible roles/projects

## Pre-Commit Hook (Client)

Pre-commit hooks are the first line of defense against changes that may cause unwanted results when running Ansible playbooks.
The pre-commit hook will check that a set of automated tools show that everything is okay.

* Ansible Lint
* Vault Encryption Check

The project setup/update scripts automatically put the pre-commit hook in place, see the [setup](../Setup.md) documentation 
for more information.

## Pre-Receive Hook (Server)

**TODO**