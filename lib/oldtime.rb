libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
require "bundler/setup"
Bundler.require

module Oldtime
  autoload :VERSION, "oldtime/version"
  autoload :UI, "oldtime/ui"
  autoload :CLI, "oldtime/cli"

  Error = Class.new Exception
  FatalError = Class.new Exception

  class << self
    attr_accessor :ui

    def ui
      @ui ||= UI.new
    end
  end
end

Rc = Optimism.require("oldtime/rc")

module Kernel
private

  def configure(data, &blk)
    Rc << Optimism(data, &blk)
  end

  def backup(instance=:default, &blk)
    Rc.backup_blks[instance] = blk
  end

  def restore(instance=:default, &blk)
    Rc.restore_blks[instance] = blk
  end

  def check_mountpoint(path)
    unless Pa.mountpoint?(path)
      raise Oldtime::Error, "`#{path}' is unmounted."
    end
  end

  def check_root
    unless Process.uid == 0
      raise Oldtime::Error, "need root privilege to run this script."
    end
  end
end

Optimism.undef_method :backup, :restore, :configure
