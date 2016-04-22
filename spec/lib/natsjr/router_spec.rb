require 'spec_helper'

describe NatsJr::Router do
  it { is_expected.to respond_to(:add_route, :invoke_route, :data, :response) }

  let(:type) { :PUBLISH }
  let(:route) { "bar" }
  let(:handler) { ->(msg) { "Hello #{msg}" } }

  before do
    subject.instance_variable_set(:@routes, {})
    subject.add_route(type, route, &handler)
  end

  describe "immutable route store" do
      it do
        expect {
          subject.instance_variable_get(:@routes).merge!(hello: "world")
        }.to raise_error(java.lang.UnsupportedOperationException)
      end
  end

  describe "#add_route" do
    context "new" do
      it { expect(subject.instance_variable_get(:@routes)).to include(route) }
    end

    context "route already present" do
      it do
        expect { subject.add_route(type, route, &handler) }.to(
          raise_error(subject::RouteAlreadyExistsError)
        )
      end
    end
  end

  describe "#invoke_route" do
    let(:connection) { double("Connection") }
    let(:message) { double("Message") }

    before do
      allow(connection).to receive(:publish)
      allow(message).to receive(:subject) { "foo:bar" }
      allow(message).to receive(:get_reply_to) { "INBOX:foo" }
      allow(message).to receive(:data) { byte(hello: "world") }
    end

    context ":PUBLISH" do
      it { expect(handler).to receive(:call) }
      it { expect(connection).not_to receive(:publish) }
    end

    context ":RESPOND" do
      let(:type) { :RESPOND }
      let(:response) { byte("Hello #{{hello: "world"}}") }

      it { expect(handler).to receive(:call).with(hello: "world") }
      it { expect(connection).to(receive(:publish).with(message.get_reply_to, response)) }
    end

    after do
      subject.invoke_route(connection, message)
    end
  end
end
