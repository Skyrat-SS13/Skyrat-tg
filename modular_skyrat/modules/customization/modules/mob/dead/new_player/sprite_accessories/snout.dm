/datum/sprite_accessory/snouts
	key = "snout"
	generic = "Snout"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/lizard_snouts.dmi'
	flags_for_organ = SPRITE_ACCESSORY_USE_MUZZLED_SPRITE
	organ_type = /obj/item/organ/external/snout
	recommended_species = list(SPECIES_MAMMAL, SPECIES_LIZARD, SPECIES_UNATHI, SPECIES_LIZARD_ASH, SPECIES_LIZARD_SILVER)
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/snouts/is_hidden(mob/living/carbon/human/human)
	if((human.wear_mask?.flags_inv & HIDESNOUT) || (human.head?.flags_inv & HIDESNOUT))
		return TRUE

	return FALSE

/obj/item/organ/external/snout
	mutantpart_key = "snout"
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	external_bodyshapes = NONE // We don't actually want this to have  by default, since some of them don't apply that.
	preference = "feature_snout"

/datum/bodypart_overlay/mutant/snout
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/snout/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/snout/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)


/obj/item/organ/external/snout/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_USE_MUZZLED_SPRITE)
		external_bodyshapes |= BODYSHAPE_SNOUTED
	if(sprite_accessory_flags & SPRITE_ACCESSORY_USE_ALT_FACEWEAR_LAYER)
		external_bodyshapes |= BODYSHAPE_ALT_FACEWEAR_LAYER

	return ..()

/obj/item/organ/external/snout/top
	bodypart_overlay = /datum/bodypart_overlay/mutant/snout/top

/datum/bodypart_overlay/mutant/snout/top
	layers = EXTERNAL_FRONT


/obj/item/organ/external/snout/top_adj
	bodypart_overlay = /datum/bodypart_overlay/mutant/snout/top_adj

/datum/bodypart_overlay/mutant/snout/top_adj
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT


/datum/sprite_accessory/snouts/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	flags_for_organ = NONE
	factual = FALSE

/datum/sprite_accessory/snouts/mammal
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	recommended_species = list(SPECIES_MAMMAL, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/vulpkanin
	recommended_species = list(SPECIES_MAMMAL, SPECIES_VULP, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/tajaran
	recommended_species = list(SPECIES_MAMMAL, SPECIES_TAJARAN, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/akula
	recommended_species = list(SPECIES_MAMMAL, SPECIES_AKULA, SPECIES_AQUATIC, SPECIES_HUMANOID)

/datum/sprite_accessory/snouts/mammal/bird
	name = "Beak"
	icon_state = "bird"

/datum/sprite_accessory/snouts/mammal/birdsmall
	name = "Beak (small)"
	icon_state = "birdsmall"

/datum/sprite_accessory/snouts/mammal/bigbeak
	name = "Big Beak"
	icon_state = "bigbeak"

/datum/sprite_accessory/snouts/mammal/bigbeakshort
	name = "Big Beak Short"
	icon_state = "bigbeakshort"

/datum/sprite_accessory/snouts/mammal/slimbeak
	name = "Slim Beak"
	icon_state = "slimbeak"

/datum/sprite_accessory/snouts/mammal/slimbeakshort
	name = "Slim Beak Short"
	icon_state = "slimbeakshort"

/datum/sprite_accessory/snouts/mammal/slimbeakalt
	name = "Slim Beak Alt"
	icon_state = "slimbeakalt"

/datum/sprite_accessory/snouts/mammal/hookbeak
	name = "Hook Beak"
	icon_state = "hookbeak"

/datum/sprite_accessory/snouts/mammal/hookbeakbig
	name = "Hook Beak Big"
	icon_state = "hookbeakbig"

/datum/sprite_accessory/snouts/mammal/corvidbeak
	name = "Corvid Beak"
	icon_state = "corvidbeak"

/datum/sprite_accessory/snouts/mammal/bug
	name = "Bug"
	icon_state = "bug"
	flags_for_organ = NONE
	color_src = USE_MATRIXED_COLORS
	organ_type = /obj/item/organ/external/snout/top_adj

/datum/sprite_accessory/snouts/mammal/bug_no_eyes
	name = "Bug (No eyes)"
	icon_state = "bug_no_eyes"
	flags_for_organ = NONE
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/elephant
	name = "Elephant"
	icon_state = "elephant"

/datum/sprite_accessory/snouts/mammal/husky
	name = "Husky"
	icon_state = "husky"

/datum/sprite_accessory/snouts/mammal/rhino
	name = "Horn"
	icon_state = "rhino"

/datum/sprite_accessory/snouts/mammal/rodent
	name = "Rodent"
	icon_state = "rodent"

/datum/sprite_accessory/snouts/mammal/vulpkanin/lcanid
	name = "Mammal, Long"
	icon_state = "lcanid"

/datum/sprite_accessory/snouts/mammal/lcanidalt
	name = "Mammal, Long ALT"
	icon_state = "lcanidalt"

/datum/sprite_accessory/snouts/mammal/vulpkanin/lcanidstriped
	name = "Mammal, Long, Striped"
	icon_state = "lcanidstripe"

/datum/sprite_accessory/snouts/mammal/lcanidstripedalt
	name = "Mammal, Long, Striped ALT"
	icon_state = "lcanidstripealt"

/datum/sprite_accessory/snouts/mammal/tajaran/scanid
	name = "Mammal, Short"
	icon_state = "scanid"

/datum/sprite_accessory/snouts/mammal/tajaran/scanidalt
	name = "Mammal, Short ALT"
	icon_state = "scanidalt"

/datum/sprite_accessory/snouts/mammal/tajaran/scanidalt2
	name = "Mammal, Short ALT 2"
	icon_state = "scanidalt2"

/datum/sprite_accessory/snouts/mammal/tajaran/scanidalt3
	name = "Mammal, Short ALT 3"
	icon_state = "scanidalt3"

/datum/sprite_accessory/snouts/mammal/tajaran/normal
	name = "Tajaran, normal"
	icon_state = "ntajaran"

/datum/sprite_accessory/snouts/mammal/wolf
	name = "Mammal, Thick"
	icon_state = "wolf"

/datum/sprite_accessory/snouts/mammal/wolfalt
	name = "Mammal, Thick ALT"
	icon_state = "wolfalt"

/datum/sprite_accessory/snouts/mammal/otie
	name = "Otie"
	icon_state = "otie"

/datum/sprite_accessory/snouts/mammal/otiesmile
	name = "Otie Smile"
	icon_state = "otiesmile"

/*/datum/sprite_accessory/snouts/mammal/round
	name = "Mammal Round"
	icon_state = "round"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/roundlight
	name = "Mammal Round + Light"
	icon_state = "roundlight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/snouts/mammal/sergal
	name = "Sergal"
	icon_state = "sergal"

/datum/sprite_accessory/snouts/mammal/akula/shark
	name = "Shark"
	icon_state = "shark"

/datum/sprite_accessory/snouts/mammal/akula/hshark
	name = "hShark"
	icon_state = "hshark"

/datum/sprite_accessory/snouts/mammal/akula/hshark_eyes
	name = "hShark and eyes"
	icon_state = "hshark_eyes"

/*/datum/sprite_accessory/snouts/mammal/sharp
	name = "Mammal Sharp"
	icon_state = "sharp"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/sharplight
	name = "Mammal Sharp + Light"
	icon_state = "sharplight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/toucan
	name = "Toucan"
	icon_state = "toucan"

/datum/sprite_accessory/snouts/mammal/redpanda
	name = "WahCoon"
	icon_state = "wah"

/datum/sprite_accessory/snouts/mammal/redpandaalt
	name = "WahCoon ALT"
	icon_state = "wahalt"

/******************************************
**************** Snouts *******************
*************but higher up*****************/

/datum/sprite_accessory/snouts/mammal/top
	flags_for_organ = SPRITE_ACCESSORY_USE_MUZZLED_SPRITE | SPRITE_ACCESSORY_USE_ALT_FACEWEAR_LAYER
	organ_type = /obj/item/organ/external/snout/top
	relevent_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/snouts/mammal/top/fbird
	name = "Beak (Top)"
	icon_state = "fbird"

/datum/sprite_accessory/snouts/mammal/top/fbigbeak
	name = "Big Beak (Top)"
	icon_state = "fbigbeak"

/datum/sprite_accessory/snouts/mammal/top/fbug
	name = "Bug (Top)"
	icon_state = "fbug"
	flags_for_organ = NONE
	color_src = USE_MATRIXED_COLORS
	organ_type = /obj/item/organ/external/snout/top_adj
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/snouts/mammal/top/felephant
	name = "Elephant (Top)"
	icon_state = "felephant"

/datum/sprite_accessory/snouts/mammal/top/frhino
	name = "Horn (Top)"
	icon_state = "frhino"

/datum/sprite_accessory/snouts/mammal/top/fhusky
	name = "Husky (Top)"
	icon_state = "fhusky"

/datum/sprite_accessory/snouts/mammal/top/vulpkanin/flcanid
	name = "Mammal, Long (Top)"
	icon_state = "flcanid"

/datum/sprite_accessory/snouts/mammal/top/flcanidalt
	name = "Mammal, Long ALT (Top)"
	icon_state = "flcanidalt"

/datum/sprite_accessory/snouts/mammal/top/vulpkanin/flcanidstriped
	name = "Mammal, Long, Striped (Top)"
	icon_state = "flcanidstripe"

/datum/sprite_accessory/snouts/mammal/top/flcanidstripedalt
	name = "Mammal, Long, Striped ALT (Top)"
	icon_state = "flcanidstripealt"

/datum/sprite_accessory/snouts/mammal/top/tajaran/fscanid
	name = "Mammal, Short (Top)"
	icon_state = "fscanid"

/datum/sprite_accessory/snouts/mammal/top/tajaran/fscanidalt
	name = "Mammal, Short ALT (Top)"
	icon_state = "fscanidalt"

/datum/sprite_accessory/snouts/mammal/top/tajaran/fscanidalt2
	name = "Mammal, Short ALT 2 (Top)"
	icon_state = "fscanidalt2"

/datum/sprite_accessory/snouts/mammal/top/tajaran/fscanidalt3
	name = "Mammal, Short ALT 3 (Top)"
	icon_state = "fscanidalt3"

/datum/sprite_accessory/snouts/mammal/top/fwolf
	name = "Mammal, Thick (Top)"
	icon_state = "fwolf"

/datum/sprite_accessory/snouts/mammal/top/fwolfalt
	name = "Mammal, Thick ALT (Top)"
	icon_state = "fwolfalt"

/datum/sprite_accessory/snouts/mammal/top/fotie
	name = "Otie (Top)"
	icon_state = "fotie"

/datum/sprite_accessory/snouts/mammal/top/fotiesmile
	name = "Otie Smile (Top)"
	icon_state = "fotiesmile"

/datum/sprite_accessory/snouts/mammal/top/frodent
	name = "Rodent (Top)"
	icon_state = "frodent"

/*/datum/sprite_accessory/snouts/mammal/top/fround
	name = "Mammal Round (Top)"
	icon_state = "fround"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/top/froundlight
	name = "Mammal Round + Light (Top)"
	icon_state = "froundlight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/top/fpede
	name = "Scolipede (Top)"
	icon_state = "fpede"

/datum/sprite_accessory/snouts/mammal/top/fsergal
	name = "Sergal (Top)"
	icon_state = "fsergal"

/datum/sprite_accessory/snouts/mammal/top/fshark
	name = "Shark (Top)"
	icon_state = "fshark"

/*/datum/sprite_accessory/snouts/mammal/top/fsharp
	name = "Mammal Sharp (Top)"
	icon_state = "fsharp"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/snouts/mammal/top/fsharplight
	name = "Mammal Sharp + Light (Top)"
	icon_state = "fsharplight"
	color_src = USE_ONE_COLOR*/

/datum/sprite_accessory/snouts/mammal/top/ftoucan
	name = "Toucan (Top)"
	icon_state = "ftoucan"

/datum/sprite_accessory/snouts/mammal/top/fredpanda
	name = "WahCoon (Top)"
	icon_state = "fwah"

/datum/sprite_accessory/snouts/mammal/skulldog
	name = "Skulldog"
	icon_state = "skulldog"

/datum/sprite_accessory/snouts/mammal/hanubus
	name = "Anubus"
	icon_state = "hanubus"

/datum/sprite_accessory/snouts/mammal/hpanda
	name = "Panda"
	icon_state = "hpanda"

/datum/sprite_accessory/snouts/mammal/hjackal
	name = "Jackal"
	icon_state = "hjackal"

/datum/sprite_accessory/snouts/mammal/hspots
	name = "Hyena"
	icon_state = "hspots"

/datum/sprite_accessory/snouts/mammal/hhorse
	name = "Horse"
	icon_state = "hhorse"

/datum/sprite_accessory/snouts/mammal/hzebra
	name = "Zebra"
	icon_state = "hzebra"

/datum/sprite_accessory/snouts/mammal/top/fcorvidbeak
	name = "Corvid Beak (Top)"
	icon_state = "fcorvidbeak"

/datum/sprite_accessory/snouts/mammal/akula/shark_light
	name = "Shark Light"
	icon_state = "sharkblubber"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/snouts/mammal/rat
	name = "Rat"
	icon_state = "rat"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/snouts/mammal/stubby
	name = "Stubby"
	icon_state = "stubby"
	color_src = USE_MATRIXED_COLORS
	flags_for_organ = NONE

/datum/sprite_accessory/snouts/mammal/leporid
	name = "Leporid"
	icon_state = "leporid"
	color_src = USE_MATRIXED_COLORS
	flags_for_organ = NONE

/datum/sprite_accessory/snouts/acrador
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	name = "Acrador (Short)"
	icon_state = "acrador_short"

/datum/sprite_accessory/snouts/acrador_1
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	name = "Acrador 1 (Normal)"
	icon_state = "acrador_1"

/datum/sprite_accessory/snouts/acrador_2
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	name = "Acrador 2 (Normal)"
	icon_state = "acrador_2"

/datum/sprite_accessory/snouts/acrador_3
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	name = "Acrador 3 (Normal)"
	icon_state = "acrador_3"

/datum/sprite_accessory/snouts/acrador_4
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_src = USE_MATRIXED_COLORS
	name = "Acrador 4 (Normal)"
	icon_state = "acrador_4"
