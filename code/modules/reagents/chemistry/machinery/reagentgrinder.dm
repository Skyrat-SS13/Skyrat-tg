
/obj/machinery/reagentgrinder
	name = "\improper All-In-One Grinder"
	desc = "From BlenderTech. Will It Blend? Let's test it out!"
	icon = 'icons/obj/machines/kitchen.dmi'
	icon_state = "juicer1"
	base_icon_state = "juicer"
	layer = BELOW_OBJ_LAYER
	circuit = /obj/item/circuitboard/machine/reagentgrinder
	pass_flags = PASSTABLE
	resistance_flags = ACID_PROOF
	anchored_tabletop_offset = 8
	var/operating = FALSE
	var/obj/item/reagent_containers/beaker = null
	var/limit = 10
	var/speed = 1
	var/list/holdingitems

	var/static/radial_examine = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_examine")
	var/static/radial_eject = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_eject")
	var/static/radial_grind = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_grind")
	var/static/radial_juice = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_juice")
	var/static/radial_mix = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_mix")

/obj/machinery/reagentgrinder/Initialize(mapload)
	. = ..()
	holdingitems = list()
	beaker = new /obj/item/reagent_containers/cup/beaker/large(src)
	warn_of_dust()
	RegisterSignal(src, COMSIG_STORAGE_DUMP_CONTENT, PROC_REF(on_storage_dump))

/// Add a description to the current beaker warning of blended dust, if it doesn't already have that warning.
/obj/machinery/reagentgrinder/proc/warn_of_dust()
	if(HAS_TRAIT(beaker, TRAIT_MAY_CONTAIN_BLENDED_DUST))
		return

	beaker.desc += " May contain blended dust. Don't breathe this!"
	ADD_TRAIT(beaker, TRAIT_MAY_CONTAIN_BLENDED_DUST, TRAIT_GENERIC)

/obj/machinery/reagentgrinder/constructed/Initialize(mapload)
	. = ..()
	holdingitems = list()
	QDEL_NULL(beaker)
	update_appearance()

/obj/machinery/reagentgrinder/on_deconstruction(disassmbled)
	drop_all_items()
	beaker?.forceMove(drop_location())
	beaker = null

/obj/machinery/reagentgrinder/Destroy()
	QDEL_NULL(beaker)
	return ..()

/obj/machinery/reagentgrinder/contents_explosion(severity, target)
	if(!beaker)
		return

	switch(severity)
		if(EXPLODE_DEVASTATE)
			SSexplosions.high_mov_atom += beaker
		if(EXPLODE_HEAVY)
			SSexplosions.med_mov_atom += beaker
		if(EXPLODE_LIGHT)
			SSexplosions.low_mov_atom += beaker

/obj/machinery/reagentgrinder/RefreshParts()
	. = ..()
	speed = 1
	for(var/datum/stock_part/servo/servo in component_parts)
		speed = servo.tier

/obj/machinery/reagentgrinder/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !issilicon(user) && !isobserver(user))
		. += span_warning("You're too far away to examine [src]'s contents and display!")
		return

<<<<<<< HEAD
=======
	var/total_weight = 0
	var/list/obj/item/to_process = list()
	for(var/obj/item/target in src)
		if((target in component_parts) || target == beaker)
			continue
		to_process["[target.name]"] += 1
		total_weight += target.w_class
	if(to_process.len)
		. += span_notice("Currently holding.")
		for(var/target_name as anything in to_process)
			. += span_notice("[to_process[target_name]] [target_name]")
		. += span_notice("Filled to <b>[round((total_weight / maximum_weight) * 100)]%</b> capacity.")

	if(!QDELETED(beaker))
		. += span_notice("A beaker of <b>[beaker.reagents.maximum_volume]u</b> capacity is present. Contains:")
		if(beaker.reagents.total_volume)
			for(var/datum/reagent/reg as anything in beaker.reagents.reagent_list)
				. += span_notice("[round(reg.volume, CHEMICAL_VOLUME_ROUNDING)]u of [reg.name]")
		else
			. += span_notice("Nothing.")
		. += span_notice("[EXAMINE_HINT("Right click")] with empty hand to remove beaker.")
	else
		. += span_warning("It's missing a beaker.")

	. += span_notice("You can drag a storage item to dump its contents in the grinder.")
	if(anchored)
		. += span_notice("It can be [EXAMINE_HINT("wrenched")] loose.")
	else
		. += span_warning("Needs to be [EXAMINE_HINT("wrenched")] in place to work.")
	. += span_notice("Its maintainence panel can be [EXAMINE_HINT("screwed")] [panel_open ? "closed" : "open"].")
	if(panel_open)
		. += span_notice("It can be [EXAMINE_HINT("pried")] apart.")

/obj/machinery/reagentgrinder/update_overlays()
	. = ..()

	if(!QDELETED(beaker))
		. += "[base_icon_state]-beaker"

	if(anchored && !panel_open && is_operational)
		. += "[base_icon_state]-on"

/obj/machinery/reagentgrinder/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == beaker)
		beaker = null
		update_appearance(UPDATE_OVERLAYS)

/obj/machinery/reagentgrinder/RefreshParts()
	. = ..()

	for(var/datum/stock_part/part in component_parts)
		if(istype(part, /datum/stock_part/servo))
			speed = part.tier
		else if(istype(part, /datum/stock_part/matter_bin))
			maximum_weight = WEIGHT_CLASS_GIGANTIC * part.tier
/**
 * Inserts, removes or replaces the beaker present
 * Arguments
 *
 * * mob/living/user - the player performing the action
 * * obj/item/reagent_containers/new_beaker - the new beaker to replace the old, null to do nothing
 */
/obj/machinery/reagentgrinder/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	PRIVATE_PROC(TRUE)

	if(!QDELETED(beaker))
		try_put_in_hand(beaker, user)

	if(!QDELETED(new_beaker))
		if(!user.transferItemToLoc(new_beaker, src))
			return
		beaker = new_beaker

	update_appearance(UPDATE_OVERLAYS)

/**
 * Transfer this item or items inside if its a bag into the grinder
 * Arguments
 *
 * * mob/user - the player who is inserting these items
 * * list/obj/item/to_add - list of items to add
 */
/obj/machinery/reagentgrinder/proc/load_items(mob/user, list/obj/item/to_add)
	PRIVATE_PROC(TRUE)

	//surface level checks to filter out items that can be grinded/juice
	var/list/obj/item/filtered_list = list()
	for(var/obj/item/ingredient as anything in to_add)
		//what are we trying to grind exactly?
		if((ingredient.item_flags & ABSTRACT) || (ingredient.flags_1 & HOLOGRAM_1))
			continue

		//Nothing would come from grinding or juicing
		if(!length(ingredient.grind_results) && !ingredient.reagents.total_volume)
			to_chat(user, span_warning("You cannot grind/juice [ingredient] into reagents!"))
			continue

		//Error messages should be in the objects' definitions
		if(!ingredient.blend_requirements(src))
			continue

		filtered_list += ingredient
	if(!filtered_list.len)
		return FALSE

	//find total weight of all items already in grinder
	var/total_weight
	for(var/obj/item/to_process in src)
		if((to_process in component_parts) || to_process == beaker)
			continue
		total_weight += to_process.w_class

	//Now transfer the items 1 at a time while ensuring we don't go above the maximum allowed weight
	var/items_transfered = 0
	for(var/obj/item/weapon as anything in filtered_list)
		if(weapon.w_class + total_weight > maximum_weight)
			to_chat(user, span_warning("[weapon] is too big to fit into [src]."))
			continue
		weapon.forceMove(src)
		total_weight += weapon.w_class
		items_transfered += 1
		to_chat(user, span_notice("[weapon] was loaded into [src]."))

	return items_transfered

/obj/machinery/reagentgrinder/item_interaction(mob/living/user, obj/item/tool, list/modifiers, is_right_clicking)
	if(user.combat_mode || (tool.item_flags & ABSTRACT) || (tool.flags_1 & HOLOGRAM_1) || !can_interact(user) || !user.can_perform_action(src, ALLOW_SILICON_REACH))
		return ..()

	//add the beaker
	if (is_reagent_container(tool) && tool.is_open_container())
		replace_beaker(user, tool)
		to_chat(user, span_notice("You add [tool] to [src]."))
		return ITEM_INTERACT_SUCCESS

	//add items from bag
	else if(istype(tool, /obj/item/storage/bag))
		var/list/obj/item/to_add = list()
		//list of acceptable items from the bag
		var/static/list/accepted_items = list(
			/obj/item/grown,
			/obj/item/food/grown,
			/obj/item/food/honeycomb,
		)

		//add to list of items to check for
		for(var/obj/item/ingredient in tool)
			if(!is_type_in_list(ingredient, accepted_items))
				continue
			to_add += ingredient

		//add the items
		var/items_added = load_items(user, to_add)
		if(!items_added)
			to_chat(user, span_warning("No items were added."))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("[items_added] items were added from [tool] to [src]."))
		return ITEM_INTERACT_SUCCESS

	//add item directly
	else if(length(tool.grind_results) || tool.reagents?.total_volume)
		if(tool.atom_storage) //anything that has internal storage would be too much recursion for us to handle
			to_chat(user, span_notice("Drag this item onto [src] to dump its contents."))
			return ITEM_INTERACT_BLOCKING

		//add the items
		if(!load_items(user, list(tool)))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("[tool] was added to [src]."))
		return ITEM_INTERACT_SUCCESS

	//ask player to drag stuff into grinder
	else if(tool.atom_storage)
		to_chat(user, span_warning("You must drag & dump contents of [tool] into [src]."))
		return ITEM_INTERACT_BLOCKING

	return ..()

/obj/machinery/reagentgrinder/wrench_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return NONE

	var/tool_result = ITEM_INTERACT_BLOCKING
>>>>>>> dd84ca404c3 ([NO GBP] Reagent grinders display reagents on examination (#82535))
	if(operating)
		. += span_warning("\The [src] is operating.")
		return

	if(beaker || length(holdingitems))
		. += span_notice("\The [src] contains:")
		if(beaker)
			. += span_notice("- \A [beaker].")
		for(var/i in holdingitems)
			var/obj/item/O = i
			. += span_notice("- \A [O.name].")

	if(!(machine_stat & (NOPOWER|BROKEN)))
		. += "[span_notice("The status display reads:")]\n"+\
		span_notice("- Grinding reagents at <b>[speed*100]%</b>.")
		if(beaker)
			for(var/datum/reagent/R in beaker.reagents.reagent_list)
				. += span_notice("- [R.volume] units of [R.name].")

/obj/machinery/reagentgrinder/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(operating || !user.can_perform_action(src, ALLOW_SILICON_REACH | FORBID_TELEKINESIS_REACH))
		return
	eject(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/reagentgrinder/attack_robot_secondary(mob/user, list/modifiers)
	return attack_hand_secondary(user, modifiers)

/obj/machinery/reagentgrinder/attack_ai_secondary(mob/user, list/modifiers)
	return attack_hand_secondary(user, modifiers)

/obj/machinery/reagentgrinder/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == beaker)
		beaker = null
		update_appearance()
	if(holdingitems[gone])
		holdingitems -= gone

/obj/machinery/reagentgrinder/proc/drop_all_items()
	for(var/i in holdingitems)
		var/atom/movable/AM = i
		AM.forceMove(drop_location())
	holdingitems = list()

/obj/machinery/reagentgrinder/update_icon_state()
	icon_state = "[base_icon_state][beaker ? 1 : 0]"
	return ..()

/obj/machinery/reagentgrinder/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(!user)
		return FALSE
	if(beaker)
		try_put_in_hand(beaker, user)
		beaker = null
	if(new_beaker)
		beaker = new_beaker
	update_appearance()
	return TRUE

/obj/machinery/reagentgrinder/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/reagentgrinder/screwdriver_act(mob/living/user, obj/item/tool)
	. = ITEM_INTERACT_SUCCESS
	if(!beaker && !length(holdingitems))
		return default_deconstruction_screwdriver(user, icon_state, icon_state, tool)

/obj/machinery/reagentgrinder/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(tool)

/obj/machinery/reagentgrinder/attackby(obj/item/weapon, mob/living/user, params)
	if(panel_open) //Can't insert objects when its screwed open
		return TRUE

	if(!weapon.grind_requirements(src)) //Error messages should be in the objects' definitions
		return

	if (is_reagent_container(weapon) && !(weapon.item_flags & ABSTRACT) && weapon.is_open_container())
		var/obj/item/reagent_containers/container = weapon
		. = TRUE //no afterattack
		if(!user.transferItemToLoc(container, src))
			return
		replace_beaker(user, container)
		to_chat(user, span_notice("You add [container] to [src]."))
		update_appearance()
		return TRUE //no afterattack

	if(holdingitems.len >= limit)
		to_chat(user, span_warning("[src] is filled to capacity!"))
		return TRUE

	//Fill machine with a bag!
	if(istype(weapon, /obj/item/storage/bag))
		if(!weapon.contents.len)
			to_chat(user, span_notice("[weapon] is empty!"))
			return TRUE

		var/list/inserted = list()
		if(weapon.atom_storage.remove_type(/obj/item/food/grown, src, limit - length(holdingitems), TRUE, FALSE, user, inserted))
			for(var/i in inserted)
				holdingitems[i] = TRUE
			inserted = list()
		if(weapon.atom_storage.remove_type(/obj/item/food/honeycomb, src, limit - length(holdingitems), TRUE, FALSE, user, inserted))
			for(var/i in inserted)
				holdingitems[i] = TRUE

		if(!weapon.contents.len)
			to_chat(user, span_notice("You empty [weapon] into [src]."))
		else
			to_chat(user, span_notice("You fill [src] to the brim."))
		return TRUE

	if(!weapon.grind_results && !weapon.juice_typepath)
		if(user.combat_mode)
			return ..()
		else
			to_chat(user, span_warning("You cannot grind/juice [weapon] into reagents!"))
			return TRUE

	if(user.transferItemToLoc(weapon, src))
		to_chat(user, span_notice("You add [weapon] to [src]."))
		holdingitems[weapon] = TRUE
		return FALSE

/obj/machinery/reagentgrinder/proc/on_storage_dump(datum/source, datum/storage/storage, mob/user)
	SIGNAL_HANDLER

	for(var/obj/item/to_dump in storage.real_location)
		if(holdingitems.len >= limit)
			break

		if(!to_dump.grind_results && !to_dump.juice_typepath)
			continue

		if(!storage.attempt_remove(to_dump, src, silent = TRUE))
			continue

		holdingitems[to_dump] = TRUE

	to_chat(user, span_notice("You dump [storage.parent] into [src]."))
	return STORAGE_DUMP_HANDLED

/obj/machinery/reagentgrinder/ui_interact(mob/user) // The microwave Menu //I am reasonably certain that this is not a microwave
	. = ..()

	if(operating || !user.can_perform_action(src, ALLOW_SILICON_REACH))
		return

	var/list/options = list()

	if(beaker || length(holdingitems))
		options["eject"] = radial_eject

	if(HAS_AI_ACCESS(user))
		if(machine_stat & NOPOWER)
			return
		options["examine"] = radial_examine

	// if there is no power or it's broken, the procs will fail but the buttons will still show
	if(length(holdingitems))
		options["grind"] = radial_grind
		options["juice"] = radial_juice
	else if(beaker?.reagents.total_volume)
		options["mix"] = radial_mix

	var/choice

	if(length(options) < 1)
		return
	if(length(options) == 1)
		for(var/key in options)
			choice = key
	else
		choice = show_radial_menu(user, src, options, require_near = !HAS_SILICON_ACCESS(user))

	// post choice verification
	if(operating || (HAS_AI_ACCESS(user) && machine_stat & NOPOWER) || !user.can_perform_action(src, ALLOW_SILICON_REACH))
		return

	switch(choice)
		if("eject")
			eject(user)
		if("grind")
			grind(user)
		if("juice")
			juice(user)
		if("mix")
			mix(user)
		if("examine")
			examine(user)

/obj/machinery/reagentgrinder/proc/eject(mob/user)
	drop_all_items()
	if(beaker)
		replace_beaker(user)

/obj/machinery/reagentgrinder/proc/remove_object(obj/item/weapon)
	holdingitems -= weapon
	qdel(weapon)

/obj/machinery/reagentgrinder/proc/start_shaking()
	var/static/list/transforms
	if(!transforms)
		var/matrix/M1 = matrix()
		var/matrix/M2 = matrix()
		var/matrix/M3 = matrix()
		var/matrix/M4 = matrix()
		M1.Translate(-1, 0)
		M2.Translate(0, 1)
		M3.Translate(1, 0)
		M4.Translate(0, -1)
		transforms = list(M1, M2, M3, M4)
	animate(src, transform=transforms[1], time=0.4, loop=-1)
	animate(transform=transforms[2], time=0.2)
	animate(transform=transforms[3], time=0.4)
	animate(transform=transforms[4], time=0.6)

/obj/machinery/reagentgrinder/proc/shake_for(duration)
	start_shaking() //start shaking
	addtimer(CALLBACK(src, PROC_REF(stop_shaking)), duration)

/obj/machinery/reagentgrinder/proc/stop_shaking()
	update_appearance()
	animate(src, transform = matrix())

/obj/machinery/reagentgrinder/proc/operate_for(time, silent = FALSE, juicing = FALSE)
	shake_for(time / speed)
	operating = TRUE
	if(!silent)
		if(!juicing)
			playsound(src, 'sound/machines/blender.ogg', 50, TRUE)
		else
			playsound(src, 'sound/machines/juicer.ogg', 20, TRUE)
	use_power(active_power_usage * time * 0.1) // .1 needed here to convert time (in deciseconds) to seconds such that watts * seconds = joules
	addtimer(CALLBACK(src, PROC_REF(stop_operating)), time / speed)

/obj/machinery/reagentgrinder/proc/stop_operating()
	operating = FALSE

/obj/machinery/reagentgrinder/proc/juice(mob/user)
	power_change()
	if(!beaker || machine_stat & (NOPOWER|BROKEN) || beaker.reagents.holder_full())
		return
	operate_for(50, juicing = TRUE)
	for(var/obj/item/ingredient in holdingitems)
		if(beaker.reagents.holder_full())
			break

		if(ingredient.flags_1 & HOLOGRAM_1)
			to_chat(user, span_notice("You try to juice [ingredient], but it fades away!"))
			qdel(ingredient)
			continue

		if(ingredient.juice_typepath)
			juice_item(ingredient, user)

/obj/machinery/reagentgrinder/proc/juice_item(obj/item/ingredient, mob/user) //Juicing results can be found in respective object definitions
	if(!ingredient.juice(beaker.reagents, user))
		to_chat(user, span_danger("[src] shorts out as it tries to juice up [ingredient], and transfers it back to storage."))
		return
	remove_object(ingredient)

/obj/machinery/reagentgrinder/proc/grind(mob/user)
	power_change()
	if(!beaker || machine_stat & (NOPOWER|BROKEN) || beaker.reagents.holder_full())
		return
	operate_for(60)
	warn_of_dust() // don't breathe this.
	for(var/obj/item/ingredient in holdingitems)
		if(beaker.reagents.holder_full())
			break

		if(ingredient.flags_1 & HOLOGRAM_1)
			to_chat(user, span_notice("You try to grind [ingredient], but it fades away!"))
			qdel(ingredient)
			continue

		if(ingredient.grind_results)
			grind_item(ingredient, user)

/obj/machinery/reagentgrinder/proc/grind_item(obj/item/ingredient, mob/user) //Grind results can be found in respective object definitions
	if(!ingredient.grind(beaker.reagents, user))
		if(isstack(ingredient))
			to_chat(user, span_notice("[src] attempts to grind as many pieces of [ingredient] as possible."))
		else
			to_chat(user, span_danger("[src] shorts out as it tries to grind up [ingredient], and transfers it back to storage."))
		return
	remove_object(ingredient)

/obj/machinery/reagentgrinder/proc/mix(mob/user)
	//For butter and other things that would change upon shaking or mixing
	power_change()
	if(!beaker || machine_stat & (NOPOWER|BROKEN))
		return
	operate_for(50, juicing = TRUE)
	addtimer(CALLBACK(src, PROC_REF(mix_complete)), 50 / speed)

/obj/machinery/reagentgrinder/proc/mix_complete()
	if(beaker?.reagents.total_volume <= 0)
		return
	//Recipe to make Butter
	var/butter_amt = FLOOR(beaker.reagents.get_reagent_amount(/datum/reagent/consumable/milk) / MILK_TO_BUTTER_COEFF, 1)
	var/purity = beaker.reagents.get_reagent_purity(/datum/reagent/consumable/milk)
	beaker.reagents.remove_reagent(/datum/reagent/consumable/milk, MILK_TO_BUTTER_COEFF * butter_amt)
	for(var/i in 1 to butter_amt)
		var/obj/item/food/butter/tasty_butter = new(drop_location())
		tasty_butter.reagents.set_all_reagents_purity(purity)
	//Recipe to make Mayonnaise
	if (beaker.reagents.has_reagent(/datum/reagent/consumable/eggyolk))
		beaker.reagents.convert_reagent(/datum/reagent/consumable/eggyolk, /datum/reagent/consumable/mayonnaise)
	//Recipe to make whipped cream
	if (beaker.reagents.has_reagent(/datum/reagent/consumable/cream))
		beaker.reagents.convert_reagent(/datum/reagent/consumable/cream, /datum/reagent/consumable/whipped_cream)
