!define VERSION "0.0.7"
Name "StartPilot ${VERSION}"
OutFile "StartPilot Installer - ${VERSION}.exe"


InstallDir $TEMP
;Section -Prerequisites
;imagemagick
;ruby
; SetOutPath $INSTDIR\Prerequisites
;  File "..\Prerequisites\ImageMagick-6.6.4-6-Q16-windows-dll.exe"
;  File "..\Prerequisites\rubyinstaller-1.8.7-p302.exe"
;  ExecWait "$INSTDIR\Prerequisites\ImageMagick-6.6.4-6-Q16-windows-dll.exe /SILENT "
;  ExecWait '$INSTDIR\Prerequisites\rubyinstaller-1.8.7-p302.exe /SILENT /tasks="assocfiles,modpath"'
;SectionEnd


section
setOutPath $SENDTO
# define what to install and place it in the output path
file tools\trimartolod.bat
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
file tools\startpilot.yml
file tools\upload_trimartolod.bat
file tools\uptm.rb  
file tools\article.rb  
file tools\sources.rb  
file tools\highslide.rb  
file tools\photo.rb  
file tools\config.rb  
;file tools\ejekyll.exe
file tools\Tri_Martolod_Local.URL
sectionEnd

section
setOutPath c:\startpilot\tools
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


