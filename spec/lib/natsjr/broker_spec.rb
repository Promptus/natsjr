require 'spec_helper'

describe NatsJr::Broker do
  describe "#invoke" do
    let!(:cf) { double("CodeFactory") }

    before do
      allow(cf).to receive(:set_servers)
      allow(cf).to receive(:create_connection) { connection }
    end

    it do
      expect(subject.invoke(cf)).to eq(NatsJr.handler_count)
    end
  end

  describe "#servers" do
    it { expect(subject.servers.map(&:to_s)).to eq(["nats://0.0.0.0:4222"]) }
  end
end
