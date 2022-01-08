
/obj/item/bodypart/chest/necromorph
	name = BODY_ZONE_CHEST
	desc = "It's impolite to stare at a person's chest."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "slasher_chest_m"
	max_damage = 250 //SKYRAT EDIT CHANGE: max_damage = 200
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 120
	grind_results = null
	wound_resistance = 10

/obj/item/bodypart/chest/necromorph/ubermorph
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_chest"
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART


/obj/item/bodypart/l_arm/necromorph
	name = "left arm"
	desc = "Did you know that the word 'sinister' stems originally from the \
		Latin 'sinestra' (left hand), because the left hand was supposed to \
		be possessed by the devil? This arm appears to be possessed by no \
		one though."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "slasher_l_arm"
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	//max_damage = 50 //ORIGINAL
	//max_stamina_damage = 50 //ORIGINAL
	max_damage = 60 //SKYRAT EDIT CHANGE
	max_stamina_damage = 60 //SKYRAT EDIT CHANGE
	body_zone = BODY_ZONE_L_ARM
	body_part = ARM_LEFT
	aux_zone = BODY_ZONE_PRECISE_L_HAND
	aux_layer = HANDS_PART_LAYER
	body_damage_coeff = 0.75
	held_index = 1
	px_x = -6
	px_y = 0
	can_be_disabled = TRUE

/obj/item/bodypart/r_arm/necromorph
	name = "right arm"
	desc = "Over 87% of humans are right handed. That figure is much lower \
		among humans missing their right arm."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "slasher_r_arm"
	attack_verb_continuous = list("slaps", "punches")
	attack_verb_simple = list("slap", "punch")
	//max_damage = 50 //ORIGINAL
	max_damage = 60 //SKYRAT EDIT CHANGE
	body_zone = BODY_ZONE_R_ARM
	body_part = ARM_RIGHT
	aux_zone = BODY_ZONE_PRECISE_R_HAND
	aux_layer = HANDS_PART_LAYER
	body_damage_coeff = 0.75
	held_index = 2
	px_x = 6
	px_y = 0
	//max_stamina_damage = 50 //ORIGINAL
	max_stamina_damage = 60 //SKYRAT EDIT CHANGE
	can_be_disabled = TRUE

/obj/item/bodypart/l_leg/necromorph
	name = "left leg"
	desc = "Some athletes prefer to tie their left shoelaces first for good \
		luck. In this instance, it probably would not have helped."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "slasher_l_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	//max_damage = 50 //ORIGINAL
	max_damage = 60 //SKYRAT EDIT CHANGE
	body_zone = BODY_ZONE_L_LEG
	body_part = LEG_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	//max_stamina_damage = 50 //ORIGINAL
	max_stamina_damage = 60 //SKYRAT EDIT CHANGE
	can_be_disabled = TRUE

/obj/item/bodypart/r_leg/necromorph
	name = "right leg"
	desc = "You put your right leg in, your right leg out. In, out, in, out, \
		shake it all about. And apparently then it detaches.\n\
		The hokey pokey has certainly changed a lot since space colonisation."
	// alternative spellings of 'pokey' are available
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "slasher_r_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	//max_damage = 50 //ORIGINAL
	max_damage = 60 //SKYRAT EDIT CHANGE
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	//max_stamina_damage = 50 //ORIGINAL
	max_stamina_damage = 60 //SKYRAT EDIT CHANGE
	can_be_disabled = TRUE

