/*
*	LOADOUT ITEM DATUMS FOR THE NECK SLOT
*/

/// Neck Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_necks, generate_loadout_items(/datum/loadout_item/neck))

/datum/loadout_item/neck
	category = LOADOUT_ITEM_NECK

/datum/loadout_item/neck/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK)
		if(outfit.neck)
			LAZYADD(outfit.backpack_contents, outfit.neck && !visuals_only)
		outfit.neck = item_path
	else
		outfit.neck = item_path


/*
*	SCARVES
*/

/datum/loadout_item/neck/scarf_black
	name = "Black Scarf"
	item_path = /obj/item/clothing/neck/scarf/black

/datum/loadout_item/neck/scarf_christmas
	name = "Christmas Scarf"
	item_path = /obj/item/clothing/neck/scarf/christmas

/datum/loadout_item/neck/scarf_cyan
	name = "Cyan Scarf"
	item_path = /obj/item/clothing/neck/scarf/cyan

/datum/loadout_item/neck/scarf_dark_blue
	name = "Dark Blue Scarf"
	item_path = /obj/item/clothing/neck/scarf/darkblue

/datum/loadout_item/neck/scarf_green
	name = "Green Scarf"
	item_path = /obj/item/clothing/neck/scarf/green

/datum/loadout_item/neck/scarf_pink
	name = "Pink Scarf"
	item_path = /obj/item/clothing/neck/scarf/pink

/datum/loadout_item/neck/scarf_purple
	name = "Purple Scarf"
	item_path = /obj/item/clothing/neck/scarf/purple

/datum/loadout_item/neck/scarf_red
	name = "Red Scarf"
	item_path = /obj/item/clothing/neck/scarf/red

/datum/loadout_item/neck/scarf_blue_striped
	name = "Striped Blue Scarf"
	item_path = /obj/item/clothing/neck/stripedbluescarf

/datum/loadout_item/neck/scarf_green_striped
	name = "Striped Green Scarf"
	item_path = /obj/item/clothing/neck/stripedgreenscarf

/datum/loadout_item/neck/scarf_red_striped
	name = "Striped Red Scarf"
	item_path = /obj/item/clothing/neck/stripedredscarf

/datum/loadout_item/neck/scarf_orange
	name = "Orange Scarf"
	item_path = /obj/item/clothing/neck/scarf/orange

/datum/loadout_item/neck/scarf_yellow
	name = "Yellow Scarf"
	item_path = /obj/item/clothing/neck/scarf/yellow

/datum/loadout_item/neck/scarf_white
	name = "White Scarf"
	item_path = /obj/item/clothing/neck/scarf

/datum/loadout_item/neck/scarf_zebra
	name = "Zebra Scarf"
	item_path = /obj/item/clothing/neck/scarf/zebra

/*
*	NECKTIES
*/

/datum/loadout_item/neck/necktie_black
	name = "Black Necktie"
	item_path = /obj/item/clothing/neck/tie/black

/datum/loadout_item/neck/necktie_blue
	name = "Blue Necktie"
	item_path = /obj/item/clothing/neck/tie/blue

/datum/loadout_item/neck/necktie_disco
	name = "Horrific Necktie"
	item_path = /obj/item/clothing/neck/tie/horrible

/datum/loadout_item/neck/necktie_loose
	name = "Loose Necktie"
	item_path = /obj/item/clothing/neck/tie/detective

/datum/loadout_item/neck/necktie_red
	name = "Red Necktie"
	item_path = /obj/item/clothing/neck/tie/red

/datum/loadout_item/neck/discoproper
	name = "Horrible Necktie"
	item_path = /obj/item/clothing/neck/tie/disco
	restricted_roles = list(JOB_DETECTIVE)

/*
*	COLLARS
*/

/datum/loadout_item/neck/choker
	name = "Choker"
	item_path = /obj/item/clothing/neck/human_petcollar/choker

/datum/loadout_item/neck/collar
	name = "Collar"
	item_path = /obj/item/clothing/neck/human_petcollar

/datum/loadout_item/neck/leathercollar
	name = "Leather Collar"
	item_path = /obj/item/clothing/neck/human_petcollar/leather

/datum/loadout_item/neck/cbellcollar
	name = "Cowbell Collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/cow

/datum/loadout_item/neck/bellcollar
	name = "Bell Collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/bell

/datum/loadout_item/neck/spikecollar
	name = "Spike Collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/spike

/datum/loadout_item/neck/hcollar
	name = "Holocollar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/holo

/datum/loadout_item/neck/crosscollar
	name = "Cross Collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/cross

/datum/loadout_item/neck/kinkycollar
	name = "Kinky Collar"
	item_path = /obj/item/clothing/neck/kink_collar

/*
*	PONCHOS
*/

/datum/loadout_item/neck/ponchocowboy
	name = "Green cowboy poncho"
	item_path = /obj/item/clothing/neck/cowboylea

/datum/loadout_item/neck/ranger_poncho_greyscale
	name = "Greyscale ranger poncho"
	item_path = /obj/item/clothing/neck/ranger_poncho

/*
*	GAGS
*/

/datum/loadout_item/neck/gags_cloak
	name = "Colourable Cloak"
	item_path = /obj/item/clothing/neck/cloak/colourable

/datum/loadout_item/neck/gags_veil
	name = "Colourable Veil"
	item_path = /obj/item/clothing/neck/cloak/colourable/veil

/datum/loadout_item/neck/gags_shroud
	name = "Colourable Shroud"
	item_path = /obj/item/clothing/neck/cloak/colourable/shroud

/datum/loadout_item/neck/gags_boat
	name = "Colourable Boatcloak"
	item_path = /obj/item/clothing/neck/cloak/colourable/boat

/*
*	MANTLES
*/

/datum/loadout_item/neck/mantle
	name = "Mantle"
	item_path = /obj/item/clothing/neck/mantle

/datum/loadout_item/neck/mantle_hop
	name = "Head of Personnel's Mantle"
	item_path = /obj/item/clothing/neck/mantle/hopmantle
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/neck/mantle_cmo
	name = "Chief Medical Officer's Mantle"
	item_path = /obj/item/clothing/neck/mantle/cmomantle
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/neck/mantle_rd
	name = "Research Director's Mantle"
	item_path = /obj/item/clothing/neck/mantle/rdmantle
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/neck/mantle_ce
	name = "Chief Engineer's Mantle"
	item_path = /obj/item/clothing/neck/mantle/cemantle
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/neck/mantle_hos
	name = "Head of Security's Mantle"
	item_path = /obj/item/clothing/neck/mantle/hosmantle
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/neck/mantle_bs
	name = "Blueshield's Mantle"
	item_path = /obj/item/clothing/neck/mantle/bsmantle
	restricted_roles = list(JOB_BLUESHIELD)

/datum/loadout_item/neck/mantle_cap
	name = "Captain's Mantle"
	item_path = /obj/item/clothing/neck/mantle/capmantle
	restricted_roles = list(JOB_CAPTAIN)

/*
*	MISC
*/

/datum/loadout_item/neck/stethoscope
	name = "Stethoscope"
	item_path = /obj/item/clothing/neck/stethoscope
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER,JOB_SECURITY_MEDIC)

/datum/loadout_item/neck/maid
	name = "Maid Neck Cover"
	item_path = /obj/item/clothing/neck/maid

/*
*	DONATOR
*/

/datum/loadout_item/neck/donator
	donator_only = TRUE

/datum/loadout_item/neck/donator/mantle/regal
	name = "Regal Mantle"
	item_path = /obj/item/clothing/neck/mantle/regal
