require 'simplecov'
require 'rspec'
SimpleCov.coverage_dir("tmp/coverage")
SimpleCov.start

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["NATSJR_ENV"] = "test"

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$PROGRAM_NAME = Dir.pwd + "/spec/spec_helper.rb"

require 'natsjr'

def byte(str)
  NatsJr::JString.new(MultiJson.dump(str)).get_bytes
end

RSpec.configure do |config|
  def connection
    @connection ||= begin
      c = double("Connection")
      allow(c).to receive(:publish)
      allow(c).to receive(:set_disconnected_callback)
      allow(c).to receive(:set_reconnected_callback)
      allow(c).to receive(:set_closed_callback)
      allow(c).to receive(:subscribe)
      c
    end
  end
end
