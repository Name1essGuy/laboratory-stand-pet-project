Monitoring
=========

This role installs and sets up components for Certificate Authority server. It uses the easy-rsa app to generate necessary files for OpenVPN server creation.

Requirements
------------

- python3 passlib (Install: `pip install passlib`)

Role Variables
--------------

### Mysql Exporter Configuration Variables

| Variable                       | Required | Default             | Description                                         |
|--------------------------------|----------|---------------------|-----------------------------------------------------|
| `mysql_exporter_username`      | yes      | `""`                | Username of service user for access to mysql server |
| `mysql_exporter_password`      | yes      | `""`                | Password of service user for access to mysql server |

### Grafana Configuration Variables

| Variable                       | Required | Default             | Description                                         |
|--------------------------------|----------|---------------------|-----------------------------------------------------|
| `grafana_host`                 | yes      | `"127.0.0.1"`       | Ip adress of granafa server                         |
| `grafana_port`                 | yes      | `"3000"`            | Server port of grafana server                       |
| `grafana_admin_username`       | yes      | `"admin"`           | Login for grafana admin panel                       |
| `grafana_admin_password`       | yes      | `"admin"`           | Password for grafana admin panel                    |

### System Configuration

| Variable                       | Required | Default             | Description                                         |
|--------------------------------|-----------|--------------------|-----------------------------------------------------|
| `grafana_username`             | yes      | `"grafana-admin"`   | System user for Grafana operations                  |
| `grafana_group`                | yes      | `"grafana-ops"`     | System group for Grafana operation                  |
| `grafana_password`             | yes      | `""`                | Password for Grafana system user                    |
| `web_username`                 | yes      | `"web-admin"`       | System user for Nginx operations                    |
| `web_group`                    | yes      | `"web-ops"`         | System group for Nginx operations                   |
| `web_user_password`            | yes      | `""`                | Password for Nginx system user                      |


Dependencies
------------

No dependencies required.

Example Playbook
----------------

## Installation 

Playbook example:

    - hosts: servers
      roles:
         - Monitoring

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
