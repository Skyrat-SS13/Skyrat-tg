/**
 * Get a human's taur mode in a standardized way.
 *
 * Returns STYLE_TAUR_* or NONE.
 */
/mob/living/carbon/human/proc/get_taur_mode()
	var/taur_mutant_bodypart = dna.species.mutant_bodyparts["taur"]
	if(!taur_mutant_bodypart)
		return NONE

	var/bodypart_name = taur_mutant_bodypart[MUTANT_INDEX_NAME]
	var/datum/sprite_accessory/taur/taur = SSaccessories.sprite_accessories["taur"][bodypart_name]
	if(!taur)
		return NONE

	return taur.taur_mode

/datum/sprite_accessory/taur
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/taur.dmi'
	key = "taur"
	generic = "Taur Type"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 64
	center = TRUE
	relevent_layers = list(BODY_FRONT_LAYER, BODY_ADJ_LAYER, BODY_FRONT_UNDER_CLOTHES, ABOVE_BODY_FRONT_HEAD_LAYER)
	genetic = TRUE
	organ_type = /obj/item/organ/external/taur_body/horselike // horselike by default, dont forget to override if you make another bodytype
	flags_for_organ = SPRITE_ACCESSORY_HIDE_SHOES
	/// Must be a single specific tauric suit variation bitflag. Don't do FLAG_1|FLAG_2
	var/taur_mode = NONE
	/// Must be a single specific tauric suit variation bitflag. Don't do FLAG_1|FLAG_2
	var/alt_taur_mode = NONE

/datum/sprite_accessory/taur/is_hidden(mob/living/carbon/human/target)
	var/obj/item/organ/external/taur_body/taur_body = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAUR)
	if (taur_body?.hide_self)
		return TRUE

	var/obj/item/clothing/suit/worn_suit = target.wear_suit
	if (istype(worn_suit))
		if((worn_suit.flags_inv & HIDETAIL) && !worn_suit.gets_cropped_on_taurs)
			return TRUE

		if (worn_suit.flags_inv & HIDETAUR)
			switch (taur_mode)
				if (STYLE_TAUR_SNAKE)
					if (worn_suit.worn_icon_taur_snake)
						return TRUE
				if (STYLE_TAUR_PAW)
					if (worn_suit.worn_icon_taur_paw)
						return TRUE
				if (STYLE_TAUR_HOOF)
					if (worn_suit.worn_icon_taur_hoof)
						return TRUE

	if(target.owned_turf)
		var/list/used_in_turf = list("tail")
		if(target.owned_turf.name in used_in_turf)
			return TRUE

	return FALSE

/datum/sprite_accessory/taur/none
	name = "None"
	dimension_x = 32
	center = FALSE
	factual = FALSE
	color_src = null
	flags_for_organ = NONE

/datum/sprite_accessory/taur/cow
	name = "Cow"
	icon_state = "cow"
	taur_mode = STYLE_TAUR_HOOF
	alt_taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/taur/cow/spotted
	name = "Cow (Spotted)"
	icon_state = "cow_spotted"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/taur/deer
	name = "Deer"
	icon_state = "deer"
	taur_mode = STYLE_TAUR_HOOF
	alt_taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/drake
	name = "Drake"
	icon_state = "drake"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/drake/old
	name = "Drake (Old)"
	icon_state = "drake_old"

/datum/sprite_accessory/taur/tarantula
	name = "Tarantula"
	icon_state = "tarantula"
	organ_type = /obj/item/organ/external/taur_body/spider

/datum/sprite_accessory/taur/drider
	name = "Drider"
	icon_state = "drider"
	organ_type = /obj/item/organ/external/taur_body/spider

/datum/sprite_accessory/taur/eevee
	name = "Eevee"
	icon_state = "eevee"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/horse
	name = "Horse"
	icon_state = "horse"
	taur_mode = STYLE_TAUR_HOOF
	alt_taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/naga
	name = "Naga"
	icon_state = "naga"
	taur_mode = STYLE_TAUR_SNAKE
	organ_type = /obj/item/organ/external/taur_body/serpentine

/datum/sprite_accessory/taur/naga/striped
	name = "Naga, Striped"
	icon_state = "nagastriped"
	taur_mode = STYLE_TAUR_SNAKE

/datum/sprite_accessory/taur/naga/rattle
	name = "Naga, Rattle"
	icon_state = "nagarattle"
	taur_mode = STYLE_TAUR_SNAKE

/datum/sprite_accessory/taur/otie
	name = "Otie"
	icon_state = "otie"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/pede
	name = "Scolipede"
	icon_state = "pede"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	taur_mode = STYLE_TAUR_SNAKE
	color_src = USE_ONE_COLOR
	organ_type = /obj/item/organ/external/taur_body/tentacle

/datum/sprite_accessory/taur/tentacle/alt
	name = "Tentacle, Alt"
	icon_state = "tentaclealt"
	taur_mode = STYLE_TAUR_SNAKE
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/taur/canine
	name = "Canine"
	icon_state = "canine"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/feline
	name = "Feline"
	icon_state = "feline"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/goop
	name = "Goop"
	icon_state = "goop"
	taur_mode = STYLE_TAUR_SNAKE
	color_src = USE_ONE_COLOR
	organ_type = /obj/item/organ/external/taur_body/blob

/datum/sprite_accessory/taur/slime
	name = "Slime"
	icon_state = "slime"
	taur_mode = STYLE_TAUR_SNAKE
	color_src = USE_ONE_COLOR
	organ_type = /obj/item/organ/external/taur_body/blob

/datum/sprite_accessory/taur/biglegs
	name = "Big Legs"
	icon_state = "biglegs"
	taur_mode = STYLE_TAUR_PAW
	organ_type = /obj/item/organ/external/taur_body/anthro

/datum/sprite_accessory/taur/biglegs/stanced
	name = "Big Legs, Stanced"
	icon_state = "biglegs_stanced"

/datum/sprite_accessory/taur/biglegs/bird
	name = "Big Legs, Bird"
	icon_state = "biglegs_bird"

/datum/sprite_accessory/taur/biglegs/stanced/bird
	name = "Big Legs, Stanced Bird"
	icon_state = "biglegs_bird_stanced"
