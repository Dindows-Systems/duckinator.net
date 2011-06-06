require 'time'
require 'redcarpet'
require 'liquid'

class HomePage
  attr_accessor :title, :location

  def initialize(theme)
    @theme = theme
    @document_root = File.join(File.dirname(__FILE__), '..', 'public')
    @server_name = nil

    @assigns = {
      'preview'     => '', # Filled in later
      'breadcrumbs' => '', # Filled in later
      'title'       => '', # Filled in later
      'year'        => Time.now.year,
      'theme'       => @theme,
      'status'      => 200,
      'file'        => ''  # Filled in later
    }

    @@content_types = {
      '.css'      => 'text/css',
      '.js'       => 'text/javascript',
      '.html'     => 'text/html',
      '.txt'      => 'text/plain',
      '.rb'       => 'text/html', # .rb is a HTML file
      '.md'       => 'text/html', # .md is a HTML file, too
      '.png'      => 'image/png',
      '.gif'      => 'image/gif',
      '.jpg'      => 'image/jpeg',
      '.jpeg'     => 'image/jpeg', # JPEG file
      '.tar'      => 'application/x-tar',   # .tar file
      '.gz'       => 'application/x-gzip',  # .gz  file (including .tar.gz)
      '.bz2'      => 'application/x-bzip2', # .bz2 file (including .tar.bz2)
      #'.img'      => 'application/x-', #???!?!?!?!?!
      '.iso'      => 'application/x-iso-9660-image', # CD .iso image
      '.appcache' => 'text/cache-manifest', # Cache manifest for HTML5 offline apps
      
      :default    => 'application/octet-stream' # Default is download
    }

    @@status_codes = {
      :information  => [100, 101],      # Informational 1xx
      :success      => (200..206).to_a, # Successful    2xx
      :redirect     => (300..307).to_a, # Redirection   3xx
      :error        => [*(400..417), *(500..505)] # Client Error 4xx, Server Error 5xx
#      :client_error => (400..417).to_a, # Client Error  4xx
#      :server_error => (500..505).to_a, # Server Error  5xx
    }
  end

  def get_content_type(file)
    type = @@content_types[File.extname(@file)]
    type ||= @@content_types[:default]
    type
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
    @server_name ||= env['SERVER_NAME']
    @url_scheme = env['rack.url_scheme']
    @location = env['PATH_INFO'] || '/'
    @assigns['file'] = @location
    @preview = false
    $body = nil
    status = 200

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
        status = 404
      end
    end

    status = 404 unless File.exist?(@file)

    # Handle errors
    if @@status_codes[:error].include?(status)
      error_file = File.join(File.dirname(__FILE__), '..', 'errors', "#{status}.md")
      if File.exist?(error_file)
        @file = error_file
      else
        @file = File.join(File.dirname(__FILE__), '..', 'errors', 'unknown.md')
      end
    end

    content_type = get_content_type(@file)

    if ruby?
      load @file
    else
      if content_type[0..4] == 'text/'
        $body = File.open(@file, 'r:UTF-8').read
      else
        $body = File.open(@file, 'rb').read
      end
    end

    update

    if markdown? || ruby?
      page = generate_page
    end
    
    page ||= $body
    if css?
      page.gsub!(/url\(\"\/theme\/(.*)\.jpg\"\)/, 'url("/themes/' + @theme + '/\1.jpg")')
    end

    ret(status, content_type, page)

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
#{e.message}
#{e.backtrace.join("\n")}
</pre>
</body>
</html>
EOF
    ret(500, 'text/html', str)
  end

  def ret(status, content_type, page)
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

  def generate_link(url, text, prefix='', postfix='')
    url = prefix + url unless url.start_with?(prefix)
    url = url + postfix unless url.end_with?(postfix)
    "<a href=\"#{url}\">#{text}</a>"
  end

  def title_check (location_words, i)
    File.directory?(File.join(File.dirname(__FILE__), "..", "public", *location_words[0..i]))
  end

  def get_title
    location_words = []
    breadcrumbs = [generate_link('/', 'duckinator.net')]
    if @location != '/' and @location.length > 0
      location = @location.chomp('/index.md')
      location_words = location.split('/').reject(&:nil?)
      location_words.shift

      i = location_words.length-1
      i-=1 until title_check(location_words, i) || i < 0
      i+=1 # Temporary fix...This needs a bit more cleaning
      i.times do |n|
        link = location_words[0..n].join('/')
        breadcrumbs.unshift(generate_link(link, location_words[n], '/', '/'))
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

  def parse_markup(text)
    parser = Redcarpet.new(text, :smart, :hard_wrap, :tables, :fenced_code, :strikethrough, :lax_htmlblock, :no_intraemphasis)
    parser.to_html
  end

  def preview_fix
    return '' unless @preview

    preview = <<EOF
<base href="#{@url_scheme}://#{@server_name}/preview/#{@theme}/">
EOF
  end

  def generate_page
    breadcrumbs, title = get_title
    @assigns['breadcrumbs'] = breadcrumbs
    @assigns['title'] = title
    @assigns['preview'] = preview_fix
    
    $body = parse_liquid($body)
    $body = parse_markup($body)

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

