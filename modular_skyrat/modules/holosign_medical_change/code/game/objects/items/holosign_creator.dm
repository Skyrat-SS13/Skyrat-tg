/obj/item/holosign_creator/medical
	max_signs = 6
	var/directional_mode = FALSE
	var/direction_locked

/obj/item/holosign_creator/medical/examine(mob/user)
	. = ..()
	. += span_notice("CTRL + Click to switch between modes.")
	. += span_notice("Current Mode: [directional_mode ? "Directional" : "Omni-Directional"]")

/obj/item/holosign_creator/medical/CtrlClick(mob/user)
	. = ..()
	directional_mode = !directional_mode
	direction_locked = null
	if(directional_mode)
		var/user_choice = input(user, "Choose which direction you wish for the medical holobarriers to restrict.", "Medical Holobarrier Direction Selection") as null|anything in list("NORTH", "EAST", "SOUTH", "WEST")
		if(!user_choice)
			directional_mode = FALSE
			return
		switch(user_choice)
			if("NORTH")
				direction_locked = NORTH
			if("EAST")
				direction_locked = EAST
			if("SOUTH")
				direction_locked = SOUTH
			if("WEST")
				direction_locked = WEST
	to_chat(user, span_notice("New Mode: [directional_mode ? "Directional" : "Omni-Directional"]"))
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)

/obj/item/holosign_creator/medical/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	var/turf/target_turf = get_turf(target)
	var/obj/structure/holosign/barrier/medical/target_holosign = locate(holosign_type) in target_turf
	if(directional_mode && direction_locked && target_holosign)
		target_holosign.directional_mode = TRUE
		target_holosign.direction_locked = direction_locked
