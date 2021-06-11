//Human sub species helpers
#define isrobotic(A) (is_species(A,/datum/species/robotic))
#define isipc(A) (is_species(A,/datum/species/robotic/ipc))
#define issynthliz(A) (is_species(A,/datum/species/robotic/synthliz))
#define issynthanthro(A) (is_species(A,/datum/species/robotic/synthetic_mammal))
#define issynthhuman(A) (is_species(A,/datum/species/robotic/synthetic_human))

#define isvox(A) (is_species(A,/datum/species/vox))
#define ismammal(A) (is_species(A,/datum/species/mammal))
#define ispodweak(A) (is_species(A,/datum/species/pod/podweak))
#define isxenohybrid(A) (is_species(A,/datum/species/xeno))
#define isdwarf(A) (is_species(A,/datum/species/dwarf))
#define isroundstartslime(A) (is_species(A,/datum/species/jelly/roundstartslime))

#define ishorrorling(A) (istype(A, /mob/living/simple_animal/hostile/true_changeling))

#define ishumanoid(A) (is_species(A,/datum/species/humanoid))
#define isaquatic(A) (is_species(A,/datum/species/aquatic))
#define isakula(A) (is_species(A,/datum/species/akula))
