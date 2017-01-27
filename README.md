gutbackup, the simplest rsync wrapper for backup Linux system
================================

[Homepage](https://github.com/gutenye/gutbackup) |
[Documentation](https://github.com/gutenye/gutbackup/wiki) |
[Issue Tracker](https://github.com/gutenye/gutbackup/issues) |
[MIT License](http://choosealicense.com/licenses/mit) |
[Bountysource](https://www.bountysource.com/teams/gutenye) |
[by Guten Ye](http://guten.me)

|                |  Install                                         |
|----------------|------------------------------------------ |
| ArchLinux      | `$ pacaur -S gutbackup` |
| Manually       | `$ git clone git@github.com/gutenye/gutbackup.git` |

Getting Started
---------------

``` bash
Mount backup USB drive to /backup
$ mkdir -p /backup/conf/hello
$ vi /backup/conf/hello/default

    backup_options="-aP"
    files="
    /etc/fstab
    /etc/mtab
    "

$ gutbackup backup hello -- --dry-run
> rsync --files-from /tmp/files.gutbackup -aP --dry-run / /backup/hello/
```

That's it, as you can see, it just build a rsync command using options from `/backup/conf/hello/default` bash file.

**Backup to another location**

```
$ gutbackup backup hello -to /tmp/backup
> backup to /tmp/backup
> read conf from /tmp/backup/conf/hello/default
```

**Backup to another location with another conf directory**

```
$ gutbackup backup hello -to /tmp/backup -conf /etc/backup
> backup to /tmp/backup
> read conf from /etc/backup/hello/default
```

**Configuration**

You can provide options in four locations, later one override the previous. They are just plain bash files.

- system-wide: `/etc/gutbackup.conf`
- local-wide: `$conf/<profile>.conf`
- local-wide: `$conf/<profile>/<instance>`
- cmdline

```
# edit /etc/gutbackup.conf

  from="/"
  to="/backup"
  conf="$to/conf"

# edit /backup/conf/hello.conf

  backup_options="-aP"

# edit /backup/conf/hello/default

  files="/etc/fstab"

# edit /backup/conf/hello/data

  files="/root"

# cmdline

  $ gutbackup backup <profile> [instance] [options] -- [rsync-options]
  $ gutbackup backup hello     # if you omit the instance, it's "default".
  $ gutbackup backup hello data -from / -to /backup -conf /backup/conf -- --dry-run
```

Read more at [Archlinux Example](https://github.com/gutenye/gutbackup/tree/master/examples/archlinux), [Tutorial](https://github.com/gutenye/gutbackup/wiki/Tutorial), and
[Documentation](https://github.com/gutenye/gutbackup/wiki)

### Schedule Backup

```
# sytemctl enable gutbackup@hello.timer
By default, it runs daily, you can change it by
# systemctl edit gutbackup@hello.timer
  [Timer]
  OnCalendar=weekly
Read more at $ man systemd.timer
```

### I Also Use These Backup Apps

- x: encyption the backup and send it to cloud
- [Syncthing](https://syncthing.net/): Relatime Backup
- [Time Machine](https://support.apple.com/en-us/HT201250): For Mac OS
- [Helium](https://play.google.com/store/apps/details?id=com.koushikdutta.backup&hl=en): For Android
- [File History](http://windows.microsoft.com/en-us/windows-8/how-use-file-history): For Windows

Copyright
---------

The MIT License (MIT)

Copyright (c) 2013-2015 Guten Ye

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
