/datum/borer_evolution/upgrade_injection
	name = "Upgrade Injection"
	desc = "Upgrade your possible injection amount to 10 units."
	gain_text = "Their growth is astounding, their organs and glands can expand several times their size in mere days."
	unlocked_evolutions = list(/datum/borer_evolution/upgrade_injection/t2)

/datum/borer_evolution/upgrade_injection/on_evolve(mob/living/simple_animal/cortical_borer/cortical_owner)
	cortical_owner.injection_rates_unlocked += cortical_owner.injection_rates[length(cortical_owner.injection_rates_unlocked) + 1]
	return ..()

/datum/borer_evolution/upgrade_injection/t2
	name = "Upgrade Injection II"
	desc = "Upgrade your possible injection amount to 25 units."
	unlocked_evolutions = list(/datum/borer_evolution/upgrade_injection/t3)

/datum/borer_evolution/upgrade_injection/t3
	name = "Upgrade Injection III"
	desc = "Upgrade your possible injection amount to 50 units."
	unlocked_evolutions = list()
