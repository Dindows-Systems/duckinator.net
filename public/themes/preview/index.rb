require File.join(File.dirname(__FILE__), '..', '..', '..', 'backend', 'backend.rb')

env = ENV.clone
env['PATH_TRANSLATED'].delete('themes/preview/')

Homepage.new(env, 'dove')

puts env
