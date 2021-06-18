GLOBAL_LIST_EMPTY(allfaxes)
GLOBAL_LIST_INIT(admin_departments, list("Central Command"))
GLOBAL_LIST_INIT(hidden_admin_departments, list("Syndicate"))
GLOBAL_LIST_EMPTY(alldepartments)

/obj/machinery/photocopier/faxmachine
	name = "fax machine"
	icon = 'modular_skyrat/modules/faxmachines/icons/faxmachine.dmi'
	icon_state = "fax"
	density = FALSE
	pixel_y = 4
	var/fax_network = "Local Fax Network"

	var/long_range_enabled = FALSE // Can we send messages off the station?
	req_one_access = list(ACCESS_LAWYER, ACCESS_HEADS, ACCESS_ARMORY)

	use_power = TRUE
	idle_power_usage = 30
	active_power_usage = 200

	var/obj/item/card/id/scan = null // identification

	var/authenticated = FALSE
	var/sendcooldown = 0 // to avoid spamming fax messages
	var/cooldown_time = 0 // SET TO 0 FOR DEBUG - DEFAULT IS 1800

	var/department = "Unknown" // our department

	var/destination = "Not Selected" // the department we're sending to

/obj/machinery/photocopier/faxmachine/Initialize()
	. = ..()
	GLOB.allfaxes += src

	// Let's default to an area name, if the department var is not set
	if(department == "Unknown")
		var/turf/LOCATION = get_turf(src)
		if(!LOCATION)
			return
		var/area_name = LOCATION?.loc?.name
		if(area_name)
			department = area_name

	if( !(("[department]" in GLOB.alldepartments) || ("[department]" in GLOB.admin_departments)) )
		GLOB.alldepartments |= department

/obj/machinery/photocopier/faxmachine/longrange
	name = "long range fax machine"
	fax_network = "Central Command Quantum Entanglement Network"
	long_range_enabled = TRUE
	icon_state = "longfax"

/obj/machinery/photocopier/faxmachine/attack_hand(mob/user)
	ui_interact(user)

/obj/machinery/photocopier/faxmachine/attack_ghost(mob/user)
	ui_interact(user)

/obj/machinery/photocopier/faxmachine/attackby(obj/item/item, mob/user, params)
	if(istype(item,/obj/item/card/id) && !scan)
		scan(item)
	else if(istype(item, /obj/item/paper)) // Only paper can go in this one
		return ..()
	else
		return

/obj/machinery/photocopier/faxmachine/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		to_chat(user, span_warning("You swipe the card through [src], but nothing happens.")
		return
	obj_flags |= EMAGGED
	to_chat(user, span_notice("The transmitters realign to an unknown source!")

/obj/machinery/photocopier/faxmachine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FaxMachine")
		ui.open()

/obj/machinery/photocopier/faxmachine/ui_data(mob/user)
	var/list/data = list()
	var/is_authenticated = is_authenticated(user)

	if(scan)
		data["scan_name"] = scan.name
	else
		data["scan_name"] = "-----"

	data["authenticated"] = is_authenticated
	if(!is_authenticated)
		data["network"] = "Disconnected"
		data["network_class"] = "bad"
	else if(!(obj_flags & EMAGGED))
		data["network"] = fax_network
		data["network_class"] = "good"
	else
		data["network"] = "ERR*?*%!*"
		data["network_class"] = "average"

	if(paper_copy)
		data["paper"] = paper_copy.name
		data["paperinserted"] = TRUE
	else
		data["paper"] = "-----"
		data["paperinserted"] = FALSE

	data["destination"] = destination
	data["cooldown"] = sendcooldown

	if((destination in GLOB.admin_departments) || (destination in GLOB.hidden_admin_departments))
		data["respectcooldown"] = TRUE
	else
		data["respectcooldown"] = FALSE

	return data

/obj/machinery/photocopier/faxmachine/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	var/is_authenticated = is_authenticated(usr)
	switch(action)
		if("send")
			if(is_authenticated)
				if((destination in GLOB.admin_departments) || (destination in GLOB.hidden_admin_departments))
					flick("longfaxsend", src)
					send_admin_fax(usr, destination)
				else
					flick("faxsend", src)
					sendfax(destination,usr)

				if(sendcooldown)
					addtimer(CALLBACK(src, .proc/handle_cooldown, action, params), sendcooldown)
		if("remove")
			remove_photocopy(paper_copy, usr)
			paper_copy = null
		if("scan")
			scan()
		if("dept")
			if(is_authenticated)
				var/lastdestination = destination
				var/list/combineddepartments = GLOB.alldepartments.Copy()
				if(long_range_enabled)
					combineddepartments += GLOB.admin_departments.Copy()

				if(obj_flags & EMAGGED)
					combineddepartments += GLOB.hidden_admin_departments.Copy()

				destination = input(usr, "To which department?", "Choose a department", "") as null|anything in combineddepartments
				if(!destination)
					destination = lastdestination
		if("auth")
			if(!is_authenticated && scan)
				if(check_access(scan))
					authenticated = TRUE
			else if(is_authenticated)
				authenticated = FALSE
		if("rename")
			if(paper_copy)
				var/n_name = sanitize(copytext(input(usr, "What would you like to label the fax?", "Fax Labelling", paper_copy.name)  as text, 1, MAX_MESSAGE_LEN))
				if(usr.stat == 0)
					paper_copy.name = "[(n_name ? text("[n_name]") : initial(paper_copy.name))]"
					paper_copy.desc = "This is a paper titled '" + paper_copy.name + "'."

/obj/machinery/photocopier/faxmachine/proc/handle_cooldown(action, params)
	sendcooldown = 0

/obj/machinery/photocopier/faxmachine/proc/is_authenticated(mob/user)
	if(authenticated)
		return TRUE
	else if(isAdminGhostAI(user))
		return TRUE
	return FALSE

/obj/machinery/photocopier/faxmachine/proc/scan(var/obj/item/card/id/card = null)
	if(scan) // Card is in machine
		scan.forceMove(get_turf(src))
		if(!usr.get_active_held_item() && Adjacent(usr))
			usr.put_in_hands(scan)
		scan = null

	else if(Adjacent(usr))
		if(!card)
			var/obj/item/held_item = usr.get_active_held_item()
			if(istype(held_item, /obj/item/card/id))
				if(!usr.dropItemToGround(held_item))
					return
				held_item.forceMove(src)
				scan = held_item
		else if(istype(card))
			if(!usr.dropItemToGround(card))
				return
			card.forceMove(src)
			scan = card

/obj/machinery/photocopier/faxmachine/verb/eject_id()
	set category = null
	set name = "Eject ID Card"
	set src in oview(1)

	if(usr.incapacitated())
		return

	if(scan)
		to_chat(usr, "You remove [scan] from [src].")
		scan.forceMove(get_turf(src))
		if(!usr.get_active_held_item() && Adjacent(usr))
			usr.put_in_hands(scan)
		scan = null
	else
		to_chat(usr, "There is nothing to remove from [src].")

/obj/machinery/photocopier/faxmachine/proc/sendfax(var/destination,var/mob/sender)
	if(machine_stat & (BROKEN|NOPOWER))
		return

	use_power(200)

	var/success = FALSE
	for(var/target in GLOB.allfaxes)
		var/obj/machinery/photocopier/faxmachine/target_machine = target
		if(target_machine.department == destination)
			success = target_machine.receivefax(paper_copy)
	if(success != FALSE && department != destination)
		var/datum/fax/rcvdFax = new /datum/fax()
		rcvdFax.name = paper_copy.name
		rcvdFax.from_department = department
		rcvdFax.to_department = destination
		rcvdFax.origin = src
		rcvdFax.message = paper_copy
		rcvdFax.sent_by = sender
		rcvdFax.sent_at = world.time
		visible_message(span_notice("[src] beeps, \"Message transmitted successfully.\"")

	else if(destination == department)
		visible_message(span_notice("[src] beeps, \"Error transmitting message. [src] cannot send faxes to itself.\"")
	else if(destination == "Not Selected")
		visible_message(span_notice("[src] beeps, \"Error transmitting message. Select a destination.\"")
	else if(destination == "Unknown")
		visible_message(span_notice("[src] beeps, \"Error transmitting message. Cannot transmit to Unknown.\"")
	else
		visible_message(span_notice("[src] beeps, \"Error transmitting message.\"")

/obj/machinery/photocopier/faxmachine/proc/receivefax(var/obj/item/paper/incoming)
	if(machine_stat & (BROKEN|NOPOWER))
		return FALSE

	if(department == "Unknown" || department == destination)
		return FALSE	//You can't send faxes to "Unknown" or yourself

	handle_animation()
	//give the sprite some time to flick
	addtimer(CALLBACK(src, handle_copying(incoming)), 20)

//Prevents copypasta for evil faxes
/obj/machinery/photocopier/faxmachine/proc/handle_animation()
	flick("faxrecieve", src)
	playsound(loc, 'modular_skyrat/modules/faxmachines/sound/printer_dotmatrix.ogg', 50, 1)

/obj/machinery/photocopier/faxmachine/proc/handle_copying(var/obj/item/paper/incoming)
	use_power(active_power_usage)
	//if(istype(incoming, /obj/item/paper))
		//make_paper_copy(incoming)
	//else
		//return FALSE

	var/obj/item/paper/copied_paper = new(loc)
	give_pixel_offset(copied_paper)

	var/copied_info = incoming.info
	copied_info = replacetext(copied_info, "<font face=\"[PEN_FONT]\" color=", "<font face=\"[PEN_FONT]\" nocolor=")	//state of the art techniques in action
	copied_info = replacetext(copied_info, "<font face=\"[CRAYON_FONT]\" color=", "<font face=\"[CRAYON_FONT]\" nocolor=")	//This basically just breaks the existing color tag, which we need to do because the innermost tag takes priority.
	copied_paper.info += copied_info
	copied_paper.info += "</font>"
	copied_paper.name = incoming.name
	copied_paper.update_icon()
	copied_paper.stamps = incoming.stamps
	if(incoming.stamped)
		copied_paper.stamped = incoming.stamped.Copy()
	copied_paper.copy_overlays(incoming, TRUE)
	return TRUE

/obj/machinery/photocopier/faxmachine/proc/send_admin_fax(var/mob/sender, var/destination)
	if(machine_stat & (BROKEN|NOPOWER))
		return

	if(sendcooldown)
		return

	use_power(200)
/*
	var/obj/item/rcvdcopy
	if(paper_copy)
		//rcvdcopy = make_paper_copy(paper_copy)
		rcvdcopy = paper_copy
	else
		visible_message(span_notice("[src] beeps, \"Error transmitting message.\"")
		return

	rcvdcopy.loc = null //hopefully this shouldn't cause trouble
*/
	var/datum/fax/admin/AdminFax = new /datum/fax/admin()
	AdminFax.name = paper_copy.name
	AdminFax.from_department = department
	AdminFax.to_department = destination
	AdminFax.origin = src
	AdminFax.message = paper_copy
	AdminFax.sent_by = sender
	AdminFax.sent_at = world.time

	//message badmins that a fax has arrived
	switch(destination)
		if("Central Command")
			message_admins(sender, "CENTCOM FAX", destination, paper_copy, "#006100")
		if("Syndicate")
			message_admins(sender, "SYNDICATE FAX", destination, paper_copy, "#DC143C")
	sendcooldown = cooldown_time
	visible_message(span_notice("[src] beeps, \"Message transmitted successfully.\"")


/obj/machinery/photocopier/faxmachine/proc/message_admins(var/mob/sender, var/faxname, var/faxtype, var/obj/item/paper/sent, font_colour="#9A04D1")
	var/msg = {span_boldnotice("<font color='[font_colour]'>[faxname]: </font> [ADMIN_LOOKUP(sender)] | REPLY: [ADMIN_CENTCOM_REPLY(sender)] [ADMIN_FAX(sender, src, faxtype, sent)] [ADMIN_SM(sender)] | REJECT: (<A HREF='?_src_=holder;[HrefToken(TRUE)];FaxReplyTemplate=[REF(sender)];originfax=[REF(src)]'>TEMPLATE</A>)[ADMIN_SMITE(sender)] (<A HREF='?_src_=holder;[HrefToken(TRUE)];</A>) : Receiving '[sent.name]' via secure connection... <a href='?_src_=holder;[HrefToken(TRUE)];AdminFaxView=[REF(sent)]'>view message</a>)"}
	to_chat(GLOB.admins, msg)
