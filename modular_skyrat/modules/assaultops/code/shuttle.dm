/obj/machinery/computer/shuttle/syndicate_cruiser
	name = "syndicate cruiser helm"
	desc = "The terminal used to control the syndicate cruiser."
	shuttleId = "syndicate_cruiser"
	possible_destinations = "syndicate_cruiser_custom;syndicate_cruiser_away;syndicate_away;syndicate_z5;syndicate_ne;syndicate_nw;syndicate_n;syndicate_se;syndicate_sw;syndicate_s;syndicate_cruiser_dock;whiteship_away;whiteship_home;whiteship_z4;whiteship_lavaland;ferry_away"
	circuit = /obj/item/circuitboard/computer/syndicate_shuttle
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/machinery/computer/shuttle/syndicate_cruiser/launch_check(mob/user)
	return TRUE

/obj/machinery/computer/shuttle/syndicate_cruiser/allowed(mob/M)
	if(issilicon(M) && !(ROLE_SYNDICATE in M.faction))
		return FALSE
	return ..()

/obj/machinery/computer/shuttle/syndicate_cruiser/recall
	name = "syndicate shuttle recall terminal"
	desc = "Use this if your friends left you behind."
	possible_destinations = "syndicate_cruiser_away"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate_cruiser
	name = "syndicate cruiser navigation computer"
	desc = "Used to designate a precise transit location for the syndicate cruiser."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttlePortId = "syndicate_cruiser_dock"
	shuttleId = "syndicate_cruiser"
	jumpto_ports = list("syndicate_n" = 1, "whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1)
	view_range = 14
	whitelist_turfs = list(/turf/open/space, /turf/open/floor/plating, /turf/open/lava, /turf/closed/mineral)
	see_hidden = TRUE
	x_offset = -10
	y_offset = 5

/datum/map_template/shuttle/syndicate_cruiser
	name = "syndicate cruiser"
	prefix = "_maps/skyrat/shuttles/"
	port_id = "syndicate"
	suffix = "cruiser"
	who_can_purchase = null

/////////////FRIGATE
/obj/machinery/computer/shuttle/syndicate_frigate
	name = "syndicate frigate helm"
	desc = "The terminal used to control the syndicate frigate."
	shuttleId = "syndicate_frigate"
	possible_destinations = "syndicate_frigate_away;syndicate_frigate_dock;rockplanet_lz1"
	circuit = /obj/item/circuitboard/computer/syndicate_shuttle
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/machinery/computer/shuttle/syndicate_frigate/launch_check(mob/user)
	return TRUE

/obj/machinery/computer/shuttle/syndicate_frigate/allowed(mob/M)
	if(issilicon(M) && !(ROLE_SYNDICATE in M.faction))
		return FALSE
	return ..()

/obj/machinery/computer/shuttle/syndicate_frigate/recall
	name = "syndicate shuttle recall terminal"
	desc = "Use this if your friends left you behind."
	possible_destinations = "syndicate_frigate_away"

/datum/map_template/shuttle/syndicate_frigate
	name = "syndicate frigate"
	prefix = "_maps/skyrat/shuttles/"
	port_id = "syndicate"
	suffix = "frigate"
	who_can_purchase = null
