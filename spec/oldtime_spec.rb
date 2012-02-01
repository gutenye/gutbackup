require "spec_helper"

describe Kernel do
  it "#configure" do
    configure <<-EOF
      a = 1
    EOF

    Rc.a.should == 1
  end

  it "#backup" do
    backup(:foo){ "backup" }
      
    Rc.backup_blks[:foo].call.should == "backup"
  end

  it "#restore" do
    restore(:foo){ "restore" }

    Rc.restore_blks[:foo].call.should == "restore"
  end

  describe "#check_root" do
    it "works" do
      Process.stub(:uid){ 1000 }
      lambda { check_root }.should raise_error(Oldtime::Error)
    end
  end

  describe "#check_mountpoint" do
    it "works" do
      Pa.stub(:mountpoint?){ false }
      lambda { check_mountpoint("x") }.should raise_error(Oldtime::Error)
    end
  end
end
