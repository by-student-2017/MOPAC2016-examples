set Series=F

set JMol=C:\jmol-14.30.2\Jmol.jar


"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%1_MEP.mop

pause

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%2_TS.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%3_FORCE.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_IRC_products.mop

%JMol% %Series%4_IRC_products.xyz

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_IRC_reactions.mop

%JMol% %Series%4_IRC_reactions.xyz
