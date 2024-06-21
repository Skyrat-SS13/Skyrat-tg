/datum/id_trim/away/tarkon
	assignment = "P-T Deck Worker"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_WHITE
	department_state = "department"
	subdepartment_color = COLOR_DARK_CYAN
	sechud_icon_state = SECHUD_UNKNOWN
	trim_state = "trim_unknown"

/obj/item/card/id/advanced/tarkon
	name = "Tarkon deck access pass"
	desc = "A dust-collected visitors pass, A small tagline reading \"Port Tarkon, The first step to Civilian Partnership in Space Homesteading\"."
	icon = 'modular_skyrat/modules/tarkon/icons/misc/card.dmi'
	icon_state = "tarkon"
	trim = /datum/id_trim/away/tarkon
	assigned_icon_state = "assigned_tarkon"

/datum/id_trim/away/tarkon/cargo
	assignment = "P-T Cargo Personnel"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_BROWN
	department_state = "department"
	sechud_icon_state = SECHUD_CARGO_TECHNICIAN
	trim_state = "trim_cargotechnician"

/obj/item/card/id/advanced/tarkon/cargo
	name = "P-T cargo hauler's access card"
	desc = "An access card designated for \"cargo's finest\". You're also a part time space miner, when cargonia is quiet."
	trim = /datum/id_trim/away/tarkon/cargo

/datum/id_trim/away/tarkon/sec
	assignment = "P-T Port Guard"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_DARK_RED
	sechud_icon_state = SECHUD_SECURITY_OFFICER
	trim_state = "trim_securityofficer"

/obj/item/card/id/advanced/tarkon/sec
	name = "P-T resident deputy's access card"
	desc = "An access card designated for \"security members\". Everyone wants your guns, partner. Yee-haw."
	trim = /datum/id_trim/away/tarkon/sec


/datum/id_trim/away/tarkon/med
	assignment = "P-T Trauma Medic"
	access = list(ACCESS_MEDICAL, ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_MEDICAL_DOCTOR
	trim_state = "trim_medicaldoctor"

/obj/item/card/id/advanced/tarkon/med
	name = "P-T trauma medic's access card"
	desc = "An access card designated for \"medical staff\". You provide the medic bags."
	trim = /datum/id_trim/away/tarkon/med

/datum/id_trim/away/tarkon/eng
	assignment = "P-T Maintenance Crew"
	department_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_STATION_ENGINEER
	trim_state = "trim_stationengineer"

/obj/item/card/id/advanced/tarkon/engi
	name = "P-T maintenance engineer's access card"
	desc = "An access card designated for \"engineering staff\". You're going to be the one everyone points at to fix stuff, lets be honest."
	trim = /datum/id_trim/away/tarkon/eng

/datum/id_trim/away/tarkon/sci
	assignment = "P-T Field Researcher"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_WEAPONS, ACCESS_TARKON)
	department_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENTIST
	trim_state = "trim_scientist"

/obj/item/card/id/advanced/tarkon/sci
	name = "P-T field researcher's access card"
	desc = "An access card designated for \"the science team\". You are forgotten basically immediately when it comes to the lab."
	trim = /datum/id_trim/away/tarkon/sci

/datum/id_trim/away/tarkon/robo
	access = list(ACCESS_ROBOTICS)

/obj/item/card/id/away/tarkonrobo
	name = "Tarkon Robotics Card"
	desc = "An access card designed to access robot's access ports, provided by Tarkon Industries."
	icon = 'modular_skyrat/modules/tarkon/icons/misc/card.dmi'
	icon_state = "robotics"
	trim = /datum/id_trim/away/tarkon/robo

/datum/id_trim/away/tarkon/ensign
	assignment = "Tarkon Ensign"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_BLUESHIELD
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"

/obj/item/card/id/advanced/tarkon/ensign
	name = "Tarkon ensign's access card"
	desc = "An access card designated for \"Tarkon ensign\". No one has to listen to you... But you're the closest there is for command around here."
	trim = /datum/id_trim/away/tarkon/ensign

/datum/id_trim/away/tarkon/director
	assignment = "Port Tarkon Director"
	access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS, ACCESS_AWAY_GENERAL, ACCESS_TARKON, ACCESS_WEAPONS)
	department_color = COLOR_COMMAND_BLUE
	sechud_icon_state = SECHUD_CAPTAIN
	trim_state = "trim_captain"

/obj/item/card/id/advanced/tarkon/director
	name = "Tarkon port director's access card"
	desc = "An access card designated for \"Tarkon's Port Director\". Its no longer hesitation, only consideration."
	trim = /datum/id_trim/away/tarkon/director
