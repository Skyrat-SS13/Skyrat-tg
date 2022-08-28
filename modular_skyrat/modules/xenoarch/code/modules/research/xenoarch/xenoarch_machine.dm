/obj/machinery/xenoarch
	icon = 'modular_skyrat/modules/xenoarch/icons/xenoarch_machines.dmi'
	density = TRUE
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 100
	pass_flags = PASSTABLE
	///The speed in which the machine will process each item
	var/process_speed = 20 SECONDS
	///The efficacy that affects the process_speed. Start at -1 so tier 1 parts are efficacy of 0
	var/efficiency = -1
	///The holding storage for the items inserted into the machines
	var/obj/item/holding_storage
	///The time comparison, to make sure the machine doesn't perform faster than it should
	var/world_compare = 0

/obj/machinery/xenoarch/RefreshParts()
	. = ..()
	efficiency = -1
	for(var/obj/item/stock_parts/micro_laser/laser_part in component_parts)
		efficiency += laser_part.rating
	process_speed = initial(process_speed) - (6 SECONDS * efficiency)

/obj/machinery/xenoarch/Initialize(mapload)
	. = ..()
	holding_storage = new /obj/item(src)

/obj/machinery/xenoarch/Destroy()
	qdel(holding_storage)
	. = ..()

/obj/machinery/xenoarch/proc/do_machine_process()
	return

/obj/machinery/xenoarch/proc/insert_xeno_item(obj/item/insert_item, mob/living/user)
	insert_item.forceMove(holding_storage)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	to_chat(user, span_notice("The [insert_item] has been inserted into [src]."))
	world_compare = world.time + process_speed
	addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)

/obj/machinery/xenoarch/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/src_turf = get_turf(src)
	var/user_choice = tgui_alert(user, "Are you sure you want to remove all the items?", "Remove Items?", list("Yes", "No"))
	if(user_choice != "Yes")
		return
	for(var/move_out_item in holding_storage.contents)
		if(!isobj(move_out_item))
			continue
		var/obj/move_out_obj = move_out_item
		move_out_obj.forceMove(src_turf)

/obj/machinery/xenoarch/examine(mob/user)
	. = ..()
	if(holding_storage?.contents.len)
		var/is_singular = holding_storage.contents.len == 1 ? TRUE : FALSE
		. += span_notice("There [is_singular ? "is" : "are"] [holding_storage.contents.len] [is_singular ? "item" : "items"] currently in the buffer.")
		. += span_warning("You can remove the contents, but the machine is currently trying to process the items!")

/obj/machinery/xenoarch/researcher
	name = "xenoarch researcher"
	desc = "A machine that is used to condense strange rocks, useless relics, and broken objects into bigger artifacts."
	icon_state = "researcher"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	///A variable that goes from 0 to 100. Depending on what is processed, increases the value. Once 100, spawns an anomalous crystal.
	var/current_research = 0

/obj/machinery/xenoarch/researcher/examine(mob/user)
	. = ..()
	. += span_notice("[current_research]/150 research points. Research more xenoarchaeological items.")

/obj/machinery/xenoarch/researcher/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/storage/bag/xenoarch))
		var/obj/item/storage/bag/xenoarch/xenoarch_bag = weapon
		for(var/check_item in xenoarch_bag.contents)
			if(!istype(check_item, /obj/item/xenoarch/strange_rock))
				continue
			var/obj/item/xenoarch/strange_rock/strange_rock = check_item
			if(!do_after(user, xenoarch_bag.insert_speed, target = src))
				world_compare = world.time + process_speed
				addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
				return
			strange_rock.forceMove(holding_storage)
			to_chat(user, span_notice("The strange rock has been inserted into [src]."))
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(weapon, /obj/item/xenoarch/strange_rock))
		insert_xeno_item(weapon, user)
		return
	if(istype(weapon, /obj/item/xenoarch/useless_relic))
		insert_xeno_item(weapon, user)
		return
	if(istype(weapon, /obj/item/xenoarch/broken_item))
		insert_xeno_item(weapon, user)
		return
	return ..()

/obj/machinery/xenoarch/researcher/do_machine_process()
	if(!holding_storage.contents.len)
		return
	if(world_compare > world.time)
		return
	var/obj/item/remove_item = holding_storage.contents[1]
	if(!remove_item)
		return
	if(!istype(remove_item, /obj/item/xenoarch/strange_rock) && !istype(remove_item, /obj/item/xenoarch/useless_relic) && !istype(remove_item, /obj/item/xenoarch/broken_item))
		qdel(remove_item)
		return
	if(istype(remove_item, /obj/item/xenoarch/strange_rock))
		current_research += 1
	if(istype(remove_item, /obj/item/xenoarch/useless_relic))
		current_research += 5
	if(istype(remove_item, /obj/item/xenoarch/broken_item))
		current_research += 10
	if(current_research >= 150)
		current_research -= 150
		var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
		var/random_crystal = pick(choices)
		new random_crystal(get_turf(src))
	qdel(remove_item)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	world_compare = world.time + process_speed
	addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)

/obj/machinery/xenoarch/scanner
	name = "xenoarch scanner"
	desc = "A machine that is used to scan strange rocks, making it easier to extract the item inside."
	icon_state = "scanner"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner

/obj/machinery/xenoarch/scanner/attackby(obj/item/weapon, mob/user, params)
	var/scan_speed = 4 SECONDS - (1 SECONDS * efficiency)
	if(istype(weapon, /obj/item/xenoarch/strange_rock))
		var/obj/item/xenoarch/strange_rock/strange_rock = weapon
		if(!do_after(user, scan_speed, target = src))
			to_chat(user, span_warning("You interrupt the scanning process, aborting process."))
			return
		if(strange_rock.get_scanned())
			to_chat(user, span_notice("You successfully scan the strange rock. It will now report its depth in real time!"))
			return
		to_chat(user, span_warning("The strange rock was unable to be scanned, perhaps it has already been scanned?"))
		return
	return ..()

/obj/machinery/xenoarch/recoverer
	name = "xenoarch recoverer"
	desc = "A machine that will recover the damaged, destroyed objects found within the strange rocks."
	icon_state = "recoverer"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer

/obj/machinery/xenoarch/recoverer/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/xenoarch/broken_item))
		insert_xeno_item(weapon, user)
		return
	return ..()

/obj/machinery/xenoarch/recoverer/proc/recover_item(obj/insert_obj, obj/delete_obj)
	var/src_turf = get_turf(src)
	new insert_obj(src_turf)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	qdel(delete_obj)
	world_compare = world.time + process_speed
	addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)

/obj/machinery/xenoarch/recoverer/do_machine_process()
	if(!holding_storage.contents.len)
		return
	if(world_compare > world.time)
		return
	var/obj/item/content_obj = holding_storage.contents[1]
	if(!content_obj)
		return
	if(!istype(content_obj, /obj/item/xenoarch/broken_item))
		qdel(content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/tech))
		var/spawn_item = pick_weight(GLOB.tech_reward)
		recover_item(spawn_item, content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/weapon))
		var/spawn_item = pick_weight(GLOB.weapon_reward)
		recover_item(spawn_item, content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/illegal))
		var/spawn_item = pick_weight(GLOB.illegal_reward)
		recover_item(spawn_item, content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/alien))
		var/spawn_item = pick_weight(GLOB.alien_reward)
		recover_item(spawn_item, content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/plant))
		var/spawn_item = pick_weight(GLOB.plant_reward)
		recover_item(spawn_item, content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/clothing))
		var/spawn_item = pick_weight(GLOB.clothing_reward)
		recover_item(spawn_item, content_obj)
		return
	if(istype(content_obj, /obj/item/xenoarch/broken_item/animal))
		var/spawn_item
		var/turf/src_turf = get_turf(src)
		for(var/looptime in 1 to rand(1,4))
			spawn_item = pick_weight(GLOB.animal_reward)
			new spawn_item(src_turf)
		recover_item(spawn_item, content_obj)
		return

/obj/machinery/xenoarch/digger
	name = "xenoarch digger"
	desc = "A machine that is used to slowly uncover items within strange rocks."
	icon_state = "digger"
	circuit = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger

/obj/machinery/xenoarch/digger/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/storage/bag/xenoarch))
		var/obj/item/storage/bag/xenoarch/xenoarch_bag = weapon
		for(var/check_item in xenoarch_bag.contents)
			if(!istype(check_item, /obj/item/xenoarch/strange_rock))
				continue
			var/obj/item/xenoarch/strange_rock/strange_rock = check_item
			if(!do_after(user, 1 SECONDS, target = src))
				world_compare = world.time + (process_speed * 4)
				addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))
				return
			strange_rock.forceMove(holding_storage)
			to_chat(user, span_notice("The strange rock has been inserted into [src]."))
		world_compare = world.time + (process_speed * 4)
		addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))
		return
	else if(istype(weapon, /obj/item/xenoarch/strange_rock))
		insert_xeno_item(weapon, user)
		return
	return ..()

/obj/machinery/xenoarch/digger/do_machine_process()
	if(!holding_storage.contents.len)
		return
	if(world_compare > world.time)
		return
	var/turf/src_turf = get_turf(src)
	var/obj/item/content_obj = holding_storage.contents[1]
	if(!content_obj)
		return
	if(!istype(content_obj, /obj/item/xenoarch/strange_rock))
		qdel(content_obj)
		return
	var/obj/item/xenoarch/strange_rock/strange_rock = content_obj
	new strange_rock.hidden_item(src_turf)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	qdel(strange_rock)
	world_compare = world.time + (process_speed * 4)
	addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))
