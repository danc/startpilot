#!/usr/bin/env ruby
# should be invoked from the path where _config.yml stands
require 'rubygems'
require 'syncftp'
require 'date'
require 'pathname'
useproxy = false
if useproxy then
# avec proxy
#TODO read from config file
	server = 'proxy.rennes.sii.fr'
	user = 'trimartolod@ftpperso.free.fr'
else
# sans proxy
	server = 'ftpperso.free.fr'
	user = 'trimartolod'

end
site = Pathname.new('_site')

year = Date.today.strftime('%Y')

puts('Mot de passe ?')
pwd = gets.chomp()
ftp = SyncFTP.new( server , :username => user , :password => pwd , :loglevel => Logger::DEBUG )
ftp.sync( :local => '_posts', :remote => 'jekyll/_posts' )
ftp.sync( :local => '_includes', :remote => 'jekyll/_includes' )

ftp.sync( :local => (site + 'articles' + year).to_s, :remote => 'articles/' + year )
ftp.sync( :local => (site + year).to_s, :remote => year )
ftp.sync( :local => (site + 'tag').to_s, :remote => 'tag' )

Dir.chdir('_site')
ftp2 = Net::FTP.new(server)
ftp2.login(user, pwd)
ftp2.putbinaryfile( 'index.html')
ftp2.putbinaryfile( '401.html')
ftp2.putbinaryfile( '404.html')
ftp2.putbinaryfile( 'atom.xml')
ftp2.close
