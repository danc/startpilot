module Config
module_function 
# gestion des fichiers de config identique sous win et linux ($HOME). 
# On cherche d'abord startpilot.yml dans le répertoire courant, puis dans $HOME, puis $HOME/.startpilot


  def load
    require 'yaml'
    conffile = 'startpilot.yml'
    (conffile = ENV['HOME'] + '/startpilot.yml') unless File.exist?(conffile) 
    (conffile = ENV['HOME'] + '/.startpilot') unless File.exist?(conffile) 
    if File.exist?(conffile) then
      return YAML.load( File.open( conffile ).read )
    else
      #default values
      return { 'size' => '1024', 'jekyll' => '.', 'photo_master' => 'photos', 'editor' => 'mousepad' }
    end
  end
 

  def load_site_config(site)
    require 'yaml'
    conffile = 'startpilot.yml' + '.' + site
    (conffile = ENV['HOME'] + '/startpilot.yml' + '.' + site) unless File.exist?(conffile) 
    (conffile = ENV['HOME'] + '/.startpilot' + '.' + site) unless File.exist?(conffile) 
    if File.exist?(conffile) then
      return YAML.load( File.open( conffile ).read ).merge({'conffile', conffile })
    else
      #default values
      puts "Warning ! " + conffile + " not found, use default values instead"
      return { 'size' => '1024', 'jekyll' => '.', 'photo_master' => 'photos', 'editor' => 'mousepad' }
    end
  end 

end
