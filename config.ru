require File.join(File.dirname(__FILE__), "backend", "backend.rb")

homepage = Homepage.new(ENV.clone)

run homepage
