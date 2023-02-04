
/obj/vehicle/ridden/secway/engiway
	name = "engiway"
	desc = "They see me rollin'"
	icon = 'nebula_modular/icons/obj/vehicles/engiway.dmi'
	icon_state = "engiway"
	max_integrity = 60
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 60, FIRE = 60, ACID = 60)
	key_type = /obj/item/screwdriver
	integrity_failure = 0.5
/*
/datum/design/vehicles/engiway
	name = "Engiway"
	desc = "Engineering vehicle."
	id = "sexway"
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000, /datum/material/silver = 5000)
	build_path = /obj/vehicle/ridden/secway/engiway
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/techweb_node/vehicularhomicide
	id = "vehicularhomicide"
	display_name = "Vehicular homicide"
	description = "Wheels > legs."
	prereq_ids = list("adv_engi")
	design_ids = list(
		"sexway"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
*/
