class HomePage
  attr_accessor :title, :location
  def initialize(env)
    @env = env
    @location = @env['REQUEST_URI']
    @title = set_title
  end

  def set_title
    title = "duckinator.net"
    if @location != '/' and @location.length > 0
      title = "#{title} : #{@env['REQUEST_URI'][1..-1]}"
    end
    title
  end
end
