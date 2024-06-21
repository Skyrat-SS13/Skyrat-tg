/*
*	LOADOUT ITEM DATUMS FOR THE MASK SLOT
*/

/// Mask Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_masks, generate_loadout_items(/datum/loadout_item/mask))

/datum/loadout_item/mask
	category = LOADOUT_ITEM_MASK

/datum/loadout_item/mask/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.mask))
		..()
		return TRUE

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.mask)
			LAZYADD(outfit.backpack_contents, outfit.mask)
		outfit.mask = item_path
	else
		outfit.mask = item_path

/*
*	BANDANAS
*/

/datum/loadout_item/mask/black_bandana
	name = "Black Bandana"
	item_path = /obj/item/clothing/mask/bandana/black

/datum/loadout_item/mask/blue_bandana
	name = "Blue Bandana"
	item_path = /obj/item/clothing/mask/bandana/blue

/datum/loadout_item/mask/gold_bandana
	name = "Gold Bandana"
	item_path = /obj/item/clothing/mask/bandana/gold

/datum/loadout_item/mask/green_bandana
	name = "Green Bandana"
	item_path = /obj/item/clothing/mask/bandana/green

/datum/loadout_item/mask/red_bandana
	name = "Red Bandana"
	item_path = /obj/item/clothing/mask/bandana/red

/datum/loadout_item/mask/skull_bandana
	name = "Skull Bandana"
	item_path = /obj/item/clothing/mask/bandana/skull

/*
*	BALACLAVAS
*/

/datum/loadout_item/mask/balaclavaadj
	name = "Adjustable Balaclava"
	item_path = /obj/item/clothing/mask/balaclavaadjust

/datum/loadout_item/mask/balaclavathree
	name = "Three-Hole Balaclava (Black)"
	item_path = /obj/item/clothing/mask/balaclava/threehole

/datum/loadout_item/mask/balaclavagreen
	name = "Three-Hole Balaclava (Green)"
	item_path = /obj/item/clothing/mask/balaclava/threehole/green

/*
*	GAS MASKS
*/

/datum/loadout_item/mask/gas_mask
	name = "Gas Mask"
	item_path = /obj/item/clothing/mask/gas

/datum/loadout_item/mask/gas_alt
	name = "Black Gas Mask"
	item_path = /obj/item/clothing/mask/gas/alt

/datum/loadout_item/mask/gas_glass
	name = "Glass Gas Mask"
	item_path = /obj/item/clothing/mask/gas/glass

/datum/loadout_item/mask/respirator
	name = "Half Mask Respirator"
	item_path = /obj/item/clothing/mask/gas/respirator

/*
*	JOB-LOCKED
*/

// Ain't a damn thing

/*
*	MASQUERADE MASKS
*/

/datum/loadout_item/mask/masquerade
	name = "Masquerade Mask"
	item_path = /obj/item/clothing/mask/masquerade

/datum/loadout_item/mask/masquerade/two_colors
	name = "Split Masquerade Mask"
	item_path = /obj/item/clothing/mask/masquerade/two_colors

/datum/loadout_item/mask/masquerade/feathered
	name = "Feathered Masquerade Mask"
	item_path = /obj/item/clothing/mask/masquerade/feathered

/datum/loadout_item/mask/masquerade/two_colors/feathered
	name = "Feathered Split Masquerade Mask"
	item_path = /obj/item/clothing/mask/masquerade/two_colors/feathered

/*
*	FAMILIES
*/

/datum/loadout_item/mask/driscoll
	name = "Driscoll Mask"
	item_path = /obj/item/clothing/mask/gas/driscoll

/*
*	MISC
*/
/datum/loadout_item/mask/surgical
	name = "Recolorable Sterile Mask"
	item_path = /obj/item/clothing/mask/surgical/greyscale

/datum/loadout_item/mask/fake_mustache
	name = "Fake Moustache"
	item_path = /obj/item/clothing/mask/fakemoustache

/datum/loadout_item/mask/pipe
	name = "Pipe"
	item_path = /obj/item/clothing/mask/cigarette/pipe

/datum/loadout_item/mask/corn_pipe
	name = "Corn Cob Pipe"
	item_path = /obj/item/clothing/mask/cigarette/pipe/cobpipe

/datum/loadout_item/mask/plague_doctor
	name = "Plague Doctor Mask"
	item_path = /obj/item/clothing/mask/gas/plaguedoctor

/datum/loadout_item/mask/monkey
	name = "Monkey Mask"
	item_path = /obj/item/clothing/mask/gas/monkeymask

/datum/loadout_item/mask/owl
	name = "Owl Mask"
	item_path = /obj/item/clothing/mask/gas/owl_mask

/datum/loadout_item/mask/joy
	name = "Joy Mask"
	item_path = /obj/item/clothing/mask/joy

/datum/loadout_item/mask/paper
	name = "Paper Mask"
	item_path = /obj/item/clothing/mask/paper

/datum/loadout_item/mask/lollipop
	name = "Lollipop"
	item_path = /obj/item/food/lollipop

/datum/loadout_item/mask/balaclava
	name = "Balaclava"
	item_path = /obj/item/clothing/mask/balaclava


/*
*	DONATOR
*/

/datum/loadout_item/mask/donator
	donator_only = TRUE


/datum/loadout_item/mask/donator/nightlight_mask/alldono
	name = "Commercial FIR-36 Rebreather"
	item_path = /obj/item/clothing/mask/gas/nightlight/alldono
