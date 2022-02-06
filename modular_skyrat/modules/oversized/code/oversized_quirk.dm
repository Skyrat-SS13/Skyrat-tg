#define OVERSIZED_SPEED_SLOWDOWN 0.5

/datum/quirk/oversized
	name = "Oversized"
	desc = "You, for whatever reason, are FAR too tall, and will encounter some rough situations because of it."
	gain_text = span_notice("That airlock looks small...")
	lose_text = span_notice("Is it still the same size...?") //Lol
	medical_record_text = "Patient is abnormally tall."
	value = 0
	mob_trait = TRAIT_OVERSIZED
	icon = "expand-arrows-alt"
	veteran_only = TRUE

/datum/quirk/oversized/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = 2
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"] //Adjust runechat height
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_LARGE
	human_holder.dna.species.punchdamagelow += OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.dna.species.punchdamagehigh += OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.blood_volume_normal = BLOOD_VOLUME_OVERSIZED
	var/speedmod = human_holder.dna.species.speedmod + OVERSIZED_SPEED_SLOWDOWN
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

/datum/quirk/oversized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = human_holder?.client?.prefs ?human_holder?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) : 1
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"]
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_HUMAN
	human_holder.dna.species.punchdamagelow -= OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.dna.species.punchdamagehigh -= OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.blood_volume_normal = BLOOD_VOLUME_NORMAL
	var/speedmod = human_holder.dna.species.speedmod
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

#undef OVERSIZED_SPEED_SLOWDOWN
