# Configurations

```
host=""
dir=/backup
src=/
backup_options="--archive --hard-links --acls --xattrs --compress --verbose --human-readable -P --stats --del --delete-excluded --recursive"
restore_options="--archive --hard-links --acls --xattrs --compress --verbose --human-readable -P --stats"
check_root=false
```


# Server Mode

> Configure Once, Backup Every Machines.

**Server**

```
$ pacaur -S gutbackup
```

**Client**

Install rsync

```
$ pacman -S rsync
```
