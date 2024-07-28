/**
* Wings!
*
* When adding or making new wing sprites, try to use matrixed colors!
* You can find a color palette to work with in modular_skyrat\modules\customization\icons\mob\sprite_accessory\wings.dmi as 'colorpalette matrixcolors'
* Check some of the wings that make use of them for examples on how to make it look decent.
*/
/datum/sprite_accessory/wings
	icon = 'icons/mob/human/species/wings.dmi'
	generic = "Wings"
	key = "wings"
	color_src = USE_ONE_COLOR
	recommended_species = list(SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_LIZARD, SPECIES_MAMMAL)
	organ_type = /obj/item/organ/external/wings
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
	genetic = TRUE

/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	// Can hide if wearing uniform
	if(initial(key) in wearer.try_hide_mutant_parts) // initial because some of the wing types have different keys (wings_functional, wings_open, etc)
		return TRUE
	if(wearer.wear_suit)
	// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE
	// Hide accessory if flagged to do so, taking species exceptions in account
		else if((wearer.wear_suit.flags_inv & HIDEJUMPSUIT) \
				&& (!wearer.wear_suit.species_exception \
				|| !is_type_in_list(wearer.dna.species, wearer.wear_suit.species_exception)) \
			)
			return TRUE

	return FALSE

/datum/bodypart_overlay/mutant/wings/can_draw_on_bodypart(mob/living/carbon/human/wearer, ignore_suit = FALSE)
	if(!wearer.w_uniform && !wearer.wear_suit)
		return ..()

	// Can hide if wearing uniform
	if(feature_key in wearer.try_hide_mutant_parts)
		return FALSE

	if(!ignore_suit && wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return TRUE

		// Hide accessory if flagged to do so, taking species exceptions in account
		else if((wearer.wear_suit.flags_inv & HIDEJUMPSUIT) \
				&& (!wearer.wear_suit.species_exception \
				|| !is_type_in_list(src, wearer.wear_suit.species_exception)) \
			)
			return FALSE

	return TRUE

/datum/sprite_accessory/wings/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE

/*
*	FLIGHT POTION WINGS
*/

/datum/sprite_accessory/wings/angel
	color_src = USE_ONE_COLOR
	default_color = "#FFFFFF"
	locked = FALSE

/datum/sprite_accessory/wings/fly
	key = "wings_functional"

/datum/sprite_accessory/wings/megamoth
	color_src = USE_ONE_COLOR
	default_color = "#FFFFFF"
	key = "wings_functional"

/datum/sprite_accessory/wings/mothra
	key = "wings_functional"

/datum/sprite_accessory/wings/robotic
	locked = FALSE

/datum/sprite_accessory/wings/skeleton
	key = "wings_functional"

/datum/sprite_accessory/wings/dragon
	color_src = USE_ONE_COLOR
	locked = FALSE


/datum/sprite_accessory/wings_open
	key = "wings_open"
	color_src = USE_ONE_COLOR


/datum/sprite_accessory/wings_open/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	// Can hide if wearing uniform
	if(key in wearer.try_hide_mutant_parts)
		return TRUE
	if(wearer.wear_suit)
	// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE
	// Hide accessory if flagged to do so, taking species exceptions in account
		else if((wearer.wear_suit.flags_inv & HIDEJUMPSUIT) \
				&& (!wearer.wear_suit.species_exception \
				|| !is_type_in_list(wearer.dna.species, wearer.wear_suit.species_exception)) \
			)
			return TRUE

	return FALSE

/*
*	MAMMAL
*/

/datum/sprite_accessory/wings/mammal
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	default_color = DEFAULT_PRIMARY
	recommended_species = list(SPECIES_MAMMAL, SPECIES_LIZARD, SPECIES_INSECT)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/mammal/bat //TODO: port my sprite from hyper for this one
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/wings/mammal/bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/wings/mammal/beetle
	name = "Beetle"
	icon_state = "beetle"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/dragon
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/dragon/alt1
	name = "Dragon (Alt 1)"
	icon_state = "dragonalt1"

/datum/sprite_accessory/wings/mammal/dragon/alt2
	name = "Dragon (Alt 2)"
	icon_state = "dragonalt2"

/datum/sprite_accessory/wings/mammal/dragon/synth
	name = "Dragon (Synthetic)"
	icon_state = "dragonsynth"
	genetic = FALSE

/datum/sprite_accessory/wings/mammal/dragon/mechanical
	name = "Dragon (Mechanical)"
	icon_state = "robowing"

/datum/sprite_accessory/wings/mammal/fairy
	name = "Fairy"
	icon_state = "fairy"

/datum/sprite_accessory/wings/mammal/feathery
	name = "Feathery"
	icon_state = "feathery"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/feathery/alt1
	name = "Feathery (Alt 1)"
	icon_state = "featheryalt1"

/datum/sprite_accessory/wings/mammal/feathery/alt2
	name = "Feathery (Alt 2)"
	icon_state = "featheryalt2"

/datum/sprite_accessory/wings/mammal/harpy
	name = "Harpy"
	icon_state = "harpy"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/harpy
	name = "Harpy (Top)"
	icon_state = "harpy_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/harpy/alt
	name = "Harpy (Alt)"
	icon_state = "harpyalt"

/datum/sprite_accessory/wings/mammal/harpy/alt/fluffless
	name = "Harpy (Alt - Fluffless)"
	icon_state = "harpyalt_fluffless"

/datum/sprite_accessory/wings/mammal/harpy/bat
	name = "Harpy (Bat)"
	icon_state = "harpybat"

/datum/sprite_accessory/wings/mammal/top/harpy/alt
	name = "Harpy (Top - Alt)"
	icon_state = "harpyalt_top"

/datum/sprite_accessory/wings/mammal/top/harpy/alt/fluffless
	name = "Harpy (Top - Alt - Fluffless)"
	icon_state = "harpyalt_fluffless_top"

/datum/sprite_accessory/wings/mammal/top/harpy/bat
	name = "Harpy (Top - Bat)"
	icon_state = "harpybat_top"

/datum/sprite_accessory/wings/mammal/pterodactyl
	name = "Pterodactyl"
	icon_state = "pterodactyl"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/insect
	name = "Insectoid"
	icon_state = "insect"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/mini
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/mini/bat
	name = "Mini-Bat"
	icon_state = "minibat"

/datum/sprite_accessory/wings/mammal/mini/feather
	name = "Mini-Feathery"
	icon_state = "minifeather"

/datum/sprite_accessory/wings/mammal/spider
	name = "Spider Legs"
	icon_state = "spider_legs"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/succubus
	name = "Succubus"
	icon_state = "succubus"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/tiny
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/tiny/bat
	name = "Tiny-Bat"
	icon_state = "tinybat"

/datum/sprite_accessory/wings/mammal/tiny/feather
	name = "Tiny-Feathery"
	icon_state = "tinyfeather"

/*
*	LOW WINGS
*/

/datum/sprite_accessory/wings/low_wings
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings"
	icon_state = "low"
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/low_wings/top
	name = "Low Wings (Top)"
	icon_state = "low_top"

/datum/sprite_accessory/wings/low_wings/tri
	name = "Low Wings (Tri-Tone)"
	icon_state = "low_tri"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/low_wings/tri/top
	name = "Low Wings (Tri-Tone - Top)"
	icon_state = "low_tri_top"

/datum/sprite_accessory/wings/low_wings/jewel
	name = "Low Wings Jeweled"
	icon_state = "low_jewel"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/low_wings/jewel/top
	name = "Low Wings Jeweled (Top)"
	icon_state = "low_jewel_top"

/*
*	MOTH
*/

/datum/sprite_accessory/wings/moth
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/moth_wings.dmi' // Needs new icon to suit new naming convention
	default_color = "#FFFFFF"
	recommended_species = list(SPECIES_MOTH, SPECIES_MAMMAL, SPECIES_INSECT) // Mammals too, I guess. They wont get flight though, see the wing organs for that logic
	organ_type = /obj/item/organ/external/wings/moth
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/moth/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/wings/moth/atlas
	name = "Moth (Atlas)"
	icon_state = "atlas"

/datum/sprite_accessory/wings/moth/brown
	name = "Moth (Brown)"
	icon_state = "brown"

/datum/sprite_accessory/wings/moth/burnt
	name = "Burnt Off"
	icon_state = "burnt_off"
	locked = TRUE

/datum/sprite_accessory/wings/moth/deathhead
	name = "Moth (Deathshead)"
	icon_state = "deathhead"

/datum/sprite_accessory/wings/moth/featherful // Is actually 'feathery' on upstream
	name = "Moth (Featherful)"
	icon_state = "featherful"

/datum/sprite_accessory/wings/moth/firewatch
	name = "Moth (Firewatch)"
	icon_state = "firewatch"

/datum/sprite_accessory/wings/moth/gothic
	name = "Moth (Gothic)"
	icon_state = "gothic"

/datum/sprite_accessory/wings/moth/jungle
	name = "Moth (Jungle)"
	icon_state = "jungle"

/datum/sprite_accessory/wings/moth/lovers
	name = "Moth (Lovers)"
	icon_state = "lovers"

/datum/sprite_accessory/wings/moth/luna
	name = "Moth (Luna)"
	icon_state = "luna"

/datum/sprite_accessory/wings/moth/monarch
	name = "Moth (Monarch)"
	icon_state = "monarch"

/datum/sprite_accessory/wings/moth/moonfly
	name = "Moth (Moon Fly)"
	icon_state = "moonfly"

/datum/sprite_accessory/wings/moth/oakworm
	name = "Moth (Oak Worm)"
	icon_state = "oakworm"

/datum/sprite_accessory/wings/moth/plain
	name = "Moth (Plain)"
	icon_state = "plain"

/datum/sprite_accessory/wings/moth/plasmafire
	name = "Moth (Plasmafire)"
	icon_state = "plasmafire"

/datum/sprite_accessory/wings/moth/poison
	name = "Moth (Poison)"
	icon_state = "poison"

/datum/sprite_accessory/wings/moth/ragged
	name = "Moth (Ragged)"
	icon_state = "ragged"

/datum/sprite_accessory/wings/moth/reddish
	name = "Moth (Reddish)"
	icon_state = "redish"

/datum/sprite_accessory/wings/moth/rosy
	name = "Moth (Rosy)"
	icon_state = "rosy"

/datum/sprite_accessory/wings/moth/royal
	name = "Moth (Royal)"
	icon_state = "royal"

/datum/sprite_accessory/wings/moth/snow
	name = "Moth (Snow)"
	icon_state = "snow"

/datum/sprite_accessory/wings/moth/whitefly
	name = "Moth (White Fly)"
	icon_state = "whitefly"

/datum/sprite_accessory/wings/moth/witchwing
	name = "Moth (Witch Wing)"
	icon_state = "witchwing"

/datum/sprite_accessory/wings/moth/moffra
	name = "Moth (Moffra)"
	icon_state = "moffra"

/datum/sprite_accessory/wings/mammal/top/arfel_harpy
	name = "Arfel Harpy"
	icon_state = "arfelharpy_top"
	color_src = USE_ONE_COLOR
