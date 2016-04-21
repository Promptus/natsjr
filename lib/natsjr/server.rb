require "java"

module NatsJr
  module Server
    java_import "io.nats.client.ConnectionFactory"

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def respond(to:, &block)
        NatsJr::Router.add_route(:RESPOND, to, &block)
      end

      def listen(to:, &block)
        NatsJr::Router.add_route(:LISTEN, to, &block)
      end

      def run!
        Connector.invoke(ConnectionFactory.new)
      end
    end
  end
end
