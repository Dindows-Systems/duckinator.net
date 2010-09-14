require File.join(File.dirname(__FILE__), '..', 'gemfix.rb')
require 'rubygems'
require 'time'
require 'maruku'
require 'liquid'

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

    file = env['PATH_INFO']
    if file[0..8] == "/preview/" && file.length > 9
      @theme, file = env['PATH_INFO'][9..-1].split("/", 2)
      @preview = true
    end

    file = "#{env['DOCUMENT_ROOT']}/#{file}"

    if File.directory?(file)
      file = "#{file}/index.md"
    end
    @body = open(file).read

    [@status, { "Content-Type" => @content_type }, [generate_page]]
  end

  def generate_link(url, text)
    "<a href=\"#{url}\">#{text}</a>"
  end

  def get_theme
    'dark_sky'
  end

  def title_check (location_words, i)
    File.directory?("./#{location_words[0..i].join('/')}")
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

  def generate_page
    @assigns = {
      'preview'     => preview_fix,
      'breadcrumbs' => @breadcrumbs,
      'title'       => @title,
      'year'        => `date +'%Y'`.chomp,
      'theme'       => @theme
    }
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

