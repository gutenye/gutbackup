require "spec_helper"

Hooker = Oldtime::Hooker

describe Hooker do
  describe "#after" do
    it "works with :default place" do
      h = Hooker.new(:default)
      h.after(:bar){ 1 }

      Rc.hooks.default.after.bar.call.should == 1
    end

    it "works with :backup place" do
      h = Hooker.new(:backup)
      h.after(:bar){ 2 }

      Rc.hooks.backup.default.after.bar.call.should == 2
    end

    it "works with :restore place" do
      h = Hooker.new(:restore)
      h.after(:bar){ 3 }

      Rc.hooks.restore.default.after.bar.call.should == 3
    end
  end

  describe "#before" do
    it "works with :default place" do
      h = Hooker.new(:default)
      h.after(:bar){ 4 }

      Rc.hooks.default.after.bar.call.should == 4
    end

    it "works with :backup place" do
      h = Hooker.new(:backup)
      h.before(:bar){ 5 }

      Rc.hooks.backup.default.before.bar.call.should == 5
    end

    it "works with :restore place" do
      h = Hooker.new(:restore)
      h.before(:bar){ 6 }

      Rc.hooks.restore.default.before.bar.call.should == 6
    end
  end
end

