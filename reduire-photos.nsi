!define VERSION "1.0"
Name "StartPilot ${VERSION}"
OutFile "tm/startpilot/download/reduire-photos.exe"


InstallDir $TEMP

section
setOutPath $SENDTO
# define what to install and place it in the output path
file tools\reduire_photos.bat
sectionEnd

