require "java"
require "lock_jar"

module NatsJr
  lockfile = File.expand_path("../../../Jarfile.lock", __FILE__)
  LockJar.install(lockfile)
  LockJar.load(lockfile).each { |jar| require jar }

  java_import "java.lang.Runtime"
  java_import("java.lang.String") { |_, name| "J#{name}" }
  java_import "java.util.Collections"
  java_import "java.util.HashMap"
  java_import "org.apache.log4j.BasicConfigurator"
  java_import "org.apache.log4j.LogManager"

  CPU_COUNT = Runtime.getRuntime.availableProcessors

  BasicConfigurator.configure
end
