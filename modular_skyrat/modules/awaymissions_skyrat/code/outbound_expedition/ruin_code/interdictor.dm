/obj/machinery/outbound_expedition/shuttle_interdictor
	name = "shuttle interdictor"
	desc = "A large machine capable of disrupting piloting controls of starships. Destroying this may be a good idea."
	icon_state = "exonet_node"
	resistance_flags = null
	max_integrity = 250

/obj/machinery/outbound_expedition/shuttle_interdictor/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Encrypted Signal")

/obj/machinery/outbound_expedition/shuttle_interdictor/deconstruct(disassembled)
	OUTBOUND_CONTROLLER
	for(var/i in 1 to rand(4, 8))
		new/obj/effect/spawner/random/stock_parts/t4(get_turf(src))
	. = ..()
	SEND_SIGNAL(outbound_controller, COMSIG_AWAY_INTERDICTOR_DECONSTRUCTED)

/obj/machinery/outbound_expedition/shuttle_interdictor/screwdriver_act(mob/living/user, obj/item/tool)
	return TOOL_ACT_SIGNAL_BLOCKING

/obj/effect/spawner/random/stock_parts
	name = "stock parts spawner"
	loot = list(
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/scanning_module,
		/obj/item/stock_parts/cell,
		/obj/item/stock_parts/manipulator,
		/obj/item/stock_parts/matter_bin,
		/obj/item/stock_parts/micro_laser,
	)

/obj/effect/spawner/random/stock_parts/t4
	name = "t4 stock parts spawner"
	loot = list(
		/obj/item/stock_parts/capacitor/quadratic,
		/obj/item/stock_parts/scanning_module/triphasic,
		/obj/item/stock_parts/cell/bluespace,
		/obj/item/stock_parts/manipulator/femto,
		/obj/item/stock_parts/matter_bin/bluespace,
		/obj/item/stock_parts/micro_laser/quadultra,
	)
