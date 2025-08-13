# maxhoesel.borgbackup.borgmatic

Install borg+borgmatic and setup a system backup job.

This role can perform the following actions for you:

- Install borg and [borgmatic](https://torsion.org/borgmatic/) (a configuration-driven wrapper around borg)
- Set up a scheduled backup job
- Create a custom borgmatic configuration based on Ansible variables
- Manage the SSH client keys and known_hosts file for your remote repositories
- Setup a schedules using systemd timers

## Requirements

- A distribution with `borgbackup` and `borgmatic` packages in its repo
    - This role supports Borgmatic versions `1.5` and newer
    - We test the following distributions, other distros may work but are unsupported:
        - Ubuntu 22.04 LTS, 24.04 LTS
        - Debian 11, 12, 13
- **This role requires root access**. Make sure to run this role with `become: yes` or as the root user

## Role Variables

### Select Tasks to Run

You can disable individual parts of this role if you don't have a use for them.
By default, all components are executed.

| Variable | Component/Description | Notes |
|-----------|----------|-------|
| `borgmatic_install` | Install of borg + borgmatic |  |
| `borgmatic_setup_backup` | Configure the backup job/environment | **Disabling this variable will cause all the steps listed below to be skipped.**
| `borgmatic_init_repos` | Initialize the repositories defined in `borgmatic_location_repositories`
| `borgmatic_ssh_manage_key` | Setup borgmatic to use a dedicated SSH private key for remote repositories (see [below](#ssh-management)) |
| `borgmatic_ssh_manage_known_hosts` | Setup borgmatic to use a custom known_hosts file for remote repositories |
| `borgmatic_manage_config` | Generate the borgmatic config file |
| `borgmatic_manage_schedule` | Generate a the systemd timer + service for regular backups | **Disabling this variable will also disable the check job.**
| `borgmatic_schedule_check_job` | Generate of a separate job for running backup repo checks |

### General

##### `borgmatic_config_path`
- Path in which the borgmatic config should be saved
- Only has an effect if `borgmatic_setup_backup` is set to `true`
- Default: `/etc/borgmatic`

##### `borgmatic_init_encryption`
- Encryption mode to use when initializing the repositories
- Default: `repokey`

##### `borgmatic_run_backup`
- Run the backup job at the end of this roles execution
- Note that enabling this will cause the role be non-idempotent (it will report changed tasks on every run)
- Default: `false`

#### `borgmatic_run_backup_no_block`
- Whether to wait for the backup job to complete when launched through `borgmatic_run_backup`
- If enabled, the backup job will be launched in the background and Ansible execution can continue
- Default: `true`

### Configuration

The [borgmatic configuration](https://torsion.org/borgmatic/docs/reference/configuration/) is directly from the `borgmatic_config` variable.
To set a configuration option for borgmatic, just add the corresponding key to `borgmatic_config`.
See [above](#example-playbook) for an example.

There are a few special parameters that require extra attention, listed below:

- `source_directories`:
    - Required for borgmatic to work
- `repositories`:
    - Required for borgmatic to work
    - Read by the role for scanning remote hosts into the `known_hosts` file if `borgmatic_ssh_manage_known_hosts` is enabled
- `keep_<interval/from>`
    - At least one `keep_` option is required for borgmatic to work
- `encryption_passphrase`
    - Required for initializing the repository if `borgmatic_init_repos` is enabled (default: `true`)
- `ssh_command`:
    - If `borgmatic_ssh_manage_key` is enabled, `" -i {{ borgmatic_ssh_key_path }}"` will be appended to point SSH to the borgmatic private key
        - If you want to supply your own private key to borgmatic, please disable `borgmatic_ssh_manage_key`
    - If `borgmatic_ssh_manage_known_hosts` is enabled, `" -o UserKnownHostsFile={{ borgmatic_ssh_known_hosts_file }}"`
        - If you want to supply your own known_hosts file (or use the system default), please disable `borgmatic_ssh_manage_known_hosts`

### SSH Management

Unless configured otherwise, borgmatic will use the users (always `root` in case of this role) default SSH config/key for connecting to remote repositories.
By default, this role instead configures a separate SSH environment for borgmatic, so that there is no interference with other services running as root.
You can customize this behavior with the variables below

##### `borgmatic_ssh_manage_key`
- If set to `true`, the role will setup borg to use a custom ssh key found at `{{ borgmatic_ssh_key_path }}`.
  - If no key is present, a new key will automatically be generated
- If set to `false`, no key will be generated and borgmatic will use the default root ssh key
- Default: `true`

##### `borgmatic_ssh_key_path`
- Path under which the custom ssh key is saved.
- You can set this to an already existing ssh key if you don't want to use the one generated by this role
- Default: `{{ borgmatic_config_path }}/id_rsa`

##### `borgmatic_ssh_key_gen_options`
- Set the `ssh-keygen` options to use when generating the key, such as algorithm and key length
    - For RSA, use `-t rsa -b <2048/4096>`
- The following options are added by the role: `-f {{ borgmatic_ssh_key_path }} -N '' -q`
- Default: `-t ed25519`

##### `borgmatic_ssh_manage_known_hosts`
- If set to `true`, the role will create and a borgmatic-specific known_hosts file that borg will then save all remote server fingerprints to.
- If set to `false`, borgmatic will use the default root known_hosts file instead.
- Default: `true`

##### `borgmatic_ssh_known_hosts_file`
- Path under which the custom known_hosts file will be saved
- You can set this to an existing known_hosts file if you don't want to use the one generated by this role
- Default: `{{ borgmatic_config_path }}/known_hosts`

### Schedule settings

These variables control the systemd timer and service used to run borgmatic periodically.
Note that these values (except for `backup_time`) also affect the separate check jobs.

The prefix for all variables in this section is: `borgmatic_schedule_`
| Name | Description | Required | Default |
|------|-------------|:--------:|---------|
| `on` | Schedule at which the backup should be run. Can be any valid [systemd time expression](https://www.freedesktop.org/software/systemd/man/systemd.time.html#). | X | `daily` |
| `max_random_delay` | To prevent several hosts pegging your backup server at once, systemd can delay execution within a random period. This balances the load out over a longer time period and helps to prevent load spikes. You can set the maximum delay in seconds with this variable | | `1800` (30 minutes) |
| `require_ac_power` | If set to `true`, skip the backup when the host is not connected to AC power. | | `false` |
| `harden` | Whether to tighten security on the systemd service to prevent exploits as root. Can cause issues with hooks and other integrations | | `false` |
| `persistent` | Whether to immoderately run the backup job if the host "missed" its last run (the random delay still applies) | | `false` |
| `wakeup` | Whether to wake the system for the backup job if it is in standby. May or may not be supported | | `false` |

#### Scheduling A Separate Check Job

Previous versions of this role let you set up a separate check job to run at a different time than borgmatic itself, to prevent long backup runs due to checks.
This feature has been superseded by a built-in Borgmatic config option, please see the documentation [here](https://torsion.org/borgmatic/docs/how-to/deal-with-very-large-backups/#check-frequency) for how to enable it.

If you previously used this role to configure a separate job, please manually delete the old check job before adjusting your config:

1. Disable the check timer: `systemctl disable --now borgmatic-check.timer`
2. Stop the check service if it is running: `systemctl stop borgmatic-check.service`
3. Delete the following unit files:
    - `/etc/systemd/system/borgmatic-check.timer`
    - `/etc/systemd/system/borgmatic-check.service`
4. Reload systemd `systemctl daemon-reload`

## Example Playbooks

This will setup a backup job to archive important directories onto a remote server that has a repository configured

For Borgmatic 1.8 and newer:

```yaml
- hosts: all
  become: yes # this role requires root!
  tasks:
    - name: Setup backups with borgmatic
      ansible.builtin.include_role: maxhoesel.borgbackup.borgmatic
      vars:
        borgmatic_config:
          # What do we want to backup?
          source_directories:
          - /home
          - /etc
          - /var

          # Where do we want to backup to?
          repositories:
          - path: ssh://borg@remote-backup-server.local/./my_repository_name
            label: backupserver

          # What's our encryption password?
          # This is required if `borgmatic_init_repos` is set to true (default)
          encryption_passphrase: "mysupersecretpassphrase"

          # How many backups to we want to keep?
          keep_daily: 7
```

For Borgmatic 1.7 and older:

```yaml
- hosts: all
  become: yes # this role requires root!
  tasks:
    - name: Setup backups with borgmatic
      ansible.builtin.include_role: maxhoesel.borgbackup.borgmatic
      vars:
        borgmatic_config:
          location:
            # What do we want to backup?
            source_directories:
                - /home
                - /etc
                - /var

            # Where do we want to backup to?
            # For borgmatic <1.7, `borgmatic_repositories` is just a list of strings
            repositories:
            - path: ssh://borg@remote-backup-server.local/./my_repository_name
                label: backupserver

            storage:
            # What's our encryption password?
            # This is required if `borgmatic_init_repos` is set to true (default)
            encryption_passphrase: "mysupersecretpassphrase"

            retention:
            # How many backups to we want to keep?
            keep_daily: 7
```
