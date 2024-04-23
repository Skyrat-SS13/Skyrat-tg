ADMIN_VERB(request_more_opfor, R_FUN, "Request OPFOR", "Request players sign up for opfor if they have antag on.", ADMIN_CATEGORY_FUN)
	var/asked = 0
	for(var/mob/living/carbon/human/human in GLOB.alive_player_list)
		if(human.client?.prefs?.read_preference(/datum/preference/toggle/be_antag))
			to_chat(human, examine_block(span_greentext("The admins are looking for OPFOR players, if you're interested, sign up in the OOC tab!")))
			asked++
	message_admins("[ADMIN_LOOKUP(user)] has requested more OPFOR players! (Asked: [asked] players)")


ADMIN_VERB(view_opfors, R_ADMIN, "View OPFORs", "View OPFORs.", ADMIN_CATEGORY_GAME)
	user.mob.client?.view_opfors()

/client/proc/view_opfors()
	if(holder)
		var/list/dat = list("<html>")
		dat += SSopposing_force.get_check_antag_listing()
		dat += "</html>"
		usr << browse(dat.Join(), "window=roundstatus;size=500x500")
		log_admin("[key_name(usr)] viewed OPFORs.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "View OPFORs")
