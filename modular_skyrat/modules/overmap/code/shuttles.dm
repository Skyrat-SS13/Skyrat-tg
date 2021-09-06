//Common shuttles



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
