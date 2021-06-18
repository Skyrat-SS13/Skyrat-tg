/datum/admins/Topic(href, href_list)
	. = ..()
	//Topics relating to Faxes
	if(href_list["AdminFaxCreate"])
		if(!check_rights(R_FUN))
			return

		var/mob/sender = locate(href_list["AdminFaxCreate"])
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])
		var/faxtype = href_list["faxtype"]
		var/reply_to = locate(href_list["replyto"])
		var/destination
		var/notify

		var/obj/item/paper/paper = new /obj/item/paper(null) //hopefully the null loc won't cause trouble for us

		if(!fax)
			var/list/departmentoptions = GLOB.alldepartments + "All Departments"
			destination = input(usr, "To which department?", "Choose a department", "") as null|anything in departmentoptions
			if(!destination)
				qdel(paper)
				return

			for(var/thing in GLOB.allfaxes)
				var/obj/machinery/photocopier/faxmachine/targetmachine = thing
				if(destination != "All Departments" && targetmachine.department == destination)
					fax = targetmachine


		var/input_text = input(src.owner, "Please enter a message to send a fax via secure connection. Use <br> for line breaks. Both pencode and HTML work.", "Outgoing message from CentCom", "") as message|null
		if(!input_text)
			qdel(paper)
			return

		var/obj/item/pen/admin_writer = new /obj/item/pen(null)

		//input_text = paper.parsepencode(input_text, admin_writer, usr) // Encode everything from pencode to html
		qdel(admin_writer)

		var/customname = input(src.owner, "Pick a title for the fax.", "Fax Title") as text|null
		if(!customname)
			customname = "paper"

		var/sendername
		switch(faxtype)
			if("Central Command")
				sendername = "Central Command"
			if("Syndicate")
				sendername = "UNKNOWN"
			if("Custom")
				sendername = input(owner, "What organization does the fax come from? This determines the prefix of the paper (i.e. Central Command- Title). This is optional.", "Organization") as text|null

		if(sender)
			notify = alert(owner, "Would you like to inform the original sender that a fax has arrived?","Notify Sender","Yes","No")

		// Create the reply message
		if(sendername)
			paper.name = "[sendername]- [customname]"
		else
			paper.name = "[customname]"
		paper.info = input_text
		paper.update_icon()
		paper.x = rand(-2, 0)
		paper.y = rand(-1, 2)

		if(destination != "All Departments")
			if(fax.receivefax(paper) == FALSE)
				to_chat(owner, span_warning("Message transmission failed.")
				return
		else
			for(var/thing in GLOB.allfaxes)
				var/obj/machinery/photocopier/faxmachine/targetmachine = thing
				if(targetmachine.z in SSmapping.levels_by_trait(ZTRAIT_STATION))
					addtimer(CALLBACK(src, .proc/handle_sendall, targetmachine, paper), 0)

		var/datum/fax/admin/adminfax = new /datum/fax/admin()
		adminfax.name = paper.name
		adminfax.from_department = faxtype
		if(destination != "All Departments")
			adminfax.to_department = fax.department
		else
			adminfax.to_department = "All Departments"
		adminfax.origin = "Custom"
		adminfax.message = paper
		adminfax.reply_to = reply_to
		adminfax.sent_by = usr
		adminfax.sent_at = world.time

		to_chat(src.owner, span_notice("Message transmitted successfully.")
		if(notify == "Yes")
			var/mob/living/carbon/human/recipient = sender
			if(istype(recipient) && recipient.stat == CONSCIOUS && (istype(recipient.ears, /obj/item/radio/headset)))
				to_chat(sender, span_notice("Your headset pings, notifying you that a reply to your fax has arrived.")
		if(sender)
			log_admin("[key_name(src.owner)] replied to a fax message from [key_name(sender)]: [input_text]")
			message_admins("[key_name_admin(src.owner)] replied to a fax message from [key_name_admin(sender)] (<a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=[REF(paper)]'>VIEW</a>).", 1)
		else
			log_admin("[key_name(src.owner)] sent a fax message to [destination]: [input_text]")
			message_admins("[key_name_admin(src.owner)] sent a fax message to [destination] (<a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=[REF(paper)]'>VIEW</a>).", 1)
		return

	else if(href_list["refreshfaxpanel"])
		if(!check_rights(R_FUN))
			return

		//fax_panel(usr)
		return

/*
	else if(href_list["EvilFax"])
		if(!check_rights(R_FUN))
			return
		var/mob/living/carbon/human/recipient = locate(href_list["EvilFax"])
		if(!istype(recipient))
			to_chat(usr, span_notice("This can only be used on instances of type /mob/living/carbon/human.")
			return
		var/etypes = list("Borgification","Corgification","Death By Fire","Demotion Notice")
		var/eviltype = input(src.owner, "Which type of evil fax do you wish to send [recipient]?","Its good to be baaaad...", "") as null|anything in etypes
		if(!(eviltype in etypes))
			return
		var/customname = input(src.owner, "Pick a title for the evil fax.", "Fax Title") as text|null
		if(!customname)
			customname = "paper"
		var/obj/item/paper/evilfax/paper = new /obj/item/paper/evilfax(null)
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])

		paper.name = "Central Command - [customname]"
		paper.info = span_danger("You really should've known better.")
		paper.myeffect = eviltype
		paper.mytarget = recipient
		if(alert("Do you want the Evil Fax to activate automatically if [recipient] tries to ignore it?",,"Yes", "No") == "Yes")
			paper.activate_on_timeout = TRUE
		paper.x = rand(-2, 0)
		paper.y = rand(-1, 2)
		paper.update_icon()
		//we have to physically teleport the fax paper
		fax.handle_animation()
		paper.forceMove(fax.loc)
		if(istype(recipient) && recipient.stat == CONSCIOUS && (istype(recipient.ears, /obj/item/radio/headset)))
			to_chat(recipient, span_notice("Your headset pings, notifying you that a reply to your fax has arrived.")
		to_chat(src.owner, span_notice("You sent a [eviltype] fax to [recipient].")
		log_admin("[key_name(src.owner)] sent [key_name(recipient)] a [eviltype] fax")
		message_admins("[key_name_admin(src.owner)] replied to [key_name_admin(recipient)] with a [eviltype] fax")
		return
*/

	else if(href_list["FaxReplyTemplate"])
		if(!check_rights(R_FUN))
			return
		var/mob/living/carbon/human/recipient = locate(href_list["FaxReplyTemplate"])
		if(!istype(recipient))
			to_chat(usr, span_notice("This can only be used on instances of type /mob/living/carbon/human.")
			return
		var/obj/item/paper/paper = new /obj/item/paper(null)
		var/obj/machinery/photocopier/faxmachine/fax = locate(href_list["originfax"])
		paper.name = "Central Command - paper"
		var/stypes = list("Handle it yourselves!","Illegible fax","Fax not signed","Not Right Now","You are wasting our time", "Keep up the good work")
		var/stype = input(src.owner, "Which type of standard reply do you wish to send to [recipient]?","Choose your paperwork", "") as null|anything in stypes
		var/tmsg = "<font face='Verdana' color='black'><center><BR><font size='4'><B>[GLOB.station_name]</B></font><BR><BR><BR><font size='4'>Nanotrasen Communications Department Report</font></center><BR><BR>"

		if(stype == "Handle it yourselves!")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR>\
					<BR>Please proceed in accordance with Standard Operating Procedure and/or Space Law. You are fully trained to handle this situation without Central Command \
					intervention.<BR><BR><i><small>This is an automatic message.</small>"

		else if(stype == "Illegible fax")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR>\
					<BR>Your fax's grammar, syntax and/or typography are of a sub-par level and do not allow us to understand the contents of the message.<BR>\
					<BR>Please consult your nearest dictionary and/or thesaurus and try again.<BR>\
					<BR><i><small>This is an automatic message.</small>"

		else if(stype == "Fax not signed")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR>\
					<BR>Your fax has not been correctly signed and, as such, we cannot verify your identity.<BR>\
					<BR>Please sign your faxes before sending them so that we may verify your identity.<BR>\
					<BR><i><small>This is an automatic message.</small>"

		else if(stype == "Not Right Now")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR>\
					<BR>Due to pressing concerns of a matter above your current paygrade, we are unable to provide assistance in whatever matter your fax referenced.<BR>\
					<BR>This can be either due to a power outage, bureaucratic audit, pest infestation, Ascendance Event, corgi outbreak, or any other situation that \
					would affect the proper functioning of the Communications Department Fax Registration System.<BR><BR>Please try again later.<BR>\
					<BR><i><small>This is an automatic message.</small>"

		else if(stype == "You are wasting our time")
			tmsg += "Greetings, esteemed crewmember. Your fax has been <B><I>DECLINED</I></B> automatically by the Communications Department Fax Registration System.<BR>\
					<BR>In the interest of preventing further mismanagement of company resources, please avoid wasting our time with such petty drivel.<BR>\
					<BR>Do kindly remember that we expect our workforce to maintain at least a semi-decent level of profesionalism. Do not test our patience.<BR>\
					<BR><i><small>This is an automatic message.</i></small>"

		else if(stype == "Keep up the good work")
			tmsg += "Greetings, esteemed crewmember. Your fax has been received successfully by the Communications Department Fax Registration System.<BR>\
					<BR>We at Central Command appreciate the good work that you have done here, and sincerely recommend that you continue such a display of dedication to the company.<BR>\
					<BR><i><small>This is absolutely not an automated message.</i></small>"
		else
			return
		tmsg += "</font>"
		paper.info = tmsg
		paper.x = rand(-2, 0)
		paper.y = rand(-1, 2)
		paper.update_icon()
		fax.receivefax(paper)
		if(istype(recipient) && recipient.stat == CONSCIOUS && (istype(recipient.ears, /obj/item/radio/headset)))
			to_chat(recipient, span_notice("Your headset pings, notifying you that a reply to your fax has arrived.")
		to_chat(src.owner, span_notice("You sent a standard '[stype]' fax to [recipient].")
		log_admin("[key_name(src.owner)] sent [key_name(recipient)] a standard '[stype]' fax")
		message_admins("[key_name_admin(src.owner)] replied to [key_name_admin(recipient)] with a standard '[stype]' fax")
		return

	else if(href_list["AdminFaxView"])
		if(!check_rights(R_FUN))
			return

		var/obj/item/fax = locate(href_list["AdminFaxView"])
		if(istype(fax, /obj/item/paper))
			var/obj/item/paper/paper = fax
			usr.examinate(paper)
		else
			to_chat(usr, span_warning("The faxed item is not viewable. This is probably a bug, and should be reported on the tracker: [fax.type]")
		return

/datum/admins/proc/handle_sendall(var/obj/machinery/photocopier/faxmachine/targetmachine, var/obj/item/paper/paper)
	if(targetmachine.receivefax(paper) == FALSE)
		to_chat(owner, span_warning("Message transmission to [targetmachine.department] failed.")
