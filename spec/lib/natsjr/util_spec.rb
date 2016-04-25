require 'spec_helper'

module Subject
  extend NatsJr::Utils
end

describe Subject do
  let(:hash) { { hello: "world" }  }
  let(:bytes) { byte(hash) }

  context 'included' do
    it { is_expected.to respond_to(:data, :response) }
  end

  context 'data' do
    it { expect(subject.data(bytes)).to eq(hash) }
  end

  context 'response' do
    it { expect(subject.response(hash)).to eq(bytes) }
  end
end
