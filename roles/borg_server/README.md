# maxhoesel.borgbackup.borg_server

Configures a borgbackup server for receiving backups via SSH on a per-host/key basis

This role installs a server as described in the official [borgbackup documetation](https://borgbackup.readthedocs.io/en/stable/deployment/central-backup-server.html).
In this scenario, each host that sends its backups to the central server has a unique key to authenticate itself.
The server uses these keys to restrict hosts into a single directory where they can then store their backups.

## Requirements

- The following distributions are currently supported:
  - Ubuntu 18.04 LTS or newer
  - Debian 10 or newer
  - There are no plans to support CentOS/RHEL-based distros right now
- This role requires root access. Make sure to run this role with `become: yes` or equivalent

## Role Variables

### General

##### `borg_server_user`
- User under which the borg server will listen for connections
- Default: `borg`

##### `borg_server_config_path`
- Path in which the borg server config should be saved
- Currently, the config only consists out of the authorized_keys file
- Default: `/etc/borg-server`

##### `borg_server_backups_path`
- Path in which the backups should be saved
- Default: `/var/borg-server`

##### `borg_server_backups_set_permissions`
- Whether to set owner/group/mode for the backup directories
- Should be left on unless you know what you're doing.
  Disabling this option can be useful, e.g. if you are using an NFS mount as your storage
- Default: `yes`

##### `borg_server_authorized_hosts`
- List of hosts that will have access to the backup server
- Each entry is a dict containing the host name and its ssh public key
- Example:
  ```yaml
  borg_server_authorized_hosts:
    - name: host1.my.domain
      key: ssh-rsa key-goes-here
    - name: host2.my.domain
      key: ssh-rsa key-goes-here
    ...
  ```
- Default: `false`

## Example Playbooks

```yaml
- hosts: all
  roles:
    - role: maxhoesel.borgbackup.borg_server
      become: yes
      vars:
        borg_server_authorized_hosts:
          - name: host1.my.domain
            key: ssh-rsa key-goes-here
          - name: host2.my.domain
            key: ssh-rsa key-goes-here
```
