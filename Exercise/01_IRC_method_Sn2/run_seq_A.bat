set Series=A

set JMol_EXE=C:\jmol-14.30.2\Jmol.jar

REM mopac2016 version case
set MOPAC_EXE="C:\Program Files\MOPAC\MOPAC2016.exe"

REM open-mopac version case
REM set MOPAC_EXE="C:\Program Files\MOPAC\bin\mopac.exe"


%MOPAC_EXE% %Series%1_MEP.mop

pause

%MOPAC_EXE% %Series%2_TS.mop

type %Series%2_TS.arc | find /v "Transition States" > %Series%2_TSm.arc

%MOPAC_EXE% %Series%3_FORCE.mop

%MOPAC_EXE% %Series%4_IRC_products.mop

%JMol_EXE% %Series%4_IRC_products.xyz

%MOPAC_EXE% %Series%4_IRC_reactions.mop

%JMol_EXE% %Series%4_IRC_reactions.xyz
