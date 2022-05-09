#define CHOICE_TRANSFER "Initiate Crew Transfer"
#define CHOICE_CONTINUE "Continue Playing"

/datum/vote/transfer_vote
	name = "Restart"
	default_choices = list(
		CHOICE_TRANSFER,
		CHOICE_CONTINUE,
	)

/datum/vote/transfer_vote/toggle_votable(mob/toggler)
	if(!toggler)
		CRASH("[type] wasn't passed a \"toggler\" mob to toggle_votable.")
	if(!check_rights_for(toggler.client, R_ADMIN))
		return FALSE
	return TRUE

/datum/vote/transfer_vote/is_config_enabled()
	return CONFIG_GET(flag/allow_vote_restart)

/datum/vote/transfer_vote/can_be_initiated(mob/by_who, forced)
	. = ..()
	if(!.)
		return FALSE

	if(!forced && !CONFIG_GET(flag/allow_vote_restart))
		if(by_who)
			to_chat(by_who, span_warning("Restart voting is disabled."))
		return FALSE

	return TRUE

/datum/vote/transfer_vote/finalize_vote(winning_option)
	if(winning_option == CHOICE_CONTINUE)
		return

	if(winning_option == CHOICE_TRANSFER)
		SSshuttle.autoEnd()
		var/obj/machinery/computer/communications/comms_console = locate() in GLOB.machines
		if(comms_console)
			comms_console.post_status("shuttle")
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef CHOICE_TRANSFER
#undef CHOICE_CONTINUE
