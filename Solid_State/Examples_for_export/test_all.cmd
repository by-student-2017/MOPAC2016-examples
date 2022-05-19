rm *.out *.html *.mop *.arc *.pdb *.txt make* *.log >nul 2>&1
copy "keywords for MAKPOL.dat" "keywords for MAKPOL.txt"
call test.cmd "A triclinic unit cell (BELWAQ)"
call test.cmd "bis(Dihydroxybenzoato)-di-silver(i) (KAMTUN)"
call test.cmd "bis(Dihydroxypropan-2-one)-diaqua-dichloro-bis(1,3-dihydroxypropan-2-one)-di-calcium dichloride (NADQEP)"
call test.cmd "convert MERS=(10,2,2) to MERS=(2,2,10)"
call test.cmd "Diamond"
call test.cmd "Dicyano dibromo cyclohexane (YOXGOH)"
call test.cmd "Ethylenediammonium pentafluoro-oxo-vanadium (ENDFVO)"
call test.cmd "From cif file 2206537"
call test.cmd "Graphite (3,5,5) for MAKPOL"
call test.cmd "Hexaiodobenzene_(HIBENZ11)"
call test.cmd "Kalicinite (KHCO3)"
call test.cmd "PDB file containing CRYST1"
call test.cmd "Polyethylene without hydrogen atoms"
call test.cmd "re-size diamond BCC"
call test.cmd "rutile (TiO2)"
call test.cmd "Urea"
call test.cmd "Using translation distances only"
