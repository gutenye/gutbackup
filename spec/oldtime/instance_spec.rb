require "spec_helper"
Instance = Oldtime::Instance

class Instance
  public :log_time, :find_hook
end

describe Instance do
  describe "#log_time" do
    it "works" do
      Rc.p.logfile = Pa("#{$spec_data}/logfile")

      Instance.new(1,2).log_time {
        1 + 1
      }
    end
  end

  describe "#find_hook" do
    before :each do
      @i = Instance.new(1,2)
    end

    it "finds first" do
      Rc.hooks = Optimism <<-EOF
        all.files.after.halt = proc { 1 } 
        backup.files.after.halt = proc { 2 }
      EOF

      hook = @i.find_hook "backup", "files", "after", "halt"
      hook.call.should == 2
    end

    it "finds the second one" do
      Rc.hooks = Optimism <<-EOF
        all.files.after.halt = proc { 11 } 
      EOF

      hook = @i.find_hook "backup", "files", "after", "halt"
      hook.call.should == 11
    end

    it "doesn't find one " do
      Rc.hooks = Optimism <<-EOF
        all.files.after.halt = proc { 21 } 
        backup.files.after.halt = proc { 22 }
      EOF

      hook = @i.find_hook "backup", "files", "after", "notify"
      hook.should be_nil
    end
  end
end
