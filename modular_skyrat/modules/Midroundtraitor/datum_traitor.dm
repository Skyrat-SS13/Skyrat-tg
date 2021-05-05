/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	var/infil_outfit = /datum/outfit/syndicateinfiltrator

/datum/antagonist/traitor/infiltrator/on_gain()
	var/mob/living/carbon/human/H = owner.current
	H.equipOutfit(infil_outfit)
	return ..()
