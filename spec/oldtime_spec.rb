require "spec_helper"

describe Kernel do
  it "#configure" do
    configure <<-EOF
      a = 1
    EOF

    Rc.a.should == 1
  end

  describe "#_instance" do
    it "works" do
      _instance("backup", :foo){ "backup" }

      Rc.instances.backup[:foo].call.should == "backup"
    end
  end

  describe "#backup" do
    it "works" do
      should_receive(:_instance).with("backup", 1)

      backup(1)
    end
  end

  describe "#restore" do
    it "works" do
      should_receive(:_instance).with("restore", 2)

      restore(2)
    end
  end

  describe "#_hook" do
    it "works" do
      _hook("after", :halt){ "hook" }

      Rc.hooks.all.default.after.halt.call.should == "hook"
    end

    it %~:on => "all"~ do
      _hook("after", :halt, :on => "all"){ "hook_on_all" }

      Rc.hooks.all.default.after.halt.call.should == "hook_on_all"
    end

    it %~:on => "all.files"~ do
      _hook("after", :halt, :on => "all.files"){ "hook_on_all_files" }

      Rc.hooks.all.files.after.halt.call.should == "hook_on_all_files"
    end
  end

  describe "#after" do
    it "works" do
      should_receive(:_hook).with("after", :notify, {})

      after(:notify){ 1 }
    end
  end

  describe "#before" do
    it "works" do
      should_receive(:_hook).with("before", :notify1, {})

      before(:notify1){ 1 }
    end
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
