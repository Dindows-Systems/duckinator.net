require 'rubygems'
require File.join(File.dirname(__FILE__), '..', '..', '..', 'backend', 'backend.rb')
require 'cgi'

env = ENV.clone

env['PATH_TRANSLATED'] = ENV['PATH_TRANSLATED'].gsub('themes/preview/', '').gsub('/index.rb', '/index.rhtml')

cgi = CGI.new
cgi.out {
	HomePage.new(env, false, 'dove')
}

