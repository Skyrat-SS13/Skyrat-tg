/datum/borer_evolution/hivelord
	evo_type = BORER_EVOLUTION_HIVELORD

/datum/borer_evolution/hivelord/produce_offspring
	name = "Produce Offspring"
	desc = "Produce an egg, which your host will vomit up."
	gain_text = "The way that a Cortical Borer produces an egg is a strange one. So far, we have not seen how it produces one, or it doing so outside a host."

/datum/borer_evolution/hivelord/produce_offspring/on_evolve(mob/living/simple_animal/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/attack_action = new /datum/action/cooldown/borer/produce_offspring()
	attack_action.Grant(cortical_owner)
	cortical_owner.known_abilities += /datum/action/cooldown/borer/produce_offspring
