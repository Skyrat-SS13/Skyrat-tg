#define BLOOD_VOLUME_OVERSIZED 1000
#define OVERSIZED_SPEED_SLOWDOWN 0.5

/datum/quirk/oversized
	name = "Oversized"
	desc = "You, for whatever reason, are FAR too tall, and will encounter some rough situations because of it."
	gain_text = "<span class='notice'>That airlock looks small...</span>"
	lose_text = "<span class='notice'>Is its still the same size?...</span>" //Lol
	medical_record_text = "Patient is abnormally tall."
	value = 0
	mob_trait = TRAIT_OVERSIZED
	icon = "expand-arrows-alt"

/datum/quirk/oversized/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = 2
	human_holder.dna.update_body_size()
	human_holder.blood_volume = BLOOD_VOLUME_OVERSIZED
	human_holder.mob_size = MOB_SIZE_LARGE
	human_holder.dna.species.punchdamagelow += OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.dna.species.punchdamagehigh += OVERSIZED_HARM_DAMAGE_BONUS
	var/speedmod = human_holder.dna.species.speedmod + OVERSIZED_SPEED_SLOWDOWN
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)
	RegisterSignal(human_holder, COMSIG_LIVING_TRY_PULL, .proc/on_try_pull)

/datum/quirk/oversized/proc/on_try_pull(datum/source, atom/movable/target, force)
	SIGNAL_HANDLER
	if(!HAS_TRAIT(target, TRAIT_OVERSIZED) && !iscyborg(target) && quirk_holder.has_gravity())
		to_chat(target, span_warning("[quirk_holder] is far too heavy for you to pull!"))
		return COMSIG_LIVING_CANCEL_PULL

/datum/quirk/oversized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = 1
	human_holder.dna.update_body_size()
	human_holder.blood_volume = BLOOD_VOLUME_SAFE
	human_holder.mob_size = MOB_SIZE_HUMAN
	human_holder.dna.species.punchdamagelow -= OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.dna.species.punchdamagehigh -= OVERSIZED_HARM_DAMAGE_BONUS
	var/speedmod = human_holder.dna.species.speedmod
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)
	UnregisterSignal(human_holder, COMSIG_LIVING_TRY_PULL)

#undef BLOOD_VOLUME_OVERSIZED
#undef OVERSIZED_SPEED_SLOWDOWN
