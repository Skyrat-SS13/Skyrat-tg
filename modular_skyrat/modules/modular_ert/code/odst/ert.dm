/datum/antagonist/ert/odst
	name = "Orbital Drop Shock Trooper"
	role = "Trooper"
	outfit = /datum/outfit/centcom/ert/odst

/datum/antagonist/ert/odst/on_gain()
	. = ..()
	equip_odst()

/datum/antagonist/ert/odst/proc/equip_odst()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/human_target = owner.current
	human_target.set_species(/datum/species/human) //ODST are apparently human only.
	return TRUE

/datum/antagonist/ert/odst/leader
	name = "Orbital Drop Shock Trooper Leader"
	role = "Commander"
