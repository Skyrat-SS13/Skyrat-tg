/datum/sprite_accessory/ears
	key = "ears"
	generic = "Ears"
	organ_type = /obj/item/organ/external/ears // SET BACK TO THIS AS SOON AS WE GET EARS AS EXTERNAL ORGANS: organ_type = /obj/item/organ/internal/ears/mutant
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	color_src = USE_MATRIXED_COLORS
	genetic = TRUE

/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.head)
		return FALSE

	// Can hide if wearing hat
	if(key in wearer.try_hide_mutant_parts)
		return TRUE

	// Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE

	// Hide accessory if flagged to do so
	if((wearer.head?.flags_inv & HIDEHAIR || wearer.wear_mask?.flags_inv & HIDEHAIR) \
		// This line basically checks if we FORCE accessory-ears to show, for items with earholes like Balaclavas and Luchador masks
		&& ((wearer.head && !(wearer.head.flags_inv & SHOWSPRITEEARS)) || (wearer.wear_mask && !(wearer.wear_mask?.flags_inv & SHOWSPRITEEARS))))
		return TRUE

	return FALSE

/datum/sprite_accessory/ears/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"

/datum/sprite_accessory/ears/cat
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_HUMANOID, SPECIES_GHOUL)
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/fox
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears.dmi'
	organ_type = /obj/item/organ/external/ears // SET BACK TO THIS AS SOON AS WE GET EARS AS EXTERNAL ORGANS: organ_type = /obj/item/organ/internal/ears/mutant
	color_src = USE_MATRIXED_COLORS
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_HUMANOID, SPECIES_GHOUL)
	uses_emissives = TRUE

/datum/sprite_accessory/ears/mutant/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	color_src = null
	factual = FALSE

/datum/sprite_accessory/ears/mutant/big
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears_big.dmi'

/datum/sprite_accessory/ears/mutant/vulpkanin
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_VULP, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/ears/mutant/tajaran
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_TAJARAN, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/ears/mutant/akula
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMAN, SPECIES_SYNTH, SPECIES_FELINE, SPECIES_AQUATIC, SPECIES_AKULA, SPECIES_HUMANOID, SPECIES_GHOUL)

/datum/sprite_accessory/ears/mutant/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/bat
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/ears/mutant/bear
	name = "Bear"
	icon_state = "bear"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/bigwolf
	name = "Big Wolf"
	icon_state = "bigwolf"

/datum/sprite_accessory/ears/mutant/bigwolfinner
	name = "Big Wolf (ALT)"
	icon_state = "bigwolfinner"
	hasinner = TRUE

/datum/sprite_accessory/ears/mutant/bigwolfdark //alphabetical sort ignored here for ease-of-use
	name = "Dark Big Wolf"
	icon_state = "bigwolfdark"

/datum/sprite_accessory/ears/mutant/bigwolfinnerdark
	name = "Dark Big Wolf (ALT)"
	icon_state = "bigwolfinnerdark"
	hasinner = TRUE

/datum/sprite_accessory/ears/mutant/bunny
	name = "Bunny"
	icon_state = "bunny"

/datum/sprite_accessory/ears/mutant/tajaran/catbig
	name = "Cat, Big"
	icon_state = "catbig"

/datum/sprite_accessory/ears/mutant/tajaran/catnormal
	name = "Cat, normal"
	icon_state = "catnormal"

/datum/sprite_accessory/ears/mutant/cow
	name = "Cow"
	icon_state = "cow"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/curled
	name = "Curled Horn"
	icon_state = "horn1"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/ears/mutant/deer
	name = "Deer (Antler)"
	icon_state = "deer"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_TERTIARY

/datum/sprite_accessory/ears/mutant/eevee
	name = "Eevee"
	icon_state = "eevee"

/datum/sprite_accessory/ears/mutant/eevee_alt
	name = "Eevee ALT"
	icon_state = "eevee_alt"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/ears/mutant/elf
	name = "Elf"
	icon_state = "elf"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY

/datum/sprite_accessory/ears/mutant/elf/wide
	name = "Wide Elf"
	icon_state = "elfwide"

/datum/sprite_accessory/ears/mutant/elf/broad
	name = "Broad Elf"
	icon_state = "elfbroad"

/datum/sprite_accessory/ears/mutant/elf/longer
	name = "Longer Elf"
	icon_state = "elflonger"

/datum/sprite_accessory/ears/mutant/elephant
	name = "Elephant"
	icon_state = "elephant"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/fennec
	name = "Fennec"
	icon_state = "fennec"

/datum/sprite_accessory/ears/mutant/fish
	name = "Fish"
	icon_state = "fish"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/vulpkanin/fox
	name = "Fox"
	icon_state = "fox"

/datum/sprite_accessory/ears/mutant/akula/hammerhead
	name = "Hammerhead"
	icon_state = "hammerhead"

/datum/sprite_accessory/ears/mutant/husky
	name = "Husky"
	icon_state = "wolf"

/datum/sprite_accessory/ears/mutant/jellyfish
	name = "Jellyfish"
	icon_state = "jellyfish"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"

/datum/sprite_accessory/ears/mutant/lab
	name = "Dog, Long"
	icon_state = "lab"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/murid
	name = "Murid"
	icon_state = "murid"

/datum/sprite_accessory/ears/mutant/vulpkanin/otie
	name = "Otusian"
	icon_state = "otie"

/datum/sprite_accessory/ears/mutant/protogen
	name = "Protogen"
	icon_state = "protogen"

/datum/sprite_accessory/ears/mutant/rabbit
	name = "Rabbit"
	icon_state = "rabbit"

/datum/sprite_accessory/ears/mutant/big/hare_large
	name = "Rabbit (Large)"
	icon_state = "bunny_large"

/datum/sprite_accessory/ears/mutant/big/bunny_large
	name = "Curved Rabbit Ears (Large)"
	icon_state = "rabbit_large"

/datum/sprite_accessory/ears/mutant/big/sandfox_large
	name = "Sandfox (Large)"
	icon_state = "sandfox_large"

/datum/sprite_accessory/ears/mutant/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/ears/mutant/akula/sergal
	name = "Sergal"
	icon_state = "sergal"

/datum/sprite_accessory/ears/mutant/skunk
	name = "skunk"
	icon_state = "skunk"

/datum/sprite_accessory/ears/mutant/squirrel
	name = "Squirrel"
	icon_state = "squirrel"

/datum/sprite_accessory/ears/mutant/vulpkanin/wolf
	name = "Wolf"
	icon_state = "wolf"

/datum/sprite_accessory/ears/mutant/vulpkanin/perky
	name = "Perky"
	icon_state = "perky"

/datum/sprite_accessory/ears/mutant/antenna_simple1
	name = "Insect antenna (coloring 2)"
	icon_state = "antenna_simple1"

/datum/sprite_accessory/ears/mutant/antenna_simple1_v2
	name = "Insect antenna (coloring 3)"
	icon_state = "antenna_simple1v2"

/datum/sprite_accessory/ears/mutant/antenna_simple2
	name = "Insect antenna 2 (coloring 2)"
	icon_state = "antenna_simple2"

/datum/sprite_accessory/ears/mutant/antenna_simple2_v2
	name = "Insect antenna 2 (coloring 3)"
	icon_state = "antenna_simple2v2"

/datum/sprite_accessory/ears/mutant/antenna_fuzzball
	name = "Fuzzball antenna (coloring 2+3)"
	icon_state = "antenna_fuzzball"

/datum/sprite_accessory/ears/mutant/antenna_fuzzball_v2
	name = "Fuzzball antenna (coloring 3+1)"
	icon_state = "antenna_fuzzballv2"

/datum/sprite_accessory/ears/mutant/cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"

/datum/sprite_accessory/ears/mutant/cobrahoodears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"

/datum/sprite_accessory/ears/mutant/miqote
	name = "Miqo'te"
	icon_state = "miqote"

/datum/sprite_accessory/ears/mutant/hare
	name = "Hare"
	icon_state = "rabbitalt"

/datum/sprite_accessory/ears/mutant/bunnyalt
	name = "Curved Rabbit Ears"
	icon_state = "bunnyalt"

/datum/sprite_accessory/ears/mutant/deerear
	name = "Deer (ear)"
	icon_state = "deerear"

/datum/sprite_accessory/ears/mutant/teshari
	recommended_species = list(SPECIES_TESHARI)

/datum/sprite_accessory/ears/mutant/teshari/regular
	name = "Teshari Regular"
	icon_state = "teshari_regular"

/datum/sprite_accessory/ears/mutant/teshari/feathers_bushy
	name = "Teshari Feathers Bushy"
	icon_state = "teshari_feathers_bushy"

/datum/sprite_accessory/ears/mutant/teshari/feathers_mohawk
	name = "Teshari Feathers Mohawk"
	icon_state = "teshari_feathers_mohawk"

/datum/sprite_accessory/ears/mutant/teshari/feathers_spiky
	name = "Teshari Feathers Spiky"
	icon_state = "teshari_feathers_spiky"

/datum/sprite_accessory/ears/mutant/teshari/feathers_pointy
	name = "Teshari Feathers Pointy"
	icon_state = "teshari_feathers_pointy"

/datum/sprite_accessory/ears/mutant/teshari/feathers_upright
	name = "Teshari Feathers Upright"
	icon_state = "teshari_feathers_upright"

/datum/sprite_accessory/ears/mutant/teshari/feathers_mane
	name = "Teshari Feathers Mane"
	icon_state = "teshari_feathers_mane"

/datum/sprite_accessory/ears/mutant/teshari/feathers_maneless
	name = "Teshari Feathers Mane Fluffless"
	icon_state = "teshari_feathers_maneless"

/datum/sprite_accessory/ears/mutant/teshari/feathers_droopy
	name = "Teshari Feathers Droopy"
	icon_state = "teshari_feathers_droopy"

/datum/sprite_accessory/ears/mutant/teshari/feathers_longway
	name = "Teshari Feathers Longway"
	icon_state = "teshari_feathers_longway"

/datum/sprite_accessory/ears/mutant/teshari/feathers_tree
	name = "Teshari Feathers Tree"
	icon_state = "teshari_feathers_tree"

/datum/sprite_accessory/ears/mutant/teshari/feathers_ponytail
	name = "Teshari Feathers Ponytail"
	icon_state = "teshari_feathers_ponytail"

/datum/sprite_accessory/ears/mutant/teshari/feathers_mushroom
	name = "Teshari Feathers Mushroom"
	icon_state = "teshari_feathers_mushroom"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/teshari/feathers_backstrafe
	name = "Teshari Feathers Backstrafe"
	icon_state = "teshari_feathers_backstrafe"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/teshari/feathers_thinmohawk
	name = "Teshari Feathers Thin Mohawk"
	icon_state = "teshari_feathers_thinmohawk"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/teshari/feathers_thin
	name = "Teshari Feathers Thin"
	icon_state = "teshari_feathers_thin"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/teshari/feathers_thinmane
	name = "Teshari Feathers Thin Mane"
	icon_state = "teshari_feathers_thinmane"

/datum/sprite_accessory/ears/mutant/teshari/feathers_thinmaneless
	name = "Teshari Feathers Thin Mane Fluffless"
	icon_state = "teshari_feathers_thinmaneless"

/datum/sprite_accessory/ears/mutant/deer2
	name = "Deer 2"
	icon_state = "deer2"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/ears/mutant/mouse
	name = "Mouse"
	icon_state = "mouse"

/datum/sprite_accessory/ears/mutant/mouse_two
	name = "Mouse II"
	icon_state = "mouse_two"

/datum/sprite_accessory/ears/mutant/big/fourears1
	name = "Four Ears 1"
	icon_state = "four_ears_1"

/datum/sprite_accessory/ears/mutant/fourears2
	name = "Four Ears 2"
	icon_state = "four_ears_2"

/datum/sprite_accessory/ears/mutant/big/fourears3
	name = "Four Ears 3"
	icon_state = "four_ears_3"

/datum/sprite_accessory/ears/acrador
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears_big.dmi'
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/ears/acrador/long
	icon_state = "acrador_long"
	name = "Acrador (Long)"

/datum/sprite_accessory/ears/acrador/short
	icon_state = "acrador_short"
	name = "Acrador (Short)"
