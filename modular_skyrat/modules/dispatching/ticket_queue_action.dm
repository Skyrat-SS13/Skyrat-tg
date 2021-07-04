/datum/action/item_action/dispatch_ticket_new
	name = "Report Incident/Issue"
	button_icon_state = "vote"

/datum/action/item_action/dispatch_ticket_new/Trigger()
	if(!ishuman(usr)) return
	SSdispatch.ui_interact(usr, null, "ticket-new")

/obj/item/radio/headset/CtrlShiftClick(mob/living/user)
	if(!istype(user))
		return ..()
	var/list/holder_roles = SSdispatch.get_holder_roles(user)
	if(!holder_roles.len)
		to_chat(user, span_warning("You are not authorized to access the Dispatch Browser."))
		return
	SSdispatch.ui_interact(user, null, "ticket-manage")

/obj/item/radio/headset/Initialize()
	. = ..()
	actions += new /datum/action/item_action/dispatch_ticket_new(src)

/obj/item/radio/headset/examine(mob/user)
	. = ..()
	. += "<b><u>Ctrl Shift Click</b></u> to access the Dispatch Browser"
