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
	var/BR = brightness
	var/PO = bulb_power
	var/CO = bulb_colour
	if(color)
		CO = color
	if (firealarm)
		CO = bulb_emergency_colour
	else if (nightshift_enabled)
		BR = nightshift_brightness
		PO = nightshift_light_power
		if(!color)
			CO = nightshift_light_color
	var/matching = light && BR == light.light_range && PO == light.light_power && CO == light.light_color
	if(!matching)
		switchcount++
		if(rigged)
			if(status == LIGHT_OK && trigger)
				explode()
		else if( prob( min(60, (switchcount**2)*0.01) ) )
			if(trigger)
				burn_out()
		else
			use_power = ACTIVE_POWER_USE
			set_light(BR, PO, CO)
			if(play_sound)
				playsound(src.loc, 'modular_skyrat/modules/aesthetics/lights/sound/light_on.ogg', 65, 1)

/obj/machinery/light/proc/start_flickering()
	on = FALSE
	update(FALSE, TRUE, FALSE)

	constant_flickering = TRUE

	flicker_timer = addtimer(CALLBACK(src, .proc/flicker_on), rand(5, 10))

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
	flicker_timer = addtimer(CALLBACK(src, .proc/flicker_off), rand(5, 10))

/obj/machinery/light/proc/flicker_off()
	alter_flicker(FALSE)
	flicker_timer = addtimer(CALLBACK(src, .proc/flicker_on), rand(5, 50))

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


// attack with item - insert light (if right type), otherwise try to break the light
/obj/machinery/light/attackby(obj/item/tool, mob/living/user, params)

	//Light replacer code
	if(istype(tool, /obj/item/lightreplacer))
		var/obj/item/lightreplacer/replacer = tool
		replacer.ReplaceLight(src, user)
		return

	if(istype(tool, /obj/item/multitool))

		if(!constant_flickering)
			to_chat(user, span_warning("[src]'s ballast is already working!"))
			return

		to_chat(user, span_notice("You start repairing the ballast of [src] with [tool]."))
		if(do_after(user, 2 SECONDS, src))
			stop_flickering()
			to_chat(user, span_notice("You repair [src]'s ballast."))

		return

	// attempt to insert light
	if(istype(tool, /obj/item/light))
		if(status == LIGHT_OK)
			to_chat(user, span_warning("There is a [fitting] already inserted!"))
			return
		add_fingerprint(user)
		var/obj/item/light/light_object = tool
		if(!istype(light_object, light_type))
			to_chat(user, span_warning("This type of light requires a [fitting]!"))
			return
		if(!user.temporarilyRemoveItemFromInventory(light_object))
			return

		add_fingerprint(user)
		if(status != LIGHT_EMPTY)
			drop_light_tube(user)
			to_chat(user, span_notice("You replace [light_object]."))
		else
			to_chat(user, span_notice("You insert [light_object]."))
		status = light_object.status
		switchcount = light_object.switchcount
		rigged = light_object.rigged
		brightness = light_object.brightness
		on = has_power()
		update()

		qdel(light_object)

		if(on && rigged)
			explode()
		return

	// attempt to stick weapon into light socket
	if(status != LIGHT_EMPTY)
		return ..()
	if(tool.tool_behaviour == TOOL_SCREWDRIVER) //If it's a screwdriver open it.
		tool.play_tool_sound(src, 75)
		user.visible_message(span_notice("[user.name] opens [src]'s casing."), \
			span_notice("You open [src]'s casing."), span_hear("You hear a noise."))
		deconstruct()
		return
	to_chat(user, span_userdanger("You stick \the [tool] into the light socket!"))
	if(has_power() && (tool.flags_1 & CONDUCT_1))
		do_sparks(3, TRUE, src)
		if (prob(75))
			electrocute_mob(user, get_area(src), src, (rand(7,10) * 0.1), TRUE)
