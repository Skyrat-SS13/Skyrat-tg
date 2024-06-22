/datum/loadout_category/gloves
	category_name = "Gloves"
	category_ui_icon = FA_ICON_HAND
	type_to_generate = /datum/loadout_item/gloves
	tab_order = /datum/loadout_category/head::tab_order + 8

/datum/loadout_item/gloves
	abstract_type = /datum/loadout_item/gloves

/datum/loadout_item/gloves/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(equipper.dna?.species?.outfit_important_for_life)
		if(!visuals_only)
			to_chat(equipper, "Your loadout gloves were not equipped directly due to your species outfit.")
			LAZYADD(outfit.backpack_contents, item_path)
	else
		if(loadout_placement_preference != LOADOUT_OVERRIDE_JOB && outfit.gloves)
			LAZYADD(outfit.backpack_contents, outfit.gloves)
		outfit.gloves = item_path

/datum/loadout_item/gloves/fingerless
	name = "Fingerless Gloves"
	item_path = /obj/item/clothing/gloves/fingerless

/datum/loadout_item/gloves/black
	name = "Black Gloves"
	item_path = /obj/item/clothing/gloves/color/black

/datum/loadout_item/gloves/blue
	name = "Blue Gloves"
	item_path = /obj/item/clothing/gloves/color/blue

/datum/loadout_item/gloves/brown
	name = "Brown Gloves"
	item_path = /obj/item/clothing/gloves/color/brown

/datum/loadout_item/gloves/green
	name = "Green Gloves"
	item_path = /obj/item/clothing/gloves/color/green

/datum/loadout_item/gloves/grey
	name = "Grey Gloves"
	item_path = /obj/item/clothing/gloves/color/grey

/datum/loadout_item/gloves/light_brown
	name = "Light Brown Gloves"
	item_path = /obj/item/clothing/gloves/color/light_brown

/datum/loadout_item/gloves/orange
	name = "Orange Gloves"
	item_path = /obj/item/clothing/gloves/color/orange

/datum/loadout_item/gloves/purple
	name = "Purple Gloves"
	item_path = /obj/item/clothing/gloves/color/purple

/datum/loadout_item/gloves/red
	name = "Red Gloves"
	item_path = /obj/item/clothing/gloves/color/red

/datum/loadout_item/gloves/yellow
	name = "Yellow Gloves"
	item_path = /obj/item/clothing/gloves/color/ffyellow
	additional_displayed_text = list("NON-INSULATING - This item is purely cosmetic and provide no shock insulation.")

/datum/loadout_item/gloves/white
	name = "White Gloves"
	item_path = /obj/item/clothing/gloves/color/white

/datum/loadout_item/gloves/rainbow
	name = "Rainbow Gloves"
	item_path = /obj/item/clothing/gloves/color/rainbow

/datum/loadout_item/gloves/evening
	name = "Evening Gloves"
	item_path = /obj/item/clothing/gloves/evening

/datum/loadout_item/gloves/kim
	name = "Aerostatic Gloves"
	item_path = /obj/item/clothing/gloves/kim

/datum/loadout_item/gloves/maid
	name = "Maid Arm Covers"
	item_path = /obj/item/clothing/gloves/maid

/datum/loadout_item/gloves/maid_arm_covers
	name = "Colourable Maid Arm Covers"
	item_path = /obj/item/clothing/gloves/maid_arm_covers

/datum/loadout_item/gloves/armwraps
	name = "Colourable Arm Wraps"
	item_path = /obj/item/clothing/gloves/bracer/wraps

/*
*	RINGS
*/

/datum/loadout_item/gloves/silverring
	name = "Silver Ring"
	item_path = /obj/item/clothing/gloves/ring/silver

/datum/loadout_item/gloves/goldring
	name = "Gold Ring"
	item_path = /obj/item/clothing/gloves/ring

/datum/loadout_item/gloves/diamondring
	name = "Diamond Ring"
	item_path = /obj/item/clothing/gloves/ring/diamond

/*
*	DONATOR
*/

/datum/loadout_item/gloves/military
	name = "Military Gloves"
	item_path = /obj/item/clothing/gloves/military
	donator_only = TRUE
