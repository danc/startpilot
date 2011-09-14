module Highslide
module_function
  def gen(destDir, base, root, path)

    dir = destDir +  base
	highslide = (root + '_includes' + base).to_s  + ".html"
    File.open(highslide, File::CREAT|File::TRUNC|File::RDWR, 0644) do |out|
        Dir.chdir(dir.to_s)
        out << '<notextile>
    <div class="highslide-gallery">
    '

        fst = true
        Dir["*.{JPG,jpeg,png,jpg}"].each do |entry|
       
          out << '<a href="/' + path + '/' + base + '/' + entry + '" class="highslide" onclick="return hs.expand(this'
          if fst 
            fst = false
            out << ', { autoplay:true }'
          end
          out << ')">
      <img src="/' + path + '/' + base + '/p/' + entry + '" alt="Highslide JS"
        title="Cliquer pour voir" />
    </a>
    '
     
      end
      out << '</div>
    </notextile>
    '

    end
	return highslide
  end
end
