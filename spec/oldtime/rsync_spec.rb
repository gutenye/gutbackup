require "spec_helper"
require "oldtime/rsync"

Rsync2 = Oldtime::Rsync2
Rsync = Oldtime::Rsync

class Rsync
  public :build_cmd
  attr_accessor :logdir, :end_cmd, :logfile
end

class Rsync2
  public :scan, :parse, :build_cmd
  attr_accessor :logdir, :end_cmd, :logfile, :dir
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

      rsync = Rsync.new("/home <%=Rc.media%>")
      rsync.logdir.should == Pa("#{$spec_data}/oldtime/hello.log")
      rsync.end_cmd.should == "/home /media"
      rsync.logfile.should == Pa("#{$spec_data}/oldtime/hello.log/112.backup.file")
    end
  end

  describe "#build_cmd" do
    it "works" do
      Rc.backup.rsync.options = "-a"

      rsync = Rsync.new("x")
      rsync.logfile = Pa("logfile")
      rsync.build_cmd("/foo /bar").should == "rsync -a /foo /bar &> logfile | cat"
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

      rsync =Rsync.new("foo")

      rsync.logdir.should == Pa("#{$spec_data}/oldtime/hello.log")
      rsync.logfile.should == Pa("#{$spec_data}/oldtime/hello.log/112.backup.file")
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

      rsync = Rsync2.new("x")
      a = rsync.scan(data)
      b = { "guten" => "dsaf\nbar\n\n", "tagen" => "hello\n"}
      a.should == b
    end
  end

  describe "#parse" do
    it "works" do
      rsync = Rsync2.new("x")

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

      rsync = Rsync2.new("x")
      rsync.dir = "/a"
      rsync.logfile = Pa("logfile")

      a = rsync.build_cmd("/tmp /bar", {"files" => "x", "include" => "y"})
      b = "rsync -avh --files-from /a/files --include-from /a/include /tmp /bar &> logfile | cat"
      a.should == b
    end
  end
end
