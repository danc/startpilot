#!/usr/bin/env ruby
# should be invoked from the path where _config.yml stand
require 'net/http'
require 'yaml'
require 'digest/md5'
require 'pathname'
module Sync
module_function
	def download_source(http, file, serverPath)
	  puts 'telechargement de ' + serverPath  + file
	  resp = http.get(serverPath  + file)
	  open(file, "wb") { |f|
		f.write(resp.body)
	  }
	end
	
	def proxy_http(conf)
	    if conf['proxy_addr'] then
		  # avec proxy
		  proxy_addr = conf['proxy_addr']
		  proxy_port = conf['proxy_port']
		  http = Net::HTTP::Proxy(proxy_addr, proxy_port).start(conf['site_url']) #e.g. 'trimartolod.free.fr'
		else
		  # sans proxy
		  http = Net::HTTP.start(conf['site_url']) 
		end
		return http
	end


  def download(conf)
    Dir.chdir(conf['jekyll'])
    
	http = proxy_http(conf)

    resp = http.get("/jekyll/_includes/.syncftp")
    md5s = YAML.load( resp.body)

    md5s.each { | file, md5 |
      t = file.split('/')
      t.shift
      f = t.join('/')
      remoted = md5s['jekyll/' + f]
      l = Pathname.new(f)
      if l.exist? then
      d = Digest::MD5.hexdigest( l.open.read )
          if (d == remoted) then
         #puts f + ' idem ' #+  d + ' = ' + remoted 
        else
          puts f +  ' diff '#d + ' <> ' + remoted 
          download_source(http, f, '/jekyll/')
        end
      else
        puts f + ' non-existant localement'
        download_source(http, f, '/jekyll/')
      end
    }

  end
  
require 'rubygems'
require 'syncftp'
require 'date'
require 'pathname'
  def upload(conf)
	Dir.chdir(conf['jekyll'])
	if conf['proxy_addr'] then
	# avec proxy
		server = conf['proxy_addr']
		user = conf['ftp_user'] + '@' + conf['ftp_url'] #'trimartolod@ftpperso.free.fr'
	else
	# sans proxy
		server = conf['ftp_url'] #e.g. 'ftpperso.free.fr'
		user = conf['ftp_user'] #e.g. 'trimartolod'
	end
	site = Pathname.new('_site')

	year = Date.today.strftime('%Y')
	puts('Mot de passe ?')
	pwd = gets.chomp()

	ftp = SyncFTP.new( server , :username => user , :password => pwd , :passive => true, :loglevel => Logger::DEBUG )
	ftp.sync( :local => '_posts', :remote => 'jekyll/_posts' )
	ftp.sync( :local => '_includes', :remote => 'jekyll/_includes' )

	ftp.sync( :local => (site + 'articles' + year).to_s, :remote => 'articles/' + year )
	ftp.sync( :local => (site + year).to_s, :remote => year )
	ftp.sync( :local => (site + 'tag').to_s, :remote => 'tag' )

	Dir.chdir('_site')
	ftp2 = Net::FTP.new(server)

	ftp2.login(user, pwd)
	ftp2.passive = true
	ftp2.putbinaryfile( 'index.html')
	ftp2.putbinaryfile( '401.html')
	ftp2.putbinaryfile( '404.html')
	ftp2.putbinaryfile( 'atom.xml')
	ftp2.close

	
  end
end
