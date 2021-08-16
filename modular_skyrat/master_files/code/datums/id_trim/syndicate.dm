///SYNDICATE ID TRIMS
/datum/id_trim/syndicom/skyrat
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/syndicom/skyrat/crew
	assignment = "Syndicate Operative"
	trim_state = "trim_syndicateoperative"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/datum/id_trim/syndicom/skyrat/captain
	assignment = "Syndicate Ship Captain"
	trim_state = "trim_syndicateshipcaptain"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

///DS-2

/datum/id_trim/job/syndicom/skyrat/assault
	assignment = "DS-2 Operative"
	trim_state = "trim_syndicateoperative"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/syndicom/skyrat/assault/assistant
	assignment = "Operative"
	trim_state = "trim_syndicateassistant"
	config_job = "operative"
	full_access = list(ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_MAINT_TUNNELS)
	job = /datum/job/skyratghostrole/syndicate/operative

/datum/id_trim/job/syndicom/skyrat/assault/syndicatestaff
	assignment = "Service Staff"
	trim_state = "trim_syndicatestaff"
	config_job = "syndicate_staff"
	full_access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_MINERAL_STOREROOM)
	job = /datum/job/skyratghostrole/syndicate/service

/datum/id_trim/job/syndicom/skyrat/assault/researcher
	assignment = "Researcher"
	trim_state = "trim_researcher"
	config_job = "researcher"
	full_access = list(ACCESS_ROBOTICS, ACCESS_RND, ACCESS_TOXINS, ACCESS_TOXINS_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY,
					ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_GENETICS, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_RND, ACCESS_TOXINS, ACCESS_TOXINS_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY,
						ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_GENETICS, ACCESS_AUX_BASE)
	job = /datum/job/skyratghostrole/syndicate/researcher

/datum/id_trim/job/syndicom/skyrat/assault/stationmedicalofficer
	assignment = "Station Medical Officer"
	trim_state = "trim_stationmedicalofficer"
	full_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	job = /datum/job/skyratghostrole/syndicate/medicalofficer

/datum/id_trim/job/syndicom/skyrat/assault/masteratarms
	assignment = "Master At Arms"
	trim_state = "trim_masteratarms"
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_COURT, ACCESS_MECH_SECURITY, ACCESS_MAINT_TUNNELS, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	full_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_COURT, ACCESS_MECH_SECURITY, ACCESS_MAINT_TUNNELS, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	job = /datum/job/skyratghostrole/syndicate/masteratarms

/datum/id_trim/job/syndicom/skyrat/assault/brigofficer
	assignment = "Enforcement Officer"
	trim_state = "trim_brigofficer"
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	full_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	job = /datum/job/skyratghostrole/syndicate/brig_officer

/datum/id_trim/job/syndicom/skyrat/assault/chiefmasteratarms
	assignment = "Chief Master At Arms"
	trim_state = "trim_chiefmasteratarms"
	access = list(ACCESS_SYNDICATE,ACCESS_ROBOTICS,ACCESS_SYNDICATE_LEADER)

/datum/id_trim/job/syndicom/skyrat/assault/chiefresearchofficer
	assignment = "Chief Research Officer"
	trim_state = "trim_chiefresearchofficer"
	access = list(ACCESS_SYNDICATE,ACCESS_ROBOTICS,ACCESS_SYNDICATE_LEADER)

/datum/id_trim/job/syndicom/skyrat/assault/chiefengineeringofficer
	assignment = "Chief Engineering Officer"
	trim_state = "trim_chiefengineeringofficer"
	access = list(ACCESS_ENGINE_EQUIP,ACCESS_SYNDICATE,ACCESS_ROBOTICS,ACCESS_SYNDICATE_LEADER)

/datum/id_trim/job/syndicom/skyrat/assault/stationadmiral
	assignment = "Station Admiral"
	trim_state = "trim_stationadmiral"
	job = /datum/job/skyratghostrole/syndicate/station_admiral

/datum/id_trim/job/syndicom/skyrat/assault/stationadmiral/New()
	full_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_COMMON) + SSid_access.get_flag_access_list(ACCESS_FLAG_COMMAND))
	full_wildcard_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_PRV_COMMAND) + SSid_access.get_flag_access_list(ACCESS_FLAG_CAPTAIN))
	minimal_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_COMMON) + SSid_access.get_flag_access_list(ACCESS_FLAG_COMMAND))
	minimal_wildcard_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_PRV_COMMAND) + SSid_access.get_flag_access_list(ACCESS_FLAG_CAPTAIN))

	return ..()

///Interdyne

/datum/id_trim/syndicom/skyrat/interdyne
	assignment = "Interdyne Operative"
	trim_state = "trim_syndicateoperative"

/datum/id_trim/syndicom/skyrat/interdyne/commsofficer
	assignment = "Comms Officer"
	trim_state = "trim_commsofficer"

/datum/id_trim/syndicom/skyrat/interdyne/deckofficer
	assignment = "Deck Officer"
	trim_state = "trim_deckofficer"
	access = list(ACCESS_SYNDICATE,ACCESS_ROBOTICS,ACCESS_SYNDICATE_LEADER)

///Misc

/datum/id_trim/syndicom/skyrat/misc
	assignment = "Nuclear Tech Support" //Hello? Yes? Nanotrasen? This is Gorlex, uhh. There seems to be an issue.. is your self-destruct running?

/datum/id_trim/syndicom/skyrat/misc/corporateliasion //Syndicate HoP
	assignment = "Corporate Liaison"
	trim_state = "trim_corporateliaison"

/datum/id_trim/syndicom/skyrat/misc/investigativeofficer
	assignment = "Investigative Officer"
	trim_state = "trim_investigativeofficer"

/datum/id_trim/syndicom/skyrat/misc/corporatelawyer
	assignment = "Corporate Lawyer"
	trim_state = "trim_corporatelawyer"

/datum/id_trim/syndicom/skyrat/misc/geneticsresearcher
	assignment = "Genetics Researcher"
	trim_state = "trim_geneticsresearcher"

/datum/id_trim/syndicom/skyrat/misc/chef
	assignment = "Chef"
	trim_state = "trim_chef"

/datum/id_trim/syndicom/skyrat/misc/counsel
	assignment = "Counsel"
	trim_state = "trim_counsel"

/datum/id_trim/syndicom/skyrat/misc/sanitationtechnician
	assignment = "Sanitation Technician"
	trim_state = "trim_sanitationtechnician"

/datum/id_trim/syndicom/skyrat/misc/deckcrewman //Finally, an excuse to emag the supply console.
	assignment = "Deck Crewman"
	trim_state = "trim_deckcrewman"

///No Custom Icon
/datum/id_trim/syndicom/skyratnoicon/roboticstechnician
	assignment = "Robotics Technician"
	trim_state = "trim_roboticist"

/datum/id_trim/job/syndicom/skyratnoicon/enginetechnician
	assignment = "Engine Technician"
	trim_state = "trim_stationengineer"
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_AUX_BASE,
					ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	full_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_AUX_BASE,
					ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	job = /datum/job/skyratghostrole/syndicate/enginetech
