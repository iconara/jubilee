# -*- encoding: binary -*-

# Implements a simple DSK for configuring a Jubilee server
#
# See https://github.com/isaiah/jubilee/examples/jubilee.conf.rb
# for example configuration files.
module Jubilee
  class Configuration
    attr_reader :app

    def initialize(options, &block)
      @options = options
      @block = block
      reload
    end

    def reload
      instance_eval(File.read(config_file), config_file) if config_file
    end

    def app
      @app ||= load_rack_adapter(@options, &@block)
      if !@options[:quiet] and @options[:environment] == "development"
        logger = @options[:logger] || STDOUT
        Rack::CommonLogger.new(@app, logger)
      else
        @app
      end
    end

    # sets the host and port jubilee listens to +address+ may be an Integer port 
    # number for a TCP port or an "IP_ADDRESS:PORT" for TCP listeners
    #
    #   listen 3000 # listen to port 3000 on all TCP interfaces
    #   listen "127.0.0.1:3000"  # listen to port 3000 on the loopback interface
    #   listen "[::1]:3000" # listen to port 3000 on the IPv6 loopback interface
    def listen(address, options = {})
      @options[:host], @options[:port] = expand_addr(address)
      @options.merge! options
    end

    # sets the working directory for jubilee
    def working_directory(path)
      path = File.expand_path(path)
      if config_file && config_file[0] != ?/ && ! File.readable?("#{path}/#{config_file}")
         raise ArgumentError,
              "config_file=#{config_file} would not be accessible in" \
              " working_directory=#{path}"
      end
    end

    # sets the number of worker threads in the threads pool, Each worker thread
    # will serve exactly one client at a time.
    def worker_threads(nr)
      set_int(:worker_threads, nr, 1)
    end

    # TODO more precise
    # set the event bus bridge prefix, prefix, options
    # eventbus /eventbus, inbound: {foo:bar}, outbound: {foo: bar}
    # will set the event bus prefix as eventbus "/eventbus", it can be
    # connected via new EventBus("http://localhost:3215/eventbus"), inbound and
    # outbound options are security measures that will filter the messages
    def eventbus(prefix, options = {})
      @options[:event_bus][:prefix] = prefix
      @options[:event_bus][:inbound] = options[:inbound]
      @options[:event_bus][:outbound] = options[:outbound]
    end

    # Set the port to be discovered by other jubilee instances in the network
    def clustering(port)
      set_int(:cluster_port, port, 1025)
    end

    # enable debug messages
    def debug(bool)
      set_bool(:debug, bool)
    end

    # enable daemon mode
    def daemonize(bool)
      set_bool(:debug, bool)
    end

    # enable https mode, provide the :keystore path and password
    def ssl(options = {})
      set_path(:ssl_keystore, options[:keystore])
      @options[:ssl_password] = options[:password]
      @options[:ssl] = true
    end

    # sets the path for the PID file of the jubilee event loop
    def pid(path)
      set_path(:pid, path)
    end

    # Allows redirecting $stderr to a given path, if you are daemonizing and
    # useing the default +logger+, this defautls to log/jubilee.stderr.log
    def stderr_path(path)
      set_path(:stderr_path, path)
    end

    # live stderr_path, this defaults to log/jubilee.stdout.log when daemonized
    def stdout_path(path)
      set_path(:stdout_path, path)
    end

    private
    def load_rack_adapter(options, &block)
      if block
        inner_app = Rack::Builder.new(&block).to_app
      else
        if options[:rackup]
          Kernel.load(options[:rackup])
          inner_app = Object.const_get(File.basename(options[:rackup], '.rb').capitalize.to_sym).new
        else
          Dir.chdir options[:chdir] if options[:chdir]
          inner_app, opts = Rack::Builder.parse_file "config.ru"
        end
      end
      inner_app
    end

    def expand_addr(addr)
      return "0.0.0.0:#{addr}" if addr === Integer
      case addr
      when %r{\A(?:\*:)?(\d+)\z}
        "0.0.0.0:#$1"
      when %r{\A\[([a-fA-F0-9:]+)\]:(\d+)\z}, %r{\A(.*):(\d+)\z}
        canonicalize_tcp($1, $2.to_i)
      else
        addr
      end
    end

    def set_int(var, n, min)
      Integer === n or raise ArgumentError, "not an integer: #{var}=#{n.inspect}"
      n >= min or raise ArgumentError, "too low (< #{min}): #{var}=#{n.inspect}"
      @options[var] = n
    end

    def set_path(var, path)
      case path
      when NilClass, String
        @options[var] = path
      else
        raise ArgumentError
      end
    end

    def set_bool(var, bool)
      case bool
      when true, false
        @options[var] = bool
      else
        raise ArgumentError, "#{var}=#{bool.inspect} not a boolean"
      end
    end

    def canonicalize_tcp(addr, port)
      packed = Socket.pack_sockaddr_in(port, addr)
      port, addr = Socket.unpack_sockaddr_in(packed)
      /:/ =~ addr ? "[#{addr}]:#{port}" : "#{addr}:#{port}"
    end
  end
end
