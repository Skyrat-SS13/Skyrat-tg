/datum/sprite_accessory/tails
	key = "tail"
	generic = "Tail"
	organ_type = /obj/item/organ/tail
	icon = 'modular_skyrat/master_files/icons/mob/mutant_bodyparts.dmi'
	special_render_case = TRUE
	special_icon_case = TRUE
	special_colorize = TRUE
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	/// A generalisation of the tail-type, e.g. lizard or feline, for hardsuit or other sprites
	var/general_type

/datum/sprite_accessory/tails/get_special_render_state(mob/living/carbon/human/H)
	// Hardsuit tail spriting
	if(general_type && H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit))
		var/obj/item/clothing/suit/space/hardsuit/HS = H.wear_suit
		if(HS.hardsuit_tail_colors)
			return "[general_type]_hardsuit"

	var/obj/item/organ/tail/T = H.getorganslot(ORGAN_SLOT_TAIL)
	if(T && T.wagging)
		return "[icon_state]_wagging"

	return icon_state

/datum/sprite_accessory/tails/get_special_icon(mob/living/carbon/human/H, passed_state)
	var/returned = icon
	if(passed_state == "[general_type]_hardsuit") //Guarantees we're wearing a hardsuit, skip checks
		var/obj/item/clothing/suit/space/hardsuit/HS = H.wear_suit
		if(HS.hardsuit_tail_colors)
			returned = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails_hardsuit.dmi'
	return returned

/datum/sprite_accessory/tails/get_special_render_colour(mob/living/carbon/human/H, passed_state)
	if(passed_state == "[general_type]_hardsuit") //Guarantees we're wearing a hardsuit, skip checks
		var/obj/item/clothing/suit/space/hardsuit/HS = H.wear_suit
		if(HS.hardsuit_tail_colors)
			//Currently this way, when I have more time I'll write a hex -> matrix converter to pre-bake them instead
			var/list/finished_list = list()
			finished_list += ReadRGB("[HS.hardsuit_tail_colors[1]]0")
			finished_list += ReadRGB("[HS.hardsuit_tail_colors[2]]0")
			finished_list += ReadRGB("[HS.hardsuit_tail_colors[3]]0")
			finished_list += list(0,0,0,255)
			for(var/index in 1 to finished_list.len)
				finished_list[index] /= 255
			return finished_list
	return null

/datum/sprite_accessory/tails/lizard
	recommended_species = list("lizard", "ashlizard", "synthmammal", "mammal", "unathi", "silverlizard")
	organ_type = /obj/item/organ/tail/lizard
	general_type = "lizard"

/datum/sprite_accessory/tails/human
	recommended_species = list("human", "synthhuman", "felinid", "synthmammal", "mammal")
	organ_type = /obj/item/organ/tail/cat

/datum/sprite_accessory/tails/monkey/default
	name = "Monkey"
	icon_state = "monkey"
	icon = 'icons/mob/mutant_bodyparts.dmi'
	recommended_species = list("human", "synthhuman", "felinid", "synthmammal", "mammal", "monkey")
	color_src = FALSE
	organ_type = /obj/item/organ/tail/monkey

/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit)
		if(H.try_hide_mutant_parts)
			return TRUE
		if(H.wear_suit.flags_inv & HIDEJUMPSUIT)
			if(istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit))
				var/obj/item/clothing/suit/space/hardsuit/HS = H.wear_suit
				if(HS.hardsuit_tail_colors)
					return FALSE
			return TRUE
	return FALSE

/datum/sprite_accessory/tails/none
	name = "None"
	icon_state = "none"
	recommended_species = list("synthmammal", "mammal", "human", "synthhuman", "humanoid")
	color_src = null
	factual = FALSE

/datum/sprite_accessory/tails/mammal
	icon_state = "none"
	recommended_species = list("synthmammal", "mammal","human", "synthhuman", "humanoid")
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails.dmi'
	organ_type = /obj/item/organ/tail/fluffy/no_wag
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/tails/mammal/wagging
	organ_type = /obj/item/organ/tail/fluffy

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin
	recommended_species = list("synthmammal", "mammal", "human", "synthhuman", "vulpkanin", "humanoid")
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/tajaran
	recommended_species = list("synthmammal", "mammal", "human", "synthhuman", "tajaran", "humanoid")
	general_type = "feline"

/datum/sprite_accessory/tails/mammal/wagging/akula
	recommended_species = list("synthmammal", "mammal", "human", "synthhuman", "akula", "aquatic", "humanoid")
	general_type = "marine"

/datum/sprite_accessory/tails/mammal/wagging/avian1
	name = "Avian (alt 1)"
	icon_state = "avian1"
	general_type = "avian"

/datum/sprite_accessory/tails/mammal/wagging/avian2
	name = "Avian (alt 2)"
	icon_state = "avian2"
	general_type = "avian"

/datum/sprite_accessory/tails/mammal/wagging/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	general_type = "lizard"

/datum/sprite_accessory/tails/mammal/wagging/batl
	name = "Bat (Long)"
	icon_state = "batl"
	general_type = "feline"

/datum/sprite_accessory/tails/mammal/wagging/bats
	name = "Bat (Short)"
	icon_state = "bats"
	general_type = "feline"

/datum/sprite_accessory/tails/mammal/wagging/cable
	name = "Cable"
	icon_state = "cable"

/datum/sprite_accessory/tails/mammal/wagging/bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/tails/mammal/wagging/tajaran/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	color_src = USE_ONE_COLOR
	general_type = "feline"

/datum/sprite_accessory/tails/mammal/wagging/twocat
	name = "Cat, Double"
	icon_state = "twocat"

/datum/sprite_accessory/tails/mammal/wagging/corvid
	name = "Corvid"
	icon_state = "crow"
	general_type = "avian"

/datum/sprite_accessory/tails/mammal/wagging/cow
	name = "Cow"
	icon_state = "cow"

/*/datum/sprite_accessory/tails/mammal/wagging/dtiger //icon = 'icons/mob/mutant_bodyparts.dmi'
	name = "Dark Tiger"
	icon_state = "dtiger"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY*/

/datum/sprite_accessory/tails/mammal/wagging/eevee
	name = "Eevee"
	icon_state = "eevee"
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/fennec
	name = "Fennec"
	icon_state = "fennec"
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/fish
	name = "Fish"
	icon_state = "fish"
	general_type = "marine"

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox
	name = "Fox"
	icon_state = "fox"
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox2
	name = "Fox (Alt 2)"
	icon_state = "fox2"
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/vulpkanin/fox3
	name = "Fox (Alt 3)"
	icon_state = "fox3"
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/hawk
	name = "Hawk"
	icon_state = "hawk"
	general_type = "avian"


/datum/sprite_accessory/tails/mammal/wagging/horse
	name = "Horse"
	icon_state = "horse"
	color_src = USE_ONE_COLOR
	default_color = HAIR

/datum/sprite_accessory/tails/mammal/wagging/husky
	name = "Husky"
	icon_state = "husky"
	general_type = "shepherdlike"

/datum/sprite_accessory/tails/mammal/wagging/insect
	name = "Insect"
	icon_state = "insect"

/datum/sprite_accessory/tails/mammal/wagging/kangaroo
	name = "kangaroo"
	icon_state = "kangaroo"
	general_type = "straighttail"

/datum/sprite_accessory/tails/mammal/wagging/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	general_type = "vulpine" // vulpine until I can be bothered to make kitsune hardsuit tailsprite!

/datum/sprite_accessory/tails/mammal/wagging/lab
	name = "Lab"
	icon_state = "lab"

/datum/sprite_accessory/tails/mammal/wagging/leopard
	name = "Leopard"
	icon_state = "leopard"
	general_type = "feline"

/*/datum/sprite_accessory/tails/mammal/wagging/ltiger //icon = 'icons/mob/mutant_bodyparts.dmi'
	name = "Light Tiger"
	icon_state = "ltiger"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY*/

/datum/sprite_accessory/tails/mammal/wagging/murid
	name = "Murid"
	icon_state = "murid"

/datum/sprite_accessory/tails/mammal/wagging/orca
	name = "Orca"
	icon_state = "orca"
	general_type = "marine"

/datum/sprite_accessory/tails/mammal/wagging/otie
	name = "Otusian"
	icon_state = "otie"
	general_type = "straighttail"

/datum/sprite_accessory/tails/mammal/wagging/rabbit
	name = "Rabbit"
	icon_state = "rabbit"

/datum/sprite_accessory/tails/mammal/wagging/ailurus
	name = "Red Panda"
	icon_state = "wah"
	extra = TRUE

/datum/sprite_accessory/tails/mammal/wagging/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/tails/mammal/wagging/sergal
	name = "Sergal"
	icon_state = "sergal"
	general_type = "shepherdlike"

/datum/sprite_accessory/tails/mammal/wagging/akula/shark
	name = "Shark"
	icon_state = "shark"
	general_type = "marine"

/datum/sprite_accessory/tails/mammal/wagging/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	general_type = "shepherdlike"

/datum/sprite_accessory/tails/mammal/wagging/skunk
	name = "Skunk"
	icon_state = "skunk"
	general_type = "vulpine"

/datum/sprite_accessory/tails/mammal/wagging/stripe
	name = "Stripe"
	icon_state = "stripe"

/datum/sprite_accessory/tails/mammal/wagging/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"
	general_type = "straighttail"

/datum/sprite_accessory/tails/mammal/wagging/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/tamamo_kitsune
	name = "Tamamo Kitsune Tails"
	icon_state = "9sune"

/datum/sprite_accessory/tails/mammal/wagging/tentacle
	name = "Tentacle"
	icon_state = "tentacle"

/datum/sprite_accessory/tails/mammal/wagging/tiger
	name = "Tiger"
	icon_state = "tiger"
	general_type = "feline"


/datum/sprite_accessory/tails/mammal/wagging/wolf
	name = "Wolf"
	icon_state = "wolf"
	color_src = USE_ONE_COLOR
	general_type = "shepherdlike"

/datum/sprite_accessory/tails/mammal/wagging/guilmon
	name = "Guilmon"
	icon_state = "guilmon"
	general_type = "lizard"

/datum/sprite_accessory/tails/mammal/wagging/akula/sharknofin
	name = "Shark no fin"
	icon_state = "sharknofin"
	general_type = "marine"

/datum/sprite_accessory/tails/mammal/raptor
    name = "Raptor"
    icon_state = "raptor"

/datum/sprite_accessory/tails/mammal/wagging/lunasune
	name = "Lunasune"
	icon_state = "lunasune"
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/tails/mammal/wagging/spade
	name = "Succubus Spade Tail"
	icon_state = "spade"
