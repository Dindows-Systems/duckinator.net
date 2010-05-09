require 'rubygems'
require 'cgi'

cgi = CGI.new
cgi.out { "" }
`/usr/bin/env ruby #{ENV['PATH_TRANSLATED']}`

