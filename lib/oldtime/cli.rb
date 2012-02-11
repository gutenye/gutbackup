module Oldtime
  class CLI < Thor
    include Thor::Actions

    # check_unknown_options!

    # default_task :install
    class_option "no-color", :type => :boolean, :banner => "Disable colorization in output"
    class_option "verbose",  :aliases => "-V", :type => :boolean, :banner => "Enable verbose output mode"
    class_option "dir", :aliases => "-d", :type => :string, :banner => "config directory"
    class_option "halt", :aliases => "-h", :type => :boolean, :default => false :banner => "halt system after process completed. "
    class_option "after", :aliases => "-a", :type => :array, :banner => "after hook."
    class_option "before", :aliases => "-b", :type => :string, :banner => "before hook."

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
      run(:backup, profile, instance, options.dup)
    end

    desc "restore <profile> [instance]", "begin restore process."
    def restore(profile, instance=:default)
      run(:restore, profile, instance, options.dup)
    end

private

    def run(action, profile, instance, o)
      Rc.action = action
      Rc.profile = profile
      instance = Rc.instance = instance.to_sym
      setup_logfile
      load_profile profile

      o[:before].unshift "default"
      o[:after].unshift "default"
      o[:after] << "halt" if o.halt?

      Instance.new(:restore, instance, o[:before].uniq, o[:after].uniq).run
    end

    def load_profile(profile)
     file = Pa("#{Rc.p.home}/#{profile}.conf")

     if file.exists?
        load file.p
      else
        raise Error, "can't find the profile configuration file -- #{file}"
      end
    end

    def setup_logfile
      # logfile
      logdir = Pa("#{Rc.p.home}/#{Rc.profile}.log")
      Pa.mkdir_f logdir
      Rc.p.logfile = Pa("#{logdir}/#{Rc.action}.#{Time.now.strftime('%Y%m%d%H%M')}")
    end

  end
end
