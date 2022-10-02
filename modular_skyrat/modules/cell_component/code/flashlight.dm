#define FLASHLIGHT_MODE_LOW "low"
#define FLASHLIGHT_MODE_MEDIUM "medium"
#define FLASHLIGHT_MODE_HIGH "high"

/obj/item/flashlight
	/// Does this flashlight utilize batteries?
	var/uses_battery = TRUE
	/// What's this flashlight's special cell, if any?
	var/cell_override
	/// How much power (per process) does this flashlight use, if uses_battery = TRUE
	power_use_amount = POWER_CELL_USE_MINIMUM
	/// Mode of the flashlight, how strong the light is and how much the power usage is affected.
	var/flashlight_mode = FLASHLIGHT_MODE_LOW
	/// Does this flashlight have modes?
	var/has_modes = TRUE
	/// Does this flashlight make the extra noise upon being turned on?
	var/makes_noise_when_lit = TRUE

/obj/item/flashlight/Initialize(mapload)
	. = ..()
	if(icon_state == "[initial(icon_state)]-on")
		turn_on(FALSE)
	update_brightness()

	if(uses_battery)
		AddComponent(/datum/component/cell, cell_override, CALLBACK(src, .proc/turn_off))

/obj/item/flashlight/proc/update_brightness()
	set_light_on(on)
	if(light_system == STATIC_LIGHT)
		update_light()
	update_appearance()

/obj/item/flashlight/examine(mob/user)
	. = ..()
	if(has_modes)
		. += "This flashlight has modes! Ctrl-click it to change the mode."
		. += "It is currently set to [flashlight_mode] intensity."

/obj/item/flashlight/CtrlClick(mob/user)
	. = ..()
	if(has_modes)
		switch(flashlight_mode)
			if(FLASHLIGHT_MODE_LOW)
				flashlight_mode = FLASHLIGHT_MODE_MEDIUM
				power_use_amount = POWER_CELL_USE_VERY_LOW
				set_light_range(initial(light_range) + 1)
				set_light_power(initial(light_power) + 1)
				to_chat(user, span_notice("You set [src] to medium."))
			if(FLASHLIGHT_MODE_MEDIUM)
				flashlight_mode = FLASHLIGHT_MODE_HIGH
				power_use_amount = POWER_CELL_USE_LOW
				set_light_range(initial(light_range) + 2)
				set_light_power(initial(light_power) + 2)
				to_chat(user, span_notice("You set [src] to high."))
			if(FLASHLIGHT_MODE_HIGH)
				flashlight_mode = FLASHLIGHT_MODE_LOW
				power_use_amount = POWER_CELL_USE_MINIMUM
				set_light_range(initial(light_range))
				set_light_power(initial(light_power))
				to_chat(user, span_notice("You set [src] to low."))

/obj/item/flashlight/attack_self(mob/user)
	. = ..()
	if(on)
		turn_off()
	else
		if(uses_battery && !(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
			return
		turn_on(makes_noise_when_lit)
	playsound(user, on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
	return TRUE

/**
 * Handles turning on the flashlight.
 * Parameters:
 * * noisy - Boolean on whether the flashlight should make an additional noise from being turned on or not. Defaults to TRUE.
 */
/obj/item/flashlight/proc/turn_on(noisy = TRUE)
	on = TRUE
	if (uses_battery)
		START_PROCESSING(SSobj, src)
	update_brightness()
	if(noisy)
		playsound(src, 'modular_skyrat/master_files/sound/effects/flashlight.ogg', 40, TRUE) //Credits to ERIS for the sound
	update_action_buttons()

/// Handles turning off the flashlight.
/obj/item/flashlight/proc/turn_off()
	on = FALSE
	update_brightness()
	update_action_buttons()

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
	has_modes = FALSE

/obj/item/flashlight/lantern
	uses_battery = FALSE
	has_modes = FALSE
	makes_noise_when_lit = FALSE

/obj/item/flashlight/slime
	uses_battery = FALSE
	has_modes = FALSE
	makes_noise_when_lit = FALSE

/obj/item/flashlight/flare
	uses_battery = FALSE
	has_modes = FALSE
	makes_noise_when_lit = FALSE

/obj/item/flashlight/emp/debug
	uses_battery = FALSE

/obj/item/flashlight/glowstick
	uses_battery = FALSE
	has_modes = FALSE
	makes_noise_when_lit = FALSE

/obj/item/flashlight/spotlight
	uses_battery = FALSE
	has_modes = FALSE

/obj/item/flashlight/eyelight
	uses_battery = FALSE
	has_modes = FALSE

/obj/item/flashlight/pen
	cell_override = /obj/item/stock_parts/cell/potato
	has_modes = FALSE

#undef FLASHLIGHT_MODE_LOW
#undef FLASHLIGHT_MODE_MEDIUM
#undef FLASHLIGHT_MODE_HIGH
