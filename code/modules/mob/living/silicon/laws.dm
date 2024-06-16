/mob/living/silicon/proc/show_laws()
	laws_sanity_check()
	var/list/law_box = list(span_bold("Obey these laws:"))
	law_box += laws.get_law_list(include_zeroth = TRUE)
	to_chat(src, examine_block(jointext(law_box, "\n")))

/mob/living/silicon/proc/try_sync_laws()
	return

/mob/living/silicon/proc/laws_sanity_check()
	if (!laws)
		make_laws()

/mob/living/silicon/proc/log_current_laws()
	var/list/the_laws = laws.get_law_list(include_zeroth = TRUE)
	var/lawtext = the_laws.Join(" ")
	log_silicon("LAW: [key_name(src)] spawned with [lawtext]")

/mob/living/silicon/proc/deadchat_lawchange()
	var/list/the_laws = laws.get_law_list(include_zeroth = TRUE)
	var/lawtext = the_laws.Join("<br/>")
	deadchat_broadcast("'s <b>laws were changed.</b> <a href='?src=[REF(src)]&dead=1&printlawtext=[url_encode(lawtext)]'>View</a>", span_name("[src]"), follow_target=src, message_type=DEADCHAT_LAWCHANGE)

/mob/living/silicon/proc/post_lawchange(announce = TRUE)
	throw_alert(ALERT_NEW_LAW, /atom/movable/screen/alert/newlaw)
	if(announce && last_lawchange_announce != world.time)
		to_chat(src, span_boldannounce("Your laws have been changed."))
		SEND_SOUND(src, sound('sound/machines/cryo_warning.ogg'))
		// lawset modules cause this function to be executed multiple times in a tick, so we wait for the next tick in order to be able to see the entire lawset
		addtimer(CALLBACK(src, PROC_REF(show_laws)), 0)
		addtimer(CALLBACK(src, PROC_REF(deadchat_lawchange)), 0)
		last_lawchange_announce = world.time
	// SKYRAT EDIT ADDITION START: AI LAWSYNC
	if(isAI(src))
		var/mob/living/silicon/ai/ai = src
		for(var/mob/living/silicon/robot/cyborg as anything in ai.connected_robots)
			if(cyborg.connected_ai && cyborg.lawupdate)
				cyborg.lawsync()
	// SKYRAT EDIT ADDITON END

/mob/living/silicon/proc/set_zeroth_law(law, law_borg, announce = TRUE)
	laws_sanity_check()
	laws.set_zeroth_law(law, law_borg)
	post_lawchange(announce)

/mob/living/silicon/proc/add_inherent_law(law, announce = TRUE)
	laws_sanity_check()
	laws.add_inherent_law(law)
	lawcheck += law
	post_lawchange(announce)

/mob/living/silicon/proc/clear_inherent_laws(announce = TRUE)
	laws_sanity_check()
	for (var/law in laws.inherent)
		if (law in lawcheck)
			lawcheck -= law
	laws.clear_inherent_laws()
	post_lawchange(announce)

/mob/living/silicon/proc/add_supplied_law(number, law, announce = TRUE)
	laws_sanity_check()
	laws.add_supplied_law(number, law)
	lawcheck += law
	post_lawchange(announce)

/mob/living/silicon/proc/clear_supplied_laws(announce = TRUE)
	laws_sanity_check()
	for(var/law in laws.supplied)
		if (law in lawcheck)
			lawcheck -= law
	laws.clear_supplied_laws()
	post_lawchange(announce)

/mob/living/silicon/proc/add_ion_law(law, announce = TRUE)
	laws_sanity_check()
	laws.add_ion_law(law)
	ioncheck += law
	post_lawchange(announce)

/mob/living/silicon/proc/add_hacked_law(law, announce = TRUE)
	laws_sanity_check()
	laws.add_hacked_law(law)
	hackedcheck += law
	post_lawchange(announce)

/mob/living/silicon/proc/replace_random_law(law, remove_law_groups, insert_law_group, announce = TRUE)
	laws_sanity_check()
	. = laws.replace_random_law(law, remove_law_groups, insert_law_group)
	post_lawchange(announce)

/mob/living/silicon/proc/shuffle_laws(list/groups, announce = TRUE)
	laws_sanity_check()
	laws.shuffle_laws(groups)
	post_lawchange(announce)

/mob/living/silicon/proc/remove_law(number, announce = TRUE)
	laws_sanity_check()
	. = laws.remove_law(number)
	if (. in lawcheck)
		lawcheck -= .
	post_lawchange(announce)

/mob/living/silicon/proc/clear_ion_laws(announce = TRUE)
	laws_sanity_check()
	laws.clear_ion_laws()
	ioncheck = list()
	post_lawchange(announce)

/mob/living/silicon/proc/clear_hacked_laws(announce = TRUE)
	laws_sanity_check()
	laws.clear_hacked_laws()
	hackedcheck = list()
	post_lawchange(announce)

/mob/living/silicon/proc/make_laws()
	laws = new /datum/ai_laws
	laws.set_laws_config()
	laws.associate(src)

/mob/living/silicon/proc/clear_zeroth_law(force, announce = TRUE)
	laws_sanity_check()
	var/zeroth = laws.zeroth
	if(laws.clear_zeroth_law(force))
		lawcheck -= zeroth
	post_lawchange(announce)
