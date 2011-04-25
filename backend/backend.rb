require File.join(File.dirname(__FILE__), '..', 'gemfix.rb')
require 'rubygems'
require 'time'
require 'maruku'
require 'liquid'
#require 'mime/types'

class HomePage
  attr_accessor :title, :location

  def initialize(theme)
    @theme = theme
    @document_root = File.join(File.dirname(__FILE__), '..', 'public')

    @assigns = {
      'preview'     => '', # Filled in later
      'breadcrumbs' => '', # Filled in later
      'title'       => '', # Filled in later
      'year'        => Time.now.year,
      'theme'       => @theme,
      'file'        => ''  # Filled in later
    }
  end

  def update
    @assigns['year']  = Time.now.year
    @assigns['theme'] = get_theme
  end

  def get_theme
    @theme # Stop-gap until yaml config is done.
#    if File.exist?(File.join(File.dirname(__FILE__), '..', 'config.yaml'))
      # Handle yaml config here
#    else
#      @theme
#    end
  end

  def call(env)
    @env = env
    @location = env['PATH_INFO'] || "/"
    @assigns['file'] = @location
    @status = 200
    @content_type = 'text/html'
    @preview = false
    $body = nil

    if @location[0..8] == '/preview/' && @location.length > 9
      @theme, @location = env['PATH_INFO'][9..-1].split("/", 2)
      @preview = true
    elsif @location[0..6] == '/theme/'
      @location = @location[7..-1]
      @location = "/themes/#{@theme}/#{@location}"
#    elsif @location[0..5] == "/rss/" && @location.length > 5
#      return RSS.new(env)
    end

    @file = "#{@document_root}/#{@location}"

    if File.directory?(@file)
      # Had to use @file[-1,1] because DreamHost uses ruby 1.8 :(
      if @file[-1,1] != '/'
        # 301: Moved permanently
        return [301, { 'Location' => "#{env['PATH_INFO']}/"}, ['']]
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
      @file = File.join(File.dirname(__FILE__), '..', 'errors', "#{@status}.md")
    end
    
    if ruby?
      load @file
    else
      $body = open(@file).read
    end

    if css?
      @content_type = 'text/css'
    elsif js?
      @content_type = 'text/javascript'
    elsif markdown? || ruby?
      page = generate_page
      @content_type = 'text/html'
    #else
    #  @content_type = MIME::Types.type_for(@file)
    end
    
    page ||= $body
    if css?
      page.gsub!(/url\(\"\/theme\/(.*)\.jpg\"\)/, 'url("/themes/' + @theme + '/\1.jpg")')
    end

    ret(nil, nil, page)
  end

  def ret(status, content_type, page)
    status ||= @status
    content_type ||= @content_type
    [status, { "Content-Type" => content_type }, [page]]
  end

  def css?
    @file.end_with?('.css') || @file.end_with?('.css.rb')
  end

  def js?
    @file.end_with?('.js') || @file.end_with?('.js.rb')
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

  def title_check (location_words, i)
    File.directory?(File.join(File.dirname(__FILE__), "..", "public", *location_words[0..i]))
  end

  def get_title
    location_words = []
    breadcrumbs = [generate_link('http://duckinator.net', 'duckinator.net')]
    if @location != '/' and @location.length > 0
      location = @location.chomp('/index.md')
      location_words = location.split('/').reject(&:nil?)
      location_words.shift

      i = location_words.length-1
      i-=1 until title_check(location_words, i) || i < 0
      location_words.map do |n|
        link = location_words[0..n].join('/')
        breadcrumbs.unshift(generate_link(link, location_words[n]))
      end
    end
    location_words << 'duckinator.net'
    breadcrumbs = breadcrumbs.join(' : ')
    title = location_words.join(' : ')
    [breadcrumbs, title]
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
    return '' unless @preview

    preview = <<EOF
<base href="#{@env['rack.url_scheme']}://#{@env['SERVER_NAME']}/preview/#{@theme}/">
EOF
  end

  def generate_page
    breadcrumbs, title = get_title
    @assigns['breadcrumbs'] = breadcrumbs
    @assigns['title'] = title
    @assigns['preview'] = preview_fix
    
    $body = parse_liquid($body)
    $body = Maruku.new($body).to_html

    text = open(File.dirname(__FILE__) + '/template.html').read

    @assigns['content'] = $body

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
end

