//1st option from the Tanygin's manunscript:
#define SEMI_INTEGRATED

#define PARTIAL_PERIODIC
#define ELECTROSTATICS
#define DIPOLES
#define ROTATION
#define EXTERNAL_FORCES
#define CONSTRAINTS
#define MASS
#define EXCLUSIONS
#define COMFORCE
#define COMFIXED
#define MOLFORCES

#ifdef FFTW
#define MODES
#endif

#define BOND_VIRTUAL
#define COLLISION_DETECTION
#define LANGEVIN_PER_PARTICLE
#define ROTATION_PER_PARTICLE
#define CATALYTIC_REACTIONS

#define NEMD
#define NPT 
#define GHMC

#ifdef CUDA
#define MMM1D_GPU
#define EWALD_GPU
//2nd option from the Tanygin's manunscript:
#define BARNES_HUT
#endif

#define AREA_FORCE_GLOBAL   
#define VOLUME_FORCE   

#define TABULATED
#define LENNARD_JONES
#define LENNARD_JONES_GENERIC
#define LJGEN_SOFTCORE
#define LJCOS
#define LJCOS2
#define GAUSSIAN
#define HAT
#define LJ_ANGLE
#define GAY_BERNE
#define SMOOTH_STEP
#define HERTZIAN
#define BMHTF_NACL
#define MORSE
#define BUCKINGHAM
#define SOFT_SPHERE
#define INTER_RF
#define OVERLAPPED

#define TWIST_STACK
#define HYDROGEN_BOND

#define BOND_ANGLE
#define BOND_ANGLEDIST
#define BOND_ANGLEDIST_HARMONIC
#define BOND_ENDANGLEDIST
#define BOND_ENDANGLEDIST_HARMONIC

#define VIRTUAL_SITES_RELATIVE
#define GAUSSRANDOM
