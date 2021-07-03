/obj/machinery/xenoarch
	icon = 'modular_skyrat/modules/xenoarch/icons/xenoarch_machines.dmi'
	density = TRUE
	layer = BELOW_OBJ_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 100
	pass_flags = PASSTABLE

	var/process_speed = 20 SECONDS //5 seconds is the lowest it will go
	var/efficiency = -1 //putting it at negative 1 so that tier 1 parts dont do anything to efficiency

	var/obj/item/holding_storage

	var/world_compare = 0

/obj/machinery/xenoarch/RefreshParts()
	efficiency = -1
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		efficiency += M.rating
	process_speed = initial(process_speed) - (5 SECONDS * efficiency)

/obj/machinery/xenoarch/Initialize()
	. = ..()
	holding_storage = new /obj/item(src)

/obj/machinery/xenoarch/Destroy()
	qdel(holding_storage)
	. = ..()

/obj/machinery/xenoarch/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/src_turf = get_turf(src)
	var/user_choice = input(user, "Are you sure you want to remove all the items?", "Remove Items?") as null|anything in list("Yes", "No")
	if(user_choice != "Yes")
		return
	for(var/move_out_item in holding_storage.contents)
		if(!isobj(move_out_item))
			continue
		var/obj/moveOutObj = move_out_item
		moveOutObj.forceMove(src_turf)

/obj/machinery/xenoarch/researcher
	name = "xenoarch researcher"
	desc = "A machine that is used to deconstruct strange rocks and useless relics for research points."
	icon_state = "researcher"
	circuit = /obj/item/circuitboard/machine/xenoarch_researcher
	var/list/held_items = list()

/obj/machinery/xenoarch/researcher/examine(mob/user)
	. = ..()
	if(holding_storage.contents.len)
		var/is_singular = holding_storage.contents.len == 1 ? TRUE : FALSE
		. += span_notice("There [is_singular ? "is" : "are"] [holding_storage.contents.len] [is_singular ? "item" : "items"] currently in the buffer.")

/obj/machinery/xenoarch/researcher/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/storage/bag/xenoarch))
		var/obj/item/storage/bag/xenoarch/xenoarchBag = weapon
		for(var/check_item in xenoarchBag.contents)
			if(!istype(check_item, /obj/item/xenoarch/strange_rock))
				continue
			var/obj/item/xenoarch/strange_rock/strangeRock = check_item
			if(!do_after(user, xenoarchBag.insert_speed, target = src))
				world_compare = world.time + process_speed
				addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
				return
			strangeRock.forceMove(holding_storage)
			to_chat(user, span_notice("The strange rock has been inserted into [src]."))
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(weapon, /obj/item/xenoarch/strange_rock))
		var/obj/item/xenoarch/strange_rock/strangeRock = weapon
		strangeRock.forceMove(holding_storage)
		to_chat(user, span_notice("The strange rock has been inserted into [src]."))
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(weapon, /obj/item/xenoarch/useless_relic))
		var/obj/item/xenoarch/useless_relic/uselessRelic = weapon
		uselessRelic.forceMove(holding_storage)
		to_chat(user, span_notice("The useless relic has been inserted into [src]."))
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(weapon, /obj/item/xenoarch/broken_item))
		var/obj/item/xenoarch/broken_item/brokenItem = weapon
		brokenItem.forceMove(holding_storage)
		to_chat(user, span_notice("The broken item has been inserted into [src]."))
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	return ..()

/obj/machinery/xenoarch/researcher/proc/do_machine_process()
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
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 500))
	if(istype(remove_item, /obj/item/xenoarch/useless_relic))
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 750))
	if(istype(remove_item, /obj/item/xenoarch/broken_item))
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
	qdel(remove_item)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	world_compare = world.time + process_speed
	addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)

/obj/machinery/xenoarch/digger
	name = "xenoarch digger"
	desc = "A machine that is used to slowly uncover items within strange rocks."
	icon_state = "digger"
	circuit = /obj/item/circuitboard/machine/xenoarch_digger
	var/list/held_items = list()

/obj/machinery/xenoarch/digger/examine(mob/user)
	. = ..()
	if(holding_storage.contents.len)
		var/is_singular = holding_storage.contents.len == 1 ? TRUE : FALSE
		. += span_notice("There [is_singular ? "is" : "are"] [holding_storage.contents.len] [is_singular ? "item" : "items"] currently in the buffer.")

/obj/machinery/xenoarch/digger/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/storage/bag/xenoarch))
		var/obj/item/storage/bag/xenoarch/xenoarchBag = weapon
		for(var/check_item in xenoarchBag.contents)
			if(!istype(check_item, /obj/item/xenoarch/strange_rock))
				continue
			var/obj/item/xenoarch/strange_rock/strangeRock = check_item
			if(!do_after(user, 1 SECONDS, target = src))
				world_compare = world.time + (process_speed * 4)
				addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))
				return
			strangeRock.forceMove(holding_storage)
			to_chat(user, span_notice("The strange rock has been inserted into [src]."))
		world_compare = world.time + (process_speed * 4)
		addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))
		return
	if(istype(weapon, /obj/item/xenoarch/strange_rock))
		var/obj/item/xenoarch/strange_rock/strangeRock = weapon
		strangeRock.forceMove(holding_storage)
		to_chat(user, span_notice("The strange rock has been inserted into [src]."))
		world_compare = world.time + (process_speed * 4)
		addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))
		return
	return ..()

/obj/machinery/xenoarch/digger/proc/do_machine_process()
	if(!holding_storage.contents.len)
		return
	if(world_compare > world.time)
		return
	var/turf/src_turf = get_turf(src)
	var/obj/item/contentObj = holding_storage.contents[1]
	if(!contentObj)
		return
	if(!istype(contentObj, /obj/item/xenoarch/strange_rock))
		qdel(contentObj)
		return
	var/obj/item/xenoarch/strange_rock/strangeRock = contentObj
	new strangeRock.hidden_item(src_turf)
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	qdel(strangeRock)
	world_compare = world.time + (process_speed * 4)
	addtimer(CALLBACK(src, .proc/do_machine_process), (process_speed * 4))

/obj/machinery/xenoarch/scanner
	name = "xenoarch scanner"
	desc = "A machine that is used to scan strange rocks, making it easier to extract the item inside."
	icon_state = "scanner"
	circuit = /obj/item/circuitboard/machine/xenoarch_scanner

/obj/machinery/xenoarch/scanner/attackby(obj/item/weapon, mob/user, params)
	var/scan_speed = 4 SECONDS - (1 SECONDS * efficiency)
	if(istype(weapon, /obj/item/xenoarch/strange_rock))
		var/obj/item/xenoarch/strange_rock/strangeRock = weapon
		if(!do_after(user, scan_speed, target = src))
			to_chat(user, span_warning("You interrupt the scanning process, aborting process."))
			return
		if(strangeRock.get_scanned())
			to_chat(user, span_notice("You successfully scan the strange rock. It will now report its depth in real time!"))
			return
		to_chat(user, span_warning("The strange rock was unable to be scanned, perhaps it has already been scanned?"))
		return
	return ..()

/obj/machinery/xenoarch/recoverer
	name = "xenoarch recoverer"
	desc = "A machine that will recover the damaged, destroyed objects found within the strange rocks."
	icon_state = "recoverer"
	circuit = /obj/item/circuitboard/machine/xenoarch_recoverer

/obj/machinery/xenoarch/recoverer/examine(mob/user)
	. = ..()
	if(holding_storage.contents.len)
		var/is_singular = holding_storage.contents.len == 1 ? TRUE : FALSE
		. += span_notice("There [is_singular ? "is" : "are"] [holding_storage.contents.len] [is_singular ? "item" : "items"] currently in the buffer.")

/obj/machinery/xenoarch/recoverer/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/xenoarch/broken_item))
		var/obj/item/xenoarch/broken_item/brokenObject = weapon
		brokenObject.forceMove(holding_storage)
		to_chat(user, span_notice("The broken object has been inserted into [src]."))
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	return ..()

/obj/machinery/xenoarch/recoverer/proc/do_machine_process()
	if(!holding_storage.contents.len)
		return
	if(world_compare > world.time)
		return
	var/turf/src_turf = get_turf(src)
	var/obj/item/contentObj = holding_storage.contents[1]
	if(!contentObj)
		return
	if(!istype(contentObj, /obj/item/xenoarch/broken_item))
		qdel(contentObj)
		return
	if(istype(contentObj, /obj/item/xenoarch/broken_item/tech))
		var/spawn_item = pickweight(GLOB.tech_reward)
		new spawn_item(src_turf)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		qdel(contentObj)
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(contentObj, /obj/item/xenoarch/broken_item/weapon))
		var/spawn_item = pickweight(GLOB.weapon_reward)
		new spawn_item(src_turf)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		qdel(contentObj)
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(contentObj, /obj/item/xenoarch/broken_item/illegal))
		var/spawn_item = pickweight(GLOB.illegal_reward)
		new spawn_item(src_turf)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		qdel(contentObj)
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(contentObj, /obj/item/xenoarch/broken_item/alien))
		var/spawn_item = pickweight(GLOB.alien_reward)
		new spawn_item(src_turf)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		qdel(contentObj)
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
	if(istype(contentObj, /obj/item/xenoarch/broken_item/plant))
		new /obj/item/seeds/random(src_turf)
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		qdel(contentObj)
		world_compare = world.time + process_speed
		addtimer(CALLBACK(src, .proc/do_machine_process), process_speed)
		return
