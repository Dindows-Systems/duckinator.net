require File.join(File.dirname(__FILE__), '..', 'gemfix.rb')
require 'rubygems'
require 'time'
require 'maruku'
require 'liquid'
require 'mime/types'

class HomePage
  attr_accessor :title, :location
  def call(env, theme=nil, error=nil)
    @env = env
    @location = env['PATH_INFO'] || "/"
    @original = @location
    @theme = theme || get_theme
    set_title
    @status = 200
    @content_type = "text/html"
    @preview = false
    @body = nil

    return pull if env['PATH_INFO'].gsub('/','') == 'autopull'

    if !error.nil?
      
    elsif @location[0..5] == "/rss/" && @location.length > 5
      return RSS.new(env)
    elsif @location[0..8] == "/preview/" && @location.length > 9
      @theme, @location = env['PATH_INFO'][9..-1].split("/", 2)
      @preview = true
    elsif @location[0..6] == "/theme/"
      @location = @location[7..-1]
      @location = "/themes/#{@theme}/#{@location}"
    end

    @file = "#{env['DOCUMENT_ROOT']}/#{@location}"

    if File.directory?(@file)
      # Had to use @file[-1,1] because DreamHost uses ruby 1.8 :(
      if @file[-1,1] != '/'
        # 301: Moved permanently
        return [301, { "Location" => "#{env['PATH_INFO']}/"}, ['']]
      end
      if File.file?("#{@file}/index.rb")
        @file = "#{@file}/index.rb"
      elsif File.file?("#{@file}/index.md")
        @file = "#{@file}/index.md"
      else
        # Directory exists, no index file
        # Handle this better. 404 is not correct.
        @status = 404
      end
    end

    @status = 404 if !File.exist?(@file)

    if @status != 200
      @file = "#{env['DOCUMENT_ROOT']}/../errors/#{@status}.md"
    end
    
    if @file.end_with?('.rb')
      load @file
    else
      @body = open(@file).read
    end
    page = generate_page if markdown? || ruby?
    page ||= @body
    if css?
      page.gsub!(/url\(\"\/theme\/(.*)\.jpg\"\)/, 'url("/themes/' + @theme + '/\1.jpg")')
    end
    @content_type = MIME::Types.type_for(@file) unless markdown? || ruby?

    [@status, { "Content-Type" => @content_type }, [page]]
  rescue => e
    [500, { "Content-Type" => "text/plain" }, [e.to_s]]
  end

  def css?
    @file.end_with?('.css')
  end

  def markdown?
    @file.end_with?('.md')
  end

  def ruby?
    @file.end_with?('.rb')
  end

  def generate_link(url, text)
    "<a href=\"#{url}\">#{text}</a>"
  end

  def get_theme
    'fairview_pier'
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
      'theme'       => @theme,
      'file'        => @original
    }
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
      text.gsub!('<link rel="stylesheet" href="/theme/', "<link rel=\"stylesheet\" href=\"/themes/#{@theme}/")
      text.gsub!("<link rel='stylesheet' href='/theme/", "<link rel='stylesheet' href='/themes/#{@theme}/")
      text.gsub!('<link rel="stylesheet" href="/css/', "<link rel=\"stylesheet\" href=\"/preview/#{@theme}/css/")
      text.gsub!("<link rel='stylesheet' href='/css/", "<link rel='stylesheet' href='/preview/#{@theme}/css/")
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

