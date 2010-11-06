#!/usr/bin/env ruby
#Déclarer des librairies additionnelles, placées au même niveau que le programme  principal
$LOAD_PATH.unshift( File.dirname(__FILE__)  )

load('sync.rb')
load('config.rb')

conf = Config.load
Sync.upload(conf)