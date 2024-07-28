/datum/sprite_accessory/tails
	key = "tail"
	generic = "Tail"
	organ_type = /obj/item/organ/external/tail
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails.dmi'
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	/// Can we use this tail for the fluffy tail turf emote?
	var/fluffy = FALSE

/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/wearer)
	var/list/used_in_turf = list("tail")
	if(wearer.owned_turf?.name in used_in_turf)
	// Emote exception
		return TRUE

	if(!wearer.w_uniform && !wearer.wear_suit)
		return FALSE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	if(wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return FALSE
		// Hide accessory if flagged to do so
		else if(wearer.wear_suit.flags_inv & HIDETAIL)
			return TRUE

/datum/sprite_accessory/tails/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	recommended_species = list(SPECIES_SYNTH, SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_HUMANOID, SPECIES_GHOUL)
	color_src = null
	factual = FALSE

/datum/sprite_accessory/tails/lizard
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails.dmi'
	recommended_species = list(SPECIES_LIZARD, SPECIES_LIZARD_ASH, SPECIES_MAMMAL, SPECIES_UNATHI, SPECIES_LIZARD_SILVER)
	organ_type = /obj/item/organ/external/tail/lizard

/datum/sprite_accessory/tails/lizard/short/twotone
	name = "Short (Two-Tone)"
	icon_state = "short2tone"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/tails/human
	recommended_species = list(SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_MAMMAL, SPECIES_GHOUL)
	organ_type = /obj/item/organ/external/tail/cat

/datum/sprite_accessory/tails/human/cat
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails.dmi'
	icon_state = "cat"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/monkey/default
	name = "Monkey"
	icon_state = "monkey"
	icon = 'icons/mob/human/species/monkey/monkey_tail.dmi'
	recommended_species = list(SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_MAMMAL, SPECIES_MONKEY, SPECIES_GHOUL)
	organ_type = /obj/item/organ/external/tail/monkey

/datum/sprite_accessory/tails/mammal
	icon_state = "none"
	recommended_species = list(SPECIES_MAMMAL,SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_HUMANOID, SPECIES_GHOUL)
	organ_type = /obj/item/organ/external/tail/fluffy/no_wag
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/tails/mammal/wagging
	organ_type = /obj/item/organ/external/tail/fluffy
	flags_for_organ = SPRITE_ACCESSORY_WAG_ABLE

/datum/sprite_accessory/tails/mammal/wagging/akula
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_AKULA, SPECIES_AQUATIC, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/tails/mammal/wagging/tajaran
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_TAJARAN, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/tails/mammal/teshari
	recommended_species = list(SPECIES_TESHARI)

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_VULP, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/tails/mammal/wagging/big
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails_big.dmi'
	dimension_x = 64
	center = TRUE

/datum/sprite_accessory/tails/mammal/wagging/avian
	name = "Avian"
	icon_state = "avian1"
/datum/sprite_accessory/tails/mammal/wagging/avian/alt
	name = "Avian (Alt)"
	icon_state = "avian2"

/datum/sprite_accessory/tails/mammal/wagging/axolotl
	name = "Axolotl"
	icon_state = "axolotl"

/datum/sprite_accessory/tails/mammal/wagging/bat_long
	name = "Bat (Long)"
	icon_state = "batl"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/bat_short
	name = "Bat (Short)"
	icon_state = "bats"

/datum/sprite_accessory/tails/mammal/wagging/cable
	name = "Cable"
	icon_state = "cable"

/datum/sprite_accessory/tails/mammal/wagging/bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/tails/mammal/wagging/queenbee
	name = "Queen Bee"
	icon_state = "queenbee"

/datum/sprite_accessory/tails/mammal/wagging/tajaran/cat_big
	name = "Cat (Big)"
	icon_state = "catbig"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/cat_double
	name = "Cat (Double)"
	icon_state = "twocat"

/datum/sprite_accessory/tails/mammal/wagging/cat_triple
	name = "Cat (Triple)"
	icon_state = "threecat"

/datum/sprite_accessory/tails/mammal/wagging/corvid
	name = "Corvid"
	icon_state = "crow"

/datum/sprite_accessory/tails/mammal/wagging/cow
	name = "Cow"
	icon_state = "cow"

/datum/sprite_accessory/tails/mammal/wagging/data_shark
	name = "Data shark"
	icon_state = "datashark"

/datum/sprite_accessory/tails/mammal/deer
	name = "Deer"
	icon_state = "deer"

/datum/sprite_accessory/tails/mammal/wagging/deer_two
	name = "Deer II"
	icon_state = "deer_two"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/eevee
	name = "Eevee"
	icon_state = "eevee"

/datum/sprite_accessory/tails/mammal/wagging/fennec
	name = "Fennec"
	icon_state = "fennec"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox
	name = "Fox"
	icon_state = "fox"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox/alt_1
	name = "Fox (Alt 1)"
	icon_state = "fox2"

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox/alt_2
	name = "Fox (Alt 2)"
	icon_state = "fox3"

/datum/sprite_accessory/tails/mammal/wagging/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/tails/mammal/wagging/hawk
	name = "Hawk"
	icon_state = "hawk"

/datum/sprite_accessory/tails/mammal/wagging/horse
	name = "Horse"
	icon_state = "horse"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY

/datum/sprite_accessory/tails/mammal/wagging/husky
	name = "Husky"
	icon_state = "husky"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/insect
	name = "Insect"
	icon_state = "insect"

/datum/sprite_accessory/tails/mammal/wagging/queeninsect
	name = "Queen Insect"
	icon_state = "queeninsect"

/datum/sprite_accessory/tails/mammal/wagging/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"

/*
*	KITSUNE
*/

/datum/sprite_accessory/tails/mammal/wagging/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/lunasune
	name = "Kitsune (Lunasune)"
	icon_state = "lunasune"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/kitsune/sabresune
	name = "Kitsune (Sabresune)"
	icon_state = "sabresune"

/datum/sprite_accessory/tails/mammal/wagging/kitsune/septuple
	name = "Kitsune (Septuple)"
	icon_state = "sevenkitsune"

/datum/sprite_accessory/tails/mammal/wagging/kitsune/tamamo
	name = "Kitsune (Tamamo)"
	icon_state = "9sune"

/datum/sprite_accessory/tails/mammal/wagging/lab
	name = "Labrador"
	icon_state = "lab"

/datum/sprite_accessory/tails/mammal/wagging/leopard
	name = "Leopard"
	icon_state = "leopard"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/murid
	name = "Murid"
	icon_state = "murid"

/datum/sprite_accessory/tails/mammal/wagging/murid_two
	name = "Murid II"
	icon_state = "murid_two"

/datum/sprite_accessory/tails/mammal/wagging/orca
	name = "Orca"
	icon_state = "orca"

/datum/sprite_accessory/tails/mammal/wagging/otie
	name = "Otusian"
	icon_state = "otie"

/datum/sprite_accessory/tails/mammal/wagging/plug
	name = "Plug"
	icon_state = "plugtail"

/datum/sprite_accessory/tails/mammal/wagging/plug/scorpion
	name = "Scorpion Plug"
	icon_state = "scorptail"

/datum/sprite_accessory/tails/mammal/wagging/rabbit
	name = "Rabbit"
	icon_state = "rabbit"

/datum/sprite_accessory/tails/mammal/wagging/rabbit/alt
	name = "Rabbit (Alt)"
	icon_state = "rabbit_alt"

/datum/sprite_accessory/tails/mammal/raptor
	name = "Raptor"
	icon_state = "raptor"

/datum/sprite_accessory/tails/mammal/wagging/red_panda
	name = "Red Panda"
	icon_state = "wah"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/tails/mammal/wagging/segmented
	name = "Segmented"
	icon_state = "segmentedtail"

/datum/sprite_accessory/tails/mammal/wagging/sergal
	name = "Sergal"
	icon_state = "sergal"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/servelyn
	name = "Servelyn"
	icon_state = "tiger2"

/datum/sprite_accessory/tails/mammal/wagging/big/shade
	name = "Shade"
	icon_state = "shadekin_large"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/tails/mammal/wagging/big/shade/long
	name = "Shade (Long)"
	icon_state = "shadekinlong_large"

/datum/sprite_accessory/tails/mammal/wagging/big/shade/striped
	name = "Shade (Striped)"
	icon_state = "shadekinlongstriped_large"

/datum/sprite_accessory/tails/mammal/wagging/big/ringtail
	name = "Ring Tail (Long)"
	icon_state = "bigring_large"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/tails/mammal/wagging/akula/akula
	name = "Akula"
	icon_state = "akula"

/datum/sprite_accessory/tails/mammal/wagging/akula/shark
	name = "Shark"
	icon_state = "shark"

/datum/sprite_accessory/tails/mammal/wagging/akula/shark_no_fin
	name = "Shark (No Fin)"
	icon_state = "sharknofin"

/datum/sprite_accessory/tails/mammal/wagging/akula/fish
	name = "Fish"
	icon_state = "fish"

/datum/sprite_accessory/tails/mammal/wagging/shepherd
	name = "Shepherd"
	icon_state = "shepherd"

/datum/sprite_accessory/tails/mammal/wagging/skunk
	name = "Skunk"
	icon_state = "skunk"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/snake
	name = "Snake"
	icon_state = "snaketail"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/snake_dual
	name = "Snake (Dual)"
	icon_state = "snakedual"

/datum/sprite_accessory/tails/mammal/wagging/snake_stripe
	name = "Snake (Stripe)"
	icon_state = "snakestripe"

/datum/sprite_accessory/tails/mammal/wagging/snake_stripe_alt
	name = "Snake (Stripe Alt)"
	icon_state = "snakestripealt"

/datum/sprite_accessory/tails/mammal/wagging/snake_under
	name = "Snake (Undertail color)"
	icon_state = "snakeunder"

/datum/sprite_accessory/tails/mammal/wagging/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	color_src = USE_ONE_COLOR
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/stripe
	name = "Stripe"
	icon_state = "stripe"
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/straight
	name = "Straight Tail"
	icon_state = "straighttail"

/datum/sprite_accessory/tails/mammal/wagging/spade
	name = "Succubus Spade Tail"
	icon_state = "spade"

/datum/sprite_accessory/tails/mammal/wagging/tailmaw
	name = "Tailmaw"
	icon_state = "tailmaw"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/tailmaw/wag
	name = "Tailmaw (Wag)"
	icon_state = "tailmawwag"

/datum/sprite_accessory/tails/mammal/wagging/tentacle
	name = "Tentacle"
	icon_state = "tentacle"

/*
*	TESHARI
*/

/datum/sprite_accessory/tails/mammal/teshari/default
	name = "Teshari (Default)"
	icon_state = "teshari_default"

/datum/sprite_accessory/tails/mammal/teshari/fluffy
	name = "Teshari (Fluffy)"
	icon_state = "teshari_fluffy"
/datum/sprite_accessory/tails/mammal/teshari/thin
	name = "Teshari (Thin)"
	icon_state = "teshari_thin"

/datum/sprite_accessory/tails/mammal/wagging/tiger
	name = "Tiger"
	icon_state = "tiger"

/datum/sprite_accessory/tails/mammal/wagging/wolf
	name = "Wolf"
	icon_state = "wolf"
	color_src = USE_ONE_COLOR
	fluffy = TRUE

/datum/sprite_accessory/tails/mammal/wagging/zorgoia
	name = "Zorgoia tail"
	icon_state = "zorgoia"

/datum/sprite_accessory/tails/mammal/reptileslim
	name = "Slim reptile"
	icon_state = "reptileslim"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/australian_shepherd
	name = "Australian Shepherd"
	icon_state = "australianshepherd"
