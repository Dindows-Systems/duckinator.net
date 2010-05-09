#noheaders
require File.join(File.dirname(__FILE__), '..', '..', '..', 'backend', 'backend.rb')

env = ENV.clone

env['PATH_TRANSLATED'] = ENV['PATH_TRANSLATED'].gsub('themes/preview/', '').gsub('/index.rb', '/index.rhtml')

HomePage.new(env, 'dove')

