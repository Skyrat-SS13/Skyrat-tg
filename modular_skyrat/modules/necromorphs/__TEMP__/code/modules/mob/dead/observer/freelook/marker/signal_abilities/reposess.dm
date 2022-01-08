/datum/signal_ability/repossess
	name = "Repossess"
	id = "repossess"
	desc = "Seperates the target necromorph from their controlling signal, causing them to become an inert vessel once more, that can be posessed by any other signal.<br>\
	Good to use in cases of a necromorph player going AFK"
	target_string = "A currently controlled necromorph vessel"
	energy_cost = 50
	autotarget_range = 1

	target_types = list(/mob/living)
	allied_check = TRUE

	targeting_method	=	TARGET_CLICK
	marker_only = TRUE

/datum/signal_ability/repossess/special_check(var/mob/living/target)
	if (!target.key)
		return FALSE
	return TRUE

/datum/signal_ability/repossess/on_cast(var/mob/user, var/mob/living/target, var/list/data)
	target.necro_evacuate()
