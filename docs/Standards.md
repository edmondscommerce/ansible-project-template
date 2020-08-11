# Ansible Standardisation

## Motivation

Ansible projects can become very complex and difficult to manage.
To improve how we work with Ansible and to make transferring from one project to another easier, we should keep all
foundations of each project the same.

**We need standardisation**

This project is our effort to standardise how we work with Ansible and will continue to evolve over time but the core
rules will not change wildly.

## Goal

The goal is to establish a single standard approach to Ansible projects
*   Clearly documented
*   Hopefully something that we might be able to enforce with automated QA, at least to some extent
*   Protects as much as possible against gotchas and pitfalls
*   Optimise for security and performance but above all it is optimised for legibility and clarity

---

 1. [Repository name and folder Structure](#repository-structure)
 2. [Playbooks, Tasks and Roles](#playbooks-tasks-roles)
 3. [Ansible Vault](#ansible-vault)

## <a id="repository-structure">Repository name and folder Structure

The repository should clearly indicate that it is an Ansible based dev ops project.
Naming options include:

  * project-ansible
  * project-devops
  * project-infrastructure

```
.
├── docs/
├── environment/        # Host specific configuration
├── files/              # Contains non template files, e.g. - SQL files, images, certificates
├── playbooks/          # Collection of plays, groups multiple plays together
├── plays/              # Individual plays, each one handles a smaller part of host management
├── roles/              # Stores Ansible roles, handled by Ansible Galaxy and the contents should be git ignored
├── shellscripts/       # Helper shell scripts one might use for CI purposes or otherwise
├── templates/          # Should only contain Jinja 2 template files
├── vars/               # Non-host specific variables
├── ansible.cfg
├── .ansible-lint
├── .gitignore          # a base .gitignore you are free to add additional rules to
├── README.md           # Entry point to the documentation, should be a quick start and point to different pages in the docs folder
├── requirements.yml
├── vault.secret
└── Vagrantfile
```

## <a id="playbooks-tasks-roles"></a>Playbooks, Tasks and Roles

 - All tasks **MUST** be named.
 - The shell module **SHOULD NOT** be used. It can be used as a last resort when there is no appropriate
   command/module.
 - The `loop` directive is the only way you **SHOULD** loop in playbooks.
 - Packages **MUST** be installed with the distribution agnostic `package` module.
 - pre_task/post_task/roles directives **MUST NOT** be used. Use the `import_*`/`include_*` set of directives
   instead.
 - Jinja2 expressions **MUST NOT** be used as the content attribute of the copy directive. Create a template
   file instead, and use the template module.


## <a id="ansible-vault"></a>Ansible Vault

 - Vault data **SHOULD** be stored in a flat file (single encrypted vault), there can be multiple files in each host and group.
 - Vault files **SHOULD** only be stored within the environment directory and nowhere else.
 - Vault files **MUST NOT** be decrypted to edit, use the CLI edit commands. This is to avoid accidentally committing access credentials to Git
 - All vault variables **MUST** be prefixed with `vault_` and then loaded directly into vars files.
 - The files that load the vault variables can be group specific (e.g. - vars/mysql.yml, vars/nginx.yml).
 - All vault files **MUST** be placed into the environment directory and be encrypted using the Ansible vault commands.

See the [best practice page](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#variables-and-vaults) for more information
It is recommended that the following pages are read in the order below.

* [Variables](./Standards/Variables.md)
* [Plays and Plabybooks](./Standards/Plays.md)
* [Vault](./Standards/Vault.md)
* [Roles and Dependencies](./Standards/Roles.md)
* [Environment Management](./Standards/Environment.md)
* [Quality Assurance and Continuous Integration](./Standards/QA-CI.md)
* [Migrating Existing Projects](./Standards/Migration.md)
