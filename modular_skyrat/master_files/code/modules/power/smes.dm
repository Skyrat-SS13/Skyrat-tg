// TG power bad, SMES power update good
// Doubles output ability for input/output to allow for higher power generation passthrough without needing to build more SMES or hotwire
/obj/machinery/power/smes
	capacity = 75 * STANDARD_CELL_CHARGE
	input_level = 75 KILO WATTS
	input_level_max = 400 KILO WATTS
	output_level = 75 KILO WATTS
	output_level_max = 400 KILO WATTS
