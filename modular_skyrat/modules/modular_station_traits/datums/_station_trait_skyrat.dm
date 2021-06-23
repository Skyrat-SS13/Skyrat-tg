/datum/station_trait/announcement_swanson
	name = "Announcement Intern"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 1
	show_in_report = TRUE
	report_message = "Please be nice to him."
	blacklist = list(/datum/station_trait/announcement_medbot, /datum/station_trait/announcement_intern)

/datum/station_trait/announcement_swanson/New()
	. = ..()
	SSstation.announcer = /datum/centcom_announcer/announcement_swanson
