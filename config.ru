require File.join(File.dirname(__FILE__), "backend", "backend.rb")

homepage = HomePage.new(ENV.clone)

run homepage
