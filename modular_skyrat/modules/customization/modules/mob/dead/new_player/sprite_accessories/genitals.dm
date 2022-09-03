/datum/sprite_accessory/genital
	special_render_case = TRUE
	special_colorize = TRUE
	var/associated_organ_slot
	/// If true, then there should be a variant in the icon file that's slightly pinkier to match human base colors.
	var/has_skintone_shading = FALSE
	///Where the genital is on the body. If clothing doesn't cover it, it shows up!
	var/genital_location = GROIN

/datum/sprite_accessory/genital/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	var/obj/item/organ/external/genital/badonkers = H.getorganslot(associated_organ_slot)
	if(!badonkers)
		return TRUE
	switch(badonkers.visibility_preference)
		if(GENITAL_ALWAYS_SHOW)
			return FALSE
		if(GENITAL_HIDDEN_BY_CLOTHES)
			if((H.w_uniform && H.w_uniform.body_parts_covered & genital_location) || (H.wear_suit && H.wear_suit.body_parts_covered & genital_location))
				return TRUE
			else
				return FALSE
		else
			return TRUE

/datum/sprite_accessory/genital/get_special_render_state(mob/living/carbon/human/human)
	var/obj/item/organ/external/genital/genital = human.getorganslot(associated_organ_slot)
	return "[genital?.sprite_suffix]"

/datum/sprite_accessory/genital/get_special_render_colour(mob/living/carbon/human/human, render_state)
	var/obj/item/organ/external/genital/genital = human.getorganslot(associated_organ_slot)
	if(genital?.uses_skin_color && human.dna.species.use_skintones)
		return skintone2hex(human.skin_tone)

/datum/sprite_accessory/genital/penis
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/penis_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = NAME_PENIS
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE
	special_icon_case = TRUE
	special_x_dimension = TRUE
	//default_color = DEFAULT_SKIN_OR_PRIMARY //This is the price we're paying for sheaths
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE
	var/can_have_sheath = TRUE

/datum/sprite_accessory/genital/penis/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	. = ..()

/datum/sprite_accessory/genital/penis/get_special_icon(mob/living/carbon/human/H)
	var/returned = icon
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/taur_penis_onmob.dmi'
	return returned

/datum/sprite_accessory/genital/penis/get_special_x_dimension(mob/living/carbon/human/H)
	var/returned = dimension_x
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 64
	return returned

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = "None"
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
	key = "testicles"
	always_color_customizable = TRUE
	special_icon_case = TRUE
	special_x_dimension = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	genetic = TRUE
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	. = ..()

/datum/sprite_accessory/genital/testicles/get_special_icon(mob/living/carbon/human/H)
	var/returned = icon
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/taur_testicles_onmob.dmi'
	return returned

/datum/sprite_accessory/genital/testicles/get_special_x_dimension(mob/living/carbon/human/H)
	var/returned = dimension_x
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & STYLE_TAUR_SNAKE))
			returned = 64
	return returned

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = "None"
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
	key = NAME_VAGINA
	always_color_customizable = TRUE
	default_color = "#FFCCCC"
	relevent_layers = list(BODY_FRONT_LAYER)
	genetic = TRUE
	var/alt_aroused = TRUE

/datum/sprite_accessory/genital/vagina/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	. = ..()

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

/datum/sprite_accessory/genital/vagina/cloaca
	icon_state = "cloaca"
	name = "Cloaca"

/datum/sprite_accessory/genital/womb
	organ_type = /obj/item/organ/external/genital/womb
	associated_organ_slot = ORGAN_SLOT_WOMB
	key = "womb"
	genetic = TRUE

/datum/sprite_accessory/genital/womb/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/womb/normal
	icon_state = "none"
	name = "Normal"
	color_src = null

/datum/sprite_accessory/genital/anus
	organ_type = /obj/item/organ/external/genital/anus
	associated_organ_slot = ORGAN_SLOT_ANUS
	key = NAME_ANUS
	genetic = TRUE

/datum/sprite_accessory/genital/anus/is_hidden(mob/living/carbon/human/owner, obj/item/bodypart/bodypart)
	if(owner.underwear != "Nude" && !(owner.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
		return TRUE
	. = ..()

/datum/sprite_accessory/genital/anus/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/anus/normal
	icon_state = NAME_ANUS
	name = "Anus"
	color_src = null

/datum/sprite_accessory/genital/breasts
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/genitals/breasts_onmob.dmi'
	organ_type = /obj/item/organ/external/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = "breasts"
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	has_skintone_shading = TRUE
	genital_location = CHEST
	genetic = TRUE

/datum/sprite_accessory/genital/breasts/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.undershirt != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
		return TRUE
	. = ..()

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
