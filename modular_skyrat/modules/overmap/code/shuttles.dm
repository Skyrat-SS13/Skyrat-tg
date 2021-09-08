//Common shuttles
/obj/machinery/computer/shuttle/exploration_crow
	name = "ESS Crow Ship Console"
	desc = "Used to control the ESS Crow."
	circuit = /obj/item/circuitboard/computer/exploration_crow
	shuttleId = "exploration_crow"
	possible_destinations = "mediumdock;largedock;hugedock;gateway"

/obj/item/circuitboard/computer/exploration_crow
	name = "ESS Crow Ship Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/exploration_crow
/datum/overmap_object/shuttle/ship
/datum/map_template/shuttle/common
	port_id = "common"
	who_can_purchase = null

/datum/map_template/shuttle/common/vulture
	suffix = "vulture"
	name = "MS Vulture"

/datum/map_template/shuttle/common/platform_small
	suffix = "platform_small"
	name = "Platform Shuttle"

/datum/map_template/shuttle/common/platform_medium
	suffix = "platform_medium"
	name = "Platform Shuttle"

/datum/map_template/shuttle/common/platform_large
	suffix = "platform_large"
	name = "Platform Shuttle"

/datum/map_template/shuttle/crow
	port_id = "exploration"
	suffix = "crow"
	name = "ESS Crow"
	who_can_purchase = null

/datum/map_template/shuttle/titan
	port_id = "ncv"
	suffix = "titan"
	name = "NCV Titan"
	who_can_purchase = null

/obj/machinery/computer/shuttle/ncv_titan
	name = "NCV Titan NAVCOM"
	desc = "Used to control the NCV Titan."
	circuit = /obj/item/circuitboard/computer/ncv_titan
	shuttleId = "ncv_titan"
	possible_destinations = "ncv_titan_dock"

/obj/item/circuitboard/computer/ncv_titan
	name = "ESS Crow Ship Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/ncv_titan
/obj/machinery/computer/overmap_console
