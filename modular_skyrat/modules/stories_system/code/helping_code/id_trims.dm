/datum/id_trim/centcom/centcom_inspector
	assignment = JOB_CENTCOM_INSPECTOR

/datum/id_trim/centcom/centcom_inspector/New()
	. = ..()

	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION)) // torn on if they should have AA, or need to ask to get it

/datum/id_trim/job/assistant/tourist
	assignment = "Tourist"

/datum/id_trim/job/assistant/government_official
	assignment = "Government Official"
