require 'rubygems'
require 'cgi'

def run
	`/usr/bin/env ruby #{ENV['PATH_TRANSLATED']}`
end

if open(ENV['PATH_TRANSLATED']).read[0...10] == "#noheaders")
	run
else
	cgi = CGI.new
	cgi.out { run }
end

