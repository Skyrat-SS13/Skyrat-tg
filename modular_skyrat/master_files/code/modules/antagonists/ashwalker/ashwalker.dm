/datum/antagonist/ashwalker/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.remove_language(/datum/language/common, TRUE, TRUE, LANGUAGE_ALL)
	holder.remove_language(/datum/language/draconic, TRUE, TRUE, LANGUAGE_ALL)
	holder.grant_language(/datum/language/ashtongue, TRUE, TRUE, LANGUAGE_ALL)
	holder.selected_language = /datum/language/ashtongue
