require 'rubygems'
require 'cgi'
require 'time'
require 'maruku'
require 'liquid'

class HomePage
  attr_accessor :title, :location
  def initialize(env, theme=nil, location_override=nil)
    @location = env['REQUEST_URI'] || "/"
    @theme = theme || get_theme
    @title = set_title

    @body = open(env['PATH_TRANSLATED']).read

    @location_override=location_override

    cgi = CGI.new
    cgi.out { generate_page }
  end

  def get_theme
    'dark_sky'
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

  def parse_liquid(text)
    t = Liquid::Template.parse(text)
    t.render(@assigns)
  end

  def parse_maruku(text)
    maruku = Maruku.new(text)
    maruku.to_html
  end

  def generate_page
    @assigns = {
      'title'   => @title,
      'year'    => `date +'%Y'`.chomp,
      'theme'   => @theme
    }
    @body = parse_liquid(@body)
    @body = parse_maruku(@body)

    text = open(File.dirname(__FILE__) + '/template.html').read

    @assigns['content'] = @body

    text = parse_liquid(text)
    if !@location_override.nil?
      text.gsub!(/<a href='\//, "<a href='#{@location_override}/")
      text.gsub!(/<a href="\//, "<a href="#{@location_override}/")
    end
    text
  end
end

def run
  HomePage.new(ENV.clone)
end
