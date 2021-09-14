/datum/loadout_item/neck
	category = LOADOUT_CATEGORY_NECK

//MISC
/datum/loadout_item/neck/headphones
	name = "Headphones"
	path = /obj/item/clothing/ears/headphones

/datum/loadout_item/neck/choker
	name = "Choker"
	path = /obj/item/clothing/neck/human_petcollar/choker
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/neck/collar
	name = "Collar"
	path = /obj/item/clothing/neck/human_petcollar
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/leathercollar
	name = "Leather collar"
	path = /obj/item/clothing/neck/human_petcollar/leather
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/cbellcollar
	name = "Cowbell collar"
	path = /obj/item/clothing/neck/human_petcollar/locked/cowcollar
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/bellcollar
	name = "Bell collar"
	path = /obj/item/clothing/neck/human_petcollar/locked/bellcollar
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/spikecollar
	name = "Spike collar"
	path = /obj/item/clothing/neck/human_petcollar/locked/spikecollar

/datum/loadout_item/neck/hcollar
	name = "Holocollar"
	path = /obj/item/clothing/neck/human_petcollar/locked/holocollar

/datum/loadout_item/neck/ponchocowboy
	name = "Green cowboy poncho"
	path = /obj/item/clothing/neck/cowboylea

/datum/loadout_item/neck/brownponchocowboy
	name = "Brown cowboy poncho"
	path = /obj/item/clothing/neck/ponchoranger

/datum/loadout_item/neck/crosscollar
	name = "Cross collar"
	path = /obj/item/clothing/neck/human_petcollar/locked/cross
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/poly_cloak
	name = "Polychromic Cloak"
	path = /obj/item/clothing/neck/cloak/polychromic
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/poly_veil
	name = "Polychromic Veil"
	path = /obj/item/clothing/neck/cloak/polychromic/veil
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/poly_shroud
	name = "Polychromic Shroud"
	path = /obj/item/clothing/neck/cloak/polychromic/shroud
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/poly_boat
	name = "Polychromic Boatcloak"
	path = /obj/item/clothing/neck/cloak/polychromic/boat
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/neck/stethoscope
	name = "Stethoscope"
	path = /obj/item/clothing/neck/stethoscope
	restricted_roles = list("Medical Doctor", "Chief Medical Officer","Security Medic")

//SCARVES
/datum/loadout_item/neck/scarf
	subcategory = LOADOUT_SUBCATEGORY_NECK_SCARVES

/datum/loadout_item/neck/scarf/scarf
	name = "White Scarf"
	path = /obj/item/clothing/neck/scarf
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/neck/scarf/blackscarf
	name = "Black scarf"
	path = /obj/item/clothing/neck/scarf/black

/datum/loadout_item/neck/scarf/redscarf
	name = "Red scarf"
	path = /obj/item/clothing/neck/scarf/red

/datum/loadout_item/neck/scarf/greenscarf
	name = "Green scarf"
	path = /obj/item/clothing/neck/scarf/green

/datum/loadout_item/neck/scarf/darkbluescarf
	name = "Dark blue scarf"
	path = /obj/item/clothing/neck/scarf/darkblue

/datum/loadout_item/neck/scarf/purplescarf
	name = "Purple scarf"
	path = /obj/item/clothing/neck/scarf/purple

/datum/loadout_item/neck/scarf/yellowscarf
	name = "Yellow scarf"
	path = /obj/item/clothing/neck/scarf/yellow

/datum/loadout_item/neck/scarf/orangescarf
	name = "Orange scarf"
	path = /obj/item/clothing/neck/scarf/orange

/datum/loadout_item/neck/scarf/cyanscarf
	name = "Cyan scarf"
	path = /obj/item/clothing/neck/scarf/cyan

/datum/loadout_item/neck/scarf/stripedredscarf
	name = "Striped red scarf"
	path = /obj/item/clothing/neck/stripedredscarf

/datum/loadout_item/neck/scarf/stripedbluescarf
	name = "Striped blue scarf"
	path = /obj/item/clothing/neck/stripedbluescarf

/datum/loadout_item/neck/scarf/stripedgreenscarf
	name = "Striped green scarf"
	path = /obj/item/clothing/neck/stripedgreenscarf

//TIES
/datum/loadout_item/neck/tie
	subcategory = LOADOUT_SUBCATEGORY_NECK_TIE

/datum/loadout_item/neck/tie/bluetie
	name = "Blue tie"
	path = /obj/item/clothing/neck/tie/blue

/datum/loadout_item/neck/tie/redtie
	name = "Red tie"
	path = /obj/item/clothing/neck/tie/red

/datum/loadout_item/neck/tie/blacktie
	name = "Black tie"
	path = /obj/item/clothing/neck/tie/black

/datum/loadout_item/neck/tie/disco
	name = "Yellow Necktie"
	path = /obj/item/clothing/neck/tie/horrible

/datum/loadout_item/neck/tie/discoproper
	name = "Horrible Necktie"
	path = /obj/item/clothing/neck/tie/disco
	restricted_roles = list("Detective")
	restricted_desc = "Superstar Detectives"

//MANTLES

/datum/loadout_item/neck/mantle
	name = "Mantle"
	path = /obj/item/clothing/neck/mantle

/datum/loadout_item/neck/mantle/hopmantle
	name = "Head of Personnel's Mantle"
	path = /obj/item/clothing/neck/mantle/hopmantle
	restricted_roles = list("Head of Personnel")

/datum/loadout_item/neck/mantle/cmomantle
	name = "Chief Medical Officer's Mantle"
	path = /obj/item/clothing/neck/mantle/cmomantle
	restricted_roles = list("Chief Medical Officer")

/datum/loadout_item/neck/mantle/rdmantle
	name = "Research Director's Mantle"
	path = /obj/item/clothing/neck/mantle/rdmantle
	restricted_roles = list("Research Director")

/datum/loadout_item/neck/mantle/cemantle
	name = "Chief Engineer's Mantle"
	path = /obj/item/clothing/neck/mantle/cemantle
	restricted_roles = list("Chief Engineer")

/datum/loadout_item/neck/mantle/hosmantle
	name = "Head of Security's Mantle"
	path = /obj/item/clothing/neck/mantle/hosmantle
	restricted_roles = list("Head of Security")

/datum/loadout_item/neck/mantle/bsmantle
	name = "Blueshield's Mantle"
	path = /obj/item/clothing/neck/mantle/bsmantle
	restricted_roles = list("Blueshield")

/datum/loadout_item/neck/mantle/capmantle
	name = "Captain's Mantle"
	path = /obj/item/clothing/neck/mantle/capmantle
	restricted_roles = list("Captain")

