require "spec_helper"

CLI = Oldtime::CLI

class CLI
  public :load_profile, :setup_logfile, :log_time
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

  describe "#log_time" do
    it "works" do
      Rc.p.logfile = Pa("#{$spec_data}/logfile")

      CLI.new.log_time {
        1 + 1
      }
    end
  end
end

