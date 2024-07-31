/obj/item/organ/internal/tongue/synth
	name = "synthetic voicebox"
	desc = "A fully-functional synthetic tongue, encased in soft silicone. Features include high-resolution vocals and taste receptors."
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue"
	say_mod = "beeps"
	attack_verb_continuous = list("beeps", "boops")
	attack_verb_simple = list("beep", "boop")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	liked_foodtypes = NONE
	disliked_foodtypes = NONE
	maxHealth = 100 //RoboTongue!
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_TONGUE
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/tongue/synth/can_speak_language(language)
	return TRUE

/obj/item/organ/internal/tongue/synth/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/datum/design/synth_tongue
	name = "Synthetic Tongue"
	desc = "A fully-functional synthetic tongue, encased in soft silicone. Features include high-resolution vocals and taste receptors."
	id = "synth_tongue"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/internal/tongue/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
