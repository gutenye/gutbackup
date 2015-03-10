oldtime, a bash script using rsync to provide a backup solution.
================================

|                |                                           |
|----------------|------------------------------------------ |
| Homepage:      | https://github.com/GutenYe/oldtime        |
| Author:	       | Guten                                     |
| License:       | GPL                                       |
| Documentation: | http://rubydoc.info/gems/oldtime/frames   |
| Issue Tracker: | https://github.com/GutenYe/oldtime/issues |

a easy to use backup solution based on rsync.

Getting started
---------------

	$ oldtime backup hello

For a gettting started example, see [oldtime-helloworld](https://github.com/GutenYe/oldtime-helloworld). <br\>
For a real world example, see [oldtime-archlinux-solution](https://github.com/GutenYe/oldtime-archlinux-solution).

Environment variables used in script.

	OLDTIME_DEBUG=1

Install
-------

**Archlinux**: Install [oldtime](https://aur.archlinux.org/packages/oldtime/) from AUR using [aura](https://github.com/aurapm/aura) helper

	# aura -A oldtime

Development
----------

Run a test

	bin/oldtime backup -d test hello

Copyright
---------

Copyright 2013-2015 Guten Ye

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
