/obj/machinery/arc_furnace
	name = "arc furnace"
	desc = "An arc furnace, a specialist machine that can rapidly smelt ores using, as the name implies, massive \
		amounts of electricity. While not nearly as fast and efficient as other ore refining methods, none are anywhere \
		near as portable as these are."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "arc_furnace"
	base_icon_state = "arc_furnace"
	appearance_flags = KEEP_TOGETHER | LONG_GLIDE | PIXEL_SCALE
	layer = BELOW_OBJ_LAYER
	density = TRUE
	circuit = null
	light_color = LIGHT_COLOR_CYAN
	light_power = 10
	flags_1 = NODECONSTRUCT_1
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10 // This baby consumes so much power
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/arc_furnace
	/// If the furnace is currently working on smelting something
	var/operating = FALSE
	/// Image for the radial eject button
	var/static/radial_eject = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_eject")
	/// Image for the radial use button
	var/static/radial_use = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")
	/// Radial options for using the arc furnace
	var/static/list/radial_options = list("eject" = radial_eject, "use" = radial_use)
	/// Soundloop for while we are smelting ores
	var/datum/looping_sound/arc_furnace_running/soundloop

/obj/machinery/arc_furnace/Initialize(mapload)
	. = ..()

	soundloop = new(src, FALSE)

	flick("arc_furnace_deploy", src)

/obj/machinery/arc_furnace/examine(mob/user)
	. = ..()
	. += span_notice("You could probably <b>repack</b> this with <b>right click</b>.")

	if(length(contents))
		. += span_notice("It has <b>[contents[1]]</b> sitting in it.")

/obj/machinery/arc_furnace/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	balloon_alert_to_viewers("repacking...")
	if(do_after(user, 1 SECONDS, target = src))
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		deconstruct(disassembled = TRUE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/arc_furnace/deconstruct(disassembled = TRUE)
	eject_contents()
	new repacked_type(get_turf(src))
	return ..()

/obj/machinery/arc_furnace/update_appearance()
	. = ..()
	cut_overlays()

	if(length(contents))
		var/image/overlayed_item = image(icon = contents[1].icon, icon_state = contents[1].icon_state)
		overlayed_item.transform = matrix(, 0, 0, 0, 0.8, 0)
		add_overlay(overlayed_item)

	var/image/furnace_front_overlay = image(icon = icon, icon_state = "[operating ? "[base_icon_state]_overlay_active" : "[base_icon_state]_overlay"]")
	add_overlay(furnace_front_overlay)

/obj/machinery/arc_furnace/attackby(obj/item/attacking_item, mob/living/user, params)
	if(operating)
		balloon_alert(user, "furnace busy")
		return TRUE

	if(length(contents))
		balloon_alert(user, "furnace full")
		return TRUE

	if(istype(attacking_item, /obj/item/stack/ore))
		attacking_item.forceMove(src)
		balloon_alert(user, "ore added")
		update_appearance()
		return TRUE

	return ..()

/obj/machinery/arc_furnace/ui_interact(mob/user)
	. = ..()

	if(operating || !user.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	if(isAI(user) && (machine_stat & NOPOWER))
		return

	if(!length(contents))
		balloon_alert(user, "it's empty!")
		return

	var/choice = show_radial_menu(user, src, radial_options, require_near = !issilicon(user))

	// post choice verification
	if(operating || !user.can_perform_action(src, ALLOW_SILICON_REACH))
		return
	if(isAI(user) && (machine_stat & NOPOWER))
		return

	usr.set_machine(src) // What does this even do??
	switch(choice)
		if("eject")
			eject_contents()
		if("use")
			smelt_it_up(user)

/obj/machinery/arc_furnace/proc/eject_contents()
	if(operating)
		return

	playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)

	if(!length(contents))
		return

	var/atom/movable/thing_inside = contents[1]
	thing_inside.forceMove(drop_location())
	update_appearance()

/obj/machinery/arc_furnace/proc/smelt_it_up(mob/user)
	if(machine_stat & (NOPOWER|BROKEN))
		balloon_alert(user, "button doesn't respond")
		return
	if(operating)
		balloon_alert(user, "already smelting")
		return

	var/obj/item/stack/ore/ore_to_smelt = contents[1]
	if(!istype(ore_to_smelt))
		balloon_alert(user, "nothing to smelt")

	operating = TRUE
	/// How long the smelting is going to take based off the stack size
	var/smelting_time = ore_to_smelt.amount * 1 SECONDS
	loop(smelting_time)

	soundloop.start()
	set_light(l_range = 3)

	update_appearance()

/obj/machinery/arc_furnace/proc/loop(time)
	if(machine_stat & (NOPOWER|BROKEN))
		end_smelting()
		return

	if(!length(contents))
		end_smelting()
		return

	if(time <= 0)
		succeed_smelting()
		return

	time -= 1 SECONDS
	use_power(active_power_usage)
	addtimer(CALLBACK(src, PROC_REF(loop), time), 1 SECONDS)

/obj/machinery/arc_furnace/proc/succeed_smelting()
	var/obj/item/stack/ore/ore_to_smelt = contents[1]
	if(!istype(ore_to_smelt))
		end_smelting()
	/// Stack of product we just made and are going to fiddle with after spawning
	var/obj/item/stack/smelting_product = new ore_to_smelt.refined_type(drop_location())
	smelting_product.amount = ore_to_smelt.amount
	smelting_product.update_appearance(UPDATE_ICON)
	qdel(ore_to_smelt)
	end_smelting()

/obj/machinery/arc_furnace/proc/end_smelting()
	operating = FALSE
	update_appearance()

// Item for creating the arc furnace or carrying it around

/obj/item/flatpacked_machine/arc_furnace
	name = "\improper flatpacked arc furnace"
	desc = "An arc furnace, a specialist machine that can rapidly smelt ores using, as the name implies, massive \
		amounts of electricity. While not nearly as fast and efficient as other ore refining methods, none are anywhere \
		near as portable as these are."
	icon_state = "arc_furnace_folded"
	type_to_deploy = /obj/machinery/arc_furnace
