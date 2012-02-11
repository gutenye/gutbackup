require "spec_helper"
Instance = Oldtime::Instance

class Instance
  class << self
    public :log_time
  end
end

describe Instance do
  describe ".log_time" do
    it "works" do
      Rc.p.logfile = Pa("#{$spec_data}/logfile")

      Instance.log_time {
        1 + 1
      }
    end
  end

  describe "#after" do
    it "works" do
      i = Instance.new(:backup, :files)
      i.after(:foo){ 1 }

      Rc.hooks.backup.files.after.foo.call.should == 1
    end
  end

  describe "#before" do
    it "works" do
      i = Instance.new(:restore, :system)
      lambda { i.before }.should raise_error(Oldtime::EFatal)
    end
  end
end
