# Vagrant Rundeck

Rundeck environment for development purposes.

To see a list of vagrant command options, check it out on [Vagrant small cheat sheet](https://site-nogsantos.web.app/posts/vagrant/)

## Troubleshooting

When running, some errors can occur, it will depend on your system and of the versions of the tools.

### ERROR umount: /mnt: not mounted

Update `vagrant-vbguest`.

```bash
vagrant plugin uninstall vagrant-vbguest
vagrant plugin install vagrant-vbguest --plugin-version 0.30 # check the last version at https://github.com/dotless-de/vagrant-vbguest
```

### Error message given during initialization: Unable to resolve dependency

```bash
vagrant plugin update
```

### Vagrant sshfs unmounted

```bash
vagrant sshsf <target>
```
