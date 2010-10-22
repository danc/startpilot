SET PATH=C:\startpilot\tools\imagemagick;C:\startpilot\tools\ruby\bin;%PATH%
SET RUBYLIB=C:\startpilot\tools\ruby\lib
rem pilote la generation de gallerie photos (path des images en argument) 
rem et d'un squelette d'article
cd C:\startpilot\tools
ruby startpilot.rb %*

rem recupere autres .textiles
rem cd C:\startpilot\tm
rem ruby C:\startpilot\tools\downtm.rb
rem lance la moulinette jekyll et le test local
cd C:\startpilot\tools
trimartolod_local.bat
