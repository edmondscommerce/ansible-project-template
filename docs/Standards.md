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

The repository **SHOULD** clearly state that it is a DevOps project by using one of the following suffixes:
`ansible`, `devops` or `infrastructure`.

```
.
├── docs/
├── environment/        # Host specific configuration
├── files/              # MUST contain only static files, e.g. SQL files, images, certificates
├── playbooks/          # Collection of plays, groups multiple plays together
├── plays/              # Individual plays, each one handles a smaller part of host management
├── roles/              # Stores Ansible roles, handled by Ansible Galaxy and the contents should be git ignored
├── shellscripts/       # Helper shell scripts one might use for CI purposes or otherwise
├── templates/          # MUST only contain dynamic files, that use the Jinja2 templating language
├── vars/               # Non-host specific variables
├── ansible.cfg
├── .ansible-lint
├── .gitignore          # a base .gitignore you are free to add additional rules to
├── README.md           # SHOULD be a quick start and point to different pages in the docs folder
├── requirements.yml
├── vault.secret
└── Vagrantfile
```

## <a id="playbooks-tasks-roles"></a>Playbooks, Tasks and Roles

 - You **MUST** name to all tasks. [Ansible Docs - Always Name Tasks](always-name-tasks)
 - You **MUST** install packages using the distribution agnostic `package` module. [Unify Package
   Installation](unify-package-installation)
 - You **MUST** use the `import_*`/`include_*` modules instead of pre_task/post_task/roles directives.
   [Ansible Docs - Including and Importing](including-and-importing)
 - You **MUST** use jinja2 template files instead of jinja2 expressions within the content attribute of the
   copy module. [Ansible Docs - Copy module](copy-module)
 - You **SHOULD** use the shell module only when there is no appropriate Ansible module, or the command module
   does not suffice.
 - You **SHOULD** use the `loop` directive. [Migrating from with_X to loop][migrating-from-with-to-loop]


## <a id="ansible-vault"></a>Ansible Vault

 - You **MUST** store vault data in a flat file (single encrypted vault). There can be multiple files in each
   host and group.
 - You **MUST** store vault file within the environment directory and nowhere else.
 - You **MUST** edit the encrypted vault fiels using the ansible-vault edit command. This is to avoid accidentally
   committing access credentials to git. [More information on Vault and it's usage](Standards/Vault.md)
 - You **MUST** prefix all variables with `vault_`
 - All vault variables **MUST** be prefixed with `vault_` and then loaded directly into vars files.
 - The files that load the vault variables can be group specific (e.g. - vars/mysql.yml, vars/nginx.yml).

See the [best practice page][variables-and-vault] for more information

---

Further resources. It is recommended that the following pages are read in the order below.

  * [Variables](./Standards/Variables.md)
  * [Plays and Plabybooks](./Standards/Plays.md)
  * [Vault](./Standards/Vault.md)
  * [Roles and Dependencies](./Standards/Roles.md)
  * [Environment Management](./Standards/Environment.md)
  * [Quality Assurance and Continuous Integration](./Standards/QA-CI.md)


[always-name-tasks]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#always-name-tasks
[unify-package-installation]: https://radeksprta.eu/posts/make-ansible-playbook-distribution-agnostic/
[including-and-importing]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_includes.html
[copy-module]: https://docs.ansible.com/ansible/latest/modules/copy_module.html#synopsis
[migration-from-with-to-loop]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html#migrating-from-with-x-to-loop
[variables-and-vault]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_includes.html
