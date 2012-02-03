require "spec_helper"
require "oldtime/rsync"

Rsync2 = Oldtime::Rsync2
Rsync = Oldtime::Rsync

class Rsync
  public :build_cmd
  attr_accessor :end_cmd
end

class Rsync2
  public :scan, :parse, :build_cmd
  attr_accessor :end_cmd, :dir
end

describe Rsync do
  before :all do
    Rc.media = "/media"
    Rc.action = "backup"
    Rc.profile = "hello"
    Rc.instance = "file"
  end

  describe "#initialize" do
    it "works" do
      Time.stub_chain("now.strftime"){ "112" }

      rsync = Rsync.new("/home <%=Rc.media%>", "x")
      rsync.end_cmd.should == "/home /media"
    end
  end

  describe "#build_cmd" do
    it "works" do
      Rc.backup.rsync.options = "-a"
      Rc.p.logfile = Pa("logfile")

      rsync = Rsync.new("x", "y")
      rsync.build_cmd("/foo /bar").should == "rsync -a --log-file logfile /foo /bar"
    end
  end
end

describe Rsync2 do
  before :all do
    Rc.media = "/media"
    Rc.action = "backup"
    Rc.profile = "hello"
    Rc.instance = "file"
  end

  describe "#initialize" do
    it "works" do
      Time.stub_chain("now.strftime"){ "112" }

      rsync =Rsync.new("foo", "y")
    end
  end

  describe "#scan" do
    it "works" do
      data=<<-EOF
  [guten]   
dsaf
bar

[tagen]
hello
      EOF

      rsync = Rsync2.new("x", "y")
      a = rsync.scan(data)
      b = { "guten" => "dsaf\nbar\n\n", "tagen" => "hello\n"}
      a.should == b
    end
  end

  describe "#parse" do
    it "works" do
      rsync = Rsync2.new("x", "y")

      file = Pa("#{$spec_data}/filea")
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
      Rc.p.logfile = "logfile"

      rsync = Rsync2.new("x", "y")
      rsync.dir = "/a"

      a = rsync.build_cmd("/tmp /bar", {"files" => "x", "include" => "y"})
      b = "rsync -avh --files-from /a/files --include-from /a/include --log-file logfile /tmp /bar"
      a.should == b
    end
  end
end
