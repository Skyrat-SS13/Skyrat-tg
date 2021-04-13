/obj/item/flashlight
	/// Does this flashlight utilize batteries?
	var/uses_battery = TRUE
	/// Does this flashlight have a cell override?
	var/cell_override
	/// How much power(per process) does this flashlight use? If any.
	var/power_cell_use = POWER_CELL_USE_VERY_LOW

/obj/item/flashlight/Initialize()
	. = ..()
	if(icon_state == "[initial(icon_state)]-on")
		turn_on()

/obj/item/flashlight/proc/update_brightness()
	set_light_on(on)
	if(light_system == STATIC_LIGHT)
		update_light()
	update_appearance()

/obj/item/flashlight/attack_self(mob/user)
	. = ..()
	if(on)
		turn_off(user)
	else
		turn_on(user)

/obj/item/flashlight/component_cell_out_of_charge()
	turn_off()

/obj/item/flashlight/proc/turn_off()
	SIGNAL_HANDLER

	on = FALSE

	if(uses_battery)
		SEND_SIGNAL(src, COMSIG_CELL_STOP_USE)

	update_brightness()

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/flashlight/proc/turn_on(mob/user)
	SIGNAL_HANDLER

	if(uses_battery)
		var/datum/component/cell/battery_compartment = GetComponent(/datum/component/cell)
		if(battery_compartment)
			if(!battery_compartment.simple_power_use(user))
				return
		SEND_SIGNAL(src, COMSIG_CELL_START_USE)

	on = TRUE

	playsound(src, 'modular_skyrat/master_files/sound/effects/flashlight.ogg', 40, TRUE)

	update_brightness()

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/flashlight/update_icon_state()
	. = ..()
	if(on)
		icon_state = "[initial(icon_state)]-on"
	else
		icon_state = initial(icon_state)

/obj/item/flashlight/ComponentInitialize()
	. = ..()
	if(uses_battery)
		AddComponent(/datum/component/cell, cell_override, power_cell_use)

/obj/item/flashlight/flare/turn_on()
	on = TRUE
	update_brightness()

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/flashlight/flare/turn_off()
	on = FALSE
	force = initial(src.force)
	damtype = initial(src.damtype)
	update_brightness()

/obj/item/flashlight/seclite
	cell_override = /obj/item/stock_parts/cell/upgraded

/obj/item/flashlight/lamp
	uses_battery = FALSE

/obj/item/flashlight/flare
	uses_battery = FALSE

/obj/item/flashlight/emp/debug
	uses_battery = FALSE

/obj/item/flashlight/glowstick
	uses_battery = FALSE

/obj/item/flashlight/spotlight
	uses_battery = FALSE

/obj/item/flashlight/eyelight
	uses_battery = FALSE

/obj/item/flashlight/pen
	cell_override = /obj/item/stock_parts/cell/potato
