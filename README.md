Oldtime, a highly customizable and configurable backup & restore system
=================================================================

| Homepage:      |  https://github.com/GutenYe/oldtime       |
|----------------|-------------------------------------------|
| Author:	       | Guten                                     |
| License:       | MIT-LICENSE                               |
| Documentation: | http://rubydoc.info/gems/oldtime/frames   |
| Issue Tracker: | https://github.com/GutenYe/oldtime/issues |

oldtime, The old time.

### Is It Good?

Yes.

### Is It "Production Ready™"?

No.

Getting Started
--------------

For example, we want to backup /oldtime to /tmp/hello.oldtime using rsync.

create hello example

	$ git clone git://github.com/GutenYe/oldtime-hello-example.git  /tmp/oldtime
	$ sudo ln -s /tmp/oldtime /oldtime

it will have these files:

	# /oldtime/oldtimerc
		media = "/tmp"  # get this variable by Rc.media. Syntax see Optimsim

	/oldtime/oldtime/
		hello.conf
		hello/
			backup.hello

	# /oldtime/oldtime/hello/backup.hello

		/oldtime/  <%=Rc.media%>/hello.oldtime/ # an ERB template. see ERB

		[exclude]
		/.git
    /oldtimerc

	# /oldtime/hello.conf

		require "oldtime/rsync"
		
		configure <<EOF
			backup:
				rsync.options = "-av --delete" # get this variable by Rc.backup.rsync.options
			
			restore:
				rsync.options = "-av"
		EOF

		backup do
			rsync2 "backup.hello"  # load /oldtime/hello/backup.hello file
		end

		restore do
			rsync "<%=Rc.media%>/hello.oldtime/ /oldtime/.oldtime/"
		end

Let's begin.

	$ oldtime backup hello
	# it calls "rsync -av --delete --exclude-from /tmp/hello.xxx/exclude /oldtime/ /tmp/hello.oldtime/"

	$ oldtime restore hello
	# it calls "rsync -av /tmp/hello.oldtime/ /oldtime/"

for a real world example, see [oldtime-archlinux-solution](https://github.com/GutenYe/oldtime-archlinux-solution).

Install
-------

	# Archlinux
	pacman -S ruby rsync
	gem install oldtime

Note on Patches/Pull Requests
-----------------------------

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add tests for it. This is important so I don't break it in a future version unintentionally.
4. Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
5. Send me a pull request. Bonus points for topic branches.
6. Coding Style Guide: https://gist.github.com/1105334

Credits
--------

* [Contributors](https://github.com/GutenYe/oldtime/contributors)

Resources
---------

* [Ruby](http://www.ruby-lang.org/en): A Programmer's Best Friend
* [Archlinux](http://www.archlinux.org): A simple, lightweight distribution
* [pacuaer](https://github.com/Spyhawk/pacaur): A fast workflow AUR wrapper using cower as backend

Copyright
---------

(the MIT License)

Copyright (c) 2011 Guten

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
