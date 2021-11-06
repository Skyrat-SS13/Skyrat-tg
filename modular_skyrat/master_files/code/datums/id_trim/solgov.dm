/datum/id_trim/solgov
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	assignment = "SolGov"
	trim_state = "trim_solgov"

/datum/id_trim/solgov/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/datum/id_trim/solgov/liasion
	assignment = "SolGov Liasion"

/datum/id_trim/space_police //Overrides the normal /tg/ ERTSEC Icon, these guys aren't NT!
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_solgov"
