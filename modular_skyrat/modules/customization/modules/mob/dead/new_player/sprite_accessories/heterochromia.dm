/datum/sprite_accessory/heterochromia
	name = "Heterochromia"
	key = "heterochromia"
	relevent_layers = list(BODY_FRONT_UNDER_CLOTHES)
	color_src = USE_ONE_COLOR
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/heterochromia.dmi'
	default_color = "#555555"

/datum/sprite_accessory/heterochromia/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEEYES))
		return TRUE
	return FALSE

/datum/sprite_accessory/heterochromia/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/heterochromia/human
	name = "Heterochromia (Human)"
	icon_state = "human"

/datum/sprite_accessory/heterochromia/vox
	name = "Heterochromia (Vox)"
	icon_state = "vox"

/datum/sprite_accessory/heterochromia/teshari
	name = "Heterochromia (Teshari)"
	icon_state = "teshari"
