$: << "."
require "lib/oldtime/version"

Gem::Specification.new do |s|
	s.name = "oldtime"
	s.version = Oldtime::VERSION
	s.summary = "the backup & restore system"
	s.description = <<-EOF
the backup & restore sytem
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenYe/oldtime"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	#s.executables = ["x"]

	#s.add_dependency "x"
end
