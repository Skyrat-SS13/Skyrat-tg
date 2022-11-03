/// SYNDICATE ID TRIMS
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

/// DS-2

/datum/id_trim/syndicom/skyrat/ds2
	assignment = "DS-2 Operative"
	trim_state = "trim_syndicateoperative"

/datum/id_trim/syndicom/skyrat/ds2/prisoner
	assignment = "DS-2 Hostage"
	trim_state = "trim_ds2prisoner"
	sechud_icon_state = SECHUD_DS2_PRISONER

/datum/id_trim/syndicom/skyrat/ds2/miner
	assignment = "DS-2 Mining Officer"
	trim_state = "trim_ds2miningofficer"
	sechud_icon_state = SECHUD_DS2_MININGOFFICER

/datum/id_trim/syndicom/skyrat/ds2/syndicatestaff
	assignment = "DS-2 General Staff"
	trim_state = "trim_ds2generalstaff"
	sechud_icon_state = SECHUD_DS2_GENSTAFF

/datum/id_trim/syndicom/skyrat/ds2/researcher
	assignment = "DS-2 Researcher"
	trim_state = "trim_ds2researcher"
	sechud_icon_state = SECHUD_DS2_RESEARCHER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/datum/id_trim/syndicom/skyrat/ds2/enginetechnician
	assignment = "DS-2 Engine Technician"
	trim_state = "trim_ds2enginetech"
	sechud_icon_state = SECHUD_DS2_ENGINETECH

/datum/id_trim/syndicom/skyrat/ds2/medicalofficer
	assignment = "DS-2 Medical Officer"
	trim_state = "trim_ds2medicalofficer"
	sechud_icon_state = SECHUD_DS2_DOCTOR

/datum/id_trim/syndicom/skyrat/ds2/masteratarms
	assignment = "DS-2 Master At Arms"
	trim_state = "trim_ds2masteratarms"
	sechud_icon_state = SECHUD_DS2_MASTERATARMS
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/skyrat/ds2/brigofficer
	assignment = "DS-2 Brig Officer"
	trim_state = "trim_ds2brigofficer"
	sechud_icon_state = SECHUD_DS2_BRIGOFFICER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/skyrat/ds2/corporateliasion // DS2 HoP
	assignment = "DS-2 Corporate Liaison"
	trim_state = "trim_ds2corporateliaison"
	sechud_icon_state = SECHUD_DS2_CORPLIAISON
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/skyrat/ds2/stationadmiral
	assignment = "DS-2 Admiral"
	trim_state = "trim_ds2admiral"
	sechud_icon_state = SECHUD_DS2_ADMIRAL
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/// Interdyne

/datum/id_trim/syndicom/skyrat/interdyne
	assignment = "Interdyne Operative"
	trim_state = "trim_syndicateoperative"

/datum/id_trim/syndicom/skyrat/interdyne/commsofficer
	assignment = "Comms Officer"
	trim_state = "trim_commsofficer"

/datum/id_trim/syndicom/skyrat/interdyne/deckofficer
	assignment = "Deck Officer"
	trim_state = "trim_deckofficer"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/// Misc

/datum/id_trim/syndicom/skyrat/misc
	assignment = "Nuclear Tech Support" // Hello? Yes? Nanotrasen? This is Gorlex, uhh. There seems to be an issue.. is your self-destruct running?
