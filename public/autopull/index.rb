require 'cgi'
cgi = CGI.new
cgi.out {
	"Pulling from github... #{`git pull &> autopull/log`}Done. <a href=\"log\">log</a>"
}
