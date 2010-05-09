require File.join(File.basename(__FILE__), 'backend.rb')

env = ENV.clone
env['PATH_TRANSLATED'].delete('themes/preview/')

Homepage.new(env, 'dove')

puts env
