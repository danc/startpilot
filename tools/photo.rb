module Photo
module_function

  def reduire (image, destDir, conf)
    size = (conf["size"]).to_s # nb pixels de la photo reduite
    destinationDir = destDir + File.basename(File.dirname(image))
    destinationDir.mkdir unless destinationDir.directory?
    thumb = destinationDir + 'p'
    thumb.mkdir unless thumb.directory?
    img = (destinationDir  +  File.basename(image)).to_s
    system ('convert  -geometry ' + size +'x' + size + ' -density 120 -quality 80 ' + image + ' ' + img)
    system ('convert -thumbnail 100x100 -density 72 -quality 80 ' + image + ' ' + (destinationDir + 'p' +  File.basename(image)).to_s)
  # marquage des photos
    if (copyright = conf['copyright']) then
      cmd = 'convert '+ img + ' -fill yellow -pointsize 20 -gravity SouthEast -draw "text 10,10 \'' + copyright + '\'"  ' + img
      system (cmd)
    end
  end
end
