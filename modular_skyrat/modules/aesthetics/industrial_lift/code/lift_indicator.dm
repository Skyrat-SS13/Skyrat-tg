/obj/machinery/lift_indicator
	name = "elevator floor indicator"
	desc = "Indicates what floor the elevator is on and which way it's going."
	icon = 'modular_skyrat/modules/aesthetics/industrial_lift/icons/industrial_lift.dmi'
	light_color = LIGHT_COLOR_DARK_BLUE
	light_power = 1
	maptext_x = 16

	/// = (real lowest floor's z-level) - (what we want to display)
	lowest_floor_offset = -1
	/// The lowest floor number. Ignore Centcom and Interlink
	lowest_floor_num = 4

/obj/machinery/lift_indicator/proc/get_current_level_as_text(level)
	switch(level)
		if(4)
			return "Lower Level"
		if(5)
			return "Tram Level"

/obj/machinery/lift_indicator/proc/get_current_level_as_sign(level)
	switch(level)
		if(4)
			return "L"
		if(5)
			return "T"

/obj/machinery/lift_indicator/examine(mob/user)
	. = ..()

	if(!is_operational)
		. += span_notice("The display is dark.")
		return

	var/dirtext
	switch(current_lift_direction)
		if(UP)
			dirtext = "travelling upwards"
		if(DOWN)
			dirtext = "travelling downwards"
		else
			dirtext = "stopped"

	. += span_notice("The elevator is at [get_current_level_as_text(current_lift_floor)], [dirtext].")

/obj/machinery/lift_indicator/update_appearance(updates)
	. = ..()

	if(!is_operational)
		set_light(l_on = FALSE)
		maptext = ""
		return

	set_light(l_on = TRUE)
	maptext = {"<div style="font:5pt 'Small Fonts';color:[LIGHT_COLOR_DARK_BLUE]">[get_current_level_as_sign(current_lift_floor)]</div>"}

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/lift_indicator, 34)
