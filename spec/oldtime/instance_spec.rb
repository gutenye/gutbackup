require "spec_helper"
Instance = Oldtime::Instance

class Instance
  public :log_time, :find_hooks
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

  describe "#find_hooks" do
    before :each do
      @i = Instance.new(1,2)
    end

    it "works" do
      Rc.hooks = Optimism <<-EOF
        all.default.after.halt = proc { 1 }
        backup.default.after.halt = proc { 2 }

        all.files.after.halt = proc { 3 } 
        backup.files.after.halt = proc { 4 }
      EOF

      hooks = @i.find_hooks "backup", "files", "after", "halt"
      hooks.map{|v| v.call}.should == [4, 2]
    end

    it "works" do
      Rc.hooks = Optimism <<-EOF
        all.default.after.halt = proc { 1 }

        all.files.after.halt = proc { 3 } 
      EOF

      hooks = @i.find_hooks "backup", "files", "after", "halt"
      hooks.map{|v| v.call}.should == [3, 1]
    end




  end


end
