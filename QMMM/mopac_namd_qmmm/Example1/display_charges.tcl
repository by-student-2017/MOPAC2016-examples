
####  This can take a while!!


# PSF file with topology of QM atoms ONLY
set qmPSF "PolyAla-qm.QMonly.psf"
# Conversion file between global indices and QM indices.
set idDictFileName "PolyAla-qm.idDict.txt"

# DCD file with positions of QM atoms ONLY
set qmDCD "PolyAla_out.QMonly.dcd"
# DCD file with charge of QM atoms ONLY
set qmQDCD "PolyAla_out.qdcd"

# text file with charges on each QM atom
set chargesOutput "PolyAla_out.qm.charges.txt"

###

set fp [open "$idDictFileName" r]
set file_data [read $fp]
close $fp

set data [split $file_data "\n"]

foreach line $data {
    
    if { $line == "" } {
        continue
    }
    
    set fields [split $line]
    
    set indx [ lindex $fields 0 ]
    set ID [ lindex $fields 1 ]
    
    puts "$indx -> $ID"
    
    dict set idIndxDict $ID $indx
}

# In the charge DCD file, the X coordinate contains the global index of the atom 
# with respect to the entire simulated system, and the Y coordinate has the atom charge.

set chrgid [ mol new "$qmPSF" ]
mol addfile "$qmQDCD" type dcd waitfor all $chrgid

set qmPos [ mol new "$qmPSF" ]
mol addfile "$qmDCD" type dcd waitfor all $qmPos

set numFrames [ molinfo $qmPos get numframes ]

puts "Processing $numFrames frames"

set sel [ atomselect $chrgid all ]
set selTrg [ atomselect $qmPos all ]

set selLen [ $sel num ]
set selTrgLen [ $selTrg num ]

if { $selLen != $selTrgLen } {
    puts "Selection sizes do not match!"
}

set fileId [open $chargesOutput "w"]

set j 0
set chrgList {}

for {set i 0} {$i < $selLen } {incr i} {
    lappend chrgList 0
}

# display update on

for {set i 0} {$i < $numFrames} {incr i} {
    
    $sel frame $i
    $selTrg frame $j
    
    set atmid [ $sel get x ]
    set atmchrg [ $sel get y ]
    
    # Creates list with new atom charges...
    
    for {set atmindx 0} {$atmindx < $selLen} {incr atmindx} {
        
        set currid [ expr int( [ lindex $atmid $atmindx ] ) ]
        set currchrg [ lindex $atmchrg $atmindx ]
        set currindx [ dict get $idIndxDict $currid ]
        
        lset chrgList $currindx $currchrg
    }
    
    # Applies list to molecule
    
    $selTrg set user $chrgList
    
    # Writes charges to file
    set data [ join $chrgList "," ]
    puts $fileId "$data"
    
    # Moves display to new frame
    
    animate goto $j
#     display update
    
    incr j
}

# Modifies representation parameters
mol off $chrgid
mol modstyle 0 $qmPos Licorice
# Indicates that color of atoms should come from their Beta field
# which will be populated with partial charges below.
mol modcolor 0 $qmPos User

mol colupdate 0 $qmPos on

mol addrep $qmPos
