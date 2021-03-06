# Playbooks and Plays

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

## Avoid using LineInFile

Line in file makes assumptions about the environment and does not lend itself to being idempotent.

Instead a J2 template should be used where we want to take control of files on the target machine.

## Lookup functions

Ansible provides the [lookup](https://docs.ansible.com/ansible/latest/plugins/lookup.html) plugin to help populate 
variables from different sources. The most common use of this is to generate [disposable passwords](./Vault.md), however
there are other things that it can be used for, such as reading values from the environment or shell commands.

These need to be explored further to see how useful they are.
