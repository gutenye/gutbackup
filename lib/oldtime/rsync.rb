require "erb"

module Oldtime
  class Rsync
    def initialize(end_cmd)
      @end_cmd = ERB.new(end_cmd).result(binding)
      @logdir = Pa("#{Rc.p.home}/#{Rc.profile}.log")
      @logfile = Pa("#{@logdir}/#{Time.now.strftime('%Y%m%d-%H%M')}.#{Rc.action}.#{Rc.instance}")
      Pa.mkdir_f @logdir
    end

    def run
      cmd = build_cmd(@end_cmd)
      system cmd, :verbose => true
    end

  private
    def build_cmd(end_cmd)
      "rsync #{Rc[Rc.action].rsync.options} #{end_cmd} &> #{@logfile} | cat"
    end
  end

  class Rsync2
    def initialize(file)
      @file = file
      @logdir = Pa("#{Rc.p.home}/#{Rc.profile}.log")
      @logfile = Pa("#{@logdir}/#{Time.now.strftime('%Y%m%d-%H%M')}.#{Rc.action}.#{Rc.instance}")
      Pa.mkdir_f @logdir
    end

    def run
      begin
        @dir = Pa.mktmpdir(Rc.profile)

        end_cmd, file_config = parse(@file)
        file_config.each { |k, v|
          File.write("#{@dir}/#{k}", v)
        }
        cmd = build_cmd(end_cmd, file_config)

        start_time = Time.time
        system cmd, :verbose => true
        escape_time = Time::Deta.new((Time.time-start_time).to_i).display
        File.append(@logfile.p, "TOTAL ESCAPE TIME: #{escape_time}")
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

      cmd << "#{end_cmd} &> #{@logfile} | cat"
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
    def rsync(end_cmd)
      Rsync.new(end_cmd).run
    end

    # read rsync cmd from file.
    def rsync2(filename)
      file = Pa("#{Rc.p.home}/#{Rc.profile}/#{filename}")
      Rsync2.new(file).run
    end
  end
end

include Oldtime::Rsync_Kernel

Optimism.undef_method :rsync, :rsync2
