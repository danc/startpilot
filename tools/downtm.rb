#!/usr/bin/env ruby
# should be invoked from the path where _config.yml stand
require 'net/http'
require 'yaml'
require 'digest/md5'
require 'pathname'


def download_source(http, file, serverPath)
  puts 'telechargement de ' + serverPath  + file
  resp = http.get(serverPath  + file)
  open(file, "wb") { |f|
    f.write(resp.body)
  }
end


useproxy = false
if useproxy then
# avec proxy
# TODO read from config file
proxy_addr = 'proxy.rennes.sii.fr'
proxy_port = 3128

http = Net::HTTP::Proxy(proxy_addr, proxy_port).start('trimartolod.free.fr') 

else
# sans proxy
http = Net::HTTP.start('trimartolod.free.fr') 

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
