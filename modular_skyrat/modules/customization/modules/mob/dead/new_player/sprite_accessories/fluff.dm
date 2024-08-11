/datum/sprite_accessory/fluff/moth
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/moth_fluff.dmi'
	default_color = "#FFFFFF"
	key = "fluff"
	generic = "Fluff"
	recommended_species = list(SPECIES_MOTH, SPECIES_MAMMAL, SPECIES_INSECT)
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/fluff

/datum/sprite_accessory/fluff/moth/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/fluff/moth/is_hidden(mob/living/carbon/human/human)
	if((human.head?.flags_inv & HIDEHAIR) || (human.wear_mask?.flags_inv & HIDEHAIR))
		return TRUE

	return FALSE

/datum/sprite_accessory/fluff/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/fluff/moth/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/fluff/moth/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/fluff/moth/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/fluff/moth/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/fluff/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/fluff/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/fluff/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/fluff/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/fluff/moth/punished
	name = "Burnt Off"
	icon_state = "punished"
	locked = TRUE

/datum/sprite_accessory/fluff/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/fluff/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/fluff/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/fluff/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/fluff/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/fluff/moth/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/fluff/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/fluff/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/fluff/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/fluff/moth/insectm
	name = "Insect male (Tertiary)"
	icon_state = "insectm"
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/fluff/moth/insectf
	name = "Insect female (Tertiary)"
	icon_state = "insectf"
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/fluff/moth/fsnow
	name = "Snow (Top)"
	icon_state = "fsnow"

/datum/sprite_accessory/fluff/moth/snowdual
	name = "Snow (Dual-Color)"
	icon_state = "snowdual"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/fluff/moth/teshari
	name = "Teshari Mane"
	icon_state = "teshmane"
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/fluff/moth/teshari/front
	name = "Teshari Mane (Top)"
	icon_state = "teshmane_top"
	default_color = DEFAULT_TERTIARY
