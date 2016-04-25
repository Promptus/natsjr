module NatsJr
  module Utils
    def data(bytes)
      MultiJson.load(JString.new(bytes).to_s, symbolize_keys: true)
    end

    def response(hash)
      JString.new(MultiJson.dump(hash)).get_bytes
    end
  end
end
