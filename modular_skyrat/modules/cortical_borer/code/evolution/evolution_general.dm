/datum/borer_evolution/upgrade_injection
	name = "Upgrade Injection"
	desc = "Upgrade your possible injection amount to 10 units."
	gain_text = "Their growth is astounding, their organs and glands can expand several times their size in mere days."
	unlocked_evolutions = list(/datum/borer_evolution/upgrade_injection/t2)
	tier = 1

/datum/borer_evolution/upgrade_injection/on_evolve(mob/living/simple_animal/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.injection_rates_unlocked += cortical_owner.injection_rates[length(cortical_owner.injection_rates_unlocked) + 1]

/datum/borer_evolution/upgrade_injection/t2
	name = "Upgrade Injection II"
	desc = "Upgrade your possible injection amount to 25 units."
	unlocked_evolutions = list(/datum/borer_evolution/upgrade_injection/t3)
	tier = 2

/datum/borer_evolution/upgrade_injection/t3
	name = "Upgrade Injection III"
	desc = "Upgrade your possible injection amount to 50 units."
	unlocked_evolutions = list()
	tier = 3

/datum/borer_evolution/sugar_immunity
	name = "Sugar Immunity"
	desc = "Become immune to the ill effects of sugar in you or a host."
	gain_text = "Of the biggest ones, a few have managed to resist the effects of sugar. Truly concerning if we wish to keep them contained."
	evo_cost = 5
	tier = 5

/datum/borer_evolution/sugar_immunity/on_evolve(mob/living/simple_animal/cortical_borer/cortical_owner)
	. = ..()
	cortical_owner.upgrade_flags |= BORER_SUGAR_IMMUNE
