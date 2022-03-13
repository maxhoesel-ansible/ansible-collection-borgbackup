
<a name="v0.1.10"></a>
## [v0.1.10] - 2022-03-13

<a name="v0.1.9"></a>
## [v0.1.9] - 2022-03-12
### Bug Fixes
- **borgmatic:** improve ssh fingerprint reliability ([cf03a99](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/cf03a99)) [Max Hösel]
- **borgmatic:** remove trailing newline from ssh command ([#20](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/20)) ([c6f39ca](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/c6f39ca)) [Max Hösel]

### Documentation
- update readme ([a20f56a](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/a20f56a)) [Max Hösel]
- update contribution docs ([77f804b](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/77f804b)) [Max Hösel]
- add author names to changelog ([63ec791](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/63ec791)) [Max Hösel]


<a name="v0.1.8"></a>
## [v0.1.8] - 2021-08-28
### Bug Fixes
- **borgmatic:** always update APT cache before installing ([5a67a0b](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/5a67a0b)) [Max Hösel]

### Features
- **borg_server:** add support for debian 11 ([#18](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/18)) ([8a23df4](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/8a23df4)) [Max Hösel]


<a name="v0.1.7"></a>
## [v0.1.7] - 2021-08-18
### Bug Fixes
- allow roles to run in --check mode once configured ([#12](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/12)) ([8d01dd9](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/8d01dd9)) [Max Hösel]
- **borgmatic:** be less picky about undefined vars ([#16](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/16)) ([caacd4e](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/caacd4e)) [Max Hösel]

### Documentation
- **borgmatic:** remove outdated var entry ([1447df3](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/1447df3)) [Max Hösel]

### Features
- **borgmatic:** add support for debian 11 ([06dfe98](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/06dfe98)) [Max Hösel]
- **borgmatic:** add execution-limiting variables ([d4e27d0](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/d4e27d0)) [Max Hösel]
- **borgmatic:** add separate check schedule ([#13](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/13)) ([98e7ebb](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/98e7ebb)) [Max Hösel]


<a name="v0.1.6"></a>
## [v0.1.6] - 2021-05-24
### Bug Fixes
- **borg_server:** handle removal failures gracefully ([#9](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/9)) ([e0de2ff](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/e0de2ff)) [Max Hösel]


<a name="v0.1.5"></a>
## [v0.1.5] - 2021-04-18
### Bug Fixes
- **borgmatic:** schedule timer without restarting ([#7](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/7)) ([3fc8681](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/3fc8681)) [Max Hösel]
- **borgmatic:** only run tasks when required ([#6](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/6)) ([9fc71da](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/9fc71da)) [Max Hösel]

### Documentation
- fix typo ([bd23ac6](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/bd23ac6)) [Max Hösel]

### Features
- **borgmatic:** disable hardening and add flag ([#8](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/8)) ([a7fb928](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/a7fb928)) [Max Hösel]


<a name="v0.1.4"></a>
## [v0.1.4] - 2021-04-09
### Bug Fixes
- **borg_server:** use rm to remove unknown dirs ([ab7d4ba](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/ab7d4ba)) [Max Hösel]

### Features
- **borgmatic:** add require_ac_power flag ([3051d11](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/3051d11)) [Max Hösel]


<a name="v0.1.3"></a>
## [v0.1.3] - 2021-04-09
### Bug Fixes
- prevent errors when removing already absent files ([#4](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/4)) ([b6364b8](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/b6364b8)) [Max Hösel]


<a name="v0.1.2"></a>
## [v0.1.2] - 2021-04-08
### Features
- **backup_server:** add backup_path_clean option ([#2](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/2)) ([89a24bd](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/89a24bd)) [Max Hösel]


<a name="v0.1.1"></a>
## [v0.1.1] - 2021-04-04
### Documentation
- link commits in changelog ([3a51665](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/3a51665)) [Max Hösel]

### Features
- **borg_server:** add backups_set_permissions flag ([#1](https://github.com/maxhoesel/ansible-collection-borgbackup/issues/1)) ([f5c2b91](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/f5c2b91)) [Max Hösel]


<a name="v0.1.0"></a>
## v0.1.0 - 2021-04-04
### Bug Fixes
- **borgmatic:** don't crash without remote repos ([681f4e9](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/681f4e9)) [Max Hösel]

### Features
- initial commit ([0a1df66](https://github.com/maxhoesel/ansible-collection-borgbackup/commit/0a1df66)) [Max Hösel]


[v0.1.10]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.9...v0.1.10
[v0.1.9]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.8...v0.1.9
[v0.1.8]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.7...v0.1.8
[v0.1.7]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.6...v0.1.7
[v0.1.6]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.5...v0.1.6
[v0.1.5]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.4...v0.1.5
[v0.1.4]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.3...v0.1.4
[v0.1.3]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.2...v0.1.3
[v0.1.2]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.1...v0.1.2
[v0.1.1]: https://github.com/maxhoesel/ansible-collection-borgbackup/compare/v0.1.0...v0.1.1
