module Zipper
module_function
  def gen(post, highslide, year, destDir, base, conf)

#	zip = Pathname.new(conf['startpilot']) + ( base.to_s + '.zip')
	zip = Pathname.new(conf['startpilot']) + 'modifs.zip'
#	File.delete(zip) if File.exists?(zip)
	Zip::ZipFile.open(zip, Zip::ZipFile::CREATE) {
	  |zf|
		zf.dir.mkdir("_posts") unless zf.file.exists?("_posts")
		zf.dir.chdir("_posts")
		zf.file.open(File.basename(post), "w") { |os| os.write IO.read(post) }
		zf.dir.chdir("..")
		zf.dir.mkdir("_includes") unless zf.file.exists?("_includes")
		zf.dir.chdir("_includes")
		zf.file.open(File.basename(highslide), "w") { |os| os.write IO.read(highslide) }
		zf.dir.chdir("..")
		zf.dir.mkdir("infos_asso") unless zf.file.exists?("infos_asso")
		zf.dir.chdir("infos_asso")
		zf.dir.mkdir(year) unless zf.file.exists?(year)
		zf.dir.chdir(year)
		zf.dir.mkdir(base) unless zf.file.exists?(base)
		zf.dir.chdir(base)
		zf.dir.mkdir('p') unless zf.file.exists?('p')
		Dir.chdir(destDir + base)
		Dir['*.{jpg,jpeg,png}'].each { |image|
			bn = File.basename(image)
			zf.file.open(bn , "wb") { |os| os.write( File.open(image, 'rb').read) }
			zf.dir.chdir('p')
			zf.file.open(bn, "wb") { |os| os.write( File.open(destDir + base + 'p' + bn , 'rb').read) }
			zf.dir.chdir("..")
		}
	 }
  end
end
