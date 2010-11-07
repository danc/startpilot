module Config

  def load
    require 'yaml'
    conffile = ENV['HOME'] + '/startpilot.yml'
    if File.exist?(conffile) then
      #ok
    else
      # retrieve $HOME environment variable, according to the platform
      conffile =  ENV['HOME'] + '/.startpilot'
    end
    if File.exist?(conffile) then
      return YAML.load( File.open( conffile ).read )
    else
      #default values
      return { 'size' => '1024', 'jekyll' => '.', 'photo_master' => 'photos', 'editor' => 'mousepad' }
    end
  end
  
module_function :load
end
