$: << "."
require "lib/<%=project%>/version"

Gem::Specification.new do |s|
	s.name = "<%=project%>"
	s.version = <%=project.capitalize%>::VERSION
	s.summary = "a good lib"
	s.description = <<-EOF
a good lib
	EOF

	s.author = "<%=author%>"
	s.email = "<%=email%>"
	s.homepage = "http://github.com/<%=github.username%>/<%=project%>"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	#s.executables = ["x"]

	#s.add_dependency "x"
end
