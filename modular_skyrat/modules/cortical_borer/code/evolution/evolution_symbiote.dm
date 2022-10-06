/datum/borer_evolution/symbiote
	evo_type = BORER_EVOLUTION_SYMBIOTE

/datum/borer_evolution/symbiote/revive_host
	name = "Revive Host"
	desc = "Revive your host and heal what ails them."
	gain_text = "As I was in the lab, the most curious occurance so far happened. A Cortical Borer went into one of the cadaver's heads, and moments later they were standing again."

/datum/borer_evolution/symbiote/revive_host/on_evolve(mob/living/simple_animal/cortical_borer/cortical_owner)
	. = ..()
	var/datum/action/attack_action = new /datum/action/cooldown/borer/revive_host()
	attack_action.Grant(cortical_owner)
	cortical_owner.known_abilities += /datum/action/cooldown/borer/revive_host
