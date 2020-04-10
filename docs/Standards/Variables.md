# Variables


## Namespacing

Where possible, variables should be stored in a top level dictionary to separate different areas.

For example:


```
mysql:
    dbname: "ABC"
    pass: "{{ mysql_pass }}"
```


    

Similar to PSR-4 in Composer/PHP, a dictionary should also be one per file.

For example, the above example should be placed in vars/mysql.yml.

Environment based variables should not use the namespacing dictionary.


## Variable Values

Keep your variables [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

No [magic strings](https://deviq.com/magic-strings/).

**Values should only ever be assigned to one variable** -
 reuse among other variables is fine by referencing other variables. 
 
 **There should be a single source of truth.**

### Example

Instead of writing
```yaml
server_ip: 123.123.123.123
db_server_ip: 123.123.123.123
```

Do this instead
```yaml
server_ip: 123.123.123.123
db_server_ip: "{{ server_ip }}"
```

## Use the vars directory
All variables should be defined in the vars directory, environment specific variables should be in their relevant environment and be loaded by the vars files.

This prevents coupling to a single environment and ensures that the environment variables do not become too numerous

For example, for a web server you might define the public directory for your application so that it can vary among environments -
however the PHP version would be the same and would be loaded by set as such in the vars files.
 The vars files would also then load the environment variable for the public directory.


## Ansible Variables

Ansible provides a wealth of [different variables]((https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)) that can be accessed by the plays. These should be used where possible.

Example of these are Server IP addresses, e.g. 
```
"{{ hostvars['magento2-webserver']['ansible_default_ipv4']['address'] }}" 
```

Will give you the IP address of the magento2-webserver hosts which will be correct in each environment.

We should also always try to use the directory variables instead of relative paths to allow the files to be moved around easily, for example the “{{ inventory_dir }}”



