/datum/action/item_action/dispatch_ticket_new
	name = "Report Incident/Issue"
	button_icon_state = "vote"
	var/datum/tgui/ui_cache

/datum/action/item_action/dispatch_ticket_new/Trigger()
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
	actions += new /datum/action/item_action/dispatch_ticket_new(src)

/obj/item/radio/headset/examine(mob/user)
	. = ..()
	. += "<b><u>Ctrl Shift Click</b></u> to access the Dispatch Browser"
