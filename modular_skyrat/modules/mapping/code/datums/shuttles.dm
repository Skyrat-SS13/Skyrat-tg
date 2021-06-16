/datum/map_template/shuttle/arrival/outpost
	suffix = "outpost"
	name = "arrival shuttle (Outpost)"

/datum/map_template/shuttle/emergency/outpost
	suffix = "outpost"
	name = "Outpoststation Emergency Shuttle"
	description = "The perfect shuttle for rectangle enthuasiasts, this long and slender shuttle has been known for it's incredible(Citation Needed) safety rating."
	admin_notes = "Has airlocks on both sides of the shuttle and will probably ram deltastation's maint wing below medical. Oh well?"
	credit_cost = CARGO_CRATE_VALUE * 4

/*----- Black Market Shuttle Datum + related code -----*/
/datum/map_template/shuttle/ruin/blackmarket_chevvy
	prefix = "_maps/skyrat/shuttles/"
	suffix = "blackmarket_chevvy"
	name = "Black Market Chevvy"

/obj/machinery/computer/shuttle/caravan/blackmarket_chevvy
	name = "Chevvy Shuttle Console"
	desc = "Used to control the affectionately named 'Chevvy'."
	req_access = list(208)
	circuit = /obj/item/circuitboard/computer/blackmarket_chevvy
	shuttleId = "blackmarket_chevvy"
	possible_destinations = "blackmarket_chevvy_custom;blackmarket_chevvy_home;whiteship_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/blackmarket_chevvy
	name = "Chevvy Navigation Computer"
	desc = "Used to designate a precise transit location for the affectionately named 'Chevvy'."
	shuttleId = "blackmarket_chevvy"
	lock_override = NONE
	shuttlePortId = "blackmarket_chevvy_custom"
	jumpto_ports = list("blackmarket_chevvy_home" = 1, "whiteship_home" = 1)
	view_range = 0
	x_offset = 2
	y_offset = 0

/obj/item/circuitboard/computer/blackmarket_chevvy
	name = "Chevvy Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/caravan/blackmarket_chevvy
/*----- End of Black Market Shuttle Code -----*/

/*----- Interdyne Cargo Shuttle Datum + related code -----*/
/datum/map_template/shuttle/ruin/interdyne_cargo
	prefix = "_maps/skyrat/shuttles/"
	suffix = "interdyne_cargo"
	name = "Interdyne Cargo Shuttle"

/obj/machinery/computer/shuttle/caravan/interdyne_cargo
	name = "Cargo Shuttle Console"
	desc = "Used to control the cargo shuttle."
	req_access = list(ACCESS_SYNDICATE)
	circuit = /obj/item/circuitboard/computer/interdyne_cargo
	shuttleId = "interdyne_cargo"
	possible_destinations = "interdyne_cargo_home;interdyne_cargo_away"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED

/obj/item/circuitboard/computer/interdyne_cargo
	name = "Cargo Shuttle Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/caravan/interdyne_cargo
/*----- End of Black Market Shuttle Code -----*/
