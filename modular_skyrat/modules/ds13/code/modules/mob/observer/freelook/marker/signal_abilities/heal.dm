/datum/signal_ability/heal
	name = "Reconstitute"
	id = "reconstitute"
	desc = "Regrows one severed limb on a target necromorph, and heals up to 40 normal damage<br>\
	Also removes any embedded shrapnel and weapons in the target's body<br>\
	The target also recieves Lasting Damage proportional to the health of the limb, effectively reducing their maximum health.<br>\
	This ability will not heal lasting damage"
	target_string = "A damaged necromorph, must be on corruption"
	energy_cost = 100
	autotarget_range = 1
	cooldown = 1 MINUTE

	target_types = list(/mob/living/carbon/human)
	allied_check = TRUE

	targeting_method	=	TARGET_CLICK

	require_corruption = TRUE
	require_necrovision = TRUE

	target_types = list(/mob/living/carbon/human)

/datum/signal_ability/heal/on_cast(var/mob/user, var/mob/living/target, var/list/data)
	var/mob/living/carbon/human/H = target
	H.regenerate_ability(subtype = /datum/extension/regenerate/reconstitute, _duration = 4 SECONDS, _cooldown =0)


/datum/extension/regenerate/reconstitute
	limb_lasting_damage = 0.5
	lasting_damage_heal = 0
	heal_amount = 40
	max_limbs = 1




/datum/signal_ability/heal/marker
	marker_only = TRUE

	energy_cost = 1000
	autotarget_range = 1
	cooldown = 1 MINUTE


	name = "Rebuild"
	id = "rebuild"
	desc = "Fully heals the target necromorph, restoring all limbs and healing up to 200 lasting damage, as well as up to 200 normal damage.<br>\
	 Also removes any embedded shrapnel and weapons in the target's body<br>\
	 Costs biomass based on the limb health and lasting damage restored. <br>\
	 The biomass spent in this way is invested into the necromorph, not destroyed, and thus will be gradually recovered after it dies. <br>\
	 Biomass costs are unpredictable and cannot be previewed, but will never be more than 1kg per 2 points of the necromorph's maximum health"
	target_string = "A damaged necromorph, must be on corruption"

/datum/signal_ability/heal/marker/can_cast_now(var/mob/user)
	var/obj/machinery/marker/M = get_marker()
	if (!M || M.biomass < 0)
		return "The marker has no biomass"

	.=..()


/datum/signal_ability/heal/marker/on_cast(var/mob/user, var/mob/living/target, var/list/data)
	var/mob/living/carbon/human/H = target
	H.regenerate_ability(subtype = /datum/extension/regenerate/rebuild, _duration = 8 SECONDS, _cooldown =0)



/datum/extension/regenerate/rebuild
	lasting_damage_heal = 200
	biomass_limb_cost = 0.5	//When a limb is replaced, the marker transfers biomass to the mob, equal to the limb's health * this value
	biomass_lasting_damage_cost = 0.5	//When lasting_damage is healed, the marker transfers biomass to the mob, equal to the damage healed * this value
	heal_amount = 200
	max_limbs = 99999 //All the limbs
	cooldown = 3 MINUTE