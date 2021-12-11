/datum/station_trait/announcement_swanson
	name = "Announcement Intern"
	trait_type = STATION_TRAIT_NEUTRAL
	weight = 5
	show_in_report = TRUE
	report_message = "Show some respect."
	blacklist = list(/datum/station_trait/announcement_medbot, /datum/station_trait/announcement_intern)

/datum/station_trait/announcement_swanson/New()
	. = ..()
	SSstation.announcer = /datum/centcom_announcer/swanson
