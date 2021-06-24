/datum/action/item_action/dispatch_ticket_new
	name = "Create Ticket"
	button_icon_state = "vote"

/datum/action/item_action/dispatch_ticket_new/Trigger()
	if(!ishuman(usr)) return
	SSdispatch.ui_interact(usr, null, "ticket-new")

/obj/item/radio/headset/RightClick(mob/user)
	var/list/holder_roles = SSdispatch.get_holder_roles(user)
	if(!holder_roles.len)
		to_chat(user, span_warning("You are not authorized to access the Ticket Browser."))
		return
	SSdispatch.ui_interact(user, null, "ticket-manage")

/obj/item/radio/headset/Initialize()
	. = ..()
	actions += new /datum/action/item_action/dispatch_ticket_new(src)
