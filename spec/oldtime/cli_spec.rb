require "spec_helper"

CLI = Oldtime::CLI

class CLI
  public :load_profile
end

describe CLI do
  describe "#load_profile" do
    it "works" do
      lambda { CLI.new.load_profile("deson_t_exists") }.should raise_error(Oldtime::Error)
    end
  end
end

