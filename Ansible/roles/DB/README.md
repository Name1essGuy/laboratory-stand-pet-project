DB
=========

This role installs and sets up components for Certificate Authority server. It uses the easy-rsa app to generate necessary files for OpenVPN server creation.

Requirements
------------

- python3 passlib (Install: `pip install passlib`)

Role Variables
--------------
### System Configuration

| Variable              | Required | Default               | Description                                                    |
|-----------------------|----------|-----------------------|----------------------------------------------------------------|
| `mysql_username`      | yes      | `"mysql-admin"`       | System user for MySQL operations                               |
| `mysql_group`         | yes      | `"mysql-ops"`         | System group for MySQL operations                              |
| `mysql_user_password` | yes      | -                     | Password for MySQL system user (should be encrypted with vault)|

Dependencies
------------

No dependencies required.

Example Playbook
----------------

## Installation 

Playbook example:

    - hosts: servers
      roles:
         - DB

## Uninstallation  

To remove the role, run:  
```bash  
ansible-playbook -i inventory uninstall.yml 
```

License
-------

BSD

Author Information
------------------

GitHub: https://github.com/Name1essGuy
