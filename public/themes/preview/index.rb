#noheaders
require File.join(File.dirname(__FILE__), '..', '..', '..', 'backend', 'backend.rb')

env = ENV.clone
env['PATH_TRANSLATED'] = env['PATH_TRANSLATED'].delete('themes/preview/').gsub('/index.rb', '/index.rhtml')

HomePage.new(env, 'dove')

