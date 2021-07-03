/obj/machinery/microwave/attackby(obj/item/O, mob/living/user, params)
	if(operating)
		return
	if(default_deconstruction_crowbar(O))
		return

	if(dirty < 100)
		if(default_deconstruction_screwdriver(user, icon_state, icon_state, O) || default_unfasten_wrench(user, O))
			update_appearance()
			return

	if(panel_open && is_wire_tool(O))
		wires.interact(user)
		return TRUE

	if(broken > 0)
		if(broken == 2 && O.tool_behaviour == TOOL_WIRECUTTER) // If it's broken and they're using a screwdriver
			user.visible_message(span_notice("[user] starts to fix part of \the [src]."), span_notice("You start to fix part of \the [src]..."))
			if(O.use_tool(src, user, 20))
				user.visible_message(span_notice("[user] fixes part of \the [src]."), span_notice("You fix part of \the [src]."))
				broken = 1 // Fix it a bit
		else if(broken == 1 && O.tool_behaviour == TOOL_WELDER) // If it's broken and they're doing the wrench
			user.visible_message(span_notice("[user] starts to fix part of \the [src]."), span_notice("You start to fix part of \the [src]..."))
			if(O.use_tool(src, user, 20))
				user.visible_message(span_notice("[user] fixes \the [src]."), span_notice("You fix \the [src]."))
				broken = 0
				update_appearance()
				return FALSE //to use some fuel
		else
			to_chat(user, span_warning("It's broken!"))
			return TRUE
		return

	if(istype(O, /obj/item/reagent_containers/spray))
		var/obj/item/reagent_containers/spray/clean_spray = O
		if(clean_spray.reagents.has_reagent(/datum/reagent/space_cleaner, clean_spray.amount_per_transfer_from_this))
			clean_spray.reagents.remove_reagent(/datum/reagent/space_cleaner, clean_spray.amount_per_transfer_from_this,1)
			playsound(loc, 'sound/effects/spray3.ogg', 50, TRUE, -6)
			user.visible_message(span_notice("[user] cleans \the [src]."), span_notice("You clean \the [src]."))
			dirty = 0
			update_appearance()
		else
			to_chat(user, span_warning("You need more space cleaner!"))
		return TRUE

	if(istype(O, /obj/item/soap) || istype(O, /obj/item/reagent_containers/glass/rag))
		var/cleanspeed = 50
		if(istype(O, /obj/item/soap))
			var/obj/item/soap/used_soap = O
			cleanspeed = used_soap.cleanspeed
		user.visible_message(span_notice("[user] starts to clean \the [src]."), span_notice("You start to clean \the [src]..."))
		if(do_after(user, cleanspeed, target = src))
			user.visible_message(span_notice("[user] cleans \the [src]."), span_notice("You clean \the [src]."))
			dirty = 0
			update_appearance()
		return TRUE

	if(istype(O, /obj/item/wirebrush))
		var/obj/item/wirebrush/usedObj = O
		user.visible_message(span_notice("[user] starts to clean \the [src]."), span_notice("You start to clean \the [src]..."))
		if(do_after(user, 2 SECONDS * usedObj.toolspeed, target = src))
			user.visible_message(span_notice("[user] cleans \the [src]."), span_notice("You clean \the [src]."))
			dirty = 0
			update_appearance()
		return TRUE

	if(dirty == 100) // The microwave is all dirty so can't be used!
		to_chat(user, span_warning("\The [src] is dirty!"))
		return TRUE

	if(istype(O, /obj/item/storage/bag/tray))
		var/obj/item/storage/T = O
		var/loaded = 0
		for(var/obj/S in T.contents)
			if(!IS_EDIBLE(S))
				continue
			if(ingredients.len >= max_n_of_items)
				to_chat(user, span_warning("\The [src] is full, you can't put anything in!"))
				return TRUE
			if(SEND_SIGNAL(T, COMSIG_TRY_STORAGE_TAKE, S, src))
				loaded++
				ingredients += S
		if(loaded)
			to_chat(user, span_notice("You insert [loaded] items into \the [src]."))
		return

	if(O.w_class <= WEIGHT_CLASS_NORMAL && !istype(O, /obj/item/storage) && !user.combat_mode)
		if(ingredients.len >= max_n_of_items)
			to_chat(user, span_warning("\The [src] is full, you can't put anything in!"))
			return TRUE
		if(!user.transferItemToLoc(O, src))
			to_chat(user, span_warning("\The [O] is stuck to your hand!"))
			return FALSE

		ingredients += O
		user.visible_message(span_notice("[user] adds \a [O] to \the [src]."), span_notice("You add [O] to \the [src]."))
		return

	..()
