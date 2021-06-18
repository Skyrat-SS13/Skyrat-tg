// Fax datum - holds all faxes sent during the round
GLOBAL_LIST_EMPTY(faxes)
GLOBAL_LIST_EMPTY(adminfaxes)

/datum/fax
	var/name = "fax"
	var/from_department = null
	var/to_department = null
	var/origin = null
	var/message = null
	var/sent_by = null
	var/sent_at = null

/datum/fax/New()
	GLOB.faxes += src

/datum/fax/admin
	var/list/reply_to = null

/datum/fax/admin/New()
	GLOB.adminfaxes += src

// Fax panel - lets admins check all faxes sent during the round
/client/proc/fax_panel() //Creates a verb for admins to open up the ui
	set name = "Fax Panel"
	set desc = "Abuse harder than you ever have before with this handy dandy semi-misc stuff menu"
	set category = "Admin.Fun"
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Fax Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	var/datum/fax_panel/tgui  = new(usr)//create the datum
	tgui.ui_interact(usr)//datum has a tgui component, here we open the window

/datum/fax_panel
	var/client/holder //client of whoever is using this datum
	var/is_funmin = FALSE
	var/list/fax_list = new list[]

/datum/fax_panel/New(user)//user can either be a client or a mob due to byondcode(tm)
	if (istype(user, /client))
		var/client/user_client = user
		holder = user_client //if its a client, assign it to holder
	else
		var/mob/user_mob = user
		holder = user_mob.client //if its a mob, assign the mob's client to holder

	is_funmin = check_rights(R_FUN)

for(var/thing in GLOB.adminfaxes)
	fax_list[] += thing

/datum/fax_panel/ui_state(mob/user)
	return GLOB.admin_state

/datum/fax_panel/ui_close()
	qdel(src)

/datum/fax_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FaxPanel")
		ui.open()

/datum/fax_panel/ui_data(mob/user)
	var/list/data = list()
	data["is_funmin"] = is_funmin
	data["fax_list"] = fax_list
	return data

/datum/admins/proc/fax_panel(var/mob/living/user)
	var/dat = ""
	for(var/thing in GLOB.adminfaxes)
		var/datum/fax/admin/afax = thing
		dat += "<tr>"
		dat += "<td>[afax.name]</td>"
		dat += "<td>[afax.from_department]</td>"
		dat += "<td>[afax.to_department]</td>"
		dat += "<td>[worldtime2text(afax.sent_at)]</td>"

/*
/datum/admins/proc/fax_panel(var/mob/living/user)
	var/dat = "<A align='right' href='?src=[REF()];[HrefToken(TRUE)];refreshfaxpanel=1'>Refresh</A>"
	dat += "<A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxCreate=1;faxtype=Custom'>Create Fax</A>"

	dat += "<div class='block'>"
	dat += "<h2>Admin Faxes</h2>"
	dat += "<table>"
	dat += "<tr style='font-weight:bold;'><td width='150px'>Name</td><td width='150px'>From Department</td><td width='150px'>To Department</td><td width='75px'>Sent At</td><td width='150px'>Sent By</td><td width='50px'>View</td><td width='50px'>Reply</td><td width='75px'>Replied To</td></td></tr>"
	for(var/thing in GLOB.adminfaxes)
		var/datum/fax/admin/afax = thing
		dat += "<tr>"
		dat += "<td>[afax.name]</td>"
		dat += "<td>[afax.from_department]</td>"
		dat += "<td>[afax.to_department]</td>"
		dat += "<td>[worldtime2text(afax.sent_at)]</td>"
		if(afax.sent_by)
			var/mob/living/sender = afax.sent_by
			dat += "<td><A HREF='?_src_=holder;[HrefToken(TRUE)];adminplayeropts=[REF(afax.sent_by)]'>[sender.name]</A></td>"
		else
			dat += "<td>Unknown</td>"
		dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxView=[REF(afax.message)]'>View</A></td>"
		//dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxView=[REF(afax)]'>View</A></td>"
		if(!afax.reply_to)
			if(afax.from_department == "Administrator")
				dat += "<td>N/A</td>"
			else
				dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxCreate=[REF(afax.sent_by)];originfax=[REF(afax.origin)];faxtype=[afax.to_department];replyto=[REF(afax.message)]'>Reply</A></td>"
			dat += "<td>N/A</td>"
		else
			dat += "<td>N/A</td>"
			dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxView=[REF(afax.reply_to)]'>Original</A></td>"
			//dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxView=[REF(afax)]'>Original</A></td>"
		dat += "</tr>"
	dat += "</table>"
	dat += "</div>"

	dat += "<div class='block'>"
	dat += "<h2>Departmental Faxes</h2>"
	dat += "<table>"
	dat += "<tr style='font-weight:bold;'><td width='150px'>Name</td><td width='150px'>From Department</td><td width='150px'>To Department</td><td width='75px'>Sent At</td><td width='150px'>Sent By</td><td width='175px'>View</td></td></tr>"
	for(var/thing in GLOB.faxes)
		var/datum/fax/sentfax = thing
		dat += "<tr>"
		dat += "<td>[sentfax.name]</td>"
		dat += "<td>[sentfax.from_department]</td>"
		dat += "<td>[sentfax.to_department]</td>"
		dat += "<td>[worldtime2text(sentfax.sent_at)]</td>"
		if(sentfax.sent_by)
			var/mob/living/sender = sentfax.sent_by
			dat += "<td><A HREF='?_src_=holder;[HrefToken(TRUE)];adminplayeropts=[REF(sentfax.sent_by)]'>[sender.name]</A></td>"
		else
			dat += "<td>Unknown</td>"
		dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxView=[REF(sentfax.message)]'>View</A></td>"
		//dat += "<td><A align='right' href='?src=[REF()];[HrefToken(TRUE)];AdminFaxView=[REF(sentfax)]'>View</A></td>"
		dat += "</tr>"
	dat += "</table>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "fax_panel", "Fax Panel", 950, 450)
	popup.set_content(dat)
	popup.open()
*/
