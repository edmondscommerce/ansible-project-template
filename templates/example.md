# Only templates should live here

Any Jinja 2 templates you want to use should live here.

These should be organised according to the location on the remote filesystem where the file is expected to end up. If
the name of the file is static then the template should have the same name, if it is going to change based on a variable 
value then it should have a descriptive filename to make clear what it is doing.

If there are multiple machines then the files should be separated by hostname at the top level.

```
templates/
├── db-server
│   └── etc
│       └── my.cnf.j2
└── web-server
    └── etc
        └── nginx
            └── conf.d
                └── website.conf.j2
```
