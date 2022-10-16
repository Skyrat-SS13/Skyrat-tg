/datum/action/innate/clock
	icon_icon = 'modular_skyrat/modules/clock_cult/icons/actions_clock.dmi'
	button_icon = 'modular_skyrat/modules/clock_cult/icons/background_clock.dmi'
	background_icon_state = "bg_clock"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS

/datum/action/innate/clock/IsAvailable()
	if(!(FACTION_CLOCK in owner.faction))
		return FALSE
	return ..()

/datum/action/innate/clock/comm
	name = "Whirring Convergence"
	desc = "Whispered words that link to the internal cogs of us all.<br><b>Warning:</b> Nearby non-servants can still hear you."
	button_icon_state = "linked_minds"

/datum/action/innate/clock/comm/Activate()
	var/input = tgui_input_text(usr, "Message to tell to the other followers.", "Voice of Cogs")
	if(!input || !IsAvailable())
		return

	var/list/filter_result = CAN_BYPASS_FILTER(usr) ? null : is_ic_filtered(input)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(usr, filter_result)
		return

	var/list/soft_filter_result = CAN_BYPASS_FILTER(usr) ? null : is_soft_ic_filtered(input)
	if(soft_filter_result)
		if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to say it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[html_encode(input)]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[input]\"")
	cultist_commune(usr, input)

/datum/action/innate/clock/comm/proc/cultist_commune(mob/living/user, message)
	var/my_message
	if(!message)
		return
	user.whisper("Engine, V vaibxr gb-gur`r gb-pbzzhar gb-nyy.", language = /datum/language/common)
	user.whisper(html_decode(message), filterproof = TRUE)
	my_message = span_italics(span_brass("<b>Ratvarian Servant [findtextEx(user.name, user.real_name) ? user.name : "[user.real_name] (as [user.name])"]:</b> [message]"))
	for(var/mob/player_mob as anything in GLOB.player_list)
		if(FACTION_CLOCK in player_mob.faction)
			to_chat(player_mob, my_message)
		else if(player_mob in GLOB.dead_mob_list)
			to_chat(player_mob, "[FOLLOW_LINK(player_mob, user)] [my_message]")

	user.log_talk(message, LOG_SAY, tag="cult")

/datum/action/item_action/toggle/clock
	button_icon = 'modular_skyrat/modules/clock_cult/icons/background_clock.dmi'
	background_icon_state = "bg_clock"
