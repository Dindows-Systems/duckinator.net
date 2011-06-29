#!/usr/bin/env ruby

require 'fileutils'
require 'time'
require 'liquid'
require 'yaml'
%w[filter breadcrumbs].map do |x|
  require File.join(File.dirname(__FILE__), "#{x}.rb")
end

class Renderer
  def initialize
    config_file = File.join(File.dirname(__FILE__), '..', 'dotcloud.yml')
    config_file += '.dist' unless File.file?(config_file)
    config   = YAML.parse(File.open(config_file))
    @appname = config.value.keys[0].value
    @config  = config[@appname]

    Liquid::Template.register_filter(TextFilter)
    @old_root = File.join(File.dirname(__FILE__), '..', 'public')
    @new_root = File.join(File.dirname(__FILE__), '..', 'static')
    @theme_old_root = File.join(@old_root, 'themes', @config['environment']['theme'].value)
    @theme_new_root = File.join(@new_root, 'themes', @config['environment']['theme'].value)
    @theme_dir      = File.join(@new_root, 'theme')

    @template = File.open(File.join(File.dirname(__FILE__), '..', 'template.html')) do |f|
      f.read
    end

    FileUtils.mkdir_p(@new_root)
  end

  def in_theme_dir?(file)
    file.start_with?(@theme_old_root) || file.start_with?(@theme_new_root)
  end

  def theme_dir_fix(file)
    if in_theme_dir?(file)
      file.gsub(@theme_old_root, @theme_dir).gsub(@theme_new_root, @theme_dir)
    else
      file
    end
  end

  def css?(file)
    file.end_with?('.css')
  end

  def javascript?(file)
    file.end_with?('.js')
  end

  def markdown?(file)
    file.end_with?('.md') || file.end_with?('.markdown')
  end

  def render_all
    render(@old_root)
  end

  def render(dir)
    pretty_dir = dir.gsub(@old_root, '')
    pretty_dir = '/' if pretty_dir.empty?
    puts "Entering #{pretty_dir}..."
    Dir["#{dir}/*"].map do |f|
      pretty = f.gsub(@old_root, '')
      if File.directory?(f)
        render(f)
      elsif File.file?(f)
        if markdown?(f)
          puts "Rendering #{pretty}..."
          save_static_html_file(f)
        else
          puts "Copying #{pretty}..."
          copy_to_static_file(f)
        end
      end
    end
    puts "Leaving #{pretty_dir}..."
  end

  def save_file(file, content)
    file = theme_dir_fix(file)
    FileUtils.mkdir_p(File.expand_path(File.dirname(file)))
    File.open(file, 'wb') do |f|
      f.print content
    end
  end

  def copy_to_static_file(file)
    if css?(file) || javascript?(file)
      text = generate_file(file)
    else
      text = File.open(file, 'rb') {|f| f.read }
    end
    old_file = File.join(File.expand_path(File.dirname(file)), File.basename(file))
    new_file = file.gsub(@old_root, @new_root)
    save_file(new_file, text)
  end

  def save_static_html_file(file)
    text = generate_html(file)
    old_file = File.join(File.expand_path(File.dirname(file)), File.basename(file))
    new_file = file.gsub(@old_root, @new_root).gsub(/\.(md|markdown)$/, '.html')
    save_file(new_file, text)
  end

  def generate_file(file)
    raw_text = File.open(file) {|f| f.read }
    breadcrumbs = BreadCrumbs.new(file)
    parse_liquid(raw_text, 'breadcrumbs' => breadcrumbs,
                           'title'       => @config['environment']['title'].value)
  end

  def generate_html(file)
    raw_text = File.open(file) {|f| f.read }
    breadcrumbs = BreadCrumbs.new(file)
    raw_text = parse_liquid(raw_text,  'breadcrumbs' => breadcrumbs,
                                       'title'       => @config['environment']['title'].value)
    parse_liquid(@template, 'breadcrumbs' => breadcrumbs,
                            'content'     => raw_text,
                            'title'       => @config['environment']['title'].value)
  end

  def parse_liquid(text, opts)
    t = Liquid::Template.parse(text)
    t.render(opts)
  end
end

Renderer.new.render_all
