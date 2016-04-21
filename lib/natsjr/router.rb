require "natsjr/router/errors"
require "natsjr/utils"

module NatsJr
  module Router
    extend Utils

    @routes = Collections.unmodifiableMap(HashMap.new)

    class << self
      def add_route(type, route, &handler)
        raise(RouteAlreadyExistsError, route) if @routes.include?(route)
        map = HashMap.new(
          route.freeze => HashMap.new(type: type, handler: handler)
        )
        map.put_all @routes if @routes.any?
        @routes = Collections.unmodifiableMap(map)
      end

      def invoke_route(connection, msg)
        subject, route, data, type = extract_data(msg)
        result = handle_call(route[:handler], data)

        if type == :RESPOND
          connection.publish(msg.get_reply_to, response(result))
        end

        NatsJr.logger.info(
          "#{type}=#{subject} request=#{data} #response=#{result}"
        )
      end

      private

      def handle_call(handler, data)
        handler.call(data)
      rescue ArgumentError => error
        { error: error.to_s }
      end

      def extract_data(msg)
        subject = msg.subject[NatsJr.namespace_with_separator.size..-1]
        route = @routes[subject]
        [subject, route, data(msg.data), route[:type]]
      end
    end
  end
end
