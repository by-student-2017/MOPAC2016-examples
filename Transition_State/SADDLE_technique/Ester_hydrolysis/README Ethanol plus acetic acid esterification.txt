These data sets show how to locate and characterize the  
transition state for the esterification reaction:
CH3-CH2-OH + CH3-COOH => C2H5-O-CO-CH3 + H2O
See: Esterification.bmp

Step 1: First, the reactants are optimized, data set:
Step 1 - Reactant ethanol plus acetic acid.mop

Step 2: The products are then optimized, data set:
Step 2 - Product ester plus water.mop

Step 3: The product is optimized using the reactant as the reference geometry, data set:
Step 3 - Product ester plus water for slope.mop

This gives rise to a product geometry on the slope 
leading up to the transition state.  Edit the ARC
file to give rise to a new data set called:
Step 3 - Product ester plus water on slope.mop  (This calculation is not run)

Step 4: The reactant is then optimized using the product geometry 
on the slope from the last calculation, data set:
Step 4 - Reactant ethanol plus acetic acid for slope.mop

This gives rise to a reactant geometry on the slope 
leading up to the transition state.  Edit the ARC
file to give rise to a new data set called:
Step 4 - Reactant ethanol plus acetic acid for slope.mop  (This calculation is not run)

Step 5: The two geometries can then be used to get in the region of the transition state.
Two strategies can be used:

(A) The geometries can be averaged using GEO_REF and TS, see data set:
Step 5a - Esterification average GEO-OPT.mop
When this is run, the resulting .new file can be used in preparing a transition state
refinement, data set:
Step 5a - Refine Esterification TS from GEO-OPT.mop

(B) The resulting geometry, together with the product geometry on
the slope, can be used in setting up a SADDLE calculation, data set:
Step 5b - Saddle for ethanol plus acetic acid.mop
The resulting geometry is very close to the transition state.  
Refinement, characterisation, and mapping of the Intrinsic Reaction Coordinate
can all be done in one job, data set:
Step 5b - Refine ethanol plus acetic acid transition state.mop

Step 6: Verify that the system is a transition state, and run the IRC, data sets:
Step 6 - FORCE from GEO-OPT.mop and
Step 6 - Force from SADDLE.mop


The AVI file shows the energy - reaction coordinate.
The xyz file is intended to be visualized using Jmol.