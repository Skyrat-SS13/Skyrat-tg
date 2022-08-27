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
	. = ..()
	SEND_SIGNAL(outbound_controller, COMSIG_AWAY_INTERDICTOR_DECONSTRUCTED)

/obj/machinery/outbound_expedition/shuttle_interdictor/screwdriver_act(mob/living/user, obj/item/tool)
	return TOOL_ACT_SIGNAL_BLOCKING
