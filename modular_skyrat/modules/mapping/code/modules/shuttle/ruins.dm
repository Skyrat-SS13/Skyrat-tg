/obj/machinery/computer/shuttle/cybersun
	name = "SCSBC-12 Shuttle Console"
	desc = "Used to control SCSBC-12."
	shuttleId = "cybersun"
	possible_destinations = "cybersun_home;cybersun_custom"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	req_access = list(ACCESS_SYNDICATE)
	circuit = /obj/item/circuitboard/computer/cybersun_shuttle

/obj/item/circuitboard/computer/cybersun_shuttle
	name = "Cybersun Shuttle (Computer Board)"
	icon_state = "generic"
	build_path = /obj/machinery/computer/shuttle/cybersun

/obj/machinery/computer/camera_advanced/shuttle_docker/cybersun
	name = "SCSBC-12 Navigation Computer"
	desc = "Used to designate a precise transit location for SCSBC-12."
	shuttleId = "cybersun"
	lock_override = NONE
	shuttlePortId = "cybersun_custom"
	jumpto_ports = list("cybersun_home" = 1)
	whitelist_turfs = list(/turf/open/space, /turf/open/floor/plating, /turf/open/lava, /turf/closed/mineral)
	view_range = 12
	designate_time = 50
	x_offset = 9
	y_offset = 9
	circuit = /obj/item/circuitboard/computer/cybersun_shuttle_nav

/obj/item/circuitboard/computer/cybersun_shuttle_nav
	name = "Cybersun Shuttle Navigation (Computer Board)"
	icon_state = "generic"
	build_path = /obj/machinery/computer/camera_advanced/shuttle_docker/cybersun
