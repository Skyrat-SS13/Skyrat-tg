//Exploration shuttles

/area/shuttle/crow
	name = "ESS Crow"
	requires_power = TRUE
	area_limited_icon_smoothing = /area/shuttle/crow

/area/shuttle/crow/cargo
	name = "ESS Crow Cargo Bay"

/area/shuttle/crow/engineering
	name = "ESS Crow Engineering"

/area/shuttle/crow/helm
	name = "ESS Crow Helm"

/obj/machinery/computer/shuttle/exploration_crow
	name = "ESS Crow Ship Console"
	desc = "Used to control the ESS Crow."
	circuit = /obj/item/circuitboard/computer/exploration_crow
	shuttleId = "exploration_crow"
	possible_destinations = "mediumdock;largedock;hugedock"

/obj/item/circuitboard/computer/exploration_crow
	name = "ESS Crow Ship Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/computer/shuttle/exploration_crow
