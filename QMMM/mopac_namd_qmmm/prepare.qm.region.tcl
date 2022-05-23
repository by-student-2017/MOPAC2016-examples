
######################################################################
######################################################################

## Documentation

######################################################################
######################################################################

# This script takes a selection of atoms from a molecular system, automatically 
# identifies QM/MM bonds and creates a PDB file with the proper values in its 
# beta (qmColumn) and occupancy (qmBondColumn) columns.
# 

# You will need to change values in the "User Defined Values" section below.
# 
# The file name given to the "qmPDB" variable will have the PDB file you should 
# give NAMD in order to run the QM/MM simulation.

# ATTENTION: For correct output, the selection of aminoacids and nucleic bases MUST
#       be made with whole residues. If you wish to only use side chains or another 
#       arbitrary set of atoms, the output will not be correct. You must change the 
#       script for your specific needs.

######################################################################
######################################################################

## User Defined Values

######################################################################
######################################################################

## Set your file names HERE

# Input PDB and PSF files:

mol new PolyAla.psf 
mol addfile PolyAla.pdb

# Output PDB and PSF files

set qmPDB "PolyAla-qm.pdb"
set qmPSF "PolyAla-qm.QMonly.psf"

# List to convert between global indices and QM indices.

set idDictFileName "PolyAla-qm.idDict.txt"

### Resets everything so we can select QM regions and QM-MM bonds
### No need to change anything here.

set sel [atomselect 0 all]

$sel set beta 0
$sel set occupancy 0

### Set you QM region(s) HERE

## QM region 1

# Only part of the protein composes QM region 1)
set seltext "(protein and resid 5 6)"
[atomselect 0 "$seltext"] set beta 1



######################################################################
######################################################################

## Processing

######################################################################
######################################################################

puts "Initializing segment and QM region loops."
set systemSegs [lsort -unique [[atomselect 0 "protein or nucleic"] get segname]]
set systemQMregs [lsort -unique [[atomselect 0 "(protein or nucleic) and beta > 0"] get beta]]

puts "Segments: $systemSegs"
puts "QM Regions: $systemQMregs"

# We cycle through all segIDs and QM regions to check for QM-MM bonds.
foreach seg $systemSegs {
    foreach qmReg $systemQMregs {
        puts "\nChecking QM region $qmReg in segment $seg"
        set qmmmm [atomselect 0 "(protein and name CA) and beta == $qmReg and segname $seg"]
        set cter [lindex [lsort -unique -integer [[atomselect 0 "segname $seg"] get resid]] end]
        set listqmmm [$qmmmm get resid]
        puts "Protein residues marked for QM this region in this segment: $listqmmm"
        
##        if { [llength $listqmmm] == 0 } { continue }
        
        list QM1bond
        list QM2bond
        
        puts "Checking N-Terminal-direction QM-MM bonds..."
        foreach resTest $listqmmm {
            if { [ lsearch $listqmmm [ expr $resTest -1 ] ] < 0 } { 
                lappend QM1bond [ expr $resTest -1 ]
            }
        }
        
        puts "Checking C-terminal-direction QM-MM bonds..."
        foreach resTest $listqmmm {
            # If the QM residue is a C terminal, the RESID + 1 won't be found
            # and the QM residue's C and O atoms will be removed from the QM region
            # for no reason, since no QM-MM bonds will be formed.
            # In this case, we just skip this QM residue and check the next.
            if { $resTest == $cter} {
#                 puts "C-terminal residue in QM region!"
                continue
            }
            if { [ lsearch $listqmmm [ expr $resTest +1 ] ] < 0 } { 
                lappend QM2bond $resTest
            }
        }
        
        puts "Making changes..."
        if {[info exists QM2bond]} {
            [atomselect 0 "name CA C and (resid $QM2bond and segname $seg)"] set occupancy 1
            [atomselect 0 "name C O and (resid $QM2bond and segname $seg)"] set beta 0
            unset QM2bond
        }
	if {[info exists QM1bond]} {
            [atomselect 0 "name CA C and (resid $QM1bond and segname $seg)"] set occupancy 1
            [atomselect 0 "name C O and (resid $QM1bond and segname $seg)"] set beta $qmReg
            unset QM1bond
        }
	


	set qmmmm [atomselect 0 "(nucleic and name P) and beta == $qmReg and segname $seg"]
        set fiveTer [lindex [lsort -unique -integer [[atomselect 0 "segname $seg"] get resid]] 0]
        set listqmmm [$qmmmm get resid]
        puts "Nucleic residues marked for QM this region in this segment: $listqmmm"
        
##        if { [llength $listqmmm] == 0 } { continue }
        
        list QM1bond
        list QM2bond
        
	puts "Checking 3'-Terminal-direction QM-MM bonds..."
        foreach resTest $listqmmm {
            if { [ lsearch $listqmmm [ expr $resTest +1 ] ] < 0 } { 
                lappend QM1bond [ expr $resTest +1 ]
            }
        }
	
        puts "Checking 5'-terminal-direction QM-MM bonds..."
        foreach resTest $listqmmm {
            # If the QM residue is a 5' terminal, the RESID - 1 won't be found
            # and the QM residue's phosphate group atoms will be removed from the QM region
            # for no reason, since no QM-MM bonds will be formed.
            # In this case, we just skip this QM residue and check the next.
            if { $resTest == $fiveTer} {
#                 puts "C-terminal residue in QM region!"
                continue
            }
            if { [ lsearch $listqmmm [ expr $resTest -1 ] ] < 0 } { 
                lappend QM2bond $resTest
            }
        }
        
        
        puts "Making changes..."
        if {[info exists QM2bond]} {
            [atomselect 0 "name C4' C5' and (resid $QM2bond and segname $seg)"] set occupancy 1
            [atomselect 0 "name P O1P O2P O5' C5' H5' H5'' and (resid $QM2bond and segname $seg)"] set beta 0
            unset QM2bond
        } 
	if {[info exists QM1bond]} {
            [atomselect 0 "name C4' C5' and (resid $QM1bond and segname $seg)"] set occupancy 1
            [atomselect 0 "name P O1P O2P O5' C5' H5' H5'' and (resid $QM1bond and segname $seg)"] set beta $qmReg
            unset QM1bond
        }
    }
}

puts "Setting atom elements"

package require topotools

topo guessatom element mass

puts "Elements guessed!"

foreach qmReg $systemQMregs {
    set qmnum [[atomselect 0 "beta == $qmReg"] num]
    set dummy [ [atomselect 0 "beta == $qmReg and occupancy > 0"] num ]
    puts "QM Region $qmReg contains $qmnum QM atoms and $dummy dummy atoms"
}

$sel writepdb $qmPDB

[ atomselect 0 "beta > 0" ] writepsf $qmPSF

set qmsel [ atomselect 0 "beta > 0" ]

set indxs [ $qmsel get index ]

set fileId [open $idDictFileName "w"]

for {set i 0} { $i < [$qmsel num] } {incr i} {
    
    set ID [lindex $indxs $i]
    
    set data "$i $ID"
    
    puts $fileId $data
}

close $fileId

quit
