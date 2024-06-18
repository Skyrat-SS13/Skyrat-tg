// Doubles output ability for input/output to allow for higher power generation passthrough without needing to build more SMES or hotwire
/obj/machinery/power/smes
	name = "power storage unit"
	desc = "A high-capacity superconducting magnetic energy storage (SMES) unit."
	icon_state = "smes"
	density = TRUE
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/smes
	can_change_cable_layer = TRUE

	/// The charge capacity.
	var/capacity = 75 * STANDARD_CELL_CHARGE // The board defaults with 5 high capacity power cells.
	/// The current charge.
	var/charge = 0

	// TRUE = attempting to charge, FALSE = not attempting to charge
	var/input_attempt = TRUE
	// TRUE = actually inputting, FALSE = not inputting
	var/inputting = TRUE
	// amount of power the SMES attempts to charge by
	var/input_level = 75 KILO WATTS
	// cap on input_level
	var/input_level_max = 400 KILO WATTS
	// amount of charge available from input last tick
	var/input_available = 0

	// TRUE = attempting to output, FALSE = not attempting to output
	var/output_attempt = TRUE
	// TRUE = actually outputting, FALSE = not outputting
	var/outputting = TRUE
	// amount of power the SMES attempts to output
	var/output_level = 75 KILO WATTS
	// cap on output_level
	var/output_level_max = 400 KILO WATTS
	// amount of power actually outputted. may be less than output_level if the powernet returns excess power
	var/output_used = 0

	var/obj/machinery/power/terminal/terminal = null
