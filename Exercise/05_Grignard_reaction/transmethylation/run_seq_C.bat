set Series=C

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%1_SADDLE.mop

pause

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%2_NLLSQ.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%3_FORCE.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_IRC_products.mop

REM C:\jmol-14.30.2\Jmol.jar %Series%4_IRC_products.xyz

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_IRC_reactions.mop

REM C:\jmol-14.30.2\Jmol.jar %Series%4_IRC_reactions.xyz
