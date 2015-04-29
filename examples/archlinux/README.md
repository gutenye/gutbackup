### Setup

1. Install `gutbackup`
2. Mount backup USB drive to `/backup`
3. Download [this](https://github.com/gutenye/gutbackup/archive/master.zip) and copy `examples/archlinux/*` to `/backup/conf/archlinux`
4. Configure settings: preserve AUR package cache

```
# edit /etc/makepkg.conf

  PKGDEST=/var/cache/pacman/pkg

# chomd 775 /var/cache/pacman/pkg
# gpasswd -a $USER root
```

### Backup

```
# gutbackup backup archlinux
```

### Restore (in a fresh installed ArchLinux)

1. Install `gutbackup`
2. Mount backup USB drive to `/backup`
3. In the first terminal

```
# gutbackup restore archlinux pkg
# cd /backup/archlinux/work
# pacman -S `cat pkg.list` -f
# pacman -S `cat aur.list` -f
# gutbackup restore archlinux etc
```

4\. In the second terminal

```
# gutbackup restore archlinux data
```

How it Works
------------

| Backup     | From                                | To                           |
|------------|-------------------------------------|------------------------------|
| pkg        | /var/cache/pacman/pkg               | /backup/archlinux/pkg        |
| etc        | /etc except /etc/fstab, ...         | /backup/archlinux/etc        |
| machineetc | /etc/fstab, /etc/default/grub, ...  | /backup/archlinux/machineetc |
| data       | /home, /root, /var/lib/, ...        | /backup/archlinux/data       |
