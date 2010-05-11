require 'cgi'
cgi = CGI.new
cgi.out {
	puts "Pulling from github..."
	`git pull &> autopull/log`
	puts "Done."
}
