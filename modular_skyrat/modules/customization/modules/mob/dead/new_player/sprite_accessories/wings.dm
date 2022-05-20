// When adding or making new wing sprites, try to use matrixed colours!
// You can find a color palette to work with in modular_skyrat\modules\customization\icons\mob\sprite_accessory\wings.dmi as 'colorpalette matrixcolors'
// Check some of the wings that make use of them for examples on how to make it look decent
/datum/sprite_accessory/wings
	icon = 'icons/mob/clothing/wings.dmi'
	generic = "Wings"
	key = "wings"
	color_src = USE_ONE_COLOR
	recommended_species = list(SPECIES_HUMAN, SPECIES_SYNTHHUMAN, SPECIES_FELINE, SPECIES_LIZARD, SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_SYNTHLIZ)
	organ_type = /obj/item/organ/external/wings
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
	genetic = TRUE

/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && H.try_hide_mutant_parts)
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"
	factual = FALSE

/datum/sprite_accessory/wings/angel
	color_src = USE_ONE_COLOR
	default_color = "#FFFFFF"

/datum/sprite_accessory/wings/megamoth
	color_src = USE_ONE_COLOR
	default_color = "#FFFFFF"

/datum/sprite_accessory/wings/dragon
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/moth
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/moth_wings.dmi' //Needs new icon to suit new naming convention
	default_color = "#FFFFFF"
	recommended_species = list(SPECIES_MOTH, SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_INSECT) //Mammals too, I guess. They wont get flight though, see the wing organs for that logic
	organ_type = /obj/item/organ/external/wings/moth
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/wings/moth/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/wings/moth/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_suit && (H.try_hide_mutant_parts || (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(H.dna.species, H.wear_suit.species_exception)))))
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/wings/moth/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/wings/moth/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/wings/moth/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/wings/moth/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/wings/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/wings/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/wings/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/wings/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/wings/moth/punished
	name = "Burnt Off"
	icon_state = "punished"
	locked = TRUE

/datum/sprite_accessory/wings/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/wings/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/wings/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/wings/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/wings/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/wings/moth/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/wings/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/wings/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/wings/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/wings/moth/rosy
	name = "Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/wings/moth/featherful // Is actually 'feathery' on upstream
	name = "Featherful"
	icon_state = "featherful"

/datum/sprite_accessory/wings/moth/brown
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/wings/moth/plasmafire
	name = "Plasmafire"
	icon_state = "plasmafire"


/datum/sprite_accessory/wings/mammal
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	default_color = DEFAULT_PRIMARY
	recommended_species = list(SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_LIZARD, SPECIES_INSECT, SPECIES_SYNTHLIZ)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/mammal/bat //TODO: port my sprite from hyper for this one
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/wings/mammal/fairy
	name = "Fairy"
	icon_state = "fairy"

/datum/sprite_accessory/wings/mammal/feathery
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/wings/mammal/featheryalt1
	name = "Feathery (alt 1)"
	icon_state = "featheryalt1"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/featheryalt2
	name = "Feathery (alt 2)"
	icon_state = "featheryalt2"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/wings/mammal/succubus
	name = "Succubus"
	icon_state = "succubus"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/dragon_synth
	name = "Dragon (synthetic alt)"
	icon_state = "dragonsynth"
	color_src = USE_MATRIXED_COLORS
	genetic = FALSE

/datum/sprite_accessory/wings/mammal/dragon_alt1
	name = "Dragon (alt 1)"
	icon_state = "dragonalt1"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/dragon_alt2
	name = "Dragon (alt 2)"
	icon_state = "dragonalt2"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/harpywings
	name = "Harpy"
	icon_state = "harpy"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/harpywingsalt1
	name = "Harpy (alt 1)"
	icon_state = "harpyalt"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/harpywingsalt2
	name = "Harpy (Bat)"
	icon_state = "harpybat"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_suit && (H.try_hide_mutant_parts || (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(H.dna.species, H.wear_suit.species_exception)))))
		return TRUE
	return FALSE

/datum/sprite_accessory/wings/mammal/top/harpywings_top
	name = "Harpy (Top)"
	icon_state = "harpy_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/harpywingsalt1_top
	name = "Harpy (alt 1) (Top)"
	icon_state = "harpyalt_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/top/harpywingsalt2_top
	name = "Harpy (Bat) (Top)"
	icon_state = "harpybat_top"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/low_wings
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings"
	icon_state = "low"
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/low_wings_top
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings (Top)"
	icon_state = "low_top"
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/low_wings_tri
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings tri-tone"
	icon_state = "low_tri"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/low_wings_tri_top
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings tri-tone (top)"
	icon_state = "low_tri_top"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/low_wings_jewel
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings jeweled"
	icon_state = "low_jewel"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/low_wings_jewel_top
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	name = "Low wings jeweled (top)"
	icon_state = "low_jewel_top"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 46
	dimension_y = 34
	center = TRUE

/datum/sprite_accessory/wings/mammal/spider
	name = "Spider legs"
	icon_state = "spider_legs"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/robowing
	name = "mechanical dragon wings"
	icon_state = "robowing"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/wings/mammal/mini_bat
	name = "Mini-Bat"
	icon_state = "minibat"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/mini_feather
	name = "Mini-Feathery"
	icon_state = "minifeather"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/tiny_bat
	name = "Tiny-Bat"
	icon_state = "tinybat"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/tiny_feather
	name = "Tiny-Feathery"
	icon_state = "tinyfeather"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/insect
	name = "Insectoid"
	icon_state = "insect"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/wings/mammal/beetle
	name = "Beetle"
	icon_state = "beetle"
	color_src = USE_ONE_COLOR
