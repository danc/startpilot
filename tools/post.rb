#!/usr/bin/env ruby
#       post.rb
#       
#       Copyright 2010 Daniel <danc@no-log.org>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.
require 'pathname'
$LOAD_PATH.unshift( File.dirname(__FILE__)  )

load('config.rb')
load('article.rb')

home =  ENV['HOME']
case ARGV.length
    when 2
        site = ARGV[0]
        base = ARGV[1]
    when 1
        site = "tm"
        base = ARGV[0]
    else
	puts "Usage : post.rb [tm| <other site>] titre"
	exit
end

#Si on precise le site, on charge sa config directement
if (ARGV.length == 2) then
  conf = Config.load_site_config(site)
else
  conf = Config.load # default current site
end
root = Pathname.new(conf['jekyll'])

puts root
post = Article.today(root, base)
if (conf['editor']) then
  if conf['start_cmd'] then
    command = conf['start_cmd'] + ' ' + conf['editor'] 
    suffix = ''
  else
    command = conf['editor'] 
    suffix = ' &'
  end

 system(command + " " + post + suffix)
else
  if (ed = ENV['VISUAL']) then
   system(ed + " " + post)
  end
end

