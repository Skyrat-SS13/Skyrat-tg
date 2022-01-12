//shows a list of clients we could send PMs to, then forwards our choice to cmd_Mentor_pm
/client/proc/cmd_mentor_pm_panel() // We're not using this and I'm debating removing the code as it's dead and useless. We don't need mentors PMing people out of the blue. That's not really how we operate.
	set category = "Mentor"
	set name = "Mentor PM"
	if(!is_mentor())
		to_chat(src, span_danger("Error: Mentor-PM-Panel: Only Mentors and Admins may use this command."))
		return
	var/list/client/targets[0]
	for(var/client/T) // What a cursed proc this is
		targets["[T]"] = T

	var/list/sorted = sort_list(targets)
	var/target = input(src, "To whom shall we send a message?", "Mentor PM", null) in sorted|null
	cmd_mentor_pm(targets[target], null)
	SSblackbox.record_feedback("tally", "Mentor_verb", TRUE, "APM") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/**
 * Takes input from cmd_mentor_pm_context, cmd_Mentor_pm_panel or /client/Topic and sends them a PM.
 * Fetching a message if needed. src is the sender and target is the target client
 *
 * Arguments:
 * * whom - The target of the mentor PM.
 * * msg - The content of the mentor PM.
 */
/client/proc/cmd_mentor_pm(whom, msg)
	var/client/target
	if(ismob(whom))
		var/mob/mob_target = whom
		target = mob_target.client
	else if(istext(whom))
		target = GLOB.directory[whom]
	else if(istype(whom,/client))
		target = whom
	if(!target)
		if(is_mentor())
			to_chat(src, span_danger("Error: Mentor-PM: Client not found."))
		else
			mentorhelp(msg)	//Mentor we are replying to left. Mentorhelp instead(check below)
		return

	if(is_mentor(whom))
		to_chat(GLOB.mentors, span_purple(span_mentor("[src] has started replying to [whom]'s mhelp.")))

	//get message text, limit it's length.and clean/escape html
	if(!msg)
		msg = tgui_input_text(src, "Message:", "Private message")

		if(!msg)
			if (is_mentor(whom))
				to_chat(GLOB.mentors, span_mentor(span_purple("[src] has stopped their reply to [whom]'s mhelp.")))
			return

		if(!target)
			if(is_mentor())
				to_chat(src, span_danger("Error: Mentor-PM: Client not found."))
			else
				mentorhelp(msg)	//Mentor we are replying to has vanished, Mentorhelp instead (how the fuck does this work?let's hope it works,shrug)
				return

		// Neither party is a mentor, they shouldn't be PMing!
		if (!target.is_mentor() && !is_mentor())
			return

	if(!msg)
		if (is_mentor(whom))
			to_chat(GLOB.mentors, span_mentor(span_purple("[src] has stopped their reply to [whom]'s mhelp.")))
		return
	log_mentor("Mentor PM: [key_name(src)]->[key_name(target)]: [msg]")

	msg = emoji_parse(msg)
	SEND_SOUND(target, 'sound/items/bikehorn.ogg')
	var/show_char = CONFIG_GET(flag/mentors_mobname_only)
	if(target.is_mentor())
		if(is_mentor())//both are mentors
			to_chat(target, span_mentor(span_purple("Mentor PM from-<b>[key_name_mentor(src, target, TRUE, FALSE, FALSE)]</b>: [msg]")))
			to_chat(src, span_mentor(span_blue("Mentor PM to-<b>[key_name_mentor(target, target, TRUE, FALSE, FALSE)]</b>: [msg]")))

		else		//recipient is a mentor but sender is not
			to_chat(target, span_mentor(span_purple("Reply PM from-<b>[key_name_mentor(src, target, TRUE, FALSE, show_char)]</b>: [msg]")))
			to_chat(src, span_mentor("Mentor PM to-<b>[key_name_mentor(target, target, TRUE, FALSE, FALSE)]</b>: [msg]"))

	else
		if(is_mentor())	//sender is a mentor but recipient is not.
			to_chat(target, span_mentor(span_purple("Mentor PM from-<b>[key_name_mentor(src, target, TRUE, FALSE, FALSE)]</b>: [msg]")))
			to_chat(src, span_mentor("Mentor PM to-<b>[key_name_mentor(target, target, TRUE, FALSE, show_char)]</b>: [msg]"))

	//we don't use message_Mentors here because the sender/receiver might get it too // We should make it an argument for that proc to ignore the sender, then. :(
	var/show_char_sender = !is_mentor() && CONFIG_GET(flag/mentors_mobname_only)
	var/show_char_recip = !target.is_mentor() && CONFIG_GET(flag/mentors_mobname_only)
	for(var/it in GLOB.mentors)
		var/client/mentor = it
		if(mentor?.key != key && mentor?.key != target.key)	//check client/mentor is an Mentor and isn't the sender or recipient
			to_chat(mentor, span_mentor("<B>Mentor PM: [key_name_mentor(src, mentor, FALSE, FALSE, show_char_sender)]-&gt;[key_name_mentor(target, mentor, FALSE, FALSE, show_char_recip)]:</B> [span_blue(msg)]")) //inform mentor
