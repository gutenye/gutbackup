oldtime, a bash script using rsync to provide a backup solution.
================================

|                |                                           |
|----------------|------------------------------------------ |
| Homepage:      | https://github.com/GutenYe/oldtime        |
| Author:	       | Guten                                     |
| License:       | MIT                                       |
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

(the MIT License)

Copyright (c) 2013-2015 Guten

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
