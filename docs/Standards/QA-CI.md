# Quality Assurance and Continuous Integration

## Ansible Lint

Ansible Lint should be used with the default configuration to check that the project does not have any serious problems.

Ansible lint can also be run in a pre-commit hook and as a CI process.


## Pre-commit hooks

Ansible/Python provides a pre-commit hook plugin that will automatically run yaml based pre-commit hooks without the need to edit local git config.

The plugin must be installed when working with any Ansible project to ensure that the hooks fire and perform the necessary checks.

Pre commit hooks are handled by the [pre-commit library](https://pre-commit.com/) that is used with most open source Ansible roles/projects


## Vault Data

All vault data must be encrypted and the vault secret must never be committed.


## Pre-Commit Hook (Client)

[https://selivan.github.io/2017/04/08/ansible-check-on-commit-vault-files-are-encrypted.html](https://selivan.github.io/2017/04/08/ansible-check-on-commit-vault-files-are-encrypted.html)


## Pre-Receive Hook (Server)