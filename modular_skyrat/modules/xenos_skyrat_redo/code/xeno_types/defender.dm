/mob/living/carbon/alien/humanoid/skyrat/defender
	name = "alien defender"
	caste = "defender"
	maxHealth = 300
	health = 300
	icon_state = "aliendefender"
	var/datum/action/cooldown/alien/skyrat/evade/evade_ability
	melee_damage_lower = 25
	melee_damage_upper = 30
	damage_coeff = 0.9

/mob/living/carbon/alien/humanoid/skyrat/defender/Initialize(mapload)
	. = ..()
	evade_ability = new
	evade_ability.Grant(src)

/mob/living/carbon/alien/humanoid/skyrat/defender/Destroy()
	QDEL_NULL(evade_ability)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/defender/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/small
	..()
