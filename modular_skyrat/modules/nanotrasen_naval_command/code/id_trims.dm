/datum/id_trim/centcom/naval
	assignment = JOB_NAVAL_ENSIGN


/datum/id_trim/centcom/naval/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))


/datum/id_trim/centcom/naval/lieutenant
	assignment = JOB_NAVAL_LIEUTENANT

/datum/id_trim/centcom/naval/ltcr
	assignment = JOB_NAVAL_LTCR

/datum/id_trim/centcom/naval/commander
	assignment = JOB_NAVAL_COMMANDER

/datum/id_trim/centcom/naval/captain
	assignment = JOB_NAVAL_CAPTAIN

/datum/id_trim/centcom/naval/rear_admiral
	assignment = JOB_NAVAL_REAR_ADMIRAL

/datum/id_trim/centcom/naval/admiral
	assignment = JOB_NAVAL_ADMIRAL

/datum/id_trim/centcom/naval/fleet_admiral
	assignment = JOB_NAVAL_FLEET_ADMIRAL
