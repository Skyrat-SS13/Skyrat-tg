/datum/ert/gcc
	roles = list(/datum/antagonist/ert/gcc, /datum/antagonist/ert/gcc/heavy)
	leader_role = /datum/antagonist/ert/gcc/commander
	rename_team = "Novaya Rossiyskaya Imperiya Platoon"
	code = "Red"
	mission = "Assist the station."
	polldesc = "a squad of specialized GCC soldiers"

/datum/antagonist/ert/gcc
	name = "Novaya Rossiyskaya Imperiya Soldier"
	role = "Soldier"
	outfit = /datum/outfit/centcom/ert/gcc

/datum/antagonist/ert/gcc/on_gain()
	. = ..()
	equip_gcc()

/datum/antagonist/ert/gcc/proc/equip_gcc()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current

	H.grant_language(/datum/language/neorusskya)

	return TRUE

/datum/antagonist/ert/gcc/commander
	name = "Novaya Rossiyskaya Imperiya Commander"
	role = "Commander"
	outfit = /datum/outfit/centcom/ert/gcc/commander

/datum/antagonist/ert/gcc/heavy
	name = "Novaya Rossiyskaya Imperiya Heavy Soldier"
	role = "Heavy Soldier"
	outfit = /datum/outfit/centcom/ert/gcc/heavy
