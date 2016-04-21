require 'spec_helper'

describe NatsJr do
  it do
    is_expected.to respond_to(
      :env, :config, :logger, :namespace, :handler_count, :nats_servers, :group
    )
  end
end
