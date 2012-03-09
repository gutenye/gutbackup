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

      run_instance(@action, @instance)

      run_hooks(:after, @after_hooks)
    end

    private

    def run_instance(action, instance)
      if blk=Rc.instances._fetch2("#{action}.#{instance}")
        log_time {
          blk.call
        }
      else
        Oldtime.ui.say "can't find `#{instance}' instance to execute."
      end
    end

    def run_hooks(pos, hooks)
      # call default hook first
      if hook=find_hook(@action, "default", pos, "default")
        hook.call 
      end

      hooks.each {|n|
        if hook=find_hook(@action, @instance, pos, n)
          hook.call 
        end
      }
    end

    def find_hook(action, instance, pos, task)
      p=[ "#{action}.#{instance}.#{pos}.#{task}", "all.#{instance}.#{pos}.#{task}" ]
          .find {|v| Rc.hooks._has_key2?(v) }

      if p
        Rc.hooks._fetch2(p)
      else
        nil
      end
    end

    def log_time(&blk)
      start_time = Time.time

      blk.call

      escape_time = Time::Deta.new((Time.time-start_time).to_i).display
      msg="\n\nTOTAL ESCAPE TIME: #{escape_time}"
      Oldtime.ui.say msg
      File.append(Rc.p.logfile.p, msg)
    end
  end
end
