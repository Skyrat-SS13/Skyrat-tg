/////////
// This is simply a copy of 'priority announcements' with minor edits to better fit the ATC system.
// This is required, as we don't have a PA system like most of the Bay-based servers.
/////////
/proc/atc_announce(message, title = "Airspace Announcements", sound = 'sound/misc/compiler-stage2.ogg')
	if(!message)
		return

	for(var/mob/M in GLOB.player_list)
		if(!isnewplayer(M) && M.can_hear())
			to_chat(M, "<span class='bold'><font color = green>[html_encode(title)]</font color><BR>[html_encode(message)]</span><BR>")
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				SEND_SOUND(M, sound('sound/misc/compiler-stage2.ogg'))

/obj/machinery/announcement_system/proc/atc_announce(message, list/channels)
	if(channels.len == 0)
		radio.talk_into(src, message, null)
	else
		for(var/channel in channels)
			radio.talk_into(src, message, channel)

//Admin and Debug stuff below here
/datum/admins/proc/atc_force_random()
	set name = "ATC - DEBUG Force Random"
	set category = "Admin.Events"
	var/datum/lore/atc_controller/ATC = atc

	if(!ATC.atcOnline == TRUE)
		to_chat(usr, "ATC Relay is currently offline, random messages disabled")
		return
	ATC.next_message = world.time	//Simply sets the next messages' time-to-send to right now; this way the next-next message also has its time re-randomly chosen

/datum/admins/proc/atc_force_custom()
	set name = "ATC - Custom Message"
	set category = "Admin.Events"
	var/datum/lore/atc_controller/ATC = atc

	if(!check_rights(0))
		return

	if(!ATC.atcOnline == TRUE)
		if(tgui_alert(usr,"The ATC Relay is offline. Are you sure you want to force a message?","Are you sure",list("Yes","No")) == "No")
			return

	var/atc_senderA = input("Ship/ATC Relay that sent the message: (Default is Airspace Announcements)", "ATC Relay", null, null)  as message|null
	var/atc_msgA = input("Airtraffic message to send:", "ATC Relay", null, null)  as message|null
	if(!atc_msgA)
		return
	if(!atc_senderA)
		atc_senderA = "Airspace Announcements"
	//Check if we have a message to pair. If not, send the message we've finished, alone.
	if(tgui_alert(usr, "Does another message follow this one? An ATC Controller's response, perhaps?","Continue?",list("Yes","No")) == "No")
		log_admin("Custom ATC Announcement: [key_name(usr)] sent the message \"[atc_msgA]\" under the title of \"[atc_senderA]\"")
		ATC.msg(atc_msgA, atc_senderA)

	var/atc_senderB = input("Ship/ATC Relay that sent the response message: (Default is Airspace Announcements)", "ATC Relay", null, null)  as message|null
	var/atc_msgB = input("Airtraffic response message to send:", "ATC Relay", null, null)  as message|null
	if(!atc_msgB)
		if(tgui_alert(usr, "Message B has no value; hitting Yes will cancel the ATC messages in full. Are you sure?","Are you sure?",list("Yes","No")) == "Yes")
			return
		atc_msgB = input("Airtraffic response message to send:", "ATC Relay", null, null)  as message|null
		if(!atc_msgB)	//Clearly, you dont want to send the messages
			return
	if(!atc_senderB)
		atc_senderB = "Airspace Announcements"

	log_admin("Custom ATC Announcement: [key_name(usr)] sent the message \"[atc_msgA]\" under the title of \"[atc_senderA]\"")
	log_admin("Custom ATC Announcement: [key_name(usr)] sent the message \"[atc_msgB]\" under the title of \"[atc_senderB]\"")

	ATC.msg(atc_msgA, atc_senderA)
	sleep(5 SECONDS)
	ATC.msg(atc_msgB, atc_senderB)
