/datum/id_trim/solfed
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "SolFed"
	trim_state = "trim_solfed"
	department_color = COLOR_SOLFED_GOLD
	subdepartment_color = COLOR_SOLFED_GOLD
	sechud_icon_state = SECHUD_SOLFED

/datum/id_trim/solfed/atmos/New()
	. = ..()
	access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_COMMAND,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EVA,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_ENGINE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINISAT,
		ACCESS_RC_ANNOUNCE,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_TELEPORTER,
		)

/datum/id_trim/solgov/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/solfed/liasion
	assignment = "SolFed Liasion"
	sechud_icon_state = SECHUD_SOLFED_LIASON

/datum/id_trim/space_police // Overrides the normal /tg/ ERTSEC Icon, these guys aren't NT!
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_spacepolice"
	department_color = COLOR_CENTCOM_BLUE // why did these guys get this but the other modular id trims didn't. what
	subdepartment_color = COLOR_SECURITY_RED
	sechud_icon_state = SECHUD_SPACE_POLICE
