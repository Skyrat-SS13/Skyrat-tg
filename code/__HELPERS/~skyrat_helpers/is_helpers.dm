//Human sub species helpers
#define issynthliz(A) (is_species(A,/datum/species/synthliz))
#define isvox(A) (is_species(A,/datum/species/vox))
#define isipc(A) (is_species(A,/datum/species/ipc))
#define ismammal(A) (is_species(A,/datum/species/mammal))
#define ispodweak(A) (is_species(A,/datum/species/pod/podweak))
#define isxenohybrid(A) (is_species(A,/datum/species/xeno))
#define isdwarf(A) (is_species(A,/datum/species/dwarf))
#define isroundstartslime(A) (is_species(A,/datum/species/jelly/roundstartslime))


//  Integrated Circuits helpers
/// isnum() returns TRUE for NaN. Also, NaN != NaN. Checkmate, BYOND.
#define isnan(x) ( (x) != (x) )

#define isinf(x) (isnum((x)) && (((x) == text2num("inf")) || ((x) == text2num("-inf"))))

/// NaN isn't a number, damn it. Infinity is a problem too.
#define isnum_safe(x) ( isnum((x)) && !isnan((x)) && !isinf((x)) )
