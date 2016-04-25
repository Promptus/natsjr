require "java"
require "lock_jar"

module NatsJr
  java_import "java.lang.Runtime"
  CPU_COUNT = Runtime.getRuntime.availableProcessors

  java_import("java.lang.String") { |_, name| "J#{name}" }
  java_import "java.util.Collections"
  java_import "java.util.HashMap"
  java_import "java.util.ArrayList"

  lockfile = File.expand_path("../../../Jarfile.lock", __FILE__)
  LockJar.install(lockfile)
  LockJar.load(lockfile).each { |jar| require jar }

  java_import "org.apache.log4j.BasicConfigurator"
  java_import "org.apache.log4j.LogManager"
  BasicConfigurator.configure
end
