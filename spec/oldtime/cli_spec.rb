require "spec_helper"

CLI = Oldtime::CLI

class CLI
  public :load_profile, :setup_logfile
end

describe CLI do
  describe "#load_profile" do
    it "works" do
      lambda { CLI.new.load_profile("deson_t_exists") }.should raise_error(Oldtime::Error)
    end
  end

  describe "#setup_logfile" do
    it "works" do
      Rc.profile = "backup"

      CLI.new.setup_logfile
    end
  end
end


