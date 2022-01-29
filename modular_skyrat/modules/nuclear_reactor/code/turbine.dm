/obj/machinery/reactor_steam_turbine
	name = "Micron Control Systems T47-ACT Steam Turbine"
	desc = "A steam turbine that converts kinetic energy into mechanical energy."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/turbine64x64.dmi'
	icon_state = "turbine_housing"
	bound_x = 64
	bound_y = 64
	/// Our turbine effect which is updated dynamically.
	var/obj/effect/overlay/turbine/turbine

/obj/machinery/reactor_steam_turbine/Destroy()
	QDEL_NULL(turbine)
	return ..()

/obj/effect/overlay/turbine
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/turbine64x64.dmi'
	icon_state = "fan"
	anchored = TRUE
	plane = FLOAT_PLANE
	layer = FLOAT_LAYER
	vis_flags = VIS_INHERIT_ID
	appearance_flags = KEEP_TOGETHER | LONG_GLIDE | PIXEL_SCALE

/obj/machinery/reactor_steam_turbine/Initialize(mapload)
	. = ..()
	turbine = new
	vis_contents += turbine

/obj/machinery/reactor_steam_turbine/proc/update_animate(new_time)
	animate(turbine, transform = turn(matrix(), 120), time = new_time, loop = -1)
	animate(transform = turn(matrix(), 240), time = new_time)
	animate(transform = null, time = new_time)

/obj/structure/reactor_output_shaft
	name = "output shaft"
	desc = "A large propshaft that connects the steam turbine to the alternator."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/turbine32x32.dmi'
	icon_state = "output_shaft"
