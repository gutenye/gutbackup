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
end
