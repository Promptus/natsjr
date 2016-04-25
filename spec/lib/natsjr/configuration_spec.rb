require 'spec_helper'

describe "NatsJr::Configuration" do
  subject(:test_object){ Object.new }
  before {  test_object.extend(NatsJr::Configuration) }

  it do
    is_expected.to respond_to(
      *%i(env root config namespace group handler_count nats_servers group
          logger logger= namespace_separator namespace_with_separator)
    )
  end

  context '#env' do
    let!(:natsjr_env) { ENV['NATSJR_ENV'] }
    before { ENV['NATSJR_ENV'] = nil }

    describe "default" do
      it { expect(subject.env).to eq("development") }
    end

    describe "altered by `NATSJR_ENV`" do
      before { ENV['NATSJR_ENV'] = "staging" }
      it { expect(subject.env).to eq("staging") }
    end

    after { ENV['NATSJR_ENV'] = natsjr_env }
  end

  context '#root' do
    it { expect(subject.root).to eq(File.dirname($PROGRAM_NAME))}
  end

  context '#config' do
    it do
      expect(subject.config).to eq(
        "namespace" => "foo",
        "namespace_separator" => ":"
      )
    end
  end

  context '#group' do
    it { expect(subject.group).to eq(subject.namespace) }
  end

  context '#handler_count' do
    it { expect(subject.handler_count).to be(NatsJr::CPU_COUNT.to_i) }
  end

  context '#logger' do
    describe "#logger" do
      it do
        expect(subject.logger).to be_a(Java::OrgApacheLog4j::Logger)
      end
    end
  end

  context '#logger=' do
    before { test_object.logger = Logger.new(STDOUT) }
    it { expect(subject.logger).to be_a(Logger) }
  end

  context '#namespace' do
    it { expect(subject.namespace).to eq("foo") }
  end

  context '#namespace_separator' do
    it { expect(subject.namespace_separator).to eq(":") }
  end

  context '#namespace_with_separator' do
    it { expect(subject.namespace_with_separator).to eq(
      "#{subject.namespace}#{subject.namespace_separator}"
    ) }
  end

  context '#nats_servers' do
    it { expect(subject.nats_servers).to eq(%w(0.0.0.0:4222)) }
  end

end
