# Parameter file for simulating a two component sphere with lipids of
# different lengths at fixed box size and temperature.
#
#
# To run this file use $ESPRESSO_SOURCE/$PLATFORM/Espresso ./scripts/main.tcl 3-4sphere.tcl
#

# For more information about the simulation model on which this simulation is based see the following reference
# 
#  Cooke, I. R., Kremer, K. and Deserno, M.(2005): Efficient,
# tuneable, generic model for fluid bilayer
# membranes. Phys. Rev. E. (to appear) also see cond-mat/0502418
#

::mmsg::send [namespace current] "loading parameter file .. " nonewline
flush stdout

# Set a bunch of default parameters.
set warmup_temp 0
set warmsteps 100
set warmtimes 20
set free_warmsteps 0 
set free_warmtimes 0 
set area_lipid 1.29
set startj 0    
set startk 0
set startmdtime 0
set npt off


# Specify the name of the job <ident> the location of forcetables and
# the output and scripts directories
set ident "3-4sphere"
set tabledir "./forcetables/"
set outputdir "./$ident/"
set topofile "$ident.top"

# Espresso Special Parameters #
setmd max_num_cells 2744

# Specify how we want to use vmd for visualization allowable values
# are "interactive" "offline" "none".  interactive rarely works
set use_vmd "offline"

# --- Specify a global key for molecule types -----#

# Here we specify two different lipid types. Both have head bead type
# 0 but one has tail beads of type 1 and the other has tail beads of
# type 2.  Note that the bonding interactions are also different and
# the lengths of the two lipids are also different.  In both cases
# consecutive atoms are bonded by FENE (type 0 ) but the bending
# interactions are different (type 1 and 2 respectively).  See the
# specification of bonded interactions later in this file.
set moltypes [list { 0 lipid { 0 1 1 1 } { 0 1 } } { 1 lipid { 0 2 2 } { 0 2 } }  ]

# --- Specify the system geometry and composition ----#
# Set the geometry to a sphere
set geometry { geometry sphere }

# In this line we specify that we wand 500 molecules of type 0 and 500
# of type 1
set n_molslist { n_molslist {  { 0 500 } { 1 500 } } }

# Now bundle the above info into a list
lappend spherespec $geometry
lappend spherespec $n_molslist

set setbox_l  { 40.0 40.0 40.0 }

# Now group the spherespec with other specs into a list of such systems (we can have multiple systems if we like)
lappend system_specs $spherespec

# Warmup parameters
#----------------------------------------------------------#
set warm_time_step 0.002

set free_warmsteps 0
set free_warmtimes 1 

# ------ Integration parameters -----------------#
set main_time_step 0.01
set verlet_skin 0.4
set langevin_gamma 1.0
set systemtemp 1.1

# The number of steps to integrate with each call to integrate
set int_steps   1000
# The number of times to call integrate
set int_n_times 100
# Write a configuration file every <write_frequency> calls to
# integrate
set write_frequency 10
# Write results to analysis files every <analysis_write_frequency>
# calls to integrate
set analysis_write_frequency 1

# Bonded and bending Potentials
#----------------------------------------------------------#
set hb_parms  [list  Harm_bend 10  4.0 ]
set hb_parms2  [list  Harm_bend 1  4.0 ]
set fene_parms { FENE 30 1.5 }

lappend bonded_parms $fene_parms
lappend bonded_parms $hb_parms
lappend bonded_parms $hb_parms2


# Non Bonded Potentials 
# Here we specify the full interaction matrix which should be
#
#  00  01  12  
#      11  12  
#          22  
#
# Since 00 , 01 and 12 are all the same repulsive lennard jones we use
lappend nb_interactions [list 0 0 tabulated 9_095_11.tab ]
lappend nb_interactions [list 0 1 tabulated 9_095_11.tab ]
lappend nb_interactions [list 0 2 tabulated 9_095_11.tab ]

# Then we specify the interactions of bead type 1 with other tail
# beads.  Note that the cross term (23) has a smaller c value
# (potential width) which gives rise to a line tension.
lappend nb_interactions [list 1 1 tabulated n9_c160_22.tab ]
lappend nb_interactions [list 1 2 tabulated n9_c140_23.tab ]

# And finally the interaction of tail beads type 2 with themselves
lappend nb_interactions [list 2 2 tabulated n9_c160_22.tab ]

# We also need to make a list of all the forcetable filenames so that
# the forcetables can be copied to the working directory.

lappend tablenames 9_095_11.tab 
lappend tablenames n9_c160_22.tab 
lappend tablenames n9_c140_23.tab 



# Analysis Parameters
#----------------------------------------------------------# 

#Set the size of the 2d grid for calculating the membrane height
#function.  Used to calculate stray lipids lipid flip-flip rates and
#for fluctuation analyses
set mgrid 8

# Distance from the bilayer beyond which a lipid is considered to be
# stray
set stray_cut_off 3

# Use these flags to specify which observables to calculate during the
# simulation.  Values are calculated after every call to the espresso
# integrate command and written to files like
# time_vs_parametername. See the module ::std_analysis for more
# details
lappend analysis_flags { pressure_calc  0 1 }
lappend analysis_flags { pik1_calc  0 1 }
lappend analysis_flags { box_len_calc  0 1}
lappend analysis_flags { flipflop_calc  0 1}
lappend analysis_flags { energy_calc  0 1}
lappend analysis_flags { orient_order_calc  0 1}

# It is not recommended to include fluctuation calculations during the
# simulation since they will crash if a hole appears in the membrane

#lappend analysis_flags { fluctuation_calc 1 1}

::mmsg::send [namespace current] "done"

















