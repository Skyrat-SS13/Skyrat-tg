/// SYNDICATE ID TRIMS
/datum/id_trim/syndicom/skyrat

// Note: These two are only left here because of the old Cybersun code.
/datum/id_trim/syndicom/skyrat/crew
	assignment = "Syndicate Operative"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/datum/id_trim/syndicom/skyrat/captain
	assignment = "Syndicate Ship Captain"
	trim_state = "trim_captain"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/// DS-2

/datum/id_trim/syndicom/skyrat/ds2
	assignment = "DS-2 Operative"
	trim_state = "trim_unknown"
	department_color = COLOR_ASSEMBLY_BLACK
	subdepartment_color = COLOR_SYNDIE_RED
	threat_modifier = 5 // Matching the syndicate threat level since DS2 is a syndicate station.

/datum/id_trim/syndicom/skyrat/ds2/prisoner
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi' // I can't put this on the basetype AAAAAA
	assignment = "DS-2 Hostage"
	trim_state = "trim_ds2prisoner"
	subdepartment_color = COLOR_MAROON
	sechud_icon_state = SECHUD_DS2_PRISONER

/datum/id_trim/syndicom/skyrat/ds2/miner
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Mining Officer"
	trim_state = "trim_ds2miningofficer"
	sechud_icon_state = SECHUD_DS2_MININGOFFICER

/datum/id_trim/syndicom/skyrat/ds2/syndicatestaff
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 General Staff"
	trim_state = "trim_ds2generalstaff"
	sechud_icon_state = SECHUD_DS2_GENSTAFF

/datum/id_trim/syndicom/skyrat/ds2/researcher
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Researcher"
	trim_state = "trim_ds2researcher"
	sechud_icon_state = SECHUD_DS2_RESEARCHER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS)

/datum/id_trim/syndicom/skyrat/ds2/enginetechnician
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Engine Technician"
	trim_state = "trim_ds2enginetech"
	sechud_icon_state = SECHUD_DS2_ENGINETECH

/datum/id_trim/syndicom/skyrat/ds2/medicalofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Medical Officer"
	trim_state = "trim_ds2medicalofficer"
	sechud_icon_state = SECHUD_DS2_DOCTOR

/datum/id_trim/syndicom/skyrat/ds2/masteratarms
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Master At Arms"
	trim_state = "trim_ds2masteratarms"
	sechud_icon_state = SECHUD_DS2_MASTERATARMS
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/skyrat/ds2/brigofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Brig Officer"
	trim_state = "trim_ds2brigofficer"
	sechud_icon_state = SECHUD_DS2_BRIGOFFICER
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/skyrat/ds2/corporateliasion // DS2 HoP
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Corporate Liaison"
	trim_state = "trim_ds2corporateliaison"
	sechud_icon_state = SECHUD_DS2_CORPLIAISON
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/datum/id_trim/syndicom/skyrat/ds2/stationadmiral
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "DS-2 Admiral"
	trim_state = "trim_ds2admiral"
	sechud_icon_state = SECHUD_DS2_ADMIRAL
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)

/// Interdyne

/datum/id_trim/syndicom/skyrat/interdyne
	assignment = "Interdyne Operative"

/datum/id_trim/syndicom/skyrat/interdyne/deckofficer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "Deck Officer"
	trim_state = "trim_deckofficer"
	department_color = COLOR_COMMAND_BLUE
	subdepartment_color = COLOR_CARGO_BROWN
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_SYNDICATE_LEADER)
