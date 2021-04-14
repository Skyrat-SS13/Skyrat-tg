/obj/item/flashlight
	/// Does this flashlight utilize batteries?
	var/uses_battery = TRUE
	/// Does this flashlight have a cell override?
	var/cell_override
	/// How much power(per process) does this flashlight use? If any.
	power_use_amount = POWER_CELL_USE_VERY_LOW

/obj/item/flashlight/Initialize()
	. = ..()
	if(icon_state == "[initial(icon_state)]-on")
		turn_on()

/obj/item/flashlight/ComponentInitialize()
	. = ..()
	if(uses_battery)
		AddComponent(/datum/component/cell, cell_override, CALLBACK(src, .proc/turn_off))

/obj/item/flashlight/proc/update_brightness()
	set_light_on(on)
	if(light_system == STATIC_LIGHT)
		update_light()
	update_appearance()

/obj/item/flashlight/attack_self(mob/user)
	. = ..()
	if(on)
		on = FALSE
		turn_off(user)
	else
		if(uses_battery && !(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
			return
		on = TRUE
		turn_on(user)
	playsound(user, on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)

/obj/item/flashlight/proc/turn_off()
	update_brightness()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/flashlight/proc/turn_on(mob/user)
	START_PROCESSING(SSobj, src)
	update_brightness()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/flashlight/process(delta_time)
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return
	if(uses_battery && !(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		turn_off()

/obj/item/flashlight/update_icon_state()
	. = ..()
	if(on)
		icon_state = "[initial(icon_state)]-on"
	else
		icon_state = initial(icon_state)

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
