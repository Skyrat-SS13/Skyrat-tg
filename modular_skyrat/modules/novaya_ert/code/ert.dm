/datum/ert/nri
	roles = list(/datum/antagonist/ert/nri, /datum/antagonist/ert/nri/medic, /datum/antagonist/ert/nri/engineer)
	leader_role = /datum/antagonist/ert/nri/commander
	rename_team = "NRI border patrol"
	code = "Red"
	mission = "Cooperate with the station, protect NRI assets."
	polldesc = "a squad of NRI border patrol"
	teamsize = 4

/datum/antagonist/ert/nri
	name = "NRI border patrol"
	role = "Private"
	outfit = /datum/outfit/centcom/ert/nri
	suicide_cry = "GOD, SAVE THE EMPRESS!!"

/datum/antagonist/ert/nri/on_gain()
	. = ..()
	equip_nri()

/datum/antagonist/ert/nri/proc/equip_nri()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current
	H.set_species(/datum/species/human)

	H.grant_language(/datum/language/panslavic)
	H.grant_language(/datum/language/schechi)
	return TRUE

/datum/antagonist/ert/nri/greet()
	if(!ert_team)
		return

	to_chat(owner, span_boldwarning("<font size=3 color=yellow>You are the [name]</font>"))

	var/missiondesc = "Your squad is responding to an emergency situation of [station_name()], with the Novaya Rossiyskaya Imperiya Defense Collegium's approval."
	if(leader) //If Squad Leader
		missiondesc += "<BR><B>Lead your squad to ensure the completion of the mission. Board the shuttle when your team is ready.</B>"

	missiondesc += "<BR><B><font size=3 color=red>You are NOT a Nanotrasen Employee. You work for Novaya Rossiyskaya Imperiya Defense Collegium.</font></B>"
	missiondesc += "<BR><B><font size=3 color=red>You are NOT a deathsquad. You are here to assist the station's Security and Command with alien infestations or enemy activity for you own gain.</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station for immediate NRI military intervention!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Minimise civillian casualties."
	missiondesc += "<BR> <B>2.</B> Neutralise the threat."
	missiondesc += "<BR> <B>3.</B> Stabilise the situation."
	missiondesc += "<BR> <B>4.</B> Contact whoever called you and assist in resolving the matter."
	missiondesc += "<BR> <B>5.</B> Protect, ensure, and uphold the rights of Novaya Rossiyskaya Imperiya, Kingdom of Agurkrral and Free Teshari League citizens on board [station_name()]. SolFed citizens' wellbeing is up to your discretion."
	missiondesc += "<BR> <B>6.</B> Attempt to subvert the station's crew in order to shift the station's territory under control of Novaya Rossiyskaya Imperiya."

	missiondesc += span_warning("<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]")
	to_chat(owner,missiondesc)

/datum/antagonist/ert/nri/commander
	role = "Commander"
	outfit = /datum/outfit/centcom/ert/nri/commander

/datum/antagonist/ert/nri/medic
	role = "Corpsman"
	outfit = /datum/outfit/centcom/ert/nri/medic

/datum/antagonist/ert/nri/engineer
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
	role = "Major"
	outfit = /datum/outfit/centcom/ert/nri/major

/datum/antagonist/ert/nri/diplomat/scientist
	role = "Research Inspector"
	outfit = /datum/outfit/centcom/ert/nri/scientist

/datum/antagonist/ert/nri/diplomat/doctor
	role = "Medical Inspector"
	outfit = /datum/outfit/centcom/ert/nri/doctor
