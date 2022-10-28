/datum/id_trim/centcom/centcom_inspector
	assignment = JOB_CENTCOM_INSPECTOR

/datum/id_trim/centcom/centcom_inspector/New()
	. = ..()

	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION)) // torn on if they should have AA, or need to ask to get it
