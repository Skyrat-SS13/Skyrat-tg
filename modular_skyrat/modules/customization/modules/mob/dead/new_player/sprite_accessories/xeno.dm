/datum/sprite_accessory/xenodorsal
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	generic = "Dorsal Spines"
	key = "xenodorsal"
	color_src = USE_ONE_COLOR
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/xenodorsal

/datum/sprite_accessory/xenodorsal/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/xenodorsal/standard
	name = "Standard"
	icon_state = "standard"

/datum/sprite_accessory/xenodorsal/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/xenodorsal/down
	name = "Dorsal Down"
	icon_state = "down"

/datum/sprite_accessory/xenodorsal/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	// Can hide if wearing uniform
	if(key in wearer.try_hide_mutant_parts)
		return TRUE
	if(wearer.wear_suit)
	// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE

//TAILS
/datum/sprite_accessory/tails/mammal/wagging/xeno_tail
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	name = "Xenomorph Tail"
	icon_state = "xeno"
	recommended_species = list(SPECIES_XENO)

//HEADS
/datum/sprite_accessory/xenohead
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	generic = "Caste Head"
	key = "xenohead"
	relevent_layers = list(BODY_ADJ_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/xenohead

/datum/sprite_accessory/xenohead/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/xenohead/standard
	name = "Standard"
	icon_state = "standard"

/datum/sprite_accessory/xenohead/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/xenohead/net
	name = "Nethead"
	icon_state = "net"

/datum/sprite_accessory/xenohead/warrior
	name = "Warrior"
	icon_state = "warrior"
