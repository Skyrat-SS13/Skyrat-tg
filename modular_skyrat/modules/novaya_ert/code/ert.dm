/datum/ert/nri
	roles = list(/datum/antagonist/ert/nri, /datum/antagonist/ert/nri/heavy, /datum/antagonist/ert/nri/medic, /datum/antagonist/ert/nri/engineer)
	leader_role = /datum/antagonist/ert/nri/commander
	rename_team = "Novaya Rossiyskaya Imperiya Patrol"
	code = "Red"
	mission = "Cooperate with the station, protect NRI assets."
	polldesc = "a squad of NRI border patrol"

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

/datum/antagonist/ert/nri/medic
	name = "Novaya Rossiyskaya Imperiya Corpsman"
	role = "Corpsman"
	outfit = /datum/outfit/centcom/ert/nri/medic

/datum/antagonist/ert/nri/engineer
	name = "Novaya Rossiyskaya Imperiya Combat Engineer"
	role = "Combat Engineer"
	outfit = /datum/outfit/centcom/ert/nri/engineer
