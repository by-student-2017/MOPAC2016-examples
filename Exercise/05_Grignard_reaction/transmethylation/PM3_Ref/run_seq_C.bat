set Series=C

set JMol=C:\jmol-14.30.2\Jmol.jar


"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%1_SADDLE.mop

pause

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%2_NLLSQ.mop

type %Series%2_TS.arc | find /v "Transition States" > %Series%2_TSm.arc

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%3_FORCE.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_IRC_products.mop

start %JMol% %Series%4_IRC_products.xyz

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_IRC_reactants.mop

%JMol% %Series%4_IRC_reactants.xyz
