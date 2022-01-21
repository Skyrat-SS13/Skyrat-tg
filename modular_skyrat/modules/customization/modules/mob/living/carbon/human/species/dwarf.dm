/datum/species/dwarf
	name = "Dwarf"
	id = SPECIES_DWARF
	limbs_id = SPECIES_HUMAN
	default_color = "#FFFFFF"
	say_mod = "bellows"
	species_traits = list(
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		HAS_FLESH,
		HAS_BONE
	)
	inherent_traits = list(
		TRAIT_DWARF,TRAIT_SNOB,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP
	)
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 0.75
	liked_food = ALCOHOL | MEAT | DAIRY //Dwarves like alcohol, meat, and dairy products.
	disliked_food = JUNKFOOD | FRIED | CLOTH //Dwarves hate foods that have no nutrition other than alcohol.
	species_language_holder = /datum/language_holder/dwarf
	learnable_languages = list(/datum/language/common, /datum/language/dwarf)
