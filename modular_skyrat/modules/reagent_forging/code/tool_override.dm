/// Called on an object when a tool with wrench capabilities is used to left click an object
/atom/proc/billow_act(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to right click an object
/atom/proc/billow_act_secondary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to left click an object
/atom/proc/tong_act(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to right click an object
/atom/proc/tong_act_secondary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to left click an object
/atom/proc/hammer_act(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to right click an object
/atom/proc/hammer_act_secondary(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to left click an object
/atom/proc/blowrod_act(mob/living/user, obj/item/tool)
	return

/// Called on an object when a tool with wrench capabilities is used to right click an object
/atom/proc/blowrod_act_secondary(mob/living/user, obj/item/tool)
	return

/**
 *Tool behavior procedure. Redirects to tool-specific procs by default.
 *
 * You can override it to catch all tool interactions, for use in complex deconstruction procs.
 *
 * Must return  parent proc ..() in the end if overridden
 */
/atom/tool_act(mob/living/user, obj/item/tool, tool_type, is_right_clicking)
	var/act_result
	var/signal_result
	if(!is_right_clicking) // Left click first for sensibility
		var/list/processing_recipes = list() //List of recipes that can be mutated by sending the signal
		signal_result = SEND_SIGNAL(src, COMSIG_ATOM_TOOL_ACT(tool_type), user, tool, processing_recipes)
		if(signal_result & COMPONENT_BLOCK_TOOL_ATTACK) // The COMSIG_ATOM_TOOL_ACT signal is blocking the act
			return TOOL_ACT_SIGNAL_BLOCKING
		if(processing_recipes.len)
			process_recipes(user, tool, processing_recipes)
		if(QDELETED(tool))
			return TRUE
		switch(tool_type)
			if(TOOL_CROWBAR)
				act_result = crowbar_act(user, tool)
			if(TOOL_MULTITOOL)
				act_result = multitool_act(user, tool)
			if(TOOL_SCREWDRIVER)
				act_result = screwdriver_act(user, tool)
			if(TOOL_WRENCH)
				act_result = wrench_act(user, tool)
			if(TOOL_WIRECUTTER)
				act_result = wirecutter_act(user, tool)
			if(TOOL_WELDER)
				act_result = welder_act(user, tool)
			if(TOOL_ANALYZER)
				act_result = analyzer_act(user, tool)
			if(TOOL_BILLOW)
				act_result = billow_act(user, tool)
			if(TOOL_TONG)
				act_result = tong_act(user, tool)
			if(TOOL_HAMMER)
				act_result = hammer_act(user, tool)
			if(TOOL_BLOWROD)
				act_result = blowrod_act(user, tool)
	else
		signal_result = SEND_SIGNAL(src, COMSIG_ATOM_SECONDARY_TOOL_ACT(tool_type), user, tool)
		if(signal_result & COMPONENT_BLOCK_TOOL_ATTACK) // The COMSIG_ATOM_TOOL_ACT signal is blocking the act
			return TOOL_ACT_SIGNAL_BLOCKING
		switch(tool_type)
			if(TOOL_CROWBAR)
				act_result = crowbar_act_secondary(user, tool)
			if(TOOL_MULTITOOL)
				act_result = multitool_act_secondary(user, tool)
			if(TOOL_SCREWDRIVER)
				act_result = screwdriver_act_secondary(user, tool)
			if(TOOL_WRENCH)
				act_result = wrench_act_secondary(user, tool)
			if(TOOL_WIRECUTTER)
				act_result = wirecutter_act_secondary(user, tool)
			if(TOOL_WELDER)
				act_result = welder_act_secondary(user, tool)
			if(TOOL_ANALYZER)
				act_result = analyzer_act_secondary(user, tool)
			if(TOOL_BILLOW)
				act_result = billow_act_secondary(user, tool)
			if(TOOL_TONG)
				act_result = tong_act_secondary(user, tool)
			if(TOOL_HAMMER)
				act_result = hammer_act_secondary(user, tool)
			if(TOOL_BLOWROD)
				act_result = blowrod_act_secondary(user, tool)
	if(act_result) // A tooltype_act has completed successfully
		log_tool("[key_name(user)] used [tool] on [src][is_right_clicking ? "(right click)" : ""] at [AREACOORD(src)]")
		return TOOL_ACT_TOOLTYPE_SUCCESS
