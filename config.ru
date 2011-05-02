Encoding.default_internal = 'UTF-8'

require File.join(File.dirname(__FILE__), "backend", "backend.rb")

theme = 'fairview_pier'

homepage = HomePage.new(theme)

run homepage
