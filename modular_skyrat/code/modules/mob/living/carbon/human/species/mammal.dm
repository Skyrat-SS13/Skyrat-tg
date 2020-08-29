/datum/species/mammal
	name = "Anthromorph" //Called so because the species is so much more universal than just mammals
	id = "mammal"
	default_color = "4B4B4B"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,HAIR,FACEHAIR)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("wings" = "None", "tail" = ACC_RANDOM, "snout" = ACC_RANDOM, "horns" = "None", "ears" = ACC_RANDOM, "legs" = ACC_RANDOM, "taur" = "None")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = GROSS | MEAT | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_icon = 'modular_skyrat/icons/mob/species/mammal/mammal_parts_greyscale.dmi'

/datum/species/mammal/qualifies_for_rank(rank, list/features)
	return TRUE

