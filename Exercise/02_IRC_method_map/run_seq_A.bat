set Series=A

set JMol=C:\jmol-14.30.2\Jmol.jar


"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%1_MEP.mop

call run_plot_after_MEP_A.bat

pause

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%2_SADLLE.mop

REM "C:\Program Files\MOPAC\MOPAC2016.exe" %Series%3_NLLSQ.mop
"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%3_TS.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%4_FORCE.mop

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%5_IRC_products.mop

%JMol% %Series%4_IRC_products.xyz

"C:\Program Files\MOPAC\MOPAC2016.exe" %Series%5_IRC_reactions.mop

%JMol% %Series%4_IRC_reactions.xyz
