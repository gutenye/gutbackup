module Oldtime
  class Hooker
    def initialize(place)
      place = place.to_sym
      @hook = case place
      when :default
        Rc.hooks[:default]
      else
        Rc.hooks[place][:default]
      end
    end

    def after(task=:default, &blk)
      @hook[:after][task] = blk
    end

    def before(task=:default, &blk)
      @hook[:before][task] = blk
    end
  end
end
