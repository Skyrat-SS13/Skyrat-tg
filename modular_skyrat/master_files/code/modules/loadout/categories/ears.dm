/datum/loadout_category/ears
	category_name = "Ears"
	category_ui_icon = FA_ICON_EAR_LISTEN
	type_to_generate = /datum/loadout_item/ears
	tab_order = /datum/loadout_category/head::tab_order + 7

/datum/loadout_item/ears
	abstract_type = /datum/loadout_item/ears

/datum/loadout_item/ears/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.ears)
		LAZYADD(outfit.backpack_contents, outfit.ears)
	outfit.ears = item_path

/datum/loadout_item/ears/headphones
	name = "Headphones"
	item_path = /obj/item/instrument/piano_synth/headphones

/datum/loadout_item/ears/earmuffs
	name = "Earmuffs"
	item_path = /obj/item/clothing/ears/earmuffs
