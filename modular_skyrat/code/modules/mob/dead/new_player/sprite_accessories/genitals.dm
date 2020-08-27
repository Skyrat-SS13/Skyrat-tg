/datum/sprite_accessory/genital
	skip_type = /datum/sprite_accessory/genital
	special_render_case = TRUE
	var/associated_organ_slot 

/datum/sprite_accessory/genital/get_special_render_state(mob/living/carbon/human/H, icon_state)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		return  "[icon_state]_[gen.sprite_suffix]"
	else
		return null

/datum/sprite_accessory/genital/penis
	icon = 'modular_skyrat/icons/mob/sprite_accessory/genitals/penis_onmob.dmi'
	skip_type = /datum/sprite_accessory/genital/penis
	organ_type = /obj/item/organ/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = "penis"
	always_color_customizable = TRUE

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/penis/human
	icon_state = "human"
	name = "Human"

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
	icon = 'modular_skyrat/icons/mob/sprite_accessory/genitals/testicles_onmob.dmi'
	skip_type = /datum/sprite_accessory/genital/testicles
	organ_type = /obj/item/organ/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = "testicles"
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/testicles/pair
	name = "Pair"
	icon_state = "pair"

/datum/sprite_accessory/genital/testicles/internal
	name = "Internal"
	icon_state = "none"
	color_src = null
	has_size = FALSE

/datum/sprite_accessory/genital/vagina
	icon = 'modular_skyrat/icons/mob/sprite_accessory/genitals/vagina_onmob.dmi'
	skip_type = /datum/sprite_accessory/genital/vagina
	organ_type = /obj/item/organ/genital/vagina
	associated_organ_slot = ORGAN_SLOT_VAGINA
	key = "vagina"
	always_color_customizable = TRUE
	default_color = "fcc"
	var/alt_aroused = TRUE

/datum/sprite_accessory/genital/vagina/get_special_render_state(mob/living/carbon/human/H, icon_state)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		return "[icon_state]_[gen.aroused]"
	else
		return null

/datum/sprite_accessory/genital/vagina/none
	icon_state = "none"
	name = "None"
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

/datum/sprite_accessory/genital/womb/normal
	icon_state = "none"
	name = "Normal"
	color_src = null

/datum/sprite_accessory/genital/breasts
	icon = 'modular_skyrat/icons/mob/sprite_accessory/genitals/breasts_onmob.dmi'
	skip_type = /datum/sprite_accessory/genital/breasts
	organ_type = /obj/item/organ/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = "breasts"

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
