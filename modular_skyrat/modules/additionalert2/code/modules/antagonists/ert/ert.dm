/datum/antagonist/ert/odst
	name = "Orbital Drop Shock Trooper"
	role = "Trooper"
	var/odst_outfit = /datum/ert/odst

/datum/antagonist/ert/odst/proc/equip_odst()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current

	H.set_species(/datum/species/human) //Plasamen burn up otherwise, and lizards are vulnerable to asimov AIs

	H.equipOutfit(odst_outfit)
	return TRUE

/datum/antagonist/ert/odst/leader
	name = "Orbital Drop Shock Trooper Leader"
	role = "Commander"
