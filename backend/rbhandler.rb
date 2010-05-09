require 'rubygems'
require 'cgi'

cgi = CGI.new
cgi.out { "" }
`/usr/bin/env ruby -r "open('#{ENV['PATH_TRANSLATED']}').read"`

