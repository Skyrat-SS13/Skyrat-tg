// STANDARD JOB TRAIT HANDLING
/datum/station_trait/job/on_lobby_button_click(mob/dead/new_player/user)
	if(SSticker.HasRoundStarted())
		to_chat(user, span_redtext("The round has already started!"))
		return
	if (LAZYFIND(lobby_candidates, user))
		LAZYREMOVE(lobby_candidates, user)
		to_chat(user, span_redtext("You have been removed from the [name] list of candidates."))
	else
		LAZYADD(lobby_candidates, user)
		to_chat(user, span_greentext("You have been added to the [name] list of candidates."))

// SKUB TRAIT HANDLING
#define PRO_SKUB "pro-skub"
#define ANTI_SKUB "anti-skub"
#define SKUB_IDFC "i don't frikkin' care"

/datum/station_trait/skub/on_lobby_button_click(mob/dead/new_player/user)
	var/skub_stance = tgui_input_list(user, "Choose your stance on skub", "Skub Stance", list(ANTI_SKUB, SKUB_IDFC, PRO_SKUB))
	skubbers[user.ckey] = skub_stance
	to_chat(user, span_greentext("You have chosen [skub_stance]!"))

#undef PRO_SKUB
#undef ANTI_SKUB
#undef SKUB_IDFC
