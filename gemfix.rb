home = ENV['HOME']

gem_dir = "#{home}/.gems/gems"

if File.directory?(gem_dir)
  Dir.glob("#{gem_dir}/*").each do |dir|
    dir += "/lib"
    $LOAD_PATH << dir unless $LOAD_PATH.include?(dir)
  end
end
