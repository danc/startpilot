SET PATH=C:\startpilot\tools\imagemagick;%PATH%
rem aller dans le r�pertoire
cd %~p1
rem cr�er un sous r�pertoire www
mkdir www
rem et un sous r�pertoire p
rem mkdir www\p
rem r�duire les photos en 120 points par pouce (suffisant pour un �cran d'ordinateur) 
rem en taille 1024 pixel max, avec une qualit� jpeg 80%
for %%I in (%*) do convert   -strip  -geometry 1024x1024 -density 120 -quality 80 %%~nI.jpg www\%%~nI.jpg
rem cr�er aussi des miniatures, pour une galerie photo par exemple
rem for %%I in (%*) do convert   -thumbnail 100x100 -density 72 -quality 80 %%~nI.jpg www\p\%%~nI.jpg
