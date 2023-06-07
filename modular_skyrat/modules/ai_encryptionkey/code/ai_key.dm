/mob/living/silicon/ai/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/encryptionkey) && opened)
		if(radio)
			radio.attackby(W,user)
		else
			to_chat(user, span_warning("Unable to locate a radio!"))

/mob/living/silicon/ai/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.combat_mode)
		return
	if(opened)
		if(radio)
			radio.screwdriver_act(user, tool)
		else
			to_chat(user, span_warning("Unable to locate a radio!"))
			
	return TOOL_ACT_TOOLTYPE_SUCCESS
