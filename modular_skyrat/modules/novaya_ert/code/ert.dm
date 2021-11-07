/datum/ert/nri
	roles = list(/datum/antagonist/ert/nri, /datum/antagonist/ert/nri/heavy)
	leader_role = /datum/antagonist/ert/nri/commander
	rename_team = "Novaya Rossiyskaya Imperiya Platoon"
	code = "Red"
	mission = "Assist the station."
	polldesc = "a squad of specialized NRI soldiers"

/datum/antagonist/ert/nri
	name = "Novaya Rossiyskaya Imperiya Soldier"
	role = "Soldier"
	outfit = /datum/outfit/centcom/ert/nri

/datum/antagonist/ert/nri/on_gain()
	. = ..()
	equip_nri()

/datum/antagonist/ert/nri/proc/equip_nri()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current

	H.grant_language(/datum/language/neorusskya)

	return TRUE

/datum/antagonist/ert/nri/commander
	name = "Novaya Rossiyskaya Imperiya Commander"
	role = "Commander"
	outfit = /datum/outfit/centcom/ert/nri/commander

/datum/antagonist/ert/nri/heavy
	name = "Novaya Rossiyskaya Imperiya Heavy Soldier"
	role = "Heavy Soldier"
	outfit = /datum/outfit/centcom/ert/nri/heavy
