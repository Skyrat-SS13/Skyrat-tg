/obj/structure/window/fulltile
	icon = 'modular_skyrat/modules/aesthetics/windows/icons/window.dmi'
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/reinforced/fulltile
	icon = 'modular_skyrat/modules/aesthetics/windows/icons/r_window.dmi'
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'modular_skyrat/modules/aesthetics/windows/icons/r_window_tinted.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/plasma/fulltile
	icon = 'modular_skyrat/modules/aesthetics/windows/icons/window_plasma.dmi'
	icon_state = "window-0"
	base_icon_state = "window"
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/reinforced/plasma/fulltile
	icon = 'modular_skyrat/modules/aesthetics/windows/icons/r_window_plasma.dmi'
	icon_state = "reinforced_window-0"
	base_icon_state = "reinforced_window"
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

/obj/structure/window/reinforced/fulltile/ice

// Polarized Windows

// First defines and allows it to be assigned an ID to be toggled
/obj/structure/window/reinforced/fulltile/polarized
	name = "Polorized Window"
	desc = "Adjusts its tint with voltage, it is reinforced with metal rods."
	var/id = null

// Proc for the Opacity, Alpha and color toggle
/obj/structure/window/reinforced/fulltile/polarized/proc/toggle()
	if(opacity)
		animate(src, color="#FFFFFF", time=5)
		set_opacity(FALSE)
		alpha = initial(alpha)
	else
		animate(src, alpha = 255, color="#222222", time=5)
		set_opacity(TRUE)

/obj/machinery/button/window/reinforced/polarized
	name = "Polorized Window Button"
	desc = "A remote control switch for polarized windows."

/obj/machinery/button/window/reinforced/polarized/attack_hand(mob/living/user)
	if(..())
		return TRUE

	toggle_tint()

/obj/machinery/button/window/reinforced/polarized/proc/toggle_tint()
	use_power(5)

	initialized_button = !initialized_button
	update_icon()

	for(var/obj/structure/window/reinforced/fulltile/polarized/window)
		if (window.id == src.id || !window.id)
			window.toggle()


/obj/machinery/button/window/reinforced/polarized/power_change()
	..()
	if(initialized_button && !powered(power_channel))
		toggle_tint()
