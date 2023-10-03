/obj/machinery/rnd/production/colony_lathe
	name = "rapid construction fabricator"
	desc = "Converts raw materials into useful objects."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "colony_lathe"
	base_icon_state = "colony_lathe"
	production_animation = null
	circuit = null
	production_animation = "colony_lathe_n"
	flags_1 = NODECONSTRUCT_1
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	light_power = 5
	charges_tax = FALSE
	allowed_buildtypes = COLONY_FABRICATOR
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine
	/// The sound loop played while the fabricator is making something
	var/datum/looping_sound/colony_fabricator_running/soundloop

/obj/machinery/rnd/production/colony_lathe/Initialize(mapload)
	. = ..()

	// We don't get new designs but can't print stuff if something's not researched, so we use the web that has everything researched
	stored_research = locate(/datum/techweb/admin) in SSresearch.techwebs
	soundloop = new(src, FALSE)
	if(!mapload)
		flick("colony_lathe_deploy", src) // Sick ass deployment animation

/obj/machinery/rnd/production/colony_lathe/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/rnd/production/colony_lathe/user_try_print_id(design_id, print_quantity)
	. = ..()
	if(.)
		soundloop.start()
		set_light(l_range = 1.5)
		icon_state = "colony_lathe_working"
		update_appearance()

/obj/machinery/rnd/production/colony_lathe/do_print(path, amount)
	. = ..()
	soundloop.stop()
	set_light(l_range = 0)
	icon_state = base_icon_state
	update_appearance()
	flick("colony_lathe_finish_print", src)

/obj/machinery/rnd/production/colony_lathe/calculate_efficiency()
	efficiency_coeff = 1

// We take from all nodes even unresearched ones
/obj/machinery/rnd/production/colony_lathe/update_designs()
	var/previous_design_count = cached_designs.len

	cached_designs.Cut()

	for(var/design_id in SSresearch.techweb_designs)
		var/datum/design/design = SSresearch.techweb_designs[design_id]

		if((isnull(allowed_department_flags) || (design.departmental_flags & allowed_department_flags)) && (design.build_type & allowed_buildtypes))
			cached_designs |= design

	var/design_delta = cached_designs.len - previous_design_count

	if(design_delta > 0)
		say("Received [design_delta] new design[design_delta == 1 ? "" : "s"].")
		playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)

	update_static_data_for_all_viewers()

// Item for carrying the lathe around and building it

/obj/item/flatpacked_machine
	name = "\improper flatpacked rapid construction fabricator"
	desc = "All of the parts, tools, and a manual that you'd need to make a rapid construction fabricator. \
		These bad boys are seen just about anywhere someone would want or need to build fast, damn the consequences. \
		That tends to be colonies, especially on dangerous worlds, where the influences of this one machine can be seen \
		in every bit of architecture."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "colony_lathe_packed"
	w_class = WEIGHT_CLASS_BULKY
	/// What structure is created by this item.
	var/type_to_deploy = /obj/machinery/rnd/production/colony_lathe
	/// How long it takes to create the structure in question.
	var/deploy_time = 5 SECONDS

/obj/item/flatpacked_machine/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy, delete_on_use = TRUE)

/obj/item/borg/apparatus/sheet_manipulator/Initialize(mapload)
	. = ..()
	storable += /obj/item/flatpacked_machine

/obj/item/borg/apparatus/circuit/Initialize(mapload)
	. = ..()
	storable += /obj/item/flatpacked_machine
