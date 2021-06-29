/datum/action/item_action/dispatch_ticket_new
	name = "Report Incident/Issue"
	button_icon_state = "vote"

/datum/action/item_action/dispatch_ticket_new/Trigger()
	if(!ishuman(usr)) return
	SSdispatch.ui_interact(usr, null, "ticket-new")

/obj/item/radio/headset/pre_attack_secondary(atom/target, mob/user, params)
	var/list/holder_roles = SSdispatch.get_holder_roles(user)
	if(!holder_roles.len)
		to_chat(user, span_warning("You are not authorized to access the Dispatch Browser."))
		return
	SSdispatch.ui_interact(user, null, "ticket-manage")
	return COMPONENT_SECONDARY_CANCEL_ATTACK_CHAIN

/obj/item/radio/headset/Initialize()
	. = ..()
	actions += new /datum/action/item_action/dispatch_ticket_new(src)

/obj/item/radio/headset/examine(mob/user)
	. = ..()
	. += "<b><u>Right Click</b></u> to access the Dispatch Browser"
