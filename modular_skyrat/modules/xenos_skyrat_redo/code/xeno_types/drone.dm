/mob/living/carbon/alien/humanoid/skyrat/drone
	name = "alien drone"
	caste = "drone"
	maxHealth = 250
	health = 250
	icon_state = "aliendrone"
	var/datum/action/cooldown/alien/skyrat/heal_aura/heal_aura_ability
	melee_damage_lower = 15
	melee_damage_upper = 20

/mob/living/carbon/alien/humanoid/skyrat/drone/Initialize(mapload)
	. = ..()
	heal_aura_ability = new /datum/action/cooldown/alien/skyrat/heal_aura()
	heal_aura_ability.Grant(src)

/mob/living/carbon/alien/humanoid/skyrat/drone/Destroy()
	QDEL_NULL(heal_aura_ability)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/drone/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel
	..()

/datum/action/cooldown/alien/skyrat/heal_aura
	name = "Healing Aura"
	desc = "Friendly xenomorphs in a short range around yourself will receive passive healing."
	button_icon_state = "healaura"
	plasma_cost = 100
	cooldown_time = 90 SECONDS
	var/aura_active = FALSE
	var/aura_duration = 30 SECONDS
	var/aura_range = 5
	var/aura_healing_amount = 10
	var/aura_healing_color = COLOR_BLUE_LIGHT
	var/datum/component/aura_healing/aura_healing_component

/datum/action/cooldown/alien/skyrat/heal_aura/Activate()
	. = ..()
	if(aura_active)
		owner.balloon_alert(owner, "already healing")
		return FALSE
	owner.balloon_alert(owner, "healing aura started")
	to_chat(owner, span_danger("We emit pheromones that encourage sisters near us to heal themselves for the next [aura_duration/10] seconds."))
	addtimer(CALLBACK(src, .proc/aura_deactivate), aura_duration)
	aura_active = TRUE
	aura_healing_component = owner.AddComponent(/datum/component/aura_healing, range = aura_range, requires_visibility = TRUE, brute_heal = aura_healing_amount, burn_heal = aura_healing_amount, limit_to_trait = TRAIT_XENO_HEAL_AURA, healing_color = aura_healing_color)
	return TRUE

/datum/action/cooldown/alien/skyrat/heal_aura/proc/aura_deactivate()
	aura_active = FALSE
	QDEL_NULL(aura_healing_component)
	owner.balloon_alert(owner, "healing aura ended")


