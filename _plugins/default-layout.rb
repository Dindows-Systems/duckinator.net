# This provides the ability to specify the following in _config.yml:
#    layouts:
#      default: DEFAULT_LAYOUT_NAME
#      _posts: DEFAULT_POST_LAYOUT_NAME
#
# To use the plugin, just drop this file in _plugins, calling it
# _plugins/implicit-layout.rb, for example
#
# Based on code from: http://stackoverflow.com/questions/8490528/how-can-i-make-jekyll-use-a-layout-without-specifying-it

module Jekyll
  module Convertible
    # TODO: Find where this is already stored so it's less hacktastic
    def __get_config_yml
      @__config  ||= YAML.load(File.open(File.join(File.dirname(__FILE__), '..', '_config.yml')))
      @__layouts ||= @__config['layouts']
    end
    
    def read_yaml(base, name)
      self.content = 'lolhi'
      return
      __get_config_yml
      dir = base.split('/')[-1] # TODO: Remove hackiness :(
      
      
      self.content = File.read(File.join(base, name))
      
      if self.content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
        self.content = $POSTMATCH
        
        begin
          self.data = YAML.load($1)
          
          if @__layouts.keys.include?(dir)
            self.data['layout'] ||= @__layouts[dir]
          elsif @__layouts.keys.include?('default')
            self.data['layout'] ||= @__layouts['default']
          end
        rescue => e
          puts "YAML Exception reading #{name}: #{e.message}"
        end
      end
      
      self.data ||= {}
    end
  end
end
