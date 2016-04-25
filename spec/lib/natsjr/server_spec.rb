require 'spec_helper'

module Subject
  include NatsJr::Server
end

describe Subject do
  context 'included' do
    it { is_expected.to respond_to(:respond, :listen, :run!) }
  end
end
