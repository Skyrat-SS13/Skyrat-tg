/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	var/infil_outfit = /datum/outfit/syndicateinfiltrator

/datum/antagonist/traitor/infiltrator/on_gain()
	var/mob/living/carbon/human/H = owner.current
	H.equipOutfit(infil_outfit)
	var/chosen_name = H.dna.species.random_name(H.gender,1,1)
	H.fully_replace_character_name(H.real_name,chosen_name)
	return ..()
