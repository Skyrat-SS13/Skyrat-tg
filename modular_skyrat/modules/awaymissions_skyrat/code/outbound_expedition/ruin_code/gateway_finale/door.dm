/obj/machinery/door/airlock/vault/gateway
	desc = "A particularly robust airlock, seemingly incapable of being pierced by tools or destroyed in any way."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	max_integrity = INFINITY

/obj/machinery/door/airlock/vault/gateway/screwdriver_act(mob/living/user, obj/item/tool)
	return TOOL_ACT_SIGNAL_BLOCKING

/obj/machinery/door/airlock/vault/gateway/welder_act(mob/living/user, obj/item/tool)
	return TOOL_ACT_SIGNAL_BLOCKING
