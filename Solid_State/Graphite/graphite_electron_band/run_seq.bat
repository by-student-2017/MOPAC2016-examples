set INPUT_FILE=graphite

set MOPAC2016_EXE="C:\Program Files\MOPAC\MOPAC2016.exe"
set MOPAC_EXE="C:\Program Files\MOPAC\bin\mopac.exe"
set MAKPOL_EXE="C:\Program Files\MOPAC\bin\mopac-mackpol.exe"
  
REM if exist %MOPAC_EXE% ( set MOPAC_EXE=%MOPAC_EXE% ) 
if exist %MOPAC2016_EXE% (
  set MOPAC_EXE=%MOPAC2016_EXE% 
  set MAKPOL_EXE=".\..\MAKPOL_F90.exe"
) 

call %MAKPOL_EXE% Make_%INPUT_FILE%.dat
call %MOPAC_EXE%  %INPUT_FILE%.mop
call .\..\bz.exe %INPUT_FILE%.brz