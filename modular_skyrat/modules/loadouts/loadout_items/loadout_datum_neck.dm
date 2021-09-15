// --- Loadout item datums for neck items ---

/// Neck Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_necks, generate_loadout_items(/datum/loadout_item/neck))

/datum/loadout_item/neck
	category = LOADOUT_ITEM_NECK

/datum/loadout_item/neck/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	outfit.neck = item_path

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
	name = "Darkblue Scarf"
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

/datum/loadout_item/neck/stethoscope
	name = "Stethoscope"
	item_path = /obj/item/clothing/neck/stethoscope


//MISC
/datum/loadout_item/neck/headphones
	name = "Headphones"
	item_path = /obj/item/clothing/ears/headphones

/datum/loadout_item/neck/choker
	name = "Choker"
	item_path = /obj/item/clothing/neck/human_petcollar/choker

/datum/loadout_item/neck/collar
	name = "Collar"
	item_path = /obj/item/clothing/neck/human_petcollar

/datum/loadout_item/neck/leathercollar
	name = "Leather collar"
	item_path = /obj/item/clothing/neck/human_petcollar/leather

/datum/loadout_item/neck/cbellcollar
	name = "Cowbell collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/cowcollar

/datum/loadout_item/neck/bellcollar
	name = "Bell collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/bellcollar

/datum/loadout_item/neck/spikecollar
	name = "Spike collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/spikecollar

/datum/loadout_item/neck/hcollar
	name = "Holocollar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/holocollar

/datum/loadout_item/neck/ponchocowboy
	name = "Green cowboy poncho"
	item_path = /obj/item/clothing/neck/cowboylea

/datum/loadout_item/neck/brownponchocowboy
	name = "Brown cowboy poncho"
	item_path = /obj/item/clothing/neck/ponchoranger

/datum/loadout_item/neck/crosscollar
	name = "Cross collar"
	item_path = /obj/item/clothing/neck/human_petcollar/locked/cross

/datum/loadout_item/neck/poly_cloak
	name = "Polychromic Cloak"
	item_path = /obj/item/clothing/neck/cloak/polychromic

/datum/loadout_item/neck/poly_veil
	name = "Polychromic Veil"
	item_path = /obj/item/clothing/neck/cloak/polychromic/veil

/datum/loadout_item/neck/poly_shroud
	name = "Polychromic Shroud"
	item_path = /obj/item/clothing/neck/cloak/polychromic/shroud

/datum/loadout_item/neck/poly_boat
	name = "Polychromic Boatcloak"
	item_path = /obj/item/clothing/neck/cloak/polychromic/boat

/datum/loadout_item/neck/stethoscope
	name = "Stethoscope"
	item_path = /obj/item/clothing/neck/stethoscope
	restricted_roles = list("Medical Doctor", "Chief Medical Officer","Security Medic")

//SCARVE

/datum/loadout_item/neck/scarf/scarf
	name = "White Scarf"
	item_path = /obj/item/clothing/neck/scarf

/datum/loadout_item/neck/scarf/blackscarf
	name = "Black scarf"
	item_path = /obj/item/clothing/neck/scarf/black

/datum/loadout_item/neck/scarf/redscarf
	name = "Red scarf"
	item_path = /obj/item/clothing/neck/scarf/red

/datum/loadout_item/neck/scarf/greenscarf
	name = "Green scarf"
	item_path = /obj/item/clothing/neck/scarf/green

/datum/loadout_item/neck/scarf/darkbluescarf
	name = "Dark blue scarf"
	item_path = /obj/item/clothing/neck/scarf/darkblue

/datum/loadout_item/neck/scarf/purplescarf
	name = "Purple scarf"
	item_path = /obj/item/clothing/neck/scarf/purple

/datum/loadout_item/neck/scarf/yellowscarf
	name = "Yellow scarf"
	item_path = /obj/item/clothing/neck/scarf/yellow

/datum/loadout_item/neck/scarf/orangescarf
	name = "Orange scarf"
	item_path = /obj/item/clothing/neck/scarf/orange

/datum/loadout_item/neck/scarf/cyanscarf
	name = "Cyan scarf"
	item_path = /obj/item/clothing/neck/scarf/cyan

/datum/loadout_item/neck/scarf/stripedredscarf
	name = "Striped red scarf"
	item_path = /obj/item/clothing/neck/stripedredscarf

/datum/loadout_item/neck/scarf/stripedbluescarf
	name = "Striped blue scarf"
	item_path = /obj/item/clothing/neck/stripedbluescarf

/datum/loadout_item/neck/scarf/stripedgreenscarf
	name = "Striped green scarf"
	item_path = /obj/item/clothing/neck/stripedgreenscarf

/datum/loadout_item/neck/bluetie
	name = "Blue tie"
	item_path = /obj/item/clothing/neck/tie/blue

/datum/loadout_item/neck/redtie
	name = "Red tie"
	item_path = /obj/item/clothing/neck/tie/red

/datum/loadout_item/neck/blacktie
	name = "Black tie"
	item_path = /obj/item/clothing/neck/tie/black

/datum/loadout_item/neck/disco
	name = "Yellow Necktie"
	item_path = /obj/item/clothing/neck/tie/horrible

/datum/loadout_item/neck/discoproper
	name = "Horrible Necktie"
	item_path = /obj/item/clothing/neck/tie/disco
	restricted_roles = list("Detective")
	restricted_desc = "Superstar Detectives"

//MANTLES

/datum/loadout_item/neck/mantle
	name = "Mantle"
	item_path = /obj/item/clothing/neck/mantle

/datum/loadout_item/neck/mantle/hopmantle
	name = "Head of Personnel's Mantle"
	item_path = /obj/item/clothing/neck/mantle/hopmantle
	restricted_roles = list("Head of Personnel")

/datum/loadout_item/neck/mantle/cmomantle
	name = "Chief Medical Officer's Mantle"
	item_path = /obj/item/clothing/neck/mantle/cmomantle
	restricted_roles = list("Chief Medical Officer")

/datum/loadout_item/neck/mantle/rdmantle
	name = "Research Director's Mantle"
	item_path = /obj/item/clothing/neck/mantle/rdmantle
	restricted_roles = list("Research Director")

/datum/loadout_item/neck/mantle/cemantle
	name = "Chief Engineer's Mantle"
	item_path = /obj/item/clothing/neck/mantle/cemantle
	restricted_roles = list("Chief Engineer")

/datum/loadout_item/neck/mantle/hosmantle
	name = "Head of Security's Mantle"
	item_path = /obj/item/clothing/neck/mantle/hosmantle
	restricted_roles = list("Head of Security")

/datum/loadout_item/neck/mantle/bsmantle
	name = "Blueshield's Mantle"
	item_path = /obj/item/clothing/neck/mantle/bsmantle
	restricted_roles = list("Blueshield")

/datum/loadout_item/neck/mantle/capmantle
	name = "Captain's Mantle"
	item_path = /obj/item/clothing/neck/mantle/capmantle
	restricted_roles = list("Captain")

//neck
/datum/loadout_item/neck/kinkycollar
	name = "Kinky collar"
	item_path = /obj/item/clothing/neck/kink_collar
