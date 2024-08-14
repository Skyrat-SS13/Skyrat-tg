/obj/item/wallframe
	icon = 'icons/obj/machines/wallmounts.dmi'
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 2)
	obj_flags = CONDUCTS_ELECTRICITY
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	/// What do we create?
	var/result_path
	/// For frames that are external to the wall they are placed on, like light fixtures and cameras.
	var/wall_external = FALSE
	/// Do we used inverse directionals?
	var/inverse_dir = TRUE
	/// Can we only hang this on walls North of us? Preferably don't enable unless you absolutely have to
	var/north_only = FALSE

/obj/item/wallframe/proc/try_build(turf/on_wall, mob/user)
	if(get_dist(on_wall,user) > 1)
		balloon_alert(user, "you are too far!")
		return
	var/floor_to_wall = get_dir(user, on_wall)
	if(!(floor_to_wall in GLOB.cardinals))
		balloon_alert(user, "stand in line with wall!")
		return

	if (north_only && floor_to_wall != NORTH)
		balloon_alert(user, "cannot place here!")
		return

	var/turf/T = get_turf(user)
	var/area/A = get_area(T)
	if(!isfloorturf(T))
		balloon_alert(user, "cannot place here!")
		return
	if(A.always_unpowered)
		balloon_alert(user, "cannot place in this area!")
		return
	if(check_wall_item(T, floor_to_wall, wall_external))
		balloon_alert(user, "already something here!")
		return

	return TRUE

/obj/item/wallframe/proc/attach(turf/on_wall, mob/user)
	if(result_path)
		playsound(src.loc, 'sound/machines/click.ogg', 75, TRUE)
		user.visible_message(span_notice("[user.name] attaches [src] to the wall."),
			span_notice("You attach [src] to the wall."),
			span_hear("You hear clicking."))
		var/facing_dir = get_dir(user, on_wall)

		if(inverse_dir) // I'm sorry about this switch, O.turn wouldn't work for whatever reason.
			facing_dir = REVERSE_DIR(facing_dir)
		var/obj/hanging_object = new result_path(get_turf(user), facing_dir, TRUE)
		hanging_object.setDir(facing_dir)

		after_attach(hanging_object)

	qdel(src)

/obj/item/wallframe/proc/after_attach(obj/attached_to)
	transfer_fingerprints_to(attached_to)

/obj/item/wallframe/screwdriver_act(mob/living/user, obj/item/tool)
	// For camera-building borgs
	var/turf/T = get_step(get_turf(user), user.dir)
	if(iswallturf(T))
		T.attackby(src, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/wallframe/wrench_act(mob/living/user, obj/item/tool)
	var/metal_amt = round(custom_materials[GET_MATERIAL_REF(/datum/material/iron)]/SHEET_MATERIAL_AMOUNT) //Replace this shit later
	var/glass_amt = round(custom_materials[GET_MATERIAL_REF(/datum/material/glass)]/SHEET_MATERIAL_AMOUNT) //Replace this shit later

	if(!metal_amt && !glass_amt)
		return FALSE
	to_chat(user, span_notice("You dismantle [src]."))
	tool.play_tool_sound(src)
	if(metal_amt)
		new /obj/item/stack/sheet/iron(get_turf(src), metal_amt)
	if(glass_amt)
		new /obj/item/stack/sheet/glass(get_turf(src), glass_amt)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/electronics
	desc = "Looks like a circuit. Probably is."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "door_electronics"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron= SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass= SMALL_MATERIAL_AMOUNT * 0.5)
	grind_results = list(/datum/reagent/iron = 10, /datum/reagent/silicon = 10)
	custom_price = PAYCHECK_CREW * 0.5
