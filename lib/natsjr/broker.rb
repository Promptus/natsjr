require "java"

module NatsJr
  module Broker
    java_import "java.net.URI"

    @connections = []

    at_exit do
      @connections.each do |connection|
        connection.close
        NatsJr.logger.debug "Closing connection #{connection}!"
      end
    end

    class << self
      def invoke(cf)
        cf.set_servers(servers)
        NatsJr.handler_count.times { @connections << subscribe(cf) }
      end

      def servers
        NatsJr.nats_servers.map { |n| URI.new("nats://#{n}") }
      end

      def subject
        "#{NatsJr.namespace_with_separator}*"
      end

      private

      def subscribe(cf)
        connection = cf.create_connection
        connection.set_disconnected_callback { |e| call_disconnect(e) }
        connection.set_reconnected_callback { |e| call_reconnect(e) }
        connection.set_closed_callback { |e| call_closed(e) }

        connection.subscribe(subject, NatsJr.group) do |msg|
          NatsJr::Router.invoke_route(connection, msg)
        end

        connection
      end

      def call_disconnect(e)
        NatsJr.logger.debug "Disconnected from #{e.connection.currentServer}!"
      end

      def call_reconnect(e)
        NatsJr.logger.debug "Reconnected to #{e.connection.currentServer}!"
      end

      def call_closed(e)
        NatsJr.logger.debug(
          "Connection to #{e.connection.currentServer} closed!"
        )
      end
    end
  end
end
