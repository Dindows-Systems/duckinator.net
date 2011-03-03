require File.join(File.dirname(__FILE__), '..', 'gemfix.rb')
require 'rubygems'
require 'time'
require 'maruku'
require 'liquid'
require 'mime/types'

class HomePage
  attr_accessor :title, :location
  def call(env, theme=nil)
    @env = env
    @location = env['PATH_INFO'] || "/"
    @theme = theme || get_theme
    set_title
    @status = 200
    @content_type = "text/html"
    @preview = false

    return pull if env['PATH_INFO'].gsub('/','') == 'autopull'

    if @location[0..8] == "/preview/" && @location.length > 9
      @theme, @location = env['PATH_INFO'][9..-1].split("/", 2)
      @preview = true
    elsif @location[0..6] == "/theme/"
      @location = @location[7..-1]
      @location = "/themes/#{@theme}/#{@location}"
    end

    @file = "#{env['DOCUMENT_ROOT']}/#{@location}"

    if File.directory?(@file)
      @file = "#{@file}/index.md"
    end
    @body = open(@file).read
    page = generate_page if markdown?
    page = generate_css  if css?
    page ||= @body
    @content_type = MIME::Types.type_for(@file) unless markdown?

    [@status, { "Content-Type" => @content_type }, [page]]
  end

  def css?
    @file[-4..-1] == ".css"
  end

  def markdown?
    @file[-3..-1] == ".md"
  end

  def generate_link(url, text)
    "<a href=\"#{url}\">#{text}</a>"
  end

  def get_theme
    'dark_sky'
  end

  def title_check (location_words, i)
    File.directory?(File.join(File.dirname(__FILE__), "..", "public", *location_words[0..i]))
  end

  def set_title
    @title = "duckinator.net"
    @breadcrumbs = generate_link('http://duckinator.net', 'duckinator.net')
    if @location != '/' and @location.length > 0
      location = @location.chomp('/index.md').chomp('/')
      location_words = location.split('/')

      i = location_words.length-1
      i-=1 until title_check(location_words, i) || i == 0
      if i >= 1
        (1..i).each do |n|
          link = location_words[0..n].join('/')
          @breadcrumbs = "#{generate_link(link, location_words[n])} : #{@breadcrumbs}"
          @title = "#{location_words[n]} : #{@title}"
        end
      end
    end
  end

  def parse_liquid(text)
    t = Liquid::Template.parse(text)
    t.render(@assigns)
  end

  def parse_maruku(text)
    maruku = Maruku.new(text)
    maruku.to_html
  end

  def preview_fix
    return "" unless @preview

    preview = <<EOF
<base href="#{@env['rack.url_scheme']}://#{@env['SERVER_NAME']}/preview/#{@theme}/">
EOF
  end

  def set_assigns
    @assigns = {
      'preview'     => preview_fix,
      'breadcrumbs' => @breadcrumbs,
      'title'       => @title,
      'year'        => `date +'%Y'`.chomp,
      'theme'       => @theme
    }
  end

  def generate_css
    set_assigns
    parse_liquid(open(@file).read)
  end

  def generate_page
    set_assigns
    @body = parse_liquid(@body)
    @body = parse_maruku(@body)

    text = open(File.dirname(__FILE__) + '/template.html').read

    @assigns['content'] = @body

    text = parse_liquid(text)
    if @preview
      text.gsub!('<a href="/', "<a href=\"/preview/#{@theme}/")
      text.gsub!("<a href='/", "<a href='/preview/#{@theme}/")
    end
    text
  end

  def pull
    text =<<EOF
<!doctype html>
<html>
  <head>
    <title>Autopull</title>
  </head>
  <body>
    Pulled from github. <a href="/autopull/log">View log</a>.
  </body>
</html>
EOF

    resp = `git pull`
    if resp.chomp != "Already up-to-date."
      File.open('public/autopull/log', 'w') do |f|
        f.write("#{Time.now}\n#{resp}")
      end
    end

    [200, { "Content-Type" => 'text/html' }, [text]]
  end
end

