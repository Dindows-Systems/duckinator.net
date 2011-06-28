class BreadCrumb
  attr_accessor :name, :url
  def initialize(name, url)
    @name, @url = name, url
    @name.gsub!('_', ' ')
  end
end

class BreadCrumbs
  def initialize(file)
    @file = file
  end

  def get
    parts = @file.split('/')
    ret = []
    (1..parts.length).map do |i|
      if File.directory?(File.join(File.dirname(__FILE__), '..', 'public', *parts[0..i]))
        ret << BreadCrumb.new(parts[i], parts[0..i].join('/'))
      end
    end
    ret
  end

  alias to_liquid get
end