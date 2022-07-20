/datum/ert/nri
	roles = list(/datum/antagonist/ert/nri, /datum/antagonist/ert/nri/heavy, /datum/antagonist/ert/nri/medic, /datum/antagonist/ert/nri/engineer)
	leader_role = /datum/antagonist/ert/nri/commander
	rename_team = "NRI "
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
	H.set_species(/datum/species/human)
	H.grant_language(/datum/language/panslavic)

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

/datum/ert/nri/diplomacy
	roles = list(/datum/antagonist/ert/nri/diplomat/scientist, /datum/antagonist/ert/nri/diplomat/doctor)
	leader_role = /datum/antagonist/ert/nri/diplomat/major
	rename_team = "NRI External Relationships Colleague"
	code = "Green"
	mission = "Cooperate with the station's command, perform routine evaluation of NRI citizen's wellbeing as well as Research and Medical departments' genetical and virological researches."
	polldesc = "NRI diplomatic mission"

/datum/antagonist/ert/nri/diplomat
	name = "NRI ERC Diplomat"
	role = "Diplomat"
	outfit = /datum/outfit/centcom/ert/nri // no shit for generic role that won't even appear bruh

/datum/antagonist/ert/nri/diplomat/major
	name = "NRI ERC Major"
	role = "Major"
	outfit = /datum/outfit/centcom/ert/nri/major

/datum/antagonist/ert/nri/diplomat/scientist
	name = "NRI ERC Research Inspector"
	role = "Research Inspector"
	outfit = /datum/outfit/centcom/ert/nri/scientist

/datum/antagonist/ert/nri/diplomat/doctor
	name = "NRI ERC Medical Inspector"
	role = "Medical Inspector"
	outfit = /datum/outfit/centcom/ert/nri/doctor
