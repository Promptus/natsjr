module NatsJr
  module Configuration
    attr_accessor :logger

    def env
      (ENV['NATSJR_ENV'] || "development").freeze
    end

    def root
      @root ||= File.dirname($PROGRAM_NAME)
    end

    def config
      @config ||= YAML.load_file("#{root}/config/config.yml")[env].freeze
    end

    def group
      @group ||= (config["group"] || namespace).to_s.freeze
    end

    def handler_count
      @handler_count ||= (config["handlers"] || NatsJr::CPU_COUNT).to_i
    end

    def logger
      @logger ||= LogManager.getLogger("NatsJr")
    end

    def namespace
      @namespace ||= (config["namespace"] || "default").to_s.freeze
    end

    def namespace_separator
      @namespace_separator ||= (
        config["namespace_separator"] || "."
      ).to_s.freeze
    end

    def namespace_with_separator
      @namespace_with_separator ||= "#{namespace}#{namespace_separator}".freeze
    end

    def nats_servers
      @nats_servers ||= (config["nats_servers"] || %w(0.0.0.0:4222)).freeze
    end
  end
end
