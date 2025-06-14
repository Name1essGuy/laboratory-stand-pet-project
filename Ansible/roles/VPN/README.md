VPN
=========

This role installs and sets up components for VPN server. OpenVPN is used as VPN server. Role requires cetrificate authority server (use Name1essGuy.CA) to download necessary certificates from.

Requirements
------------

- python3 passlib (Install: `pip install passlib`)

Role Variables
--------------

### System Configuration

| Variable             | Required | Default               | Description                                                  |
|----------------------|----------|-----------------------|--------------------------------------------------------------|
| `ovpn_username`      | yes      | `"vpn-admin"`         | System user for VPN operations                               |
| `ovpn_group`         | yes      | `"vpn-ops"`           | System group for VPN operations                              |
| `ovpn_user_password` | yes      | -                     | Password for VPN system user (should be encrypted with vault)|
| `ca_server`          | yes      | `"ca_servers"`        | Name of CA server group in your inventory file               |
| `ca_dir`             | yes      | `"/etc/CA/server"`    | Directory for CA files                                       |


Dependencies
------------



Example Playbook
----------------

## Installation 

Playbook example:

    - hosts: servers
      roles:
         - VPN

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
