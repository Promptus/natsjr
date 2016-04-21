require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$PROGRAM_NAME = Dir.pwd + "/spec/spec_helper.rb"
ENV["NATSJR_ENV"] = "test"
require 'natsjr'

def byte(str)
  NatsJr::JString.new(MultiJson.dump(str)).get_bytes
end

