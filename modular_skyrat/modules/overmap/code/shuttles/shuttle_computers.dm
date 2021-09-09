/obj/machinery/computer/shuttle/ncv_titan
	name = "NCV Titan NAVCOM"
	desc = "Used to control the NCV Titan."
	circuit = /obj/item/circuitboard/computer/ncv_titan
	shuttleId = "ncv_titan"
	possible_destinations = "ncv_titan_dock"

/obj/item/circuitboard/computer/ncv_titan
	name = "NXV Crow Ship Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/ncv_titan

/obj/machinery/computer/shuttle/exploration_crow
	name = "NXV Crow Ship Console"
	desc = "Used to control the NXV Crow."
	circuit = /obj/item/circuitboard/computer/exploration_crow
	shuttleId = "exploration_crow"
	possible_destinations = "mediumdock;largedock;hugedock;gateway"

/obj/item/circuitboard/computer/exploration_crow
	name = "NXV Crow Ship Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/exploration_crow

/obj/machinery/computer/shuttle/exploration_nexus
	name = "NXV Nexus Ship Console"
	desc = "Used to control the ESS Crow."
	circuit = /obj/item/circuitboard/computer/exploration_nexus
	shuttleId = "exploration_nexus"
	possible_destinations = "hugedock;gateway"

/obj/item/circuitboard/computer/exploration_nexus
	name = "NXV Nexus Ship Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/exploration_nexus

