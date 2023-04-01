GLOBAL_VAR_INIT(dchat_allowed, TRUE)

/datum/admins/proc/toggledchat()
	set category = "Server"
	set desc = "Toggle dis bitch"
	set name = "Toggle Dead Chat"
	toggle_dchat()
	log_admin("[key_name(usr)] toggled dead chat.")
	message_admins("[key_name_admin(usr)] toggled dead chat.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle DCHAT", "[GLOB.dchat_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/toggle_dchat(toggle = null)
	if(toggle != null) // if we're specifically en/disabling dead chat
		if(toggle != GLOB.dchat_allowed)
			GLOB.dchat_allowed = toggle
		else
			return
	else // otherwise just toggle it
		GLOB.dchat_allowed = !GLOB.dchat_allowed
	to_chat(world, span_oocplain("<B>The dead chat channel has been globally [GLOB.dchat_allowed ? "enabled" : "disabled"].</B>"))

/datum/admin_help
	/// Have we requested this ticket to stop being part of the Ticket Ping subsystem?
	var/ticket_ping_stop = FALSE
	/// Are we added to the ticket ping subsystem in the first place
	var/ticket_ping = FALSE
	/// Who is handling this admin help?
	var/handler
	/// All sanitized text
	var/full_text

/datum/admin_help/ClosureLinks(ref_src)
	. = ..()
	. += " (<A HREF='?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=handle_issue'>HANDLE</A>)" //SKYRAT EDIT ADDITION
	. += " (<A HREF='?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=pingmute'>PING MUTE</A>)" //SKYRAT EDIT ADDITION
	. += " (<A HREF='?_src_=holder;[HrefToken(forceGlobal = TRUE)];ahelp=[ref_src];ahelp_action=convert'>MHELP</A>)"

//Let the initiator know their ahelp is being handled
/datum/admin_help/proc/handle_issue(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return FALSE

	if(handler && handler == usr.ckey) // No need to handle it twice as the same person ;)
		return TRUE

	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "This ticket is already being handled by [handler]. Do you want to continue?", "Ticket already assigned", list("Yes", "No"))
		if(!response || response == "No")
			return FALSE

	var/msg = span_adminhelp("Your ticket is now being handled by [usr?.client?.holder?.fakekey ? usr?.client?.holder?.fakekey : "an administrator"]! Please wait while they type their response and/or gather relevant information.")

	if(initiator)
		to_chat(initiator, msg)

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "handling")
	msg = "Ticket [TicketHref("#[id]")] is being handled by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Being handled by [key_name]", "Being handled by [key_name_admin(usr, FALSE)]")

	handler = "[usr.ckey]"
	return TRUE

///Proc which converts an admin_help ticket to a mentorhelp
/datum/admin_help/proc/convert_to_mentorhelp(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return FALSE
	
	if(handler && handler != usr.ckey)
		var/response = tgui_alert(usr, "This ticket is already being handled by [handler]. Do you want to continue?", "Ticket already assigned", list("Yes", "No"))
		if(!response || response == "No")
			return FALSE
	
	add_verb(initiator, /client/verb/mentorhelp) // Way to override mentorhelp cooldown.

	to_chat(initiator, span_adminhelp("Your ticket was converted to Mentorhelp"))
	initiator.mentorhelp(full_text)
	initiator.giveadminhelpverb()

	message_admins("[key_name] converted Ticket #[id] from [initiator_key_name] into Mentorhelp")
	log_admin("[usr.client] converted Ticket #[id] from [initiator_ckey] into Mentorhelp")

	Close(key_name, TRUE)
