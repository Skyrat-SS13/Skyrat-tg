/obj/machinery/factory
	name = "factory machine"
	desc = "debug machine"
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/machines.dmi'

	density = TRUE

	var/has_input = FALSE
	var/input_turf = NORTH

	var/output_efficiency = 1
	var/destroy_chance = 1

	var/has_output = FALSE
	var/output_turf = SOUTH

	var/has_ore_choice = FALSE
	var/ore_choice = /obj/item/stack/ore/iron
	var/sheet_choice = /obj/item/stack/sheet/metal

	light_color = COLOR_WHITE
	light_power = 1
	light_range = 1

	var/obj/effect/overlay/vis/input_dir
	var/obj/effect/overlay/vis/output_dir
	var/obj/effect/overlay/vis/ore_output

/obj/machinery/factory/update_overlays()
	. = ..()


/obj/machinery/factory/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/machinery/factory/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/machinery/factory/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/factory/remote/config))
		var/obj/item/factory/remote/config/C = I
		if(has_input)
			input_turf = C.input_choice
		if(has_output)
			output_turf = C.output_choice
		if(has_ore_choice)
			ore_choice = C.ore_choice
		desc = "[initial(src.desc)] The ore focus is: [initial(ore_choice.name)]."
		return
	else if(istype(I, /obj/item/factory/remote/destroy))
		qdel(src)
		return
	else
		return ..()

/obj/machinery/factory/smelter
	name = "factory smelter"
	desc = "A machine that is used to smelt ores."
	icon_state = "furnace"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = TRUE

/obj/machinery/factory/smelter/process()
	if(!has_output || !has_input)
		return
	if(has_ore_choice)
		var/turf/T = get_step(src, input_turf)
		for(var/obj/A in T.contents)
			if(istype(A, ore_choice))
				var/obj/item/stack/ore/O = A
				if(O.refined_type)
					var/turf/TO = get_step(src, output_turf)
					var/obj/item/stack/NR = new O.refined_type(TO)
					NR.amount = O.amount * output_efficiency
					if(prob(100 / destroy_chance))
						qdel(O)

/obj/machinery/factory/processor
	name = "factory processor"
	desc = "A machine that is used to turn sheets into products."
	icon_state = "processor"

	has_input = TRUE
	has_output = TRUE
	has_ore_choice = TRUE

/obj/machinery/factory/processor/process()
	. = ..()

/obj/machinery/factory/miner
	name = "factory miner"
	desc = "A machine that is used to mine ores from the ground."
	icon_state = "miner"

	has_input = FALSE
	has_output = TRUE
	has_ore_choice = FALSE

/obj/machinery/factory/miner/process()
	var/turf/T = get_turf(src)
	if(istype(T, /turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral))
		var/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/M = T
		var/turf/TO = get_step(src, output_turf)
		var/chosen_ore_spawn = pickweight(M.possible_minerals)
		var/obj/item/stack/I = new chosen_ore_spawn(TO)
		I.amount = output_efficiency

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral
	icon = 'modular_skyrat/modules/factory_mining/icons/turf/floors.dmi'
	icon_state = "basalt"
	var/list/possible_minerals = list(
		/obj/item/stack/ore/uranium = 0,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 0,
		/obj/item/stack/ore/titanium = 0,
		/obj/item/stack/ore/silver = 0,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 40,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/iron
	icon_state = "basalt_iron"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 0,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 0,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/silver
	icon_state = "basalt_silver"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 35,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/titanium
	icon_state = "basalt_titanium"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 30,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/plasma
	icon_state = "basalt_plasma"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 35,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/gold
	icon_state = "basalt_gold"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 25,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/uranium
	icon_state = "basalt_uranium"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 20,
		/obj/item/stack/ore/diamond = 0,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 0,
		/obj/item/stack/ore/bananium = 0
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/diamond
	icon_state = "basalt_diamond"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 10,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/bananium = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/bluespace
	icon_state = "basalt_bluespace"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 10,
		/obj/item/stack/ore/bananium = 1
	)

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/mineral/bananium
	icon_state = "basalt_bananium"
	possible_minerals = list(
		/obj/item/stack/ore/uranium = 1,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/gold = 1,
		/obj/item/stack/ore/titanium = 1,
		/obj/item/stack/ore/silver = 1,
		/obj/item/stack/ore/plasma = 1,
		/obj/item/stack/ore/iron = 1,
		/obj/item/stack/ore/glass = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/bananium = 5
	)

