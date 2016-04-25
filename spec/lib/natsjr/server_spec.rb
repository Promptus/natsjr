require 'spec_helper'

module Subject
  include NatsJr::Server
end

describe Subject do
  let(:to) { "foo" }

  context 'included' do
    it { is_expected.to respond_to(:respond, :listen, :run!) }
  end

  context '#respond' do
    after do
      subject.respond(to: to) do
        "Hello World"
      end
    end

    it { expect(NatsJr::Router).to receive(:add_route).with(:RESPOND, to) }
  end

  context '#listen' do
    after do
      subject.listen(to: to) do
        "Hello World"
      end
    end

    it { expect(NatsJr::Router).to receive(:add_route).with(:LISTEN, to) }
  end

  context '#run!' do
    after { subject.run! }
    it { expect(NatsJr::Broker).to receive(:invoke) }
  end
end
