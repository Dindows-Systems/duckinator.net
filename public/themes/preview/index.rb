require 'backend.rb'

env = ENV.clone
env['PATH_TRANSLATED'].delete('themes/preview/')

Homepage.new(env, 'dove')
