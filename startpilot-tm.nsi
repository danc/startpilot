!define VERSION "0.2"
Name "StartPilot ${VERSION}"
OutFile "StartPilot Installer - ${VERSION}.exe"


InstallDir $TEMP

section
setOutPath $SENDTO
# define what to install and place it in the output path
file tools\trimartolod.bat
sectionEnd

section
# jekyll specific
setOutPath $HOME
file /r configs\config.yml
sectionEnd

section
# jekyll specific
setOutPath C:\startpilot\tm
file /r tm\*
sectionEnd

section
setOutPath C:\startpilot\tm\_site
sectionEnd

section
setOutPath C:\startpilot\tools
file tools\trimartolod_local.bat
file tools\startpilot.rb 
;file tools\startpilot.yml
file tools\upload_trimartolod.bat
file tools\uptm.rb  
file tools\article.rb  
file tools\sync.rb  
file tools\highslide.rb  
file tools\photo.rb  
file tools\config.rb  
file tools\zipper.rb
file tools\Tri_Martolod_Local.URL
sectionEnd

section
setOutPath C:\startpilot\tools
file /r tools\Notepad++Portable
; versions allégées
file /r tools\ruby
file /r tools\imagemagick
sectionEnd

section
  # create a shortcut in the start menu programs directory
  createShortCut "$SMPROGRAMS\trimartolod local.lnk" "C:\startpilot\tools\trimartolod_local.bat"
  createShortCut "$SMPROGRAMS\envoi trimartolod.lnk" "C:\startpilot\tools\upload_trimartolod.bat"
	createShortCut "$SMPROGRAMS\Notepad++Portable.lnk" "C:\startpilot\tools\Notepad++Portable\Notepad++Portable.exe"
sectionEnd

section
#ecriture de la version dans le fichier C:\startpilot\version
setOutPath C:\startpilot
fileOpen $0 "version" w
fileWrite $0 ${VERSION}
# close the file
fileClose $0
sectionEnd
