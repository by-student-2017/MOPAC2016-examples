set INPUT_FILE=PM6

set MOPAC2016_EXE="C:\Program Files\MOPAC\MOPAC2016.exe"
set MOPAC_EXE="C:\Program Files\MOPAC\bin\mopac.exe"
  
REM if exist %MOPAC_EXE% ( set MOPAC_EXE=%MOPAC_EXE% ) 
if exist %MOPAC2016_EXE% (
  set MOPAC_EXE=%MOPAC2016_EXE% 
) 

call %MOPAC_EXE%  %INPUT_FILE%.mop