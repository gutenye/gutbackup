require "erb"
require "tempfile"

module Oldtime
  class RsyncWithFile
    def parse(file)
      f = open(file) 
      cmdline = f.readline
      content = f.read
      f.close

      cmdline = ERB.new(cmdline).result(binding)

      # files exclude include


    end
  end

  module Rsync_Kernel

    # @overload rsync(filename)
    # @overload rsync(src, dest, o={})
    def rsync(*args)
      Rsync.rsync_with_file(xx)
      #Rsync.rsync(xx)
      puts "rsync"
    end
  end
end

module Kernel
private
  include Rsync_Kernel
end
