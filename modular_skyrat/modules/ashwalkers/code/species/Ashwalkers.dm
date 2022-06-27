/datum/species/lizard/ashwalker
	mutanteyes = /obj/item/organ/internal/eyes/night_vision
	burnmod = 0.7
	brutemod = 0.8

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	ADD_TRAIT(C, TRAIT_ASHSTORM_IMMUNE, SPECIES_TRAIT)
	RegisterSignal(C, COMSIG_MOB_ITEM_ATTACK, .proc/mob_attack)

/datum/species/lizard/ashwalker/on_species_loss(mob/living/carbon/C)
	. = ..()
	REMOVE_TRAIT(C, TRAIT_ASHSTORM_IMMUNE, SPECIES_TRAIT)
	UnregisterSignal(C, COMSIG_MOB_ITEM_ATTACK)

/datum/species/lizard/ashwalker/proc/mob_attack(datum/source, mob/M, mob/user)
	SIGNAL_HANDLER

	if(!isliving(M))
		return
	var/mob/living/living_target = M
	var/datum/status_effect/ashwalker_damage/ashie_damage = living_target.has_status_effect(/datum/status_effect/ashwalker_damage)
	if(!ashie_damage)
		ashie_damage = living_target.apply_status_effect(/datum/status_effect/ashwalker_damage)
	ashie_damage.register_mob_damage(living_target)
