#!/usr/bin/env ruby
# arguments : chemins complets des fichiers image à traiter pour en faire une gallerie
# on considère que le nom de la gallerie et de l'article sont le nom du répertoire contenant les images
# et que toutes les images passées en argument sont dans le même répertoire (appelé depuis click droit/Envoyer vers)

# les photos reduites seront placees en fonction des chemins decrits dans startpilot.yml
# jekyll + photo_master + année courante + nom de la gallerie (+ p pour le repertoire des miniatures)

# la gallerie highslide sera generee sous jekyll + '_includes' + nom de la gallerie .html
# le squelette de l'article sera genere sous jekyll + '_posts' + nom de la gallerie .textile
require 'date'
require 'pathname'
$LOAD_PATH.unshift( File.dirname(__FILE__)  )

load('config.rb')
load('photo.rb')
load('highslide.rb')
load('article.rb')
load('sources.rb')
conf = Config.load

# TODO tester si connexion internet en cours
#Sources.download(conf)

year = Date.today.strftime('%Y')
root = Pathname.new(conf['jekyll'])
photoRoot = conf['photo_master'] #repertoire maître des photos
destDir = root + photoRoot 
destDir.mkdir unless destDir.directory?
destDir += year
destDir.mkdir unless destDir.directory?

ARGV.each { |image|
  Photo.reduire(image, destDir, conf)
}

# genHighslide
path = photoRoot + '/' + year
base = File.basename(File.dirname(ARGV[0]))
Highslide.gen(destDir, base, root, path)

#modele article 
post = Article.gen(root, base)

if conf['start_cmd'] then
  command = conf['start_cmd'] + ' ' + conf['editor'] 
  suffix = ''
else
  command = conf['editor'] 
  suffix = ' &'
end
#help = (posts + '2010-10-10-help.textile').to_s
system(command + ' ' + post + suffix)
#system(command + ' ' + help + suffix)
