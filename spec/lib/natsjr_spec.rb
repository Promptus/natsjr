require 'spec_helper'

describe NatsJr do
  it do
    is_expected.to respond_to(
      *%i(env config namespace handler_count nats_servers group logger logger=)
    )
  end
end
