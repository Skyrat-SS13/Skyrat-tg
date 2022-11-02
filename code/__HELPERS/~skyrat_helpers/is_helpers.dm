//Robots
#define isrobotic(A) (is_species(A,/datum/species/robotic))
#define isipc(A) (is_species(A,/datum/species/robotic/ipc))
#define issynthliz(A) (is_species(A,/datum/species/robotic/synthliz))
#define issynthanthro(A) (is_species(A,/datum/species/robotic/synthetic_mammal))
#define issynthhuman(A) (is_species(A,/datum/species/robotic/synthetic_human))
//Actual Species
#define isvox(A) (is_species(A,/datum/species/vox))
#define isvoxprimalis(A) (is_species(A,/datum/species/vox_primalis))
#define ispodweak(A) (is_species(A,/datum/species/pod/podweak))
#define isxenohybrid(A) (is_species(A,/datum/species/xeno))
#define isdwarf(A) (is_species(A,/datum/species/dwarf))
#define isroundstartslime(A) (is_species(A,/datum/species/jelly/roundstartslime))
#define istajaran(A) (is_species(A,/datum/species/tajaran))
#define isghoul(A) (is_species(A,/datum/species/ghoul))
#define isakula(A) (is_species(A,/datum/species/akula))
#define isskrell(A) (is_species(A,/datum/species/skell)) //SKRELL GANG SKRELL GANG
#define isunathi(A) (is_species(A,/datum/species/unathi))
#define isvulpkanin(A) (is_species(A,/datum/species/vulpkanin))
#define isteshari(A) (is_species(A, /datum/species/teshari))
#define ishemophage(A) (is_species(A, /datum/species/hemophage))
#define issnail(A) (is_species(A, /datum/species/snail))
//Antags
#define ishorrorling(A) (istype(A, /mob/living/simple_animal/hostile/true_changeling))
#define iscorticalborer(A) (istype(A, /mob/living/basic/cortical_borer))
#define ismutant(A) (is_species(A, /datum/species/mutant))
//Customisation bases
#define isaquatic(A) (is_species(A,/datum/species/aquatic))
#define ishumanoid(A) (is_species(A,/datum/species/humanoid))
#define ismammal(A) (is_species(A,/datum/species/mammal))
#define isinsect(A) (is_species(A,/datum/species/insect))
#define isfeline(A) (isfelinid(A) || istajaran(A) || HAS_TRAIT(A, TRAIT_FELINE))

// Xen mobs
#define isxenmob(A) (istype(A, /mob/living/simple_animal/hostile/blackmesa/xen))
