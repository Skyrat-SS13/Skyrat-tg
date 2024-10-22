/// If a player has any of these enabled, they are forced to use a minimum of RR_OPT_IN_ENABLED_LEVEL round removal optin. Dynamic - checked on the fly, not cached.
GLOBAL_LIST_INIT(rr_optin_forcing_midround_antag_categories, list(
	ROLE_CHANGELING_MIDROUND,
	ROLE_MALF_MIDROUND,
	ROLE_OBSESSED,
	ROLE_SLEEPER_AGENT,
))

/// If a player has any of these enabled ON SPAWN, they are forced to use a minimum of RR_OPT_IN_ENABLED_LEVEL round removal optin for the rest of the round.
GLOBAL_LIST_INIT(rr_optin_forcing_on_spawn_antag_categories, list(
	ROLE_BROTHER,
	ROLE_CHANGELING,
	ROLE_CULTIST,
	ROLE_HERETIC,
	ROLE_MALF,
	ROLE_OPERATIVE,
	ROLE_TRAITOR,
	ROLE_WIZARD,
	ROLE_ASSAULT_OPERATIVE,
	ROLE_CLOWN_OPERATIVE,
	ROLE_NUCLEAR_OPERATIVE,
	ROLE_HERETIC_SMUGGLER,
	ROLE_PROVOCATEUR,
	ROLE_STOWAWAY_CHANGELING,
	ROLE_SYNDICATE_INFILTRATOR,
))

/datum/mind
	/// The optin level set by preferences.
	var/ideal_opt_in_level = RR_OPT_LEVEL_DEFAULT
	/// Set on mind transfer. Set by on-spawn antags (e.g. if you have traitor on and spawn, this will be set to RR_OPT_LEVEL_ANTAG and cannot change)
	var/on_spawn_rr_opt_in_level = RR_OPT_OUT

/datum/mind/transfer_to(mob/new_character, force_key_move)
	. = ..()

	update_opt_in()
	send_rr_optin_reminder()

/// Refreshes our ideal/on spawn round removal opt in level by accessing preferences.
/datum/mind/proc/update_opt_in()
	var/datum/preferences/preference_instance = GLOB.preferences_datums[lowertext(key)]
	if (!isnull(preference_instance))
		ideal_opt_in_level = preference_instance.read_preference(/datum/preference/choiced/rr_opt_in_status)

		for (var/antag_category in GLOB.rr_optin_forcing_on_spawn_antag_categories)
			if (antag_category in preference_instance.be_special)
				on_spawn_rr_opt_in_level = RR_OPT_LEVEL_ANTAG
				break

/// Sends a bold message to our holder, telling them if their optin setting has been set to a minimum due to their antag preferences.
/datum/mind/proc/send_rr_optin_reminder()
	var/datum/preferences/preference_instance = GLOB.preferences_datums[lowertext(key)]
	var/client/our_client = preference_instance?.parent // that moment when /mind doesnt have a ref to client :)
	if (our_client)
		var/rr_level = get_rr_opt_in_level()
		if (rr_level <= RR_OPT_OUT)
			return
		var/stringified_level = GLOB.rr_opt_in_strings["[rr_level]"]
		to_chat(our_client, span_boldnotice("Due to your antag preferences, your antag-optin status has been set to a minimum of [stringified_level]."))

/// Gets the actual opt-in level used for determining targets.
/datum/mind/proc/get_effective_opt_in_level()
	return max(ideal_opt_in_level, get_job_opt_in_level(), get_rr_opt_in_level())

/// Returns the opt in level of our job.
/datum/mind/proc/get_job_opt_in_level()
	return assigned_role?.minimum_opt_in_level || RR_OPT_OUT

/// If we have any antags enabled in GLOB.rr_optin_forcing_midround_antag_categories, returns RR_OPT_LEVEL_ANTAG. RR_OPT_OUT otherwise.
/datum/mind/proc/get_rr_opt_in_level()
	if (on_spawn_rr_opt_in_level > RR_OPT_OUT)
		return on_spawn_rr_opt_in_level

	var/datum/preferences/preference_instance = GLOB.preferences_datums[lowertext(key)]
	if (!isnull(preference_instance))
		for (var/antag_category in GLOB.rr_optin_forcing_midround_antag_categories)
			if (antag_category in preference_instance.be_special)
				return RR_OPT_LEVEL_ANTAG
	return RR_OPT_OUT

/datum/mind/Destroy()
	log_game("Mind [src] destroying with RR [get_effective_opt_in_level() ? "enabled" : "disabled"]")
	. = ..()
