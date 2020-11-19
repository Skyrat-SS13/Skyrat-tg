/datum/ambitions
	///Reasons of why would you act in antagonic ways
	var/narrative = ""
	///List of your objectives, in string form
	var/list/objectives = list()
	///Chosen intensity of your antagonism
	var/intensity = 0
	///Note in which you can optionally write out your vision/reasonings, useful if you want it to get reviewed
	var/note_to_admins = ""
	///Whether it was submitted or not
	var/submitted = FALSE
	///Whether we requested an admin review
	var/admin_review_requested = FALSE
	///Whether an admin approved our ambitions.
	var/admin_approval = FALSE
	///If we changed our ambitions after approval
	var/changed_after_approval = FALSE
	///Log of changes made to the ambitions
	var/list/log = list("Ambition Logs:")
	///The mind the ambitions belong to
	var/datum/mind/my_mind
	///The original name of our character
	var/owner_name
	///The last change requested by an admin, if a review was asked for
	var/last_requested_change

/datum/ambitions/New(datum/mind/M)
	my_mind = M
	owner_name = my_mind.current.real_name
	//Greet our antag player and give him a link to open ambitions!
	to_chat(my_mind.current, "<span class='boldnotice'>You're a story driven antagonist, this means you'll have to fill ambitions before you start antagonising!</span>")
	to_chat(my_mind.current, "<span class='boldnotice'>After filling them out you'll get access to your uplink or powers.</span>")
	to_chat(my_mind.current, "<span class='boldnotice'>Click <a href='?src=[REF(src)];pref=show_ambitions'>here</a> to set your ambitions, or access them at any time from your IC tab.</span>")

/datum/ambitions/proc/ShowPanel(mob/user, admin_view = FALSE)
	if(!user || !user.client)
		return
	var/list/dat = list("<center>")
	if(admin_view)
		dat += "<h3>Admin View Options:</h3>"
		dat += "<i>Down below you have [my_mind.current.name]'s ambitions.</i>"
		if(admin_review_requested)
			dat += "<BR><b>They have requested an admin review.</b>"
			if(admin_approval)
				dat += "<BR><b><font color='#00FF00'>...and it was granted!</font></b>"
				if(changed_after_approval)
					dat += "<BR><b><font color='#ffd500'>...however they changed their ambitions after that, see logs for more info.</font></b>"
		else
			dat += "<BR><b>They have NOT requested an admin review.</b>"
		dat += "<BR>"
		if(admin_review_requested && (!admin_approval || changed_after_approval))
			dat += "<a href='?src=[REF(src)];admin_pref=approve'>Approve</a> <a href='?src=[REF(src)];admin_pref=handle'>Handle</a> <a href='?src=[REF(src)];admin_pref=request_changes'>Request Changes</a>  <a href='?src=[REF(src)];admin_pref=discard_review'>Discard</a> -"
		dat += " <a href='?src=[REF(src)];admin_pref=logs'>Logs</a>"
		dat += "<HR>"

	dat += "<b>Antagonists are supposed to provide excitement and intrigue, drive a story with the crew, and provide fun and interesting experience for people involved. <BR> Remember, it's not about winning or losing, but about the story and interactions, this is a roleplay server.</b><BR><BR>"
	dat += "<i>Here you write your ambitions for your antagonist round! Ambitions are your motive and what you plan to accomplish throught the round.</i>"
	dat += "<BR><i>After filling all things out and submitting your ambition, your uplink/powers will unlock.</i>"
	dat += "<BR><i>If you can't come up with anything, use a <b>template</b>, and if you don't know if your ambition are proper, or too extreme, <b>request admin review</b>.</i>"
	dat += "<BR><i>You can still edit them post submission.</i>"
	dat += "<BR><b><font color='#FF0000'>If your ambitions are nonsensical, you may be subjected to an antagonist ban.</font></b>"
	var/review_link = (is_proper_ambitions() && !admin_review_requested) ? "href='?src=[REF(src)];pref=request_review'" : "class='linkOff'"
	dat += "<center><a href='?src=[REF(src)];pref=template'>Choose template</a> <a [review_link]>Request admin review (optional)</a></center>"
	dat += "<BR><i>If you do choose a template, you'll get tips regarding it in your chat, and it wont submit automatically.</i>"
	dat += "<HR>"
	if(changed_after_approval)
		dat += "<BR><b><font color='#ffd500'>Some fields were changed after an admin approval.</font></b>"
	if(last_requested_change)
		dat += "<BR><b><font color='#ffd500'>Requested changes:</font></b>"
		dat += "<BR><b><font color='#ffd500'>[last_requested_change]</font></b>"
		dat += "<BR><a href='?src=[REF(src)];pref=requested_done'>Notify admin that you've done them!</a></b>"
	dat += "<h3>Narrative:</h3>"
	dat += "<i>Here you set your narrative. It's the reason on why you're doing antagonistic things. Perhaps you need money for personal reasons, or you were contracted to do someone's dirty work, or want to take down the BigPharma.</i>"
	dat += "<BR><table align='center'; width='100%'; style='background-color:#13171C'><tr><td><center>"
	if(narrative == "")
		dat += "<font color='#CCCCFF'><b>Please set your narrative!</b></font>"
	else
		dat += narrative
	dat += "</center><center><a href='?src=[REF(src)];pref=set_narrative'>Set your narrative</a></center>"
	dat += "</td></tr></table>"
	dat += "<BR>"
	dat += "<h3>Objectives:</h3>"
	dat += "<i>Here you add your objectives. Think about them as milestones to your narratives.</i>"
	dat += "<BR><table align='center'; width='100%'; style='background-color:#13171C'>"
	if(length(objectives))
		var/even = TRUE
		var/index = 0
		for(var/objectiv in objectives)
			index++
			even = !even
			var/bg_color = "#23273C"
			if(even)
				bg_color = "#19222C"
			dat += "<tr style='background-color:[bg_color]'><td><center> * [objectiv] <a href='?src=[REF(src)];pref=edit_objective;index=[index]'>Edit</a> <a href='?src=[REF(src)];pref=remove_objective;index=[index]'>Remove</a></center></td></tr>"
	else
		dat += "<tr><td><center><font color='#CCCCFF'><b>Please add atleast one objective!</b></font></center></td></tr>"
	dat += "<tr><td><center><a href='?src=[REF(src)];pref=add_objective'>Add new objective</a></center></td></tr>"
	dat += "</table>"
	dat += "<BR>"
	dat += "<h3>Intensity:</h3>"
	dat += "<i>Set the estimated intensity of your ambitions, this helps the admins gauge on how chaotic a round may be. Please set it accordingly.</i>"
	if(intensity == 0)
		dat += "<BR><center><font color='#CCCCFF'><b>Please set your intensity!</b></font></center>"
	dat += "<table>"
	dat += "<tr><td width=15%></td><td width=85%></td></tr>"
	for(var/i in 1 to 5)
		var/current_spice
		switch(i)
			if(1)
				current_spice = AMBITION_INTENSITY_STEALTH
			if(2)
				current_spice = AMBITION_INTENSITY_MILD
			if(3)
				current_spice = AMBITION_INTENSITY_MEDIUM
			if(4)
				current_spice = AMBITION_INTENSITY_SEVERE
			if(5)
				current_spice = AMBITION_INTENSITY_EXTREME
		var/active = (current_spice == intensity)
		var/spice_link = active ? "class='linkOn'" : "href='?src=[REF(src)];pref=spice;amount=[current_spice]'"
		var/spice_name
		var/spice_desc
		var/spice_color
		switch(current_spice)
			if(AMBITION_INTENSITY_STEALTH)
				spice_name = "Stealth"
				spice_desc = "Nothing noticable to the public, interacting with one or two people."
				spice_color = "#a6a6a6"
			if(AMBITION_INTENSITY_MILD)
				spice_name = "Mild"
				spice_desc = "Thievery and vandalism."
				spice_color = "#fcdf03"
			if(AMBITION_INTENSITY_MEDIUM)
				spice_name = "Medium"
				spice_desc = "Mugging, beating people, general thuggery."
				spice_color = "#fcb103"
			if(AMBITION_INTENSITY_SEVERE)
				spice_name = "Severe"
				spice_desc = "Station sabotage and occasional manslaughter."
				spice_color = "#fc8c03"
			if(AMBITION_INTENSITY_EXTREME)
				spice_name = "Extreme"
				spice_desc = "Grand sabotage and indiscriminate murder."
				spice_color = "#fc5603"
		dat += "<tr style='background-color:[spice_color]'><td><a [spice_link]>[spice_name]</a></td><td><center><i><font color='#000000'><b>[spice_desc]</b></font></i></center></td></tr>"
	dat += "</table>"
	dat += "<HR>"
	dat += "<h3>Note to Admin (optional):</h3>"
	dat += "<i>If you want to request a review, you can set this to explain your reasoning or what experience you hope to bring to the station.</i>"
	dat += "<BR><table align='center'; width='100%'; style='background-color:#13171C'><tr><td><center>"
	dat += note_to_admins
	dat += "</center><BR><center><a href='?src=[REF(src)];pref=edit_admin_note'>Edit your note to admin</a></center>"
	dat += "</td></tr></table>"
	dat += "<HR>"
	if(!is_proper_ambitions())
		dat += "<center><b>Before you'll be able to submit your ambitions, you need to fill narratives, objectives and intensity.</b></center>"
	else if(admin_review_requested && !admin_approval)
		dat += "<center><b>You've requested admin approval, please wait before submitting.</b></center>"
	else if(!submitted)
		dat += "<center><a href='?src=[REF(src)];pref=submit'>Submit</a></center>"
	else
		dat += "<center><b>You've already submitted your ambitions, but feel free to edit them.</b></center>"

	winshow(usr, "ambition_window", TRUE)
	var/datum/browser/popup = new(usr, "ambition_window", "<div align='center'>Ambitions</div>", 950, 750)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(usr, "ambition_window", src)

/datum/ambitions/Topic(href, href_list)
	if(href_list["admin_pref"])
		switch(href_list["admin_pref"])
			if("handle")
				var/last_ckey = GLOB.ambitions_to_review[src]
				if(last_ckey && last_ckey != usr.ckey)
					var/action = alert(usr, "[last_ckey] is already handling this review! Do you want to handle nonetheless?", "", "Yes", "No")
					if(action && !(action == "Yes"))
						return
				GLOB.ambitions_to_review[src] = usr.ckey
				message_admins("<span class='adminhelp'>[usr.ckey] is handling [owner_name]'s ambitions. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
				to_chat(my_mind.current, "<span class='boldnotice'>[usr.ckey] is handling your ambitions.</span>")
			if("request_changes")
				var/changes_wanted = input(usr, "Requested changes:", "Ambitions")  as message|null
				if(changes_wanted)
					last_requested_change = changes_wanted
					to_chat(my_mind.current, "<span class='boldwarning'>[usr.ckey] requested changes on your ambitions: [changes_wanted]. (<a href='?src=[REF(src)];pref=show_ambitions'>VIEW</a>)</span>")
					message_admins("<span class='adminhelp'>[usr.ckey] requested changes in [ADMIN_TPMONTY(my_mind.current)]'s ambitions. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
			if("discard_review")
				var/action = alert(usr, "Are you sure you want to discard this review request (Use request changes if you want it changed instead)?", "", "Yes", "No")
				if(action && action == "Yes" && admin_review_requested)
					admin_review_requested = FALSE
					admin_approval = FALSE
					changed_after_approval = FALSE
					last_requested_change = null
					GLOB.ambitions_to_review -= src
					to_chat(my_mind.current, "<span class='warning'><b>Your ambitions review request was discarded by [usr.ckey].</b></span>")
					message_admins("<span class='adminhelp'>[ADMIN_TPMONTY(my_mind.current)]'s ambitions review request was DISCARDED by [usr.ckey]. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
			if("approve")
				admin_approval = TRUE
				changed_after_approval = FALSE
				last_requested_change = null
				GLOB.ambitions_to_review -= src
				log_action("APPROVED: Got an approval from [usr.ckey]", FALSE)
				to_chat(my_mind.current, "<span class='nicegreen'><b>Your ambitions were approved by [usr.ckey].</b></span>")
				message_admins("<span class='nicegreen'>[ADMIN_TPMONTY(my_mind.current)]'s ambitions were approved by [usr.ckey]. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
				submit()
			if("logs")
				var/datum/browser/popup = new(usr, "Ambition logging", "Ambition logs", 500, 200)
				popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "Ambition logs", log.Join("<BR>")))
				popup.open()
				return

		ShowPanel(usr, TRUE)
		return TRUE

	if(href_list["pref"])
		switch(href_list["pref"])
			if("template")
				var/list/available_templates = list()
				for(var/name in GLOB.ambitions_templates)
					var/datum/ambition_template/AT = GLOB.ambitions_templates[name]
					if(AT.antag_whitelist)
						continue
					if(AT.job_whitelist)
						continue
					available_templates += AT
			if("requested_done")
				to_chat(src, "<span class='nicegreen'><b>You notify admins that you have adressed the requested changes.</b></span>")
				message_admins("<span class='adminhelp'>[ADMIN_TPMONTY(usr)] notifies that he has finished the requested changes in his ambitions. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
			if("request_review")
				admin_review_requested = TRUE
				GLOB.ambitions_to_review[src] = 0
				log_action("--Requested an admin review--", FALSE)
				message_admins("<span class='adminhelp'>[ADMIN_TPMONTY(usr)] has requested a review of their ambitions. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
			if("submit")
				submit()
				log_action("SUBMIT: Submitted their ambitions", FALSE)
				message_admins("<span class='adminhelp'>[ADMIN_TPMONTY(usr)] has submitted their ambitions. (<a href='?src=[REF(src)];admin_pref=show_ambitions'>VIEW</a>)</span>")
			if("spice")
				var/new_intensity = text2num(href_list["amount"])
				if(intensity == new_intensity)
					return
				if(submitted)
					GLOB.total_intensity -= intensity
					GLOB.intensity_counts["[intensity]"] -= 1
					GLOB.total_intensity += new_intensity
					GLOB.intensity_counts["[new_intensity]"] += 1
				intensity = new_intensity
			if("edit_admin_note")
				var/msg = input(usr, "Set your note to admins!", "Note to admins", note_to_admins) as message|null
				if(msg)
					note_to_admins = strip_html_simple(msg, MAX_FLAVOR_LEN, TRUE)
					log_action("NOTE: [note_to_admins]", FALSE)
			if("set_narrative")
				var/msg = input(usr, "Set your narrative!", "Narrative", narrative) as message|null
				if(msg)
					narrative = strip_html_simple(msg, MAX_FLAVOR_LEN, TRUE)
					log_action("NARRATIVE - change: [narrative]")
			if("remove_objective")
				var/index = text2num(href_list["index"])
				if(length(objectives) < index)
					return
				log_action("OBJ - removed: [objectives[index]]")
				objectives.Remove(objectives[index])
			if("edit_objective")
				var/index = text2num(href_list["index"])
				if(length(objectives) < index)
					return
				var/old_obj = objectives[index]
				var/msg = input(usr, "Edit objective:", "Objectives", old_obj) as message|null
				if(msg)
					if(length(objectives) < index)
						return
					objectives[index] = strip_html_simple(msg, MAX_FLAVOR_LEN, TRUE)
					log_action("OBJ - edit: [old_obj] TO-> [objectives[index]]")
			if("add_objective")
				var/msg = input(usr, "Add new objective:", "Objectives", "") as message|null
				if(msg)
					var/new_obj = strip_html_simple(msg, MAX_FLAVOR_LEN, TRUE)
					objectives += new_obj
					log_action("OBJ - add: [new_obj]")

		ShowPanel(usr)
		return TRUE

/datum/ambitions/proc/log_action(text_content, clears_approval = TRUE)
	if(admin_approval && clears_approval && !changed_after_approval)
		changed_after_approval = TRUE
		log += "[time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")] CHANGED AFTER APPROVAL:"
	log += "[time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")] [text_content]"

/datum/ambitions/proc/is_proper_ambitions()
	if(intensity == 0 || length(objectives) == 0 || narrative == "")
		return FALSE
	return TRUE

/datum/ambitions/proc/submit()
	if(submitted)
		return
	submitted = TRUE
	my_mind.ambition_submit()
	GLOB.total_intensity += intensity
	GLOB.intensity_counts["[intensity]"] += 1

/mob/proc/view_ambitions()
	set name = "View Ambitions"
	set category = "IC"
	set desc = "View and edit your character's ambitions."
	if(!mind)
		return
	if(!mind.my_ambitions)
		return
	mind.my_ambitions.ShowPanel(src)

/datum/ambitions/proc/Action(action)
	ShowPanel(usr, TRUE)

#undef AMBITION_INTENSITY_MILD
#undef AMBITION_INTENSITY_MEDIUM
#undef AMBITION_INTENSITY_SEVERE
#undef AMBITION_INTENSITY_EXTREME
