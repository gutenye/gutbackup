module Oldtime
  class Instance
    attr_reader :action, :instance

    def initialize(action, instance, before_hooks=[], after_hooks=[])
      @action = action
      @instance = instance
      @before_hooks = before_hooks
      @after_hooks = after_hooks
    end

    def run
      run_hooks(:before, @before_hooks)

      run_instance

      run_hooks(:after, @after_hooks)
    end

    private

    def run_instance
      if blk=Rc.instances.backup[instance]
        log_time {
          blk.call
        }
      else
        Oldtime.ui.say "can't find `#{instance}' instance to execute."
      end
    end

    def run_hooks(pos, hooks)
      hooks.each {|n|
        hooks = find_hooks(@action, @instance, pos, n)
        hooks.each {|v| v.call}
      }
    end

    def find_hooks(action, instance, pos, task)
      ret = []

      p=[ "#{action}.#{instance}.#{pos}.#{task}", "all.#{instance}.#{pos}.#{task}" ]
          .find {|v| Rc.hooks._has_key2?(v) }
      ret << Rc.hooks._fetch2(p) if p

      p=[ "#{action}.default.#{pos}.#{task}", "all.default.#{pos}.#{task}" ]
          .find {|v| Rc.hooks._has_key2?(v) }
      ret << Rc.hooks._fetch2(p) if p

      ret
    end

    def log_time(&blk)
      start_time = Time.time

      blk.call

      escape_time = Time::Deta.new((Time.time-start_time).to_i).display
      File.append(Rc.p.logfile.p, "\n\nTOTAL ESCAPE TIME: #{escape_time}")
    end
  end
end
