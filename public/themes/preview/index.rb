#noheaders
require File.join(File.dirname(__FILE__), '..', '..', '..', 'backend', 'backend.rb')

env = ENV.clone
env['PATH_TRANSLATED'].delete('themes/preview/')

HomePage.new(env, 'dove')

