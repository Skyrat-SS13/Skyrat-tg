/datum/job
	var/alt_title_pref

/datum/job/proc/get_alt_title_pref(client/preference_source)
	if(preference_source && preference_source.prefs && preference_source.prefs.alt_titles_preferences[title])
		alt_title_pref = preference_source.prefs.alt_titles_preferences[title]
	else
		alt_title_pref = title

/datum/job/proc/get_id_titles(mob/living/carbon/human/H, obj/item/card/id/ID)
	ID.real_title = title
	if(H.client && H.client.prefs && H.client.prefs.alt_titles_preferences[title])
		ID.assignment = H.client.prefs.alt_titles_preferences[title]
	else if (alt_title_pref)
		ID.assignment = alt_title_pref
	else
		ID.assignment = title

/datum/job/proc/get_pda_titles(mob/living/carbon/human/H, obj/item/pda/PDA)
	if(H.client && H.client.prefs && H.client.prefs.alt_titles_preferences[title])
		PDA.ownjob = H.client.prefs.alt_titles_preferences[title]
	else if (alt_title_pref)
		PDA.ownjob = alt_title_pref
	else
		PDA.ownjob = title

/datum/job/proc/announce_head(mob/living/carbon/human/H, channels) //tells the given channel that the given mob is the new department head. See communications.dm for valid channels.
	if(H && GLOB.announcement_systems.len)
		if(alt_title_pref)
			//timer because these should come after the captain announcement
			SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, .proc/_addtimer, CALLBACK(pick(GLOB.announcement_systems), /obj/machinery/announcement_system/proc/announce, "NEWHEAD", H.real_name, alt_title_pref, channels), 1))
		else
			SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, .proc/_addtimer, CALLBACK(pick(GLOB.announcement_systems), /obj/machinery/announcement_system/proc/announce, "NEWHEAD", H.real_name, H.job, channels), 1))

//Command
/datum/job/captain
	alt_titles = list("Station Commander", "Commanding Officer", "Site Manager")

/datum/job/head_of_personnel
	alt_titles = list("Executive Officer", "Employment Officer", "Crew Supervisor")

/datum/job/head_of_security
	alt_titles = list("Security Commander", "Chief Constable", "Chief of Security", "Sheriff")

/datum/job/chief_engineer
	alt_titles = list("Engineering Foreman")

/datum/job/research_director
	alt_titles = list("Silicon Administrator", "Lead Researcher", "Biorobotics Director", "Research Supervisor", "Chief Science Officer")

/datum/job/quartermaster
	alt_titles = list("Deck Chief", "Cargo Foreman")

/datum/job/chief_medical_officer
	alt_titles = list("Medical Director")

//Engineering
/datum/job/station_engineer
	alt_titles = list("Emergency Damage Control Technician", "Electrician", "Engine Technician", "EVA Technician", "Engineer")

/datum/job/atmospheric_technician
	alt_titles = list("Life Support Technician", "Emergency Fire Technician")

//Medical
/datum/job/doctor
	alt_titles = list("Surgeon", "Nurse")

/datum/job/paramedic
	alt_titles = list("Emergency Medical Technician", "Search and Rescue Technician")

/datum/job/virologist
	alt_titles = list("Pathologist")

/datum/job/chemist
	alt_titles = list("Pharmacist", "Pharmacologist")

//Science
/datum/job/scientist
	alt_titles = list("Circuitry Designer", "Xenobiologist", "Cytologist", "Nanomachine Programmer", "Plasma Researcher", "Anomalist", "Lab Technician")

/datum/job/roboticist
	alt_titles = list("Biomechanical Engineer", "Mechatronic Engineer")

/datum/job/geneticist
	alt_titles = list("Mutation Researcher")

//Cargo
/datum/job/cargo_technician
	alt_titles = list("Deck Worker", "Mailman")

/datum/job/shaft_miner
	alt_titles = list("Excavator")

//Service
/datum/job/bartender
	alt_titles = list("Mixologist", "Barkeeper")

/datum/job/cook
	alt_titles = list("Chef", "Butcher", "Culinary Artist", "Sous-Chef")

/datum/job/janitor
	alt_titles = list("Custodian", "Custodial Technicial", "Sanitation Technician", "Maid")

/datum/job/curator
	alt_titles = list("Librarian", "Journalist", "Archivist")

/datum/job/psychologist
	alt_titles = list("Psychiatrist", "Therapist", "Counsellor")

/datum/job/lawyer
	alt_titles = list("Internal Affairs Agent", "Human Resources Agent", "Defence Attorney", "Public Defender", "Barrister", "Prosecutor")

/datum/job/chaplain
	alt_titles = list("Priest", "Preacher")

/datum/job/mime
	alt_titles = list("Pantomimist")

/datum/job/clown
	alt_titles = list("Jester")

/datum/job/prisoner
	alt_titles = list("Low Risk Prisoner", "High Risk Prisoner", "Extreme Risk Prisoner", "Protective Custody Prisoner")

/datum/job/assistant
	alt_titles = list("Civilian", "Tourist", "Businessman", "Trader", "Entertainer", "Off-Duty Staff", "Freelancer")

/datum/job/botanist
	alt_titles = list("Hydroponicist", "Gardener", "Botanical Researcher", "Herbalist")

//Security
/datum/job/warden
	alt_titles = list("Brig Sergeant", "Dispatch Officer", "Brig Governor", "Jailer")

/datum/job/detective
	alt_titles = list("Forensic Technician", "Private Investigator", "Forensic Scientist")

/datum/job/security_officer
	alt_titles = list("Security Operative", "Peacekeeper")

/datum/job/security_sergeant
	alt_titles = list("Security Squad Leader", "Security Task Force Leader", "Security Fireteam Leader", "Security Enforcer")

/datum/job/security_medic
	alt_titles = list("Field Medic", "Security Corpsman", "Brig Physician")

/datum/job/junior_officer
	alt_titles = list("Station Police", "Civil Protection Officer", "Parole Officer")

/datum/job/brigoff
    alt_titles = list("Brig Officer", "Prison Guard")

/datum/job/blueshield
	alt_titles = list("Command Bodyguard", "Executive Protection Agent", "Personal Protection Specialist")

//Silicon
/datum/job/ai
	alt_titles = list("Station Intelligence", "Automated Overseer")

/datum/job/cyborg
	alt_titles = list("Robot", "Android")
