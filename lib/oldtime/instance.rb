module Oldtime
  class Instance
    attr_reader :action, :instance

    def  initialize(action, instance, before_hooks=[], after_hooks=[])
      @action = action
      @instance = instance
      @before_hooks = before_hooks
      @after_hooks = after_hooks
    end

    def run
      run_before_hooks(@before_hooks)

      run_instance

      run_after_hook
    end

    private

    def run_instance
      if blk=Rc.instances.backup[instance]
        log_time {
          Instance.new(action, instance).instance_eval &blk
        }
      else
        Oldtime.ui.say "can't find `#{instance}' instance to execute."
      end
    end

    def run_before_hooks(hooks)
      hooks.map!{|v| v.to_sym}

      hooks.rever

    end

    def run_after_hook
    end

    def log_time(&blk)
      start_time = Time.time

      blk.call

      escape_time = Time::Deta.new((Time.time-start_time).to_i).display
      File.append(Rc.p.logfile.p, "\n\nTOTAL ESCAPE TIME: #{escape_time}")
    end
  end
end


  class InstanceEval
    # action :backup, :restore
    def initialize(action, instance)
      @action = action
      @instance = instance

      @hook = Rc.hooks[@action]._get2(@instance)
    end

    def after(task=:default, &blk)
      @hook.after[task] = blk
    end

    def before(*args, &blk)
      raise EFatal, "don't have a before hook inside an instance."
    end
  end
end
