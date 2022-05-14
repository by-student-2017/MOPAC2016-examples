set Series=F

set JMol_EXE=C:\jmol-14.30.2\Jmol.jar

set MOPAC2016_EXE="C:\Program Files\MOPAC\MOPAC2016.exe"
set MOPAC_EXE="C:\Program Files\MOPAC\bin\mopac.exe"

REM if exist %MOPAC_EXE% ( set MOPAC_EXE=%MOPAC_EXE% ) 
if exist %MOPAC2016_EXE% ( set MOPAC_EXE=%MOPAC2016_EXE% ) 


%MOPAC_EXE%  %Series%1_MEP.mop

pause

%MOPAC_EXE%  %Series%2_TS.mop

%MOPAC_EXE%  %Series%3_FORCE.mop

%MOPAC_EXE%  %Series%4_IRC_products.mop

start %JMol_EXE% %Series%4_IRC_products.xyz

%MOPAC_EXE%  %Series%4_IRC_reactants.mop

%JMol_EXE% %Series%4_IRC_reactants.xyz
