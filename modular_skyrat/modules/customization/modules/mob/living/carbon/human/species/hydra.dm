/datum/species/human/hydra
	name = "hydra"
	id = "hydra"
	default_color = "4B4B4B"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAS_FLESH,HAS_BONE,HAIR)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("tail" = ACC_RANDOM, WINGS = "None", "snout" = ACC_RANDOM, "spines" = "None", "frills" = "None", "horns" = ACC_RANDOM, "body_markings" = ACC_RANDOM, "legs" = "Normal Legs")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = GROSS | MEAT | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_id = "hydra"
	var/single_mind = FALSE
	var/headnames = "[],[],[]"					//name for selected heads or just one single name then host is all three heads. Welcome to my hell.
	var/obj/item/clothing/head1 = null				//Right head
	var/obj/item/clothing/head2 = null				//Middle head
	var/obj/item/clothing/head3 = null				//Left head
	var/obj/item/clothing/mask/wear_mask1 = null	// Right mask
	var/obj/item/clothing/mask/wear_mask2 = null	// Middle mask
	var/obj/item/clothing/mask/wear_mask3 = null	// left mask
	var/obj/item/clothing/neck/wear_neck1 = null	// Right neck
	var/obj/item/clothing/neck/wear_neck2 = null	// Middle neck
	var/obj/item/clothing/neck/wear_neck3 = null	// Left neck

/datum/species/hydra/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/left_head_eye_color		//eye colour of the left head
	var/right_head_eye_color	//eye colour of the right head
	var/random = rand(1,5)

	//Choose from a variety of green or brown colors, with a darker secondary and tertiary
	switch(random)
		if(1)
			main_color = "1C0"
			second_color = "180"
		if(2)
			main_color = "5C1"
			second_color = "5A1"
		if(3)
			main_color = "7A1"
			second_color = "681"
		if(4)
			main_color = "862"
			second_color = "741"
		if(5)
			main_color = "3B1"
			second_color = "391"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = second_color
	return returned


