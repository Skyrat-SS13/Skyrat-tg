/datum/id_trim/job/junior_officer
	assignment = "Civil Disputes Officer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_juniorofficer"
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_COURT,
		ACCESS_MECH_SECURITY,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_WEAPONS,
		)
	extra_access = list(
		ACCESS_BRIG,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_HOS,
		)

	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)

	job = /datum/job/junior_officer

/datum/id_trim/job/junior_officer/refresh_trim_access()
	. = ..()

	if(!.)
		return

	// Config check for if sec has maint access.
	if(CONFIG_GET(flag/security_has_maint_access))
		access |= list(ACCESS_MAINT_TUNNELS)
