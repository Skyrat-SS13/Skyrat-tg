// --- Loadout item datums for accessories ---

/// Accessory Items (Moves overrided items to backpack)
GLOBAL_LIST_INIT(loadout_accessory, generate_loadout_items(/datum/loadout_item/accessory))

/datum/loadout_item/accessory
	category = LOADOUT_ITEM_ACCESSORY

/datum/loadout_item/accessory/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.accessory)
			LAZYADD(outfit.backpack_contents, outfit.accessory)
		outfit.accessory = item_path
	else
		outfit.accessory = item_path

/datum/loadout_item/accessory/maid_apron
	name = "Maid Apron"
	item_path = /obj/item/clothing/accessory/maidapron

/datum/loadout_item/accessory/waistcoat
	name = "Waistcoat"
	item_path = /obj/item/clothing/accessory/waistcoat

/datum/loadout_item/accessory/pocket_protector
	name = "Pocket Protector"
	item_path = /obj/item/clothing/accessory/pocketprotector

/datum/loadout_item/accessory/full_pocket_protector
	name = "Pocket Protector (Filled)"
	item_path = /obj/item/clothing/accessory/pocketprotector/full
	additional_tooltip_contents = list("CONTAINS PENS - This item contains multiple pens on spawn.")

/datum/loadout_item/accessory/ribbon
	name = "Ribbon"
	item_path = /obj/item/clothing/accessory/medal/ribbon


/* TO DO - ADD THESE
/datum/loadout_item/accessory/blue_green_armband
	name = "Blue and Green Armband"
	item_path = /obj/item/clothing/accessory/armband/hydro_cosmetic

/datum/loadout_item/accessory/brown_armband
	name = "Brown Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo_cosmetic

/datum/loadout_item/accessory/green_armband
	name = "Green Armband"
	item_path = /obj/item/clothing/accessory/armband/service_cosmetic

/datum/loadout_item/accessory/purple_armband
	name = "Purple Armband"
	item_path = /obj/item/clothing/accessory/armband/science_cosmetic

/datum/loadout_item/accessory/red_armband
	name = "Red Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy_cosmetic

/datum/loadout_item/accessory/yellow_armband
	name = "Yellow Reflective Armband"
	item_path = /obj/item/clothing/accessory/armband/engine_cosmetic

/datum/loadout_item/accessory/white_armband
	name = "White Armband"
	item_path = /obj/item/clothing/accessory/armband/med_cosmetic

/datum/loadout_item/accessory/white_blue_armband
	name = "White and Blue Armband"
	item_path = /obj/item/clothing/accessory/armband/medblue_cosmetic

/datum/loadout_item/accessory/dogtags
	name = "Name-Inscribed Dogtags"
	item_path = /obj/item/clothing/accessory/cosmetic_dogtag
	additional_tooltip_contents = list("MATCHES NAME - The name inscribed on this item matches your character's name on spawn.")

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talismin"
	item_path = /obj/item/clothing/accessory/armorless_talisman
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/armorless_skullcodpiece
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)
*/
