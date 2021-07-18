
/datum/ambitions/proc/auto_approve()
	message_admins(span_adminhelp("[ADMIN_TPMONTY(my_mind.current)]'s ambitions were automatically approved"))
	to_chat(my_mind.current, span_big(span_adminhelp("Your ambitions were automatically approved. This does not mean you won't get in trouble if your ambitions are non-sensical")))
	admin_approval = TRUE
	changed_after_approval = FALSE
	last_requested_change = null
	GLOB.ambitions_to_review -= src
	submit()
	log_action("AUTOMATICALLY APPROVED", FALSE)

/datum/ambitions/proc/cancel_auto_approve()
	if(auto_approve_timerid)
		deltimer(auto_approve_timerid)
		auto_approve_timerid = 0
		message_admins(span_red("Automatic approval for [ADMIN_TPMONTY(my_mind.current)]'s ambitions was cancelled"))
		to_chat(my_mind.current, span_big(span_adminhelp("Your ambitions will no longer be automically approved. Please wait for an Admin")))

/datum/ambitions/proc/log_action(text_content, clears_approval = TRUE)
	var/admin_change = my_mind.current != usr
	if(admin_change)
		var/mob/living/holder = my_mind.current
		text_content = "\[[key_name(usr)] -> [key_name(holder)]\] " + text_content
		log_admin(text_content)
		holder.log_message(text_content, LOG_AMBITION)
	usr.log_message(text_content, LOG_AMBITION)
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

/datum/ambitions/proc/un_submit()
	if(!submitted)
		return
	submitted = FALSE
	GLOB.total_intensity -= intensity
	GLOB.intensity_counts["[intensity]"] -= 1

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
