/datum/map_template/shuttle/ruin/expedition_shuttle
	prefix = "_maps/skyrat/expeditionary_corps/"
	suffix = "expedition_shuttle"
	name = "Expedition Shuttle"
	shuttle_id = "expedition_shuttle"

/obj/machinery/computer/shuttle/expedition_shuttle
	name = "Expedition Shuttle Control"
	desc = "Used to control the expedition shuttle."
	circuit = /obj/item/circuitboard/computer/expedition_shuttle
	shuttleId = "expedition_shuttle"
	possible_destinations = "expedition_shuttle_custom;expedition_shuttle_post;expedition_shuttle_home"

/obj/machinery/computer/camera_advanced/shuttle_docker/expedition_shuttle
	name = "Expedition Shuttle Navigation Computer"
	desc = "The navigation console for the expedition shuttle."
	shuttleId = "expedition_shuttle"
	lock_override = NONE
	shuttlePortId = "expedition_shuttle_custom"
	jump_to_ports = list("expedition_shuttle_post" = 1, "expedition_shuttle_home" = 1)
	view_range = 0

/obj/item/circuitboard/computer/expedition_shuttle
	name = "Expedition Shuttle Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/expedition_shuttle
