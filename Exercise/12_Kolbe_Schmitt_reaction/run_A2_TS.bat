set Series=A

set MOPAC2016_EXE="C:\Program Files\MOPAC\MOPAC2016.exe"
set MOPAC_EXE="C:\Program Files\MOPAC\bin\mopac.exe"

if exist %MOPAC_EXE% ( set MOPAC_EXE=%MOPAC_EXE% ) 
if exist %MOPAC2016_EXE% ( set MOPAC_EXE=%MOPAC_EXE% ) 

%MOPAC_EXE% %Series%2_TS.mop

