/obj/machinery/rnd/production/colony_lathe
	name = "protolathe"
	desc = "Converts raw materials into useful objects."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "colony_lathe"
	circuit = null
	production_animation = "colony_lathe_n"
	flags_1 = NODECONSTRUCT_1
	light_color = LIGHT_COLOR_BRIGHT_YELLOW
	light_power = 5
	charges_tax = FALSE
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine
	/// The sound loop played while the fabricator is making something
	var/datum/looping_sound/colony_fabricator_running/soundloop

/obj/machinery/rnd/production/colony_lathe/Initialize(mapload)
	. = ..()

	soundloop = new(src, FALSE)
	update_designs()

	if(!mapload)
		flick("colony_lathe_deploy", src) // Sick ass deployment animation

/obj/machinery/rnd/production/colony_lathe/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/rnd/production/colony_lathe/examine(mob/user)
	. = ..()
	. += span_notice("You could probably <b>repack</b> this with <b>right click</b>.")

/obj/machinery/rnd/production/colony_lathe/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	balloon_alert_to_viewers("repacking...")
	if(do_after(user, 3 SECONDS, target = src))
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		new repacked_type(get_turf(src))
		deconstruct(disassembled = TRUE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/rnd/production/colony_lathe/user_try_print_id(design_id, print_quantity)
	. = ..()
	if(.)
		soundloop.start()
		set_light(l_range = 1.5)

/obj/machinery/rnd/production/colony_lathe/do_print(path, amount)
	. = ..()
	soundloop.stop()
	set_light(l_range = 0)

/obj/machinery/rnd/production/colony_lathe/calculate_efficiency()
	efficiency_coeff = 1

/obj/machinery/rnd/production/colony_lathe/update_designs()
	var/list/designs_to_pull_from = subtypesof(/datum/design/colony_fabricator)

	for(var/datum/design/colony_fabricator/design in designs_to_pull_from)
		var/datum/design/new_design = new design
		new_design.InitializeMaterials()
		cached_designs |= new_design
	update_static_data_for_all_viewers()

// Item for carrying the lathe around and building it

/obj/item/flatpacked_machine
	name = "\improper flatpacked rapid construction fabricator"
	desc = "All of the parts, tools, and a manual that you'd need to make a rapid construction fabricator. \
		These bad boys are seen just about anywhere someone would want or need to build fast, damn the consequences. \
		That tends to be colonies, especially on dangerous worlds, where the influences of this one machine can be seen \
		in every bit of architecture."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	icon_state = "colony_lathe_packed"
	w_class = WEIGHT_CLASS_BULKY
	/// What structure is created by this item.
	var/type_to_deploy = /obj/machinery/rnd/production/colony_lathe
	/// How long it takes to create the structure in question.
	var/deploy_time = 5 SECONDS

/obj/item/flatpacked_machine/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy, delete_on_use = TRUE)
