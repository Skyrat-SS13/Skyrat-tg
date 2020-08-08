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
	var/orename = "name"

	light_color = COLOR_WHITE
	light_power = 5
	light_range = 2

/obj/machinery/factory/update_overlays()
	. = ..()
	var/obj/effect/overlay/vis/input_dir = image("modular_skyrat/modules/factory_mining/icons/obj/machines.dmi", "input", dir = input_turf)
	var/obj/effect/overlay/vis/output_dir = image("modular_skyrat/modules/factory_mining/icons/obj/machines.dmi", "output", dir = output_turf)
	var/obj/effect/overlay/vis/ore_output = image("modular_skyrat/modules/factory_mining/icons/obj/machines.dmi", orename)
	cut_overlays()
	if(has_input)
		add_overlay(input_dir)
	if(has_output)
		add_overlay(output_dir)
	if(has_ore_choice)
		add_overlay(ore_output)

/obj/machinery/factory/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/machinery/factory/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/machinery/factory/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/factory/remote/config))
		var/obj/item/factory/remote/config/C = I
		if(C.input_choice)
			input_turf = C.input_choice
		if(C.output_choice)
			output_turf = C.output_choice
		if(C.ore_choice)
			ore_choice = C.ore_choice
			sheet_choice = C.sheet_choice
			orename = C.orename
		update_overlays()
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)
		return
	else if(istype(I, /obj/item/factory/remote/destroy))
		if(!do_after(user, 5, FALSE))
			return
		cut_overlays()
		qdel(src)
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE, -1)
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
					var/obj/item/stack/NR = new sheet_choice(TO)
					//this is part of an upgrade
					NR.amount = O.amount * output_efficiency
					//this is going to be an upgrade
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
