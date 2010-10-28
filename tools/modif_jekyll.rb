# inserer dans C:\startpilot\tools\ruby\lib\ruby\gems\1.8\gems\jekyll-0.7.0\bin\jekyll
# ligne 142

  # Modification pour startpilot : prendre en compte la modification d'un article
  # et l'ajouter dans le .zip
  dw.add_observer do |*args|
    args.each { |event|
		if (File.extname(event.path) == '.textile') && (event.type == :modified) then
		require 'zip/zipfilesystem'
		t = Time.now.strftime("%Y-%m-%d %H:%M:%S")
		puts "[#{t}] zip: #{args} changed "
		fil = event.path
		Zip::ZipFile.open("C:\\startpilot\\modifs.zip", Zip::ZipFile::CREATE) {
			|zipfile|
			zipfile.mkdir("_posts") unless zipfile.file.exists?("_posts")
			fiz = File.basename(fil)
			zipfile.dir.chdir("_posts")
			zipfile.file.open( fiz, "wb") { |f| f.write( File.open(fil, "rb").read) }
		}
		end
    }
	end
	# FIN Modification pour startpilot
