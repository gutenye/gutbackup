libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../Gemfile", __FILE__)
require "bundler/setup"
Bundler.require

module Oldtime
  autoload :VERSION, "oldtime/version"
  autoload :UI, "oldtime/ui"
  autoload :CLI, "oldtime/cli"
  autoload :Hooker, "oldtime/hooker"
  autoload :Instance, "oldtime/instance"

  Error = Class.new Exception
  EFatal = Class.new Exception

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
    _instance("backup", instance, &blk)
  end

  def restore(instance=:default, &blk)
    _instance("restore", instance, &blk)
  end

  # @example
  #
  #  after :clean, :on => "restore.files" do
  #    ...
  #  end
  def after(task=:default, o={}, &blk)
    _hook("after", task, o, &blk)
  end

  def before(task=:default, o={}, &blk)
    _hook("before", task, o, &blk)
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

  def _hook(name, task, o={}, &blk)
    on = case on=o[:on].to_s
    when ""
      "all.default"
    when "all", "backup", "restore"
      "#{on}.default"
    else
      on
    end

    Rc.hooks._set2 "#{on}.#{name}.#{task}", blk
  end

  def _instance(name, instance, &blk)
    Rc.instances[name][instance] = blk
  end
end

Optimism.undef_method :backup, :restore, :configure, :before, :after, :_hook, :_instance
