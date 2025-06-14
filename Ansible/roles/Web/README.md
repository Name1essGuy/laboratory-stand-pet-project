Web
=========

This role installs and sets up a web server for service deployment.

Requirements
------------

- python3 passlib (Install: `pip install passlib`)

Role Variables
--------------

### Main Configuration Variables

| Variable           | Required | Default               | Description                                                  |
|--------------------|----------|-----------------------|--------------------------------------------------------------|
| `release_path`     | yes      | `"/var/www/releases"` | Directory for service deployment                             |
| `server_port`      | yes      | `"80"`                | Srever port for nginx                                        |


### System Configuration

| Variable           | Required | Default               | Description                                                  |
|--------------------|----------|-----------------------|--------------------------------------------------------------|
| `web_group`        | yes      | `"web-ops"`           | System group for web operations                              |
| `web_username`     | yes      | `"web-admin"`         | System user for web operations                               |
| `web_password`     | yes      | `""`                  | Password for web system user                                 |


Dependencies
------------

No dependencies required.

Example Playbook
----------------

## Installation 

Playbook example:

    - hosts: servers
      roles:
         - Web

## Uninstallation  

To remove the CA role, run:  
```bash  
ansible-playbook -i inventory uninstall.yml 
```

License
-------

BSD

Author Information
------------------

GitHub: https://github.com/Name1essGuy
