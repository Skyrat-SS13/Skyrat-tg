/datum/sprite_accessory/genital
	skip_type = /datum/sprite_accessory/genital
	special_render_case = TRUE
	var/associated_organ_slot 

/datum/sprite_accessory/genital/penis
	skip_type = /datum/sprite_accessory/genital/penis
	organ_type = /obj/item/organ/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = "penis"

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/testicles
	skip_type = /datum/sprite_accessory/genital/testicles
	organ_type = /obj/item/organ/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = "testicles"

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/vagina
	skip_type = /datum/sprite_accessory/genital/vagina
	organ_type = /obj/item/organ/genital/vagina
	associated_organ_slot = ORGAN_SLOT_VAGINA
	key = "vagina"

/datum/sprite_accessory/genital/vagina/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/womb
	skip_type = /datum/sprite_accessory/genital/womb
	organ_type = /obj/item/organ/genital/womb
	associated_organ_slot = ORGAN_SLOT_WOMB
	key = "womb"

/datum/sprite_accessory/genital/womb/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/breasts
	icon = 'modular_skyrat/icons/mob/sprite_accessory/genitals/breasts_onmob.dmi'
	skip_type = /datum/sprite_accessory/genital/breasts
	organ_type = /obj/item/organ/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = "breasts"

/datum/sprite_accessory/genital/breasts/get_special_render_state(mob/living/carbon/human/H, icon_state)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		return gen.sprite_suffix
	else
		return null

/datum/sprite_accessory/genital/breasts/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	var/obj/item/organ/genital/breasts/badonkers = H.getorganslot(associated_organ_slot)
	if(!badonkers)
		return TRUE
	switch(badonkers.visibility_preference)
		if(GENITAL_ALWAYS_SHOW)
			return FALSE
		if(GENITAL_HIDDEN_BY_CLOTHES)
			if(H.w_uniform || H.wear_suit)
				return TRUE
			else
				return FALSE
		else
			return TRUE

/datum/sprite_accessory/genital/breasts/none
	icon_state = "none"
	name = "None"
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
