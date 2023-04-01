/datum/material/dwarf_certified
	name = "generic special event material"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"
	alpha = 255

	categories = list(MAT_CATEGORY_ITEM_MATERIAL = TRUE)

	sheet_type = /obj/item/stack/dwarf_certified

	strength_modifier = 1
	integrity_modifier = 1
	armor_modifiers = list(MELEE = 1, BULLET = 1, LASER = 1, ENERGY = 1, BOMB = 1, BIO = 1, FIRE = 1, ACID = 1)

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0

	item_sound_override = null
	turf_sound_override = null

/datum/material/dwarf_certified/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	victim.gib() // I hope she explodes
	return TRUE

/obj/item/stack/dwarf_certified
	name = "generic special event sheets"
	singular_name = "generic special event sheet"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = null // maxwell.gif
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/stacks.dmi'

	inhand_icon_state = null // dk approves of me fucking up
	lefthand_file = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/stacks_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/stacks_righthand.dmi'

	merge_type = /obj/item/stack/dwarf_certified

	w_class = WEIGHT_CLASS_NORMAL
	full_w_class = WEIGHT_CLASS_BULKY

	force = 5
	throwforce = 10
	max_amount = 15
	throw_speed = 1
	throw_range = 3

	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	mats_per_unit = list(/datum/material/dwarf_certified = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified

	attack_verb_continuous = list("bashes", "batters", "bludgeons", "thrashes", "smashes")
	attack_verb_simple = list("bash", "batter", "bludgeon", "thrash", "smash")

	novariants = FALSE
