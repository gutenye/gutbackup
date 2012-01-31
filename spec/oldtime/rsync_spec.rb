require "spec_helper"
require "oldtime/rsync"

Rsync2 = Oldtime::Rsync2
Rsync = Oldtime::Rsync

class Rsync
  public :build_cmd
end

class Rsync2
  public :scan, :parse, :build_cmd
end

describe Rsync do
  describe "#initialize" do
    it "works" do
      Rc.media = "/media"
      rsync =Rsync.new("/home <%=Rc.media%>")

      rsync.instance_variable_get(:@end_cmd).should == "/home /media"
    end
  end

  describe "#build_cmd" do
    it "works" do
      Rc.action = "backup"
      Rc.backup.rsync.options = "-a"
      rsync = Rsync.new("x")

      rsync.build_cmd("/foo /bar").should == "rsync -a /foo /bar"
    end
  end

end

describe Rsync2 do
  describe "#scan" do
    it "works" do
      data=<<-EOF
  [guten]   
dsaf
bar

[tagen]
hello
      EOF

      rsync = Rsync2.new("x")
      a = rsync.scan(data)
      b = { "guten" => "dsaf\nbar\n\n", "tagen" => "hello\n"}
      a.should == b
    end
  end

  describe "#parse" do
    it "works" do
      rsync = Rsync2.new("x")

      file = Pa("#{$spec_tmp}/file")
      data=<<-EOF
<%=Rc.foo%> /tmp /bar

[foo]
guten
      EOF


      File.write(file.p, data)
      Rc.foo = 1

      a = rsync.parse(file)
      b = [ "1 /tmp /bar", { "foo" => "guten\n" } ]
      a.should == b
    end
  end

  describe "#build_cmd" do
    it "works" do
      Rc.backup.rsync.options = "-avh"
      Rc.action = "backup"
      Rc.profile = "ywank"
      rsync = Rsync2.new("x")
      rsync.instance_variable_set(:@dir, "/a")

      a = rsync.build_cmd("/tmp /bar", {"files" => "x", "include" => "y"})
      b = "rsync -avh --files-from /a/files --include-from /a/include /tmp /bar"
      a.should == b
    end
  end
end

