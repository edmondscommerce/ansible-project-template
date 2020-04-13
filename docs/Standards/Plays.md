# Playbooks and Plays

The following is a set of rules and restrictions for when working with plays and playbooks.

## [All tasks must have names](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#always-name-tasks)

To keep things consistent and making it easier to debug when things go wrong.

This is also enforced by Ansible Lint.

## Avoid using Shell

Ansible provides several command modules that cover most needs. Where possible, use the appropriate command/function
to accomplish your goals.

Using shell should be a last resort.

## Use correct loop call

There are several different loop calls that are now deprecated, there is now only one loop function that should
be used.

For a list of the deprecated ways to loop, see
[here](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html#migrating-from-with-x-to-loop).

## Use Package (not dnf, yum, apt,  etc)

Do not use distribution specific commands when installing software packages from the repositories.

This prevents and impedes all efforts to support non-Centos distributions unnecessarily.

## File

```
  name: A file task
  file:
    state: present
    path: /path/to/file
    owner: ec
    group: ec
    mode: 0644
```

Used to create or remove files and directories. Most tasks need the directory to already exist so I used this a lot.

To create a directory set state to directory, to ensure the file / directory doesn't exist set it to absent

## Template

It places a copy of a file from your machine to the target host.

Uses a templating language to allow you to use variables in the template file.

## Avoid using LineInFile

Line in file makes assumptions about the environment and does not lend itself to being idempotent.

Instead a J2 template should be used where we want to take control of files on the target machine.

## Avoid pre-tasks, roles, and tasks and  use import_role to specify order

Recent versions of Ansible allow you to specify exactly when roles should be imported.
This can be done using the task [import_role](https://docs.ansible.com/ansible/latest/modules/import_role_module.html).

This allows much finer control of the playbook execution and should be used in preference to having a set of pre
tasks, roles, and tasks.

## Lookup functions

Ansible provides the [lookup](https://docs.ansible.com/ansible/latest/plugins/lookup.html) plugin to help populate 
variables from different sources. The most common use of this is to generate [disposable passwords](./Vault.md), however
there are other things that it can be used for, such as reading values from the environment or shell commands.

These need to be explored further to see how useful they are.
