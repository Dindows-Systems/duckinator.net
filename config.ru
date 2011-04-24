require File.join(File.dirname(__FILE__), "backend", "backend.rb")

theme = 'fairview_pier'

homepage = HomePage.new(theme)

begin
  run homepage
rescue => e
  str = <<EOF
<!doctype html>
<html>
<head>
  <title>Error - duckinator.net</title>
</head>
<body>
There was an error processing your request. Details below.

<pre>
#{e.exception}: #{e.message}
#{e.backtrace.join("\n")}
</pre>
</body>
</html>
EOF
  [500, { "Content-Type" => "text/html" }, [str]]
end
