require 'rubygems'
require File.join(File.dirname(__FILE__), '..', '..', 'backend', 'backend.rb')
require 'cgi'

env = ENV.clone

dir = env['PATH_TRANSLATED'].gsub('preview/index.rb','')
query_string = env['REDIRECT_QUERY_STRING']

begin
  query_hash = CGI.parse(query_string)
rescue
  query_hash = {}
end

if query_hash.include?('path')
  file = File.join(dir, query_hash['path'])
else
  file = dir
end

if !File.exist?(file)
  file = File.join(dir, 'index.rhtml')
end

if File.directory?(file)
  file = File.join(file, 'index.rhtml')
end

if query_hash.include?('theme')
  theme = query_hash['theme']
else
  theme = 'dove'
end

env['PATH_TRANSLATED'] = file

cgi = CGI.new
cgi.out {
  HomePage.new(env, theme, "/preview?theme=#{theme}&path=")
}

