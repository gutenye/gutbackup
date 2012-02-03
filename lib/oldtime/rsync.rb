require "erb"

module Oldtime
  class Rsync
    attr_reader :name

    def initialize(end_cmd, name)
      @end_cmd = ERB.new(end_cmd).result(binding)
      @name = name
    end

    def run
      cmd = build_cmd(@end_cmd)

      File.append(Rc.p.logfile.p, "\n#{'='*30}\n#{'='*10} rsync #{name} #{'='*10}\n#{'='*30}\n\n")
      system cmd, :verbose => true
    end

  private
    def build_cmd(end_cmd)
      "rsync #{Rc[Rc.action].rsync.options} --log-file #{Rc.p.logfile} #{end_cmd}"
    end
  end

  class Rsync2
    attr_reader :name

    def initialize(file, name)
      @file = file
      @name = name
    end

    def run
      begin
        @dir = Pa.mktmpdir(Rc.profile)

        end_cmd, file_config = parse(@file)
        file_config.each { |k, v|
          File.write("#{@dir}/#{k}", v)
        }
        cmd = build_cmd(end_cmd, file_config)

        File.append(Rc.p.logfile.p, "\n#{'='*30}\n#{'='*10} rsync #{name} #{'='*10}\n#{'='*30}\n\n")
        system cmd, :verbose => true
      ensure
        # cleanup
        Pa.rm_r @dir
      end
    end

  private

    def parse(file)
      f = open(file.p) 
      end_cmd = f.readline.rstrip
      content = f.read
      f.close

      end_cmd = ERB.new(end_cmd).result(binding)
      file_config = scan(content)

      [ end_cmd, file_config]
    end

    def build_cmd(end_cmd, file_config)
      cmd = "rsync #{Rc[Rc.action].rsync.options} "


      file_config.each { |k,v|
        cmd << "--#{k}-from #{@dir}/#{k} "
      }

      cmd << "--log-file #{Rc.p.logfile} #{end_cmd}"
    end

    # Given data:
    #   [foo]
    #   bar ...
    #
    # => {"foo" => "bar"}
    def scan(data)
      pat = /(.*?)(\[([^\]]+)\] *\n|\z)/m
      ret = {}

      tokens = []
      data.scan(pat) do |v, _, k|
        tokens << v << k
      end

      tokens[1..-1].each_slice(2){|k, v|
        next if k.nil?
        v ||= "" # nil is empty string.

        ret[k] = v
      }

      ret
    end
  end

  module Rsync_Kernel
    def rsync(end_cmd, name=nil)
      name ||= end_cmd
      Rsync.new(end_cmd, name).run
    end

    # read rsync cmd from file.
    def rsync2(filename, name=nil)
      file = Pa("#{Rc.p.home}/#{Rc.profile}/#{filename}")
      name ||= filename
      Rsync2.new(file, name).run
    end
  end
end

include Oldtime::Rsync_Kernel

Optimism.undef_method :rsync, :rsync2
