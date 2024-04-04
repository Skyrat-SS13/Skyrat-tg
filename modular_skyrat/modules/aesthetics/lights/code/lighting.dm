/// Dynamically calculate nightshift brightness. How TG does it is painful to modify.
#define NIGHTSHIFT_LIGHT_MODIFIER 0.15
#define NIGHTSHIFT_COLOR_MODIFIER 0.15

/obj/machinery/light
	brightness = 7.5
	fire_brightness = 6
	fire_colour = COLOR_FIRE_LIGHT_RED
	bulb_colour = COLOR_OFF_WHITE
	bulb_power = 0.9
	nightshift_light_color = null // Let the dynamic night shift color code handle this.
	bulb_low_power_colour = LIGHT_COLOR_BROWN
	bulb_low_power_brightness_mul = 0.75
	bulb_low_power_pow_min = 0.75
	bulb_emergency_colour = LIGHT_COLOR_INTENSE_RED
	bulb_major_emergency_brightness_mul = 0.9
	var/maploaded = FALSE //So we don't have a lot of stress on startup.
	var/turning_on = FALSE //More stress stuff.
	var/constant_flickering = FALSE // Are we always flickering?
	var/flicker_timer = null
	var/roundstart_flicker = FALSE

/obj/machinery/light/proc/delayed_turn_on(trigger, play_sound = TRUE, color_set, power_set, brightness_set)
	if(QDELETED(src))
		return
	turning_on = FALSE
	if(!on)
		return
	if( prob( min(60, (switchcount**2)*0.01) ) )
		if(trigger)
			burn_out()
	else
		use_power = ACTIVE_POWER_USE
		set_light(
			l_range = brightness_set,
			l_power = power_set,
			l_color = color_set
			)
		if(play_sound)
			playsound(src.loc, 'modular_skyrat/modules/aesthetics/lights/sound/light_on.ogg', 65, 1)

/obj/machinery/light/proc/start_flickering()
	on = FALSE
	update(FALSE, TRUE, FALSE)

	constant_flickering = TRUE

	flicker_timer = addtimer(CALLBACK(src, PROC_REF(flicker_on)), rand(5, 10))

/obj/machinery/light/proc/stop_flickering()
	constant_flickering = FALSE

	if(flicker_timer)
		deltimer(flicker_timer)
		flicker_timer = null

	set_on(has_power())

/obj/machinery/light/proc/alter_flicker(enable = TRUE)
	if(!constant_flickering)
		return
	if(has_power())
		on = enable
		update(FALSE, TRUE, FALSE)

/obj/machinery/light/proc/flicker_on()
	alter_flicker(TRUE)
	flicker_timer = addtimer(CALLBACK(src, PROC_REF(flicker_off)), rand(5, 10))

/obj/machinery/light/proc/flicker_off()
	alter_flicker(FALSE)
	flicker_timer = addtimer(CALLBACK(src, PROC_REF(flicker_on)), rand(5, 50))

/obj/machinery/light/Initialize(mapload = TRUE)
	. = ..()
	if(on)
		maploaded = TRUE

	if(roundstart_flicker)
		start_flickering()

/obj/machinery/light/multitool_act(mob/living/user, obj/item/multitool)
	if(!constant_flickering)
		balloon_alert(user, "ballast is already working!")
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "repairing the ballast...")
	if(do_after(user, 2 SECONDS, src))
		stop_flickering()
		balloon_alert(user, "ballast repaired!")
		return ITEM_INTERACT_SUCCESS
	return ..()

#undef NIGHTSHIFT_LIGHT_MODIFIER
#undef NIGHTSHIFT_COLOR_MODIFIER
