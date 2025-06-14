security
=========

This role sets up iptables security rules for this project. It meant to be used only inside this project.

Requirements
------------

No requirements.

Role Variables
--------------

### Main Configuration Variables

| Variable                | Required | Default    | Description                                                  |
|-------------------------|----------|------------|--------------------------------------------------------------|
| `node_exporter port`    | yes      | `"9100"`   | Server port on which prometheus node exporter is running     |
| `process_exporter port` | yes      | `"9256"`   | Server port on which prometheus process exporter is running  |
| `nginx_exporter port`   | yes      | `"9113"`   | Server port on which prometheus nginx exporter is running    |
| `ovpn_exporter port`    | yes      | `"9176"`   | Server port on which prometheus ovpn exporter is running     |
| `mysqld_exporter port`  | yes      | `"9104"`   | Server port on which prometheus mysqld exporter is running   |


Dependencies
------------

No dependencies needed.


Example Playbook
----------------

## Installation 

Playbook example:

    - hosts: servers
      roles:
         - securi

## Uninstallation  

To remove the VPN role, run:  
```bash  
ansible-playbook -i inventory uninstall.yml 
```

License
-------

BSD

Author Information
------------------

GitHub: https://github.com/Name1essGuy
