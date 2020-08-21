/obj/machinery/factory/loader
	name = "factory loader"
	desc = "A machine that is used to load and unload ores. Ctrl + Click to dump contents. Alt + Click to switch modes."
	icon_state = "miner"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = FALSE
	has_refined_products = FALSE
	produces_credits = FALSE

	var/ore_box_mode = TRUE

/obj/machinery/factory/loader/CtrlClick(mob/user)
	. = ..()
	if(contents)
		var/content_dumped = 0
		var/drop = drop_location()
		for(var/obj/item/item in contents)
			item.forceMove(drop)
			content_dumped++
		if(content_dumped > 0)
			to_chat(user, "<span class='notice'>You dump the contents of [src] on the ground.</span>")
		return

/obj/machinery/factory/loader/AltClick(mob/user)
	. = ..()
	ore_box_mode = !ore_box_mode
	to_chat(user, "<span class='notice'>MODE: [ore_box_mode ? "ORE BOX" : "DUMP"]</span>")

/obj/machinery/factory/loader/process()
	if(check_hostile_mobs())
		return
	if(!check_cooldown())
		return
	if(!check_coolant())
		return
	var/turf/inputing_turf = get_step(src, input_turf)
	if(inputing_turf.contents)
		for(var/obj/object in inputing_turf)
			if(istype(object, /obj/structure/ore_box))
				var/obj/structure/ore_box/ore_box = object
				if(!ore_box.contents)
					continue
				for(var/obj/item/content_item in ore_box)
					content_item.forceMove(src)
			if(istype(object, /obj/item/stack/ore))
				var/obj/item/stack/ore/ore = object
				ore.forceMove(src)
	var/turf/outputing_turf = get_step(src, output_turf)
	if(contents)
		if(ore_box_mode)
			if(outputing_turf.contents)
				for(var/obj/object in outputing_turf)
					if(istype(object, /obj/structure/ore_box))
						var/obj/structure/ore_box/ore_box = object
						for(var/obj/src_object in src.contents)
							src_object.forceMove(ore_box)
		else
			for(var/obj/src_object in src.contents)
				src_object.forceMove(outputing_turf)
