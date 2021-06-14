/datum/action/item_action/dispatch_ticket_new
	name = "Create Ticket"
	button_icon_state = "vote"

/datum/action/item_action/dispatch_ticket_new/Trigger()
	if(!ishuman(usr)) return
	SSdispatch.ui_interact(usr, null, "ticket-new")

/datum/action/item_action/dispatch_ticket_view
	name = "Dispatch Manager"
	button_icon_state = "round_end"

/datum/action/item_action/dispatch_ticket_view/Trigger()
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/user = usr
	var/obj/item/card/id/idcard = user.get_idcard()
	if(!idcard || !(\
		(ACCESS_SECURITY in idcard.access) ||\
		(ACCESS_MEDICAL in idcard.access) ||\
		(ACCESS_ENGINE in idcard.access) ))
		to_chat(user, "<span class='warning'>Invalid Access.</span>")
		return

	SSdispatch.ui_interact(user, null, "ticket-manage")

/obj/item/radio/headset/Initialize()
	. = ..()
	actions += new /datum/action/item_action/dispatch_ticket_view(src)
	actions += new /datum/action/item_action/dispatch_ticket_new(src)
