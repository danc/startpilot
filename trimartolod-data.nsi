!define VERSION "0.0.6"
Name "StartPilot ${VERSION}"
OutFile "tm/startpilot/download/TriMartolod_Data.exe"


InstallDir $TEMP


section
setOutPath C:\startpilot\tm

# jekyll specific
file /r /x *.exe /x _site /x .git /x infos_asso tm\*
sectionEnd

section
setOutPath C:\startpilot\tm\_site
sectionEnd

section
setOutPath C:\startpilot\tm\infos_asso\2010
sectionEnd

