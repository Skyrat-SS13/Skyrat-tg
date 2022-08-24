/datum/buildmode_mode/tweakcomps
	key = "tweakcomps"
	var/level = null

/datum/buildmode_mode/tweakcomps/show_help(client/target_client)
	to_chat(target_client, span_notice("***********************************************************\n\
		Right Mouse Button on buildmode button = Choose components level\n\
		Left Mouse Button on machinery = Sets components choosen level.\n\
		***********************************************************"))

/datum/buildmode_mode/tweakcomps/change_settings(client/target_client)
	var/level_to_choose = input(target_client, "Enter number of level:", "Number", "1") 
	level_to_choose = text2num(level_to_choose)
	if(!isnum(level_to_choose))
		tgui_alert(target_client, "Input a number.")
		return
	else
		level = level_to_choose

/datum/buildmode_mode/tweakcomps/handle_click(client/target_client, params, obj/machinery/object)
	if(!ismachinery(object))
		to_chat(target_client, span_warning("This object is not machinery!"))
		return
	else
		if(object.component_parts)
			for(var/obj/item/stock_parts/P in object.component_parts)
				P.rating = level
			object.RefreshParts()
			
			SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Machine Upgrade", "[level]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		else
			to_chat(target_client, span_warning("That machinery don't have components"))
			return