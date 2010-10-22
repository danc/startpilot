!define VERSION "0.0.6"
Name "StartPilot ${VERSION}"
OutFile "StartPilot TriMartolod Data - ${VERSION}.exe"


InstallDir $TEMP


section
setOutPath C:\startpilot\tm

# jekyll specific
file /r tm\*
sectionEnd

section
setOutPath C:\startpilot\tm\_site
sectionEnd

section
setOutPath C:\startpilot\tm\infos_asso\2010
sectionEnd

