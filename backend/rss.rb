require File.join(File.dirname(__FILE__), '..', 'gemfix.rb')
require 'rubygems'
require 'time'
require 'maruku'
require 'liquid'
require 'mime/types'

class RSS
  def set_handlers
    @@feed_handlers = {
                      'commits' => Feeds.commits,
                      'dux'     => Feeds.dux
                    }
  end

  def call(env)
    location = env['PATH_INFO'] || "/"
    status = 200
    content_type = "application/xhtml+xml"

    page = handle(location)

    [@status, { "Content-Type" => @content_type }, [page]]
  end

  def handle(location)
    feed = location[5..-1]
    if feed_handlers.include?(feed)
      handler = @@feed_handlers[feed]
      render(parse(handler.call))
#    else
#      env[''] # What in the heck was I going to put here?! Stupid power outage >:(
    end
  end
end

class Feeds
  def commits
    []
  end

  def dux
    []
  end
end
