module Oldtime
  class CLI < Thor
    include Thor::Actions

    # check_unknown_options!

    # default_task :install
    class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"
    class_option "verbose",  :aliases => "-V", :type => :boolean, :banner => "Enable verbose output mode"
    class_option "dir", :aliases => "-d", :type => :string, :banner => "config directory"

    def initialize(*)
      super
      o = options.dup
      the_shell = (o["no-color"] ? Thor::Shell::Basic.new : shell)
      Oldtime.ui = UI::Shell.new(the_shell)
      Oldtime.ui.debug! if o["verbose"]

      home = Rc.p.home = o["dir"] || Rc.p.home
      homerc = Rc.p.homerc = Pa("#{home}rc")

      Rc << Optimism.require(homerc.absolute2)
    end

    desc "backup <profile> [instance]", "begin backup process."
    # method_option "x", :aliases => "-x", :default => "x", :type => :string, :banner => "NAME", :desc => "x"
    def backup(profile, instance=:default)
      Rc.action = "backup"
      Rc.profile = profile
      instance = Rc.instance = instance.to_sym

      load_profile profile

      if blk=Rc.backup_blks[instance]
        blk.call
      else
        Oldtime.ui.say "can't find `#{instance}' instance to execute."
      end
    end

    desc "restore <profile> [instance]", "begin restore process."
    def restore(profile, instance=:default)
      Rc.action = "restore"
      Rc.profile = profile
      Rc.instance = instance.to_sym

      load_profile profile

      Rc.restore_blks[instance].call
    end

private

    def load_profile(profile)
     file = Pa("#{Rc.p.home}/#{profile}.conf")

     if file.exists?
        load file.p
      else
        raise Error, "can't find the profile configuration file -- #{file}"
      end
    end
  end
end
