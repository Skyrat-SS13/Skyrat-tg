/obj/machinery/hydroponics/soil/soilbin //Just a big ol' tub of dirt.
	name = "soilbin"
	desc = "I've got a box of dirt! and guess what's inside it!... Yes, dirt."
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	icon_state = "soilbin"
	gender = PLURAL
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	unwrenchable = FALSE
	self_sustaining_overlay_icon_state = null
	self_sustaining = 0
	maxnutri = 30
	maxwater = 300

/datum/crafting_recipe/soilbin
	name = "Primitive soilbin"
	result = /obj/machinery/hydroponics/soil/soilbin
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/mineral/sandstone = 5)
	time = 60
	category = CAT_MISC

/obj/machinery/hydroponics/soil/soilbin/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 10 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	new /obj/item/stack/sheet/mineral/sandstone(drop_location(), 5)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/hydroponics/soil/soilbin/gaia //Just a big ol' tub of glowning dirt.
	name = "gaian soilbin"
	desc = "I've got a box of dirt! and guess what's inside it!... Yes, dirt AND Gaia."
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	icon_state = "soilbin"
	gender = PLURAL
	circuit = null
	density = FALSE //You can step over them like a dirt pile.
	use_power = NO_POWER_USE
	unwrenchable = FALSE
	self_sustaining_overlay_icon_state = "gaia"
	self_sustaining = 1
	maxnutri = 50
	maxwater = 500

/datum/crafting_recipe/soilbin/gaia
	name = "Primitive gaian soilbin"
	result = /obj/machinery/hydroponics/soil/soilbin/gaia
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/mineral/sandstone = 5,
				/obj/item/food/grown/ambrosia/gaia = 10)
	time = 60
	category = CAT_MISC

/obj/machinery/hydroponics/soil/soilbin/gaia/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 10 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	new /obj/item/stack/sheet/mineral/sandstone(drop_location(), 5)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/crafting_recipe/compostbin
	name = "Primitive compost"
	result = /obj/machinery/compostbin
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10)
	time = 60
	category = CAT_MISC

/obj/machinery/compostbin
	name = "compost bin"
	desc = "A smelly structure made of wooden slats. Dump produce in, pull usable compost out."
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	icon_state = "compostbin"
	base_icon_state = "compost"
	anchored = TRUE
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 0
	var/reagent_id = /datum/reagent/plantnutriment/eznutriment/compost
	var/user_sees_reagents = TRUE
	var/visible_contents = TRUE
	var/processing = FALSE
	var/processed_items_per_cycle = 5
	var/max_items = 20
	var/current_item_count = 0


/obj/machinery/compostbin/Initialize(mapload)
	. = ..()
	create_reagents(1000, DRAINABLE)

/obj/machinery/compostbin/examine(mob/user)
	. = ..()
	. += span_notice("The compost bin has: <b>[reagents.total_volume] units</b>.")
	. += span_notice("The compost bin can hold: <b>[reagents.maximum_volume]</b> units.")

/obj/machinery/compostbin/proc/visible_volume()
	return reagents.total_volume

/obj/machinery/compostbin/attacked_by(obj/item/weapon, mob/living/user)
	if(!machine_stat)
		if(user.combat_mode)
			return ..()

		if(istype(weapon, /obj/item/storage/bag))
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_warning("\The [src] is already full of compost."))
				return TRUE

			if(current_item_count >= max_items)
				to_chat(user, span_warning("\The [src] is already full of produce! Wait for it to decompose."))
				return TRUE

			var/obj/item/storage/bag/bag = weapon

			for(var/obj/item/food/item in bag.contents)
				if(current_item_count >= max_items)
					break

				if(bag.atom_storage.attempt_remove(item, src))
					current_item_count++

			if(bag.contents.len == 0)
				to_chat(user, span_info("You empty \the [bag] into \the [src]."))

			else if (current_item_count >= max_items)
				to_chat(user, span_info("You fill \the [src] from \the [bag] to its capacity."))

			else
				to_chat(user, span_info("You fill \the [src] from \the [bag]."))

			start_process()
			return TRUE //no afterattack

		else if(istype(weapon, /obj/item/food))
			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_warning("\The [src] is already full of compost."))
				return TRUE

			if(current_item_count >= max_items)
				to_chat(user, span_warning("\The [src] is already full of produce! Wait for it to decompose."))

			else
				if(user.transferItemToLoc(weapon, src))
					current_item_count++
					to_chat(user, span_info("You insert \the [weapon] in \the [src]"))

			start_process()
			return TRUE //no afterattack

		else
			to_chat(user, span_warning("You cannot put \the [weapon] in \the [src]!"))

/obj/machinery/compostbin/proc/start_process()
	if(machine_stat != NONE)
		return

	if(!(locate(/obj/item/food) in contents))
		return

	begin_processing()
	processing = TRUE
	update_appearance()

/obj/machinery/compostbin/process(seconds_per_tick)
	if(!processing)
		return

	if(machine_stat != NONE)
		stop_process()
		return

	if(!current_item_count)
		stop_process()
		return

	for(var/i in 1 to processed_items_per_cycle)
		var/obj/item/food/food_to_convert = locate(/obj/item/food) in contents

		if(!food_to_convert)
			break

		if(food_to_convert.flags_1 & HOLOGRAM_1)
			qdel(food_to_convert)
			current_item_count = max(current_item_count - 1, 0)
			continue

		convert_to_compost(food_to_convert)

	if(!current_item_count)
		stop_process(FALSE)

	update_appearance()

/obj/machinery/compostbin/proc/stop_process(update_appearance = TRUE)
	end_processing()
	processing = FALSE

	if(update_appearance)
		update_appearance()

/obj/machinery/compostbin/proc/convert_to_compost(obj/item/food/food_to_convert)
	var/nutriments = ROUND_UP(food_to_convert.reagents.get_reagent_amount(/datum/reagent/consumable/nutriment, type_check = REAGENT_PARENT_TYPE))
	qdel(food_to_convert)
	current_item_count = max(current_item_count - 1, 0)
	reagents.add_reagent(reagent_id, nutriments)


/obj/machinery/compostbin/update_appearance(updates=ALL)
	. = ..()

/obj/machinery/compostbin/update_overlays()
	. = ..()

	var/initial_icon_state = initial(icon_state)
	var/shown_contents_length = visible_volume()
	if(visible_contents && shown_contents_length)
		var/content_level = "[initial_icon_state]-[base_icon_state]"
		switch(shown_contents_length)
			if(1 to 349)
				content_level += "-1"
			if(350 to 749)
				content_level += "-2"
			if(750 to 1000)
				content_level += "-3"
		. += mutable_appearance(icon, content_level)

/obj/machinery/compostbin/welder_act(mob/living/user, obj/item/tool)
	return NONE

/obj/machinery/compostbin/welder_act_secondary(mob/living/user, obj/item/tool)
	return NONE

/obj/machinery/compostbin/default_deconstruction_screwdriver()
	return NONE

/obj/machinery/compostbin/exchange_parts()
	return

/obj/machinery/compostbin/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 10 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/reagent/plantnutriment/eznutriment/compost //Basic compost (E-Z nutrients)
	name = "Basic compost"
	description = "Rotting plant matter, stinky."
	color = "#422813"

/datum/reagent/plantnutriment/eznutriment/compost/enhanced //Saltpetre and diethymix (Slightly worse than both combined)
	name = "Fertile compost"
	description = "Very fertile, rotting plant matter, stinky."
	color = "#6b963b"

/datum/reagent/plantnutriment/eznutriment/compost/enhanced/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume * 0.5))
	mytray.myseed?.adjust_production(-round(volume / 5)-prob(volume % 10))
	mytray.myseed?.adjust_potency(round(volume))
	mytray.adjust_pestlevel(-rand(1,2))
	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed))
		myseed.adjust_yield(round(volume))
		myseed.adjust_instability(-round(volume))

/datum/reagent/plantnutriment/left4zednutriment/compost //Left for Zed
	name = "Reactive compost"
	description = "A rancid smelling concoction that'll really change up your plants."
	color = "#122b29"

/datum/reagent/plantnutriment/endurogrow/compost //Endurogrow: Lifespan and Endurance up, yield and potency crippled.
	name = "Hearty compost"
	description = "A useful compost, while it might leave your plants stronger, it'll jeopardise your fruits."
	color = "#4f5010"

/datum/chemical_reaction/compost
	results = list(/datum/reagent/plantnutriment/eznutriment/compost/enhanced = 2)
	required_reagents = list(/datum/reagent/plantnutriment/eznutriment/compost = 1, /datum/reagent/medicine/earthsblood = 1)
	required_temp = 200
	optimal_temp = 700
	overheat_temp = 1000
	optimal_ph_min = 1
	optimal_ph_max = 14
	reaction_tags = REACTION_TAG_EASY

/datum/chemical_reaction/compost/leftforzed
	results = list(/datum/reagent/plantnutriment/left4zednutriment/compost = 2)
	required_reagents = list(/datum/reagent/plantnutriment/eznutriment/compost = 1, /datum/reagent/drug/nicotine = 1) //Smoking doesn't cause cancer.

/datum/chemical_reaction/compost/endurogrow
	results = list(/datum/reagent/plantnutriment/endurogrow/compost = 2)
	required_reagents = list(/datum/reagent/plantnutriment/eznutriment/compost = 1, /datum/reagent/medicine/omnizine = 1)


/obj/item/secateurs/wooden
	name = "primitive secateurs"
	desc = "Some shoddy looking secateurs, they look sturdy enough to get a graft... or poke someone in both eyes at once!"
	icon = 'modular_skyrat/modules/primitive_production/icons/prim_fun.dmi'
	icon_state = "woodensecateurs"

/datum/crafting_recipe/secateur
	name = "Primitive secateurs"
	result = /obj/item/secateurs/wooden
	reqs = list(/obj/item/stack/sheet/iron = 2,
				/obj/item/stack/sheet/mineral/wood = 6)
	time = 160
	category = CAT_MISC
