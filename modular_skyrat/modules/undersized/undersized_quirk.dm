#define UNDERSIZED_SPEED_SLOWDOWN 0.5

/datum/quirk/undersized
	name = "Undersized"
	desc = "You, for whatever reason, are FAR too small, and will encounter some rough situations because of it."
	gain_text = span_notice("That table looks large...")
	lose_text = span_notice("Is it still the same size...?") //hehe
	medical_record_text = "Patient is abnormally small."
	value = 0
	mob_trait = TRAIT_UNDERSIZED
	icon = "minimize"
	veteran_only = TRUE

/datum/quirk/undersized/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = .3
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_SMALL
	human_holder.dna.species.punchdamagelow += UNDERSIZED_HARM_DAMAGE_PENALITY
	human_holder.dna.species.punchdamagehigh += UNDERSIZED_HARM_DAMAGE_PENALITY
	human_holder.blood_volume_normal = BLOOD_VOLUME_UNDERSIZED
	var/speedmod = human_holder.dna.species.speedmod + UNDERSIZED_SPEED_SLOWDOWN
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)
	remove_verb(src, /mob/living/verb/pulled)

/datum/quirk/undersized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = human_holder?.client?.prefs ?human_holder?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) : 1
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_HUMAN
	human_holder.dna.species.punchdamagelow -= UNDERSIZED_HARM_DAMAGE_PENALITY
	human_holder.dna.species.punchdamagehigh -= UNDERSIZED_HARM_DAMAGE_PENALITY
	human_holder.blood_volume_normal = BLOOD_VOLUME_NORMAL
	var/speedmod = human_holder.dna.species.speedmod
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)
	add_verb(src, /mob/living/verb/pulled)

#undef UNDERSIZED_SPEED_SLOWDOWN
