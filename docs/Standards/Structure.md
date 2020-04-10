# Structure
 
## Repository Naming

The repository should clearly indicate that it is an Ansible based dev ops project.
Naming options include:

* project-ansible
* project-devops
* project-infrastructure



## Project Structure

```
docs/ # Project specific documentation
files/ # Contains non template files, e.g. - SQL files, images, certificates
roles/  # Stores Ansible roles, handled by Ansible Galaxy and the contents should be git ignored
environment/ # Host specific configuration
playbooks/ # Collection of plays, groups multiple plays together 
plays/ # Individual plays, each one handles a smaller part of host management
templates/ # Should only contain Jinja 2 template files
vars/ # Non-host specific variables
.gitignore
ansible.cfg
README.md # Entry point to the documentation, should be a quick start and point to different pages in the docs folder
requirements.yml
vault.secret
Vagrantfile 
```

### Git Ignore file

Your .gitignore file should match this [.gitignore](../../.gitignore)

The gitignore should contain these lines but can also be added to as required.