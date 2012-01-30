require "erb"

module Oldtime
  class RsyncWithFile
    def initialize
      @action = "backup"
      @profile = "ywank"
    end

    def parse(file)
      f = open(file) 
      @end_cmd = f.readline
      content = f.read
      f.close

      @end_cmd = ERB.new(@end_cmd).result(binding)
      @file_config = scan(content)

      @dir = Pa.mktmpdir(@profile)
      @file_config.each { |k, v|
        File.write("#{@dir}/#{k}", v)
      }
    end

    def build_cmd
      cmd = "rsync "

      @file_config.each { |k,v|
        cmd << "--#{k}-from #{@dir}/#{k} "
      }

      cmd << Rc[@action].rsync.options

      cmd << @end_cmd
    end

    def run
      cmd = build_cmd
      sh cmd
    end

    # Given data:
    #   [foo]
    #   bar ...
    #
    # => {"foo" => "bar"}
    def scan(data)
      pat = /(.*?)\[([^\]]+)\] *\n/m
      ret = {}

      tokens = []
      data.scan(pat) do |v, k|
        tokens << a << b 
      end

      tokens[1..-1].each_slice(2){|k, v|
        v ||= "" # nil is empty string.

        ret[k] = v
      }

      ret
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
