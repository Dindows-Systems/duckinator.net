require 'rubygems'
require 'time'
require 'maruku'

class HomePage
  attr_accessor :title, :location
  def initialize(env)
    @env = env
    @location = @env['REQUEST_URI'] || "/"
    @title = set_title

    @body = open(env['PAGE_LOCATION']).read

    print_page
    exit
  end

  def title_check (location_words, i)
    File.directory?("./#{location_words[0..i].join('/')}")
  end

  def set_title
    title = "duckinator.net"
    if @location != '/' and @location.length > 0
      location = @location.chomp('/index.rhtml').chomp('/')
      location_words = location.split('/')

      i = location_words.length-1
      i-=1 until title_check(location_words, i) || i == 0
      if i > 1
        title = "#{location_words[i]} : #{location_words[0..(i-1)].join(' ')} : #{title}"
      else
        title = "#{location_words[i]} : #{title}"
      end
    end
    title
  end

  def print_page
    head = ''

    text = open(File.dirname(__FILE__) + '/template.html').read
    text.gsub!('%title%', @title)
    text.gsub!('%head%', head)
    text.gsub!('%body%', @body)
    text.gsub!('%year%', `date +'%Y'`.chomp) # ... Why wont Time.now.year work?
    puts Maruku.new(text).to_html
  end
end

