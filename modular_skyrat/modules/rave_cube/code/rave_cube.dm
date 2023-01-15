#define RAVE_LIGHT_RANGE (rand(85, 115)*0.01)

/obj/machinery/rave_cube
	name = "rave cube"
	desc = "Party in a box! With bright lights and dazzling sparkles, dance the night away to your Neko Nation Anthem! Drugs not included."
	icon = 'modular_skyrat/modules/rave_cube/icons/rave_cube.dmi'
	icon_state = "ravecube"
	anchored = FALSE
	density = TRUE
	resistance_flags = FREEZE_PROOF | FIRE_PROOF
	var/active = FALSE
	var/list/spotlights = list()
	var/list/sparkles = list()
	var/xfx_mode = TRUE

/datum/supply_pack/costumes_toys/ravecube
	name = "Rave Cube Crate"
	desc = "Party in a box! With bright lights and dazzling sparkles, dance the night away to your Neko Nation Anthem! Drugs not included."
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/machinery/rave_cube)
	crate_name = "rave cube crate"

/obj/machinery/rave_cube/proc/turn_on(mob/user)
	active = TRUE
	to_chat(user, span_notice("You turn the rave cube on!"))
	update_icon()
	START_PROCESSING(SSobj, src)
	lights_setup()
	lights_spin()

/obj/machinery/rave_cube/proc/turn_off(mob/user)
	active = FALSE
	icon_state = "ravecube"
	to_chat(user, span_notice("You turn the rave cube off!"))
	set_light(0)
	remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	STOP_PROCESSING(SSobj, src)
	QDEL_LIST(spotlights)
	QDEL_LIST(sparkles)
	update_appearance()

/obj/machinery/rave_cube/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!anchored)
		to_chat(user, span_warning("You have to anchor the rave cube in place before powering it on!"))
		return
	if(active)
		turn_off(user)
	else
		turn_on(user)

/obj/machinery/rave_cube/examine(mob/user)
	. = ..()
	. += span_notice("Alt+Click to [anchored ? "un" : null]anchor [src].")
	. += span_notice("Ctrl+Shift+Click to [xfx_mode ? "dis" : "en"]able extra effects mode.")

/obj/machinery/rave_cube/AltClick(mob/living/carbon/human/user)
	. = ..()
	set_anchored(!anchored)

	if(active && !anchored)
		turn_off(user)

	balloon_alert(user, "[anchored ? null : "un"]anchored")

/obj/machinery/rave_cube/CtrlShiftClick(mob/living/carbon/human/user)
	. = ..()
	if(xfx_mode)
		xfx_mode = FALSE

	else
		xfx_mode = TRUE

	balloon_alert(user, "Extra effects [xfx_mode ? "en" : "dis"]abled")

/obj/machinery/rave_cube/update_icon_state()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	luminosity = 0

	if(active)
		luminosity = 1
		SSvis_overlays.add_vis_overlay(src, icon, "active", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "active", 0, EMISSIVE_PLANE, dir, alpha)

/obj/item/flashlight/spotlight/rave
	name = "rave light"
	desc = "Fits in with your glowing cat ears headband. Or your actual ears if you're a feline, I suppose."

/obj/machinery/rave_cube/proc/lights_setup()
	var/turf/centre = get_turf(src)
	FOR_DVIEW(var/turf/turf, 3, get_turf(src),INVISIBILITY_LIGHTING)
		if(turf.x == centre.x && turf.y > centre.y)
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), COLOR_SOFT_RED)
			continue
		if(turf.x == centre.x && turf.y < centre.y)
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_PURPLE)
			continue
		if(turf.x > centre.x && turf.y == centre.y)
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_YELLOW)
			continue
		if(turf.x < centre.x && turf.y == centre.y)
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_GREEN)
			continue
		if((turf.x+1 == centre.x && turf.y+1 == centre.y) || (turf.x+2==centre.x && turf.y+2 == centre.y))
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1.4 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_ORANGE)
			continue
		if((turf.x-1 == centre.x && turf.y-1 == centre.y) || (turf.x-2==centre.x && turf.y-2 == centre.y))
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1.4 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_CYAN)
			continue
		if((turf.x-1 == centre.x && turf.y+1 == centre.y) || (turf.x-2==centre.x && turf.y+2 == centre.y))
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1.4 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_BLUEGREEN)
			continue
		if((turf.x+1 == centre.x && turf.y-1 == centre.y) || (turf.x+2==centre.x && turf.y-2 == centre.y))
			spotlights += new /obj/item/flashlight/spotlight/rave(turf, 1.4 + get_dist(src, turf), 30 - (get_dist(src, turf) * 8), LIGHT_COLOR_BLUE)
			continue
		continue
	FOR_DVIEW_END

/obj/machinery/rave_cube/proc/lights_spin()
	say("Rave cube is initialising... Please wait.")
	icon_state = "ravecube_init"
	for(var/i in 1 to 25)
		if(QDELETED(src) || !active)
			return
		var/obj/effect/overlay/sparkles/spark = new /obj/effect/overlay/sparkles(src)
		spark.alpha = 0
		sparkles += spark
		switch(i)
			if(1 to 8)
				spark.orbit(src, 30, TRUE, 60, 36, TRUE)
			if(9 to 16)
				spark.orbit(src, 62, TRUE, 60, 36, TRUE)
			if(17 to 24)
				spark.orbit(src, 95, TRUE, 60, 36, TRUE)
			if(25)
				spark.pixel_y = 7
				spark.forceMove(get_turf(src))
		sleep(0.7 SECONDS)
	for(var/overlay in sparkles)
		var/obj/effect/overlay/sparkles/reveal = overlay
		reveal.alpha = 255
	icon_state = "ravecube_active"
	say("Rave cube initialisation complete!")
	while(active)
		for(var/lightstrip in spotlights) // The multiples reflects custom adjustments to each colors after dozens of tests
			var/obj/item/flashlight/spotlight/rave/glow = lightstrip
			if(QDELETED(glow))
				stack_trace("[glow?.gc_destroyed ? "Qdeleting glow" : "null entry"] found in [src].[gc_destroyed ? " Source qdeleting at the time." : ""]")
				return
			switch(glow.light_color)
				if(COLOR_SOFT_RED)
					if(glow.even_cycle)
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_BLUE)
					else
						glow.set_light_range_power_color(glow.base_light_range * RAVE_LIGHT_RANGE, glow.light_power * 1.48, LIGHT_COLOR_BLUE)
						glow.set_light_on(TRUE)
				if(LIGHT_COLOR_BLUE)
					if(glow.even_cycle)
						glow.set_light_range_power_color(glow.base_light_range * RAVE_LIGHT_RANGE, glow.light_power * 2, LIGHT_COLOR_GREEN)
						glow.set_light_on(TRUE)
					else
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_GREEN)
				if(LIGHT_COLOR_GREEN)
					if(glow.even_cycle)
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_ORANGE)
					else
						glow.set_light_range_power_color(glow.base_light_range * RAVE_LIGHT_RANGE, glow.light_power * 0.5, LIGHT_COLOR_ORANGE)
						glow.set_light_on(TRUE)
				if(LIGHT_COLOR_ORANGE)
					if(glow.even_cycle)
						glow.set_light_range_power_color(glow.base_light_range * RAVE_LIGHT_RANGE, glow.light_power * 2.27, LIGHT_COLOR_PURPLE)
						glow.set_light_on(TRUE)
					else
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_PURPLE)
				if(LIGHT_COLOR_PURPLE)
					if(glow.even_cycle)
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_BLUEGREEN)
					else
						glow.set_light_range_power_color(glow.base_light_range * RAVE_LIGHT_RANGE, glow.light_power * 0.44, LIGHT_COLOR_BLUEGREEN)
						glow.set_light_on(TRUE)
				if(LIGHT_COLOR_BLUEGREEN)
					if(glow.even_cycle)
						glow.set_light_range(glow.base_light_range * RAVE_LIGHT_RANGE)
						glow.set_light_color(LIGHT_COLOR_YELLOW)
						glow.set_light_on(TRUE)
					else
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_YELLOW)
				if(LIGHT_COLOR_YELLOW)
					if(glow.even_cycle)
						glow.set_light_on(FALSE)
						glow.set_light_color(LIGHT_COLOR_CYAN)
					else
						glow.set_light_range(glow.base_light_range * RAVE_LIGHT_RANGE)
						glow.set_light_color(LIGHT_COLOR_CYAN)
						glow.set_light_on(TRUE)
				if(LIGHT_COLOR_CYAN)
					if(glow.even_cycle)
						glow.set_light_range_power_color(glow.base_light_range * RAVE_LIGHT_RANGE, glow.light_power * 0.68, COLOR_SOFT_RED)
						glow.set_light_on(TRUE)
					else
						glow.set_light_on(FALSE)
						glow.set_light_color(COLOR_SOFT_RED)
					glow.even_cycle = !glow.even_cycle
		if(prob(2))  // Unique effects for the dance floor that show up randomly to mix things up
			if(!xfx_mode)
				return
			INVOKE_ASYNC(src, PROC_REF(extra_effects))
		sleep(4)
		if(QDELETED(src))
			return

/obj/machinery/rave_cube/proc/extra_effects()
	for(var/i in 1 to 10)
		spawn_atom_to_turf(/obj/effect/temp_visual/hierophant/telegraph/edge, src, 1, FALSE)
		sleep(0.5 SECONDS)
		if(QDELETED(src))
			return

#undef RAVE_LIGHT_RANGE
