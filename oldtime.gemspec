$: << File.expand_path("../lib", __FILE__)
require "oldtime/version"

Gem::Specification.new do |s|
	s.name = "oldtime"
	s.version = Oldtime::VERSION
	s.summary = "a highly customizable and configurable backup & restore system"
	s.description = <<-EOF
The backup & restore system that fits you well.  It's a highly customizable and configurable backup & restore system.
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@gmail.com"
	s.homepage = "http://github.com/GutenYe/oldtime"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	#s.executables = ["x"]

	s.add_dependency "tagen", "~>1.1.4"
  s.add_dependency "pa", "~>1.2.0"
  s.add_dependency "optimism", "~>3.1.0"
end
