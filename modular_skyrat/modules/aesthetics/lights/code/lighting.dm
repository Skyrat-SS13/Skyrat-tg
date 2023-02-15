/// Dynamically calculate nightshift brightness. How TG does it is painful to modify.
#define NIGHTSHIFT_MODIFIER 1.5
#define COLOR_BIT_SIZE 255
/obj/machinery/light
	icon = 'modular_skyrat/modules/aesthetics/lights/icons/lighting.dmi'
	overlay_icon = 'modular_skyrat/modules/aesthetics/lights/icons/lighting_overlay.dmi'
	var/maploaded = FALSE //So we don't have a lot of stress on startup.
	var/turning_on = FALSE //More stress stuff.
	var/constant_flickering = FALSE // Are we always flickering?
	var/flicker_timer = null
	var/roundstart_flicker = FALSE
	var/firealarm = FALSE

/obj/machinery/light/proc/turn_on(trigger, play_sound = TRUE)
	if(QDELETED(src))
		return
	turning_on = FALSE
	if(!on)
		return
	var/new_brightness = brightness
	var/new_power = bulb_power
	var/new_color = bulb_colour
	if(color)
		new_color = color
	if (firealarm)
		new_color = bulb_emergency_colour
	else if (nightshift_enabled)
		new_brightness /= NIGHTSHIFT_MODIFIER
		new_power /= NIGHTSHIFT_MODIFIER
		if(!color && nightshift_light_color)
			new_color = nightshift_light_color
		else if(color) // In case it's spraypainted.
			new_color = color
		else // Adjust light values to be warmer. I doubt caching would speed this up, as it's all bit operations.
			var/temp_color = hex2num(bulb_colour)
			world.log << temp_color
			// Convert to numbers for easier manipulation.
			var/red = temp_color >> 16 & COLOR_BIT_SIZE // 16 is the red colour offset.
			var/green = temp_color >> 8 & COLOR_BIT_SIZE // 8 is the green colour offset.
			var/blue = temp_color & COLOR_BIT_SIZE // And blue is just read from the first 8 bits, so extra data is just lopped off.

			world.log << "[red] | [green] | [blue]"

			green -= round(green / (NIGHTSHIFT_MODIFIER / 2)) // Divide by two otherwise it'll go red rather than orange-white.
			blue -= round(blue / NIGHTSHIFT_MODIFIER)

			new_color = num2hex((red & 255) << 16 | (green & 255) << 8 | (blue & 255), 6) // Splice the numbers together and turn them back to hex.


	var/matching = light && new_brightness == light.light_range && new_power == light.light_power && new_color == light.light_color
	if(!matching)
		switchcount++
		if( prob( min(60, (switchcount**2)*0.01) ) )
			if(trigger)
				burn_out()
		else
			use_power = ACTIVE_POWER_USE
			set_light(new_brightness, new_power, new_color)
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

/obj/machinery/light/proc/firealarm_on()
	SIGNAL_HANDLER

	firealarm = TRUE
	update()

/obj/machinery/light/proc/firealarm_off()
	SIGNAL_HANDLER

	firealarm = FALSE
	update()

/obj/machinery/light/Initialize(mapload = TRUE)
	. = ..()
	if(on)
		maploaded = TRUE

	if(roundstart_flicker)
		start_flickering()

/obj/item/light/tube
	icon = 'modular_skyrat/modules/aesthetics/lights/icons/lighting.dmi'

/obj/machinery/light/multitool_act(mob/living/user, obj/item/multitool)
	if(!constant_flickering)
		balloon_alert(user, "ballast is already working!")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	balloon_alert(user, "repairing the ballast...")
	if(do_after(user, 2 SECONDS, src))
		stop_flickering()
		balloon_alert(user, "ballast repaired!")
		return TOOL_ACT_TOOLTYPE_SUCCESS
	return ..()
