/obj/structure/stripper_pole
	name = "stripper pole"
	desc = "A pole fastened to the ceiling and floor, used to show of one's goods to company."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/dancing_pole.dmi'
	icon_state = "pole_purple_off"
	base_icon_state = "pole"
	density = TRUE
	anchored = TRUE
	max_integrity = 75
	layer = BELOW_MOB_LAYER
	pseudo_z_axis = 9 //stepping onto the pole makes you raise upwards!
	density = 0 //easy to step up on
	light_system = COMPLEX_LIGHT
	light_range = 3
	light_power = 1
	light_color = COLOR_LIGHT_PINK
	light_on = FALSE
	/// Are the animated lights enabled?
	var/lights_enabled = FALSE
	/// The mob currently using the pole to dance
	var/mob/living/dancer = null
	/// The selected pole color
	var/current_pole_color = "purple"
	/// Possible designs for the pole, populating a radial selection menu
	var/static/list/pole_designs
	/// Possible colors for the pole
	var/static/list/pole_lights = list(
								"purple" = COLOR_LIGHT_PINK,
								"cyan" = COLOR_CYAN,
								"red" = COLOR_RED,
								"green" = COLOR_GREEN,
								"white" = COLOR_WHITE,
								)
	/// Is the pole in use currently?
	var/pole_in_use

/obj/structure/stripper_pole/examine(mob/user)
	. = ..()
	. += "The lights are currently <b>[lights_enabled ? "ON" : "OFF"]</b> and could be [lights_enabled ? "dis" : "en"]abled with <b>Alt-Click</b>."


/// The list of possible designs generated for the radial reskinning menu
/obj/structure/stripper_pole/proc/populate_pole_designs()
	pole_designs = list(
		"purple" = image(icon = src.icon, icon_state = "pole_purple_on"),
		"cyan" = image(icon = src.icon, icon_state = "pole_cyan_on"),
		"red" = image(icon = src.icon, icon_state = "pole_red_on"),
		"green" = image(icon = src.icon, icon_state = "pole_green_on"),
		"white" = image(icon = src.icon, icon_state = "pole_white_on"),
	)


/obj/structure/stripper_pole/click_ctrl(mob/user)
	var/choice = show_radial_menu(user, src, pole_designs, radius = 50, require_near = TRUE)
	if(!choice)
		return FALSE
	current_pole_color = choice
	light_color = pole_lights[choice]
	update_icon()
	update_brightness()
	return TRUE


// Alt-click to turn the lights on or off.
/obj/structure/stripper_pole/click_alt(mob/user)
	lights_enabled = !lights_enabled
	balloon_alert(user, "lights [lights_enabled ? "on" : "off"]")
	playsound(user, lights_enabled ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
	update_icon_state()
	update_icon()
	update_brightness()
	return CLICK_ACTION_SUCCESS


/obj/structure/stripper_pole/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	update_brightness()
	if(!length(pole_designs))
		populate_pole_designs()


/obj/structure/stripper_pole/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_pole_color]_[lights_enabled ? "on" : "off"]"

/// Turns off/on the pole's ambient light source
/obj/structure/stripper_pole/proc/update_brightness()
	set_light_on(lights_enabled)
	update_light()


//trigger dance if character uses LBM
/obj/structure/stripper_pole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(pole_in_use)
		balloon_alert(user, "already in use!")
		return
	pole_in_use = TRUE
	dancer = user
	user.setDir(SOUTH)
	user.Stun(10 SECONDS)
	user.forceMove(loc)
	user.visible_message(pick(span_purple("[user] dances on [src]!"), span_purple("[user] flexes their hip-moving skills on [src]!")))
	dance_animate(user)
	pole_in_use = FALSE
	user.pixel_y = 0
	user.pixel_z = pseudo_z_axis //incase we are off it when we jump on!
	dancer = null

/// The proc used to make the user 'dance' on the pole. Basically just consists of pixel shifting them around a bunch and sleeping. Could probably be improved a lot.
/obj/structure/stripper_pole/proc/dance_animate(mob/living/user)
	if(user.loc != src.loc)
		return
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 0, time = 1 SECONDS)
		sleep(2 SECONDS)
		user.dir = 4
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 24, time = 1 SECONDS)
		sleep(1.2 SECONDS)
		src.layer = 4.01 //move the pole infront for now. better to move the pole, because the character moved behind people sitting above otherwise
	if(!QDELETED(src))
		animate(user, pixel_x = 6, pixel_y = 12, time = 0.5 SECONDS)
		user.dir = 8
		sleep(0.6 SECONDS)
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 4, time = 0.5 SECONDS)
		user.dir = 4
		src.layer = 4 // move it back.
		sleep(0.6 SECONDS)
	if(!QDELETED(src))
		user.dir = 1
		animate(user, pixel_x = 0, pixel_y = 0, time = 0.3 SECONDS)
		sleep(0.6 SECONDS)
	if(!QDELETED(src))
		user.do_jitter_animation()
		sleep(0.6 SECONDS)
		user.dir = 2


/obj/structure/stripper_pole/Destroy()
	. = ..()
	if(dancer)
		dancer.SetStun(0)
		dancer.pixel_y = 0
		dancer.pixel_x = 0
		dancer.pixel_z = pseudo_z_axis
		dancer.layer = layer
		dancer.forceMove(get_turf(src))
		dancer = null

/obj/structure/stripper_pole/click_ctrl_shift(mob/user)
	. = ..()
	if(. == FALSE)
		return FALSE

	add_fingerprint(user)
	balloon_alert(user, "disassembling...")
	if(!do_after(user, 8 SECONDS, src))
		balloon_alert(user, "disassembly interrupted!")
		return

	balloon_alert(user, "disassembled")
	new /obj/item/construction_kit/pole(get_turf(user))
	qdel(src)
	return TRUE

/obj/structure/stripper_pole/examine(mob/user)
	. = ..()
	. += span_purple("[src] can be disassembled by using Ctrl+Shift+Click")
