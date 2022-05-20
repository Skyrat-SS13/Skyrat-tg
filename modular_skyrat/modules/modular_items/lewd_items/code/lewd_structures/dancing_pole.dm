/*
//skyrat-tg got the BEST dancing pole in whole SS13. Be jealous of us!

/obj/structure/pole
	name = "stripper pole"
	desc = "A pole fastened to the ceiling and floor, used to show of one's goods to company."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/dancing_pole.dmi'
	icon_state = "pole"
	density = TRUE
	anchored = TRUE
	max_integrity = 75
	var/icon_state_inuse
	layer = 4 //make it the same layer as players.
	pseudo_z_axis = 9 //stepping onto the pole makes you raise upwards!
	density = 0 //easy to step up on
	var/pole_on = FALSE //lights model turned off
	light_system = STATIC_LIGHT
	light_range = 3
	light_power = 1
	light_color = COLOR_LIGHT_PINK
	light_on = FALSE
	var/mob/living/actual_user = null
	var/current_pole_color = "purple"
	var/static/list/pole_designs
	var/static/list/polelights = list(
								"purple" = COLOR_LIGHT_PINK,
								"cyan" = COLOR_CYAN,
								"red" = COLOR_RED,
								"green" = COLOR_GREEN,
								"white" = COLOR_WHITE)//list of colors to choose

//to change color of pole by using multitool
//create radial menu
/obj/structure/pole/proc/populate_pole_designs()
    pole_designs = list(
        "purple" = image (icon = src.icon, icon_state = "pole_purple_on"),
        "cyan" = image(icon = src.icon, icon_state = "pole_cyan_on"),
        "red" = image(icon = src.icon, icon_state = "pole_red_on"),
        "green" = image(icon = src.icon, icon_state = "pole_green_on"),
        "white" = image(icon = src.icon, icon_state = "pole_white_on"))

//using multitool on pole
/obj/structure/pole/multitool_act(mob/living/user, obj/item/used_item)
    . = ..()
    if(.)
        return
    var/choice = show_radial_menu(user, src, pole_designs, custom_check = CALLBACK(src, .proc/check_menu, user, used_item), radius = 50, require_near = TRUE)
    if(!choice)
        return FALSE
    current_pole_color = choice
    light_color = polelights[choice]
    update_icon()
    update_brightness()

/obj/structure/pole/proc/check_menu(mob/living/user, obj/item/multitool)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	if(!multitool || !user.is_holding(multitool))
		return FALSE
	return TRUE

//to enable lights by aliclick
/obj/structure/pole/AltClick(mob/user)
    pole_on = !pole_on
    to_chat(user, span_notice("You turn the lights [pole_on? "on. Woah..." : "off."]"))
    playsound(user, pole_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
    update_icon_state()
    update_icon()
    update_brightness()

/obj/structure/pole/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	update_brightness()
	if(!length(pole_designs))
		populate_pole_designs()

/obj/structure/pole/update_icon_state()
    . = ..()
    icon_state = "[initial(icon_state)]_[current_pole_color]_[pole_on? "on" : "off"]"

/obj/structure/pole/proc/update_brightness()
    set_light_on(pole_on)
    update_light()

//trigger dance if character uses LBM
/obj/structure/pole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(obj_flags & IN_USE)
		to_chat(user, "[src] is already in use!")
		return
	else
		obj_flags |= IN_USE
		actual_user = user
		user.setDir(SOUTH)
		user.Stun(100)
		user.forceMove(src.loc)
		user.visible_message(pick(span_purple("[user] dances on [src]!"), span_purple("[user] flexes their hip-moving skills on [src]!")))
		animatepole(user)
		user.layer = layer //set them to the poles layer
		obj_flags &= ~IN_USE
		user.pixel_y = 0
		user.pixel_z = pseudo_z_axis //incase we are off it when we jump on!
		actual_user = null
		icon_state = "[initial(icon_state)]_[current_pole_color]_[pole_on? "on" : "off"]"

/obj/structure/pole/proc/animatepole(mob/living/user)

	if(user.loc != src.loc)
		return
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 0, time = 10)
		sleep(20)
		user.dir = 4
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 24, time = 10)
		sleep(12)
		src.layer = 4.01 //move the pole infront for now. better to move the pole, because the character moved behind people sitting above otherwise
	if(!QDELETED(src))
		animate(user, pixel_x = 6, pixel_y = 12, time = 5)
		user.dir = 8
		sleep(6)
	if(!QDELETED(src))
		animate(user, pixel_x = -6, pixel_y = 4, time = 5)
		user.dir = 4
		src.layer = 4 // move it back.
		sleep(6)
	if(!QDELETED(src))
		user.dir = 1
		animate(user, pixel_x = 0, pixel_y = 0, time = 3)
		sleep(6)
	if(!QDELETED(src))
		user.do_jitter_animation()
		sleep(6)
		user.dir = 2

/obj/structure/pole/Destroy()
	. = ..()
	if(actual_user)
		actual_user.SetStun(0)
		actual_user.pixel_y = 0
		actual_user.pixel_z = pseudo_z_axis
		actual_user.layer = layer
		actual_user.forceMove(get_turf(src))

/obj/item/polepack
	name = "pink stripper pole flatpack"
	desc = "Construction requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/dancing_pole.dmi'
	throwforce = 0
	icon_state = "pole_base"
	var/unwrapped = 0
	w_class = WEIGHT_CLASS_HUGE

/obj/item/polepack/attackby(obj/item/used_item, mob/user, params) //erecting a pole here.
	add_fingerprint(user)
	if(istype(used_item, /obj/item/wrench))
		if (!(item_flags & IN_INVENTORY) && !(item_flags & IN_STORAGE))
			to_chat(user, span_notice("You begin fastening the frame to the floor and ceiling..."))
			if(used_item.use_tool(src, user, 8 SECONDS, volume = 50))
				to_chat(user, span_notice("You assemble the stripper pole."))
				new /obj/structure/pole(get_turf(user))
				qdel(src)
			return
	else
		return ..()

/obj/structure/pole/attackby(obj/item/used_item, mob/user, params) //un-erecting a pole. :(
	add_fingerprint(user)
	if(istype(used_item, /obj/item/wrench))
		to_chat(user, span_notice("You begin unfastening the frame from the floor and ceiling..."))
		if(used_item.use_tool(src, user, 8 SECONDS, volume = 50))
			to_chat(user, span_notice("You disassemble the stripper pole."))
			new /obj/item/polepack(get_turf(user))
			qdel(src)
		return
	else
		return ..()
*/
