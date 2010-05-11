require 'cgi'
cgi = CGI.new
cig.out {
	puts "Pulling from github..."
	`git pull &> autopull/log`
	puts "Done."
}
