/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat/queen
	name = "alien queen"
	caste = "queen"
	maxHealth = 500
	health = 500
	icon_state = "alienqueen"
	var/datum/action/cooldown/spell/aoe/repulse/xeno/hard_throwing/tail_sweep
	melee_damage_lower = 30
	melee_damage_upper = 35

/mob/living/carbon/alien/humanoid/skyrat/queen/Initialize(mapload)
	. = ..()
	tail_sweep = new /datum/action/cooldown/spell/aoe/repulse/xeno/hard_throwing()
	tail_sweep.Grant(src)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/carbon/alien/humanoid/skyrat/queen/Destroy()
	QDEL_NULL(tail_sweep)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/queen/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/large/queen
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin/queen
	internal_organs += new /obj/item/organ/internal/alien/eggsac
	..()

/obj/item/organ/internal/alien/neurotoxin/queen
	name = "queenly neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/skyrat,
		/datum/action/cooldown/alien/acid/skyrat/lethal,
		/datum/action/cooldown/alien/acid/corrosion,
	)

/mob/living/carbon/alien/humanoid/skyrat/queen/death(gibbed)
	if(stat == DEAD)
		return

	for(var/mob/living/carbon/carbon_mob in GLOB.alive_mob_list)
		if(carbon_mob == src)
			continue
		var/obj/item/organ/internal/alien/hivenode/node = carbon_mob.getorgan(/obj/item/organ/internal/alien/hivenode)
		if(istype(node))
			node.queen_death()

	return ..()
