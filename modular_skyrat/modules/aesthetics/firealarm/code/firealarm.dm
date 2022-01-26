/obj/machinery/firealarm
	icon = 'modular_skyrat/modules/aesthetics/firealarm/icons/firealarm.dmi'
	var/alarm_sound = 'modular_skyrat/modules/aesthetics/firealarm/sound/alarm_fire.ogg'

/obj/machinery/firealarm/Initialize(mapload, dir, building)
	. = ..()
	if(dir)
		src.setDir(dir)
	if(building)
		buildstage = 0
		panel_open = TRUE
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -24 : 24)
		pixel_y = (dir & 3)? (dir ==1 ? -24 : 24) : 0
	if(name == initial(name))
		name = "[get_area_name(src)] [initial(name)]"

	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, .proc/check_security_level)

	gather_objects()

	update_appearance()

/obj/machinery/firealarm/proc/gather_objects()
	var/area/my_area = get_area(src)

	for(var/obj/machinery/light/iterating_light in my_area)
		iterating_light.RegisterSignal(src, COMSIG_FIREALARM_TRIGGERED_ON, /obj/machinery/light.proc/firealarm_on)
		iterating_light.RegisterSignal(src, COMSIG_FIREALARM_TRIGGERED_OFF, /obj/machinery/light.proc/firealarm_off)

	for(var/obj/machinery/door/firedoor/iterating_firedoor in my_area)
		iterating_firedoor.RegisterSignal(src, COMSIG_FIREALARM_TRIGGER_DOORS, /obj/machinery/door/firedoor.proc/firealarm_on)
		iterating_firedoor.RegisterSignal(src, COMSIG_FIREALARM_TRIGGERED_OFF, /obj/machinery/door/firedoor.proc/firealarm_off)

	for(var/obj/machinery/firealarm/iterating_firealarm in my_area)
		if(iterating_firealarm == src) //Bad infinite loops.
			continue
		iterating_firealarm.RegisterSignal(src, COMSIG_FIREALARM_TRIGGERED_ON, .proc/area_alarm_on)
		iterating_firealarm.RegisterSignal(src, COMSIG_FIREALARM_TRIGGERED_OFF, .proc/area_alarm_off)

/obj/machinery/firealarm/proc/area_alarm_on()
	SIGNAL_HANDLER

	triggered = TRUE
	update_fire_light(TRUE)
	update_appearance()

/obj/machinery/firealarm/proc/area_alarm_off()
	SIGNAL_HANDLER

	triggered = FALSE
	update_fire_light(FALSE)
	update_appearance()

/obj/machinery/firealarm/proc/alarm(mob/user)
	if(triggered)
		return
	triggered = TRUE
	if(!is_operational || !COOLDOWN_FINISHED(src, last_alarm))
		return
	COOLDOWN_START(src, last_alarm, FIREALARM_COOLDOWN)
	playsound(loc, alarm_sound, 75)
	if(user)
		log_game("[user] triggered a fire alarm at [COORD(src)]")
	trigger_effects()
	trigger_doors()
	update_appearance()

/obj/machinery/firealarm/proc/trigger_doors()
	SEND_SIGNAL(src, COMSIG_FIREALARM_TRIGGER_DOORS)

/obj/machinery/firealarm/proc/trigger_effects()
	SIGNAL_HANDLER
	SEND_SIGNAL(src, COMSIG_FIREALARM_TRIGGERED_ON)

/obj/machinery/firealarm/proc/untrigger_effects()
	SEND_SIGNAL(src, COMSIG_FIREALARM_TRIGGERED_OFF)

/obj/machinery/firealarm/proc/reset(mob/user)
	if(!is_operational)
		return
	if(user)
		log_game("[user] reset a fire alarm at [COORD(src)]")
	triggered = FALSE
	untrigger_effects()
	update_appearance()

/obj/machinery/firealarm/attack_hand(mob/user, list/modifiers)
	if(buildstage != 2)
		return ..()
	add_fingerprint(user)
	if(triggered)
		reset(user)
	else
		alarm(user, TRUE)

/obj/machinery/firealarm/attackby(obj/item/tool, mob/living/user, params)
	add_fingerprint(user)

	if(tool.tool_behaviour == TOOL_SCREWDRIVER && buildstage == 2)
		tool.play_tool_sound(src)
		panel_open = !panel_open
		to_chat(user, span_notice("The wires have been [panel_open ? "exposed" : "unexposed"]."))
		update_appearance()
		return

	if(panel_open)

		if(tool.tool_behaviour == TOOL_WELDER && !user.combat_mode)
			if(atom_integrity < max_integrity)
				if(!tool.tool_start_check(user, amount=0))
					return

				to_chat(user, span_notice("You begin repairing [src]..."))
				if(tool.use_tool(src, user, 40, volume=50))
					atom_integrity = max_integrity
					to_chat(user, span_notice("You repair [src]."))
			else
				to_chat(user, span_warning("[src] is already in good condition!"))
			return

		switch(buildstage)
			if(2)
				if(tool.tool_behaviour == TOOL_MULTITOOL)
					detecting = !detecting
					if (src.detecting)
						user.visible_message(span_notice("[user] reconnects [src]'s detecting unit!"), span_notice("You reconnect [src]'s detecting unit."))
					else
						user.visible_message(span_notice("[user] disconnects [src]'s detecting unit!"), span_notice("You disconnect [src]'s detecting unit."))
					return

				else if(tool.tool_behaviour == TOOL_WIRECUTTER)
					buildstage = 1
					tool.play_tool_sound(src)
					new /obj/item/stack/cable_coil(user.loc, 5)
					to_chat(user, span_notice("You cut the wires from \the [src]."))
					update_appearance()
					return

				else if(tool.force) //hit and turn it on
					..()
					if(!triggered)
						alarm()
					return

			if(1)
				if(istype(tool, /obj/item/stack/cable_coil))
					var/obj/item/stack/cable_coil/coil = tool
					if(coil.get_amount() < 5)
						to_chat(user, span_warning("You need more cable for this!"))
					else
						coil.use(5)
						buildstage = 2
						to_chat(user, span_notice("You wire \the [src]."))
						update_appearance()
					return

				else if(tool.tool_behaviour == TOOL_CROWBAR)
					user.visible_message(span_notice("[user.name] removes the electronics from [src.name]."), \
										span_notice("You start prying out the circuit..."))
					if(tool.use_tool(src, user, 20, volume=50))
						if(buildstage == 1)
							if(machine_stat & BROKEN)
								to_chat(user, span_notice("You remove the destroyed circuit."))
								set_machine_stat(machine_stat & ~BROKEN)
							else
								to_chat(user, span_notice("You pry out the circuit."))
								new /obj/item/electronics/firealarm(user.loc)
							buildstage = 0
							update_appearance()
					return
			if(0)
				if(istype(tool, /obj/item/electronics/firealarm))
					to_chat(user, span_notice("You insert the circuit."))
					qdel(tool)
					buildstage = 1
					update_appearance()
					return

				else if(istype(tool, /obj/item/electroadaptive_pseudocircuit))
					var/obj/item/electroadaptive_pseudocircuit/pseudoc = tool
					if(!pseudoc.adapt_circuit(user, 15))
						return
					user.visible_message(span_notice("[user] fabricates a circuit and places it into [src]."), \
					span_notice("You adapt a fire alarm circuit and slot it into the assembly."))
					buildstage = 1
					update_appearance()
					return

				else if(tool.tool_behaviour == TOOL_WRENCH)
					user.visible_message(span_notice("[user] removes the fire alarm assembly from the wall."), \
						span_notice("You remove the fire alarm assembly from the wall."))
					var/obj/item/wallframe/firealarm/frame = new /obj/item/wallframe/firealarm()
					frame.forceMove(user.drop_location())
					tool.play_tool_sound(src)
					qdel(src)
					return

	return ..()

