#!/usr/bin/env ruby
#D�clarer des librairies additionnelles, plac�es au m�me niveau que le programme  principal
$LOAD_PATH.unshift( File.dirname(__FILE__)  )

load('sync.rb')
load('config.rb')

conf = Config.load
Sync.upload(conf)