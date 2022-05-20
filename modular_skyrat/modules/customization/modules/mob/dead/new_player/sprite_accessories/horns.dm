/datum/sprite_accessory/horns
	key = "horns"
	generic = "Horns"
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/horns.dmi'
	default_color = "#555555"
	genetic = TRUE

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		return TRUE
	return FALSE

/datum/sprite_accessory/horns/angler
	default_color = DEFAULT_SECONDARY

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"

/datum/sprite_accessory/horns/uni
	name = "Uni"
	icon_state = "uni"

/datum/sprite_accessory/horns/oni
	name = "Oni"
	icon_state = "oni"

/datum/sprite_accessory/horns/oni_large
	name = "Oni (Large)"
	icon_state = "oni_large"

/datum/sprite_accessory/horns/big
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/horns_big.dmi'

/datum/sprite_accessory/horns/big/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/horns/broken
	name = "Broken"
	icon_state = "broken"

/datum/sprite_accessory/horns/broken_right
	name = "Broken(right)"
	icon_state = "rbroken"

/datum/sprite_accessory/horns/broken_left
	name = "Broken(left)"
	icon_state = "lbroken"

/datum/sprite_accessory/horns/dragon
	name = "Dragon"
	icon_state = "dragon"

/datum/sprite_accessory/horns/lifted
	name = "Lifted"
	icon_state = "lifted"

/datum/sprite_accessory/horns/curly
	name = "Curly"
	icon_state = "newcurly"

/datum/sprite_accessory/horns/upwards
	name = "Upwards"
	icon_state = "upwardshorns"
