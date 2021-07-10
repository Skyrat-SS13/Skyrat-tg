/datum/action/item_action/dispatch_ticket_new
	name = "Report Incident/Issue"
	button_icon_state = "vote"
	var/datum/tgui/ui_cache
	var/last_trigger
	var/time_per_trigger = 2 SECONDS

/datum/action/item_action/dispatch_ticket_new/IsAvailable()
	return world.time > last_trigger + time_per_trigger

/datum/action/item_action/dispatch_ticket_new/Trigger()
	last_trigger = world.time
	if(!ishuman(usr)) return
	if(ui_cache) SStgui.close_uis(src)
	ui_cache = ui_interact(usr, ui_cache)

/datum/action/item_action/dispatch_ticket_new/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DispatchTicket")
		ui.open()

/datum/action/item_action/dispatch_ticket_new/ui_status(mob/living/carbon/user)
	if(!istype(user)) return UI_CLOSE
	return user.ears == target ? UI_INTERACTIVE : UI_CLOSE

/datum/action/item_action/dispatch_ticket_new/ui_data(mob/living/carbon/user)
	. = list()
	SSdispatch.sanitize_user_data(user)
	.["tdata"] = SSdispatch.ui_data_by_mob[user]["tdata"]
	.["submit_allow"] = SSdispatch.verify_ticket_data(user)
	.["priorities"] = SSDISPATCH_TICKET_PRIORITIES
	.["types"] = SSDISPATCH_TICKET_TYPES
	.["self_ref"] = REF(user)
	.["emagged"] = user.ears.obj_flags & EMAGGED

/datum/action/item_action/dispatch_ticket_new/ui_act(action, list/params)
	. = ..()
	if(.) // ABORT ABORT ABORT
		return

	if(!params["failCount"])
		params["failCount"] = 0

	var/mob/user = locate(params["self_ref"])
	if(!user)
		CRASH("ui_act called without valid self_ref")

	switch(action)
		if("ticket-suspect-toggle")
			SSdispatch.ui_data_by_mob[user]["tdata"]["suspect"] = !SSdispatch.ui_data_by_mob[user]["tdata"]["suspect"]
			if(!SSdispatch.ui_data_by_mob[user]["tdata"]["suspect"])
				SSdispatch.ui_data_by_mob[user]["tdata"]["suspectName"] = ""
				SSdispatch.ui_data_by_mob[user]["tdata"]["suspectDesc"] = ""
			return TRUE

		if("ticket-suspect-name")
			SSdispatch.ui_data_by_mob[user]["tdata"]["suspectName"] = params["suspectName"]
			return TRUE

		if("ticket-suspect-desc")
			SSdispatch.ui_data_by_mob[user]["tdata"]["suspectDesc"] = params["suspectDesc"]
			return TRUE

		if("image-attach")
			if(SSdispatch.ui_data_by_mob[user]["tdata"]["imageAttached"])
				SSdispatch.ui_data_by_mob[user]["tdata"]["imageAttached"] = FALSE
				user.balloon_alert(user, "Image Discarded!")
				return TRUE

			var/obj/item/photo/photo = user.is_holding_item_of_type(/obj/item/photo)
			if(!photo)
				if(params["failCount"] > 3) // Fail count prevents a runtime from proc overloading
					return TRUE
				if(tgui_alert(user, "Image not found; please **hold** your image to the scanner.", "Image Detection", list("Try Again", "Cancel")) != "Try Again")
					return TRUE
				params["failCount"] += 1
				return ui_act(action, params)
			SSdispatch.ui_data_by_mob[user]["tdata"]["image"] = photo.picture.picture_image
			SSdispatch.ui_data_by_mob[user]["tdata"]["imageAttached"] = TRUE
			user.balloon_alert(user, "Image Attached!")
			return TRUE

		if("image-view")
			if(!SSdispatch.ui_data_by_mob[user]["tdata"]["imageAttached"])
				CRASH("image-view called while imageAttached is FALSE")
			var/icon/image = SSdispatch.ui_data_by_mob[user]["tdata"]["image"]
			user << browse_rsc(image, "tmp_photo.png")
			user << browse("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>Attached Image</title></head>" \
							+ "<body style='overflow:hidden;margin:0;text-align:center'>" \
							+ "<img src='tmp_photo.png' width='480' style='-ms-interpolation-mode:nearest-neighbor' />" \
							+ "</body></html>", "window=photo_showing;size=480x608")
			return TRUE

		if("set-ticket-type")
			SSdispatch.ui_data_by_mob[user]["tdata"]["type"] = params["type"]
			return TRUE

		if("set-ticket-priority")
			SSdispatch.ui_data_by_mob[user]["tdata"]["priority"] = params["priority"]
			return TRUE

		if("toggle-template-use")
			SSdispatch.ui_data_by_mob[user]["tdata"]["templateUse"] = !SSdispatch.ui_data_by_mob[user]["tdata"]["templateUse"]
			if(!SSdispatch.ui_data_by_mob[user]["tdata"]["templateUse"])
				SSdispatch.ui_data_by_mob[user]["tdata"]["templateName"] = "None"
				return TRUE
			var/resp = tgui_input_list(user, "Select Template", "Template", SSdispatch.templates)
			if(!resp)
				SSdispatch.ui_data_by_mob[user]["tdata"]["templateUse"] = FALSE
				return TRUE
			SSdispatch.apply_template(user, SSdispatch.templates[resp])
			return TRUE

		if("template-set")
			var/resp = tgui_input_list(user, "Select Template", "Template", SSdispatch.templates)
			if(!resp)
				return TRUE
			SSdispatch.apply_template(user, SSdispatch.templates[resp])

		if("spoof-location") // Comms Agents
			if(!ishuman(user))
				return FALSE
			var/mob/living/carbon/human/user_human = user
			if(!(user_human.ears.obj_flags & EMAGGED))
				return FALSE
			SSdispatch.ui_data_by_mob[user]["tdata"]["location"] = "[input(user, "Enter Fake Location", "Location Spoof", "")]"
			SSdispatch.ui_data_by_mob[user]["tdata"]["location-spoofed"] = TRUE
			return TRUE

		if("spoof-creator") // Comms Agents
			if(!ishuman(user))
				return FALSE
			var/mob/living/carbon/human/user_human = user
			if(!(user_human.ears.obj_flags & EMAGGED))
				return FALSE
			SSdispatch.ui_data_by_mob[user]["tdata"]["creator"] = "[input(user, "Enter Fake Creator", "Creator Spoof", "")]"
			SSdispatch.ui_data_by_mob[user]["tdata"]["creator-spoofed"] = TRUE
			return TRUE

		if("set-ticket-title")
			SSdispatch.ui_data_by_mob[user]["tdata"]["title"] = params["title"]
			return TRUE

		if("set-ticket-extra")
			SSdispatch.ui_data_by_mob[user]["tdata"]["extra"] = params["extra"]
			return TRUE

		if("ticket-submit")
			SSdispatch.ticket_create(user, SSdispatch.ui_data_by_mob[user]["tdata"])
			SSdispatch.ui_data_by_mob[user]["tdata"]["should_clear"] = TRUE
			SSdispatch.ui_data_by_mob[user]["should_close"] = TRUE
			return TRUE

		else
			CRASH("Unknown action [action]")
	stack_trace("Action [action] did not return at end of statement")
	return TRUE


/obj/item/radio/headset/var/datum/tgui/ui_cache

/obj/item/radio/headset/CtrlShiftClick(mob/living/user)
	if(!istype(user))
		return ..()
	var/list/holder_roles = SSdispatch.get_holder_roles(user)
	if(!holder_roles.len)
		to_chat(user, span_warning("You are not authorized to access the Dispatch Browser."))
		return
	ui_cache = SSdispatch.ui_interact(user, ui_cache)

/obj/item/radio/headset/Initialize()
	. = ..()
	new /datum/action/item_action/dispatch_ticket_new(src)

/obj/item/radio/headset/examine(mob/user)
	. = ..()
	. += "<b><u>Ctrl Shift Click</b></u> to access the Dispatch Browser"
