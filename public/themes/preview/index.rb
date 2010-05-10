require 'rubygems'
require File.join(File.dirname(__FILE__), '..', '..', '..', 'backend', 'backend.rb')
require 'cgi'

env = ENV.clone

def parse_query_string(query)
	parts = query.split(/&|=/)
	Hash[*parts]
end

dir = env['PATH_TRANSLATED'].gsub('themes/preview/index.rb','')
query_string = env['REDIRECT_QUERY_STRING']
query_hash = parse_query_string(query_string)
env['PATH_TRANSLATED'] = File.join(dir, query_hash['path'])
#env['PATH_TRANSLATED'] = ENV['PATH_TRANSLATED'].gsub('themes/preview/', '').gsub('/index.rb', '/index.rhtml')

cgi = CGI.new
cgi.out {
	HomePage.new(env, false, 'dove')
}

