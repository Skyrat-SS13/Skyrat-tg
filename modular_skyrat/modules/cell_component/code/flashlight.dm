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
	update_item_action_buttons()

	if(uses_battery)
		AddComponent(/datum/component/cell, cell_override, CALLBACK(src, PROC_REF(quietly_turn_off)), _has_cell_overlays = FALSE)

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

/obj/item/flashlight/toggle_light(noisy = TRUE)
	. = ..()
	if(on)
		after_turn_on()
		if(uses_battery && !(item_use_power(power_use_amount, TRUE) & COMPONENT_POWER_SUCCESS))
			return
	if(noisy)
		playsound(src, on ? sound_on : sound_off, 40, TRUE)

/**
 * Handles turning on the flashlight.
 * Parameters:
 * * noisy - Boolean on whether the flashlight should make an additional noise from being turned on or not. Defaults to TRUE.
 */
/obj/item/flashlight/proc/after_turn_on(noisy = TRUE)
	if(uses_battery)
		START_PROCESSING(SSobj, src)
	if(noisy)
		playsound(src, 'modular_skyrat/master_files/sound/effects/flashlight.ogg', 40, TRUE) //Credits to ERIS for the sound

/// Quietly turns the flashlight off if it was on (called by the battery running out of charge).
/obj/item/flashlight/proc/quietly_turn_off()
	if(on)
		toggle_light(noisy = FALSE)

/obj/item/flashlight/process(seconds_per_tick)
	if(!on)
		STOP_PROCESSING(SSobj, src)
		return
	if(uses_battery && !(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		quietly_turn_off()

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
