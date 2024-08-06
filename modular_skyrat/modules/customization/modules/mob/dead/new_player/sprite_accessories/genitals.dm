/// The alternative `dimension_x` to use if it's a taur.
#define TAUR_DIMENSION_X 64

/datum/sprite_accessory/genital
	var/associated_organ_slot
	/// If true, then there should be a variant in the icon file that's slightly pinkier to match human base colors.
	var/has_skintone_shading = FALSE
	///Where the genital is on the body. If clothing doesn't cover it, it shows up!
	var/genital_location = GROIN

/datum/sprite_accessory/genital/is_hidden(mob/living/carbon/human/target_mob)
	var/obj/item/organ/external/genital/badonkers = target_mob.get_organ_slot(associated_organ_slot)
	if(!badonkers)
		return TRUE
	switch(badonkers.visibility_preference)
		if(GENITAL_ALWAYS_SHOW) //Never hidden
			return FALSE
		if(GENITAL_HIDDEN_BY_CLOTHES) //Hidden if the relevant body parts are covered by clothes or underwear
			//Do they have a Uniform or Suit that covers them?
			if((target_mob.w_uniform && target_mob.w_uniform.body_parts_covered & genital_location) || (target_mob.wear_suit && target_mob.wear_suit.body_parts_covered & genital_location))
				return TRUE
			//Do they have a Hospital Gown covering them? (The gown has no body_parts_covered so needs its own check)
			if(istype(target_mob.wear_suit, /obj/item/clothing/suit/toggle/labcoat/hospitalgown))
				return TRUE

			//Are they wearing an Undershirt?
			if(target_mob.undershirt != "Nude" && !(target_mob.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
				var/datum/sprite_accessory/undershirt/worn_undershirt = SSaccessories.undershirt_list[target_mob.undershirt]
				//Does this Undershirt cover a relevant slot?
				if(genital_location == CHEST) //(Undershirt always covers chest)
					return TRUE

				else if(genital_location == GROIN && worn_undershirt.hides_groin)
					return TRUE

			//Undershirt didn't cover them, are they wearing Underwear?
			if(target_mob.underwear != "Nude" && !(target_mob.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
				var/datum/sprite_accessory/underwear/worn_underwear = SSaccessories.underwear_list[target_mob.underwear]
				//Does this Underwear cover a relevant slot?
				if(genital_location == GROIN) //(Underwear always covers groin)
					return TRUE

				else if(genital_location == CHEST && worn_underwear.hides_breasts)
					return TRUE

			//Are they wearing a bra?
			if(target_mob.bra != "Nude" && !(target_mob.underwear_visibility & UNDERWEAR_HIDE_BRA) && genital_location == CHEST)
				return TRUE

			//Nothing they're wearing will cover them
			else
				return FALSE

		//If not always shown or hidden by clothes, then it defaults to always hidden
		else
			return TRUE

/datum/sprite_accessory/genital/penis
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/penis_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = ORGAN_SLOT_PENIS
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE
	special_x_dimension = TRUE
	//default_color = DEFAULT_SKIN_OR_PRIMARY //This is the price we're paying for sheaths
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	var/can_have_sheath = TRUE

/datum/sprite_accessory/genital/penis/get_special_icon(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & STYLE_TAUR_SNAKE)
		return icon

	return 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/taur_penis_onmob.dmi'

/datum/sprite_accessory/genital/penis/get_special_x_dimension(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & STYLE_TAUR_SNAKE)
		return dimension_x

	return TAUR_DIMENSION_X

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/penis/human
	icon_state = "human"
	name = "Human"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY
	has_skintone_shading = TRUE
	can_have_sheath = FALSE

/datum/sprite_accessory/genital/penis/nondescript
	icon_state = "nondescript"
	name = "Nondescript"

/datum/sprite_accessory/genital/penis/knotted
	icon_state = "knotted"
	name = "Knotted"

/datum/sprite_accessory/genital/penis/flared
	icon_state = "flared"
	name = "Flared"

/datum/sprite_accessory/genital/penis/barbknot
	icon_state = "barbknot"
	name = "Barbed, Knotted"

/datum/sprite_accessory/genital/penis/tapered
	icon_state = "tapered"
	name = "Tapered"

/datum/sprite_accessory/genital/penis/tentacle
	icon_state = "tentacle"
	name = "Tentacled"

/datum/sprite_accessory/genital/penis/hemi
	icon_state = "hemi"
	name = "Hemi"

/datum/sprite_accessory/genital/penis/hemiknot
	icon_state = "hemiknot"
	name = "Knotted Hemi"

/datum/sprite_accessory/genital/testicles
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/testicles_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = ORGAN_SLOT_TESTICLES
	always_color_customizable = TRUE
	special_x_dimension = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	genetic = TRUE
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/get_special_icon(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & STYLE_TAUR_SNAKE)
		return icon

	return 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/taur_penis_onmob.dmi'

/datum/sprite_accessory/genital/testicles/get_special_x_dimension(mob/living/carbon/human/target_mob)
	var/taur_mode = target_mob?.get_taur_mode()

	if(!taur_mode || !target_mob.dna.features["penis_taur_mode"] || taur_mode & STYLE_TAUR_SNAKE)
		return dimension_x

	return TAUR_DIMENSION_X

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/testicles/pair
	name = "Pair"
	icon_state = "pair"
	has_skintone_shading = TRUE

/datum/sprite_accessory/genital/testicles/internal
	name = "Internal"
	icon_state = "none"
	color_src = null
	has_size = FALSE

/datum/sprite_accessory/genital/vagina
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/vagina_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/vagina
	associated_organ_slot = ORGAN_SLOT_VAGINA
	key = ORGAN_SLOT_VAGINA
	always_color_customizable = TRUE
	default_color = "#FFCCCC"
	relevent_layers = list(BODY_FRONT_LAYER)
	genetic = TRUE
	var/alt_aroused = TRUE

/datum/sprite_accessory/genital/vagina/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "none"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/vagina/human
	icon_state = "human"
	name = "Human"

/datum/sprite_accessory/genital/vagina/tentacles
	icon_state = "tentacle"
	name = "Tentacle"

/datum/sprite_accessory/genital/vagina/dentata
	icon_state = "dentata"
	name = "Dentata"

/datum/sprite_accessory/genital/vagina/hairy
	icon_state = "hairy"
	name = "Hairy"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/spade
	icon_state = "spade"
	name = "Spade"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/furred
	icon_state = "furred"
	name = "Furred"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/gaping
	icon_state = "gaping"
	name = "Gaping"

/datum/sprite_accessory/genital/vagina/cloaca
	icon_state = "cloaca"
	name = "Cloaca"

/datum/sprite_accessory/genital/womb
	organ_type = /obj/item/organ/external/genital/womb
	associated_organ_slot = ORGAN_SLOT_WOMB
	key = ORGAN_SLOT_WOMB
	genetic = TRUE

/datum/sprite_accessory/genital/womb/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/womb/normal
	icon_state = "none"
	name = "Normal"
	color_src = null

/datum/sprite_accessory/genital/anus
	organ_type = /obj/item/organ/external/genital/anus
	associated_organ_slot = ORGAN_SLOT_ANUS
	key = ORGAN_SLOT_ANUS
	genetic = TRUE

/datum/sprite_accessory/genital/anus/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/anus/normal
	icon_state = "anus"
	name = "Anus"
	color_src = null

/datum/sprite_accessory/genital/breasts
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/breasts_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = ORGAN_SLOT_BREASTS
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	has_skintone_shading = TRUE
	genital_location = CHEST
	genetic = TRUE

/datum/sprite_accessory/genital/breasts/none
	icon_state = "none"
	name = SPRITE_ACCESSORY_NONE
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/breasts/pair
	icon_state = "pair"
	name = "Pair"

/datum/sprite_accessory/genital/breasts/quad
	icon_state = "quad"
	name = "Quad"

/datum/sprite_accessory/genital/breasts/sextuple
	icon_state = "sextuple"
	name = "Sextuple"

#undef TAUR_DIMENSION_X
