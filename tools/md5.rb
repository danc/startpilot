#!/usr/bin/env ruby

require 'digest/md5'




#l = Pathname.new(ARGV[0])
d = Digest::MD5.hexdigest( File.open(ARGV[0],"r").read )
puts d
