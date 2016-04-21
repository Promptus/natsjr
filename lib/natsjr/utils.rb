module NatsJr
  module Utils
    def data(bytes)
      MultiJson.load(JString.new(bytes).to_s, symbolize_keys: true)
    end

    def response(str)
      JString.new(MultiJson.dump(str)).get_bytes
    end
  end
end
