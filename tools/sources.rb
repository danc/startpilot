#!/usr/bin/env ruby
# should be invoked from the path where _config.yml stand
require 'net/http'
require 'yaml'
require 'digest/md5'
require 'pathname'
module Sources
module_function
def download_source(http, file, serverPath)
  puts 'telechargement de ' + serverPath  + file
  resp = http.get(serverPath  + file)
  open(file, "wb") { |f|
    f.write(resp.body)
  }
end


  def download(conf)
    Dir.chdir(conf['jekyll'])
    
    if conf['proxy_addr'] then
      # avec proxy
      proxy_addr = conf['proxy_addr']
      proxy_port = conf['proxy_port']
      http = Net::HTTP::Proxy(proxy_addr, proxy_port).start(conf['site_url']) #e.g. 'trimartolod.free.fr'
    else
      # sans proxy
      http = Net::HTTP.start(conf['site_url']) 
    end


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
end
