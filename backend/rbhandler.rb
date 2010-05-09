require 'rubygems'
require 'cgi'

cgi = CGI.new
cgi.out { "" }
eval(open(ENV['PATH_TRANSLATED']).read)

