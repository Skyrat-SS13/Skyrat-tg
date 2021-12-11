#define LOWPOP_FAMILIES_COUNT 50

#define TWO_STARS_HIGHPOP 11
#define THREE_STARS_HIGHPOP 16
#define FOUR_STARS_HIGHPOP 21
#define FIVE_STARS_HIGHPOP 31

#define TWO_STARS_LOW 6
#define THREE_STARS_LOW 9
#define FOUR_STARS_LOW 12
#define FIVE_STARS_LOW 15

#define CREW_SIZE_MIN 4
#define CREW_SIZE_MAX 8


GLOBAL_VAR_INIT(deaths_during_shift, 0)
///Forces the Families theme to be the one in this variable via variable editing. Used for debugging.
GLOBAL_VAR(families_override_theme)

/**
 * # Families gamemode / dynamic ruleset handler
 *
 * A special datum used by the families gamemode and dynamic rulesets to centralize code. "Family" and "gang" used interchangeably in code.
 *
 * This datum centralizes code used for the families gamemode / dynamic rulesets. Families incorporates a significant
 * amount of unique processing; without this datum, that could would be duplicated. To ensure the maintainability
 * of the families gamemode / rulesets, the code was moved to this datum. The gamemode / rulesets instance this
 * datum, pass it lists (lists are passed by reference; removing candidates here removes candidates in the gamemode),
 * and call its procs. Additionally, the families antagonist datum and families induction package also
 * contain vars that reference this datum, allowing for new families / family members to add themselves
 * to this datum's lists thereof (primarily used for point calculation). Despite this, the basic team mechanics
 * themselves should function regardless of this datum's instantiation, should a player have the gang or cop
 * antagonist datum added to them through methods external to the families gamemode / rulesets.
 *
 */
/datum/gang_handler
	/// A counter used to minimize the overhead of computationally intensive, periodic family point gain checks. Used and set internally.
	var/check_counter = 0
	/// The time, in deciseconds, that the datum's pre_setup() occured at. Used in end_time. Used and set internally.
	var/start_time = null
	/// The time, in deciseconds, that the space cops will arrive at. Calculated based on wanted level and start_time. Used and set internally.
	var/end_time = null
	/// Whether the gamemode-announcing announcement has been sent. Used and set internally.
	var/sent_announcement = FALSE
	/// Whether the "5 minute warning" announcement has been sent. Used and set internally.
	var/sent_second_announcement = FALSE
	/// Whether the space cops have arrived. Set internally; used internally, and for updating the wanted HUD.
	var/cops_arrived = FALSE
	/// The current wanted level. Set internally; used internally, and for updating the wanted HUD.
	var/wanted_level
	/// List of all /datum/team/gang. Used internally; added to externally by /datum/antagonist/gang when it generates a new /datum/team/gang.
	var/list/gangs = list()
	/// List of all family member minds. Used internally; added to internally, and externally by /obj/item/gang_induction_package when used to induct a new family member.
	var/list/gangbangers = list()
	/// List of all undercover cop minds. Used and set internally.
	var/list/undercover_cops = list()
	/// The number of families (and 1:1 corresponding undercover cops) that should be generated. Can be set externally; used internally.
	var/gangs_to_generate = 3
	/// The number of family members more that a family may have over other active families. Can be set externally; used internally.
	var/gang_balance_cap = 5
	/// Whether the handler corresponds to a ruleset that does not trigger at round start. Should be set externally only if applicable; used internally.
	var/midround_ruleset = FALSE
	/// Whether we want to use the 30 to 15 minute timer instead of the 60 to 30 minute timer, for Dynamic.
	var/use_dynamic_timing = FALSE
	/// Keeps track of the amount of deaths since the calling of pre_setup_analogue() if this is a midround handler. Used to prevent a high wanted level due to a large amount of deaths during the shift prior to the activation of this handler / the midround ruleset.
	var/deaths_during_shift_at_beginning = 0

	/// List of all eligible starting family members / undercover cops. Set externally (passed by reference) by gamemode / ruleset; used internally. Note that dynamic uses a list of mobs to handle candidates while game_modes use lists of minds! Don't be fooled!
	var/list/antag_candidates = list()
	/// List of jobs not eligible for starting family member / undercover cop. Set externally (passed by reference) by gamemode / ruleset; used internally.
	var/list/restricted_jobs
	/// The current chosen gamemode theme. Decides the available Gangs, objectives, and equipment.
	var/datum/gang_theme/current_theme

/**
 * Sets antag_candidates and restricted_jobs.
 *
 * Sets the antag_candidates and restricted_jobs lists to the equivalent
 * lists of its instantiating game_mode / dynamic_ruleset datum. As lists
 * are passed by reference, the variable set in this datum and the passed list
 * list used to set it are literally the same; changes to one affect the other.
 * Like all New() procs, called when the datum is first instantiated.
 * There's an annoying caveat here, though -- dynamic rulesets don't have
 * lists of minds for candidates, they have lists of mobs. Ghost mobs, before
 * the round has started. But we still want to preserve the structure of the candidates
 * list by not duplicating it and making sure to remove the candidates as we use them.
 * So there's a little bit of boilerplate throughout to preserve the sanctity of this reference.
 * Arguments:
 * * given_candidates - The antag_candidates list or equivalent of the datum instantiating this one.
 * * revised_restricted - The restricted_jobs list or equivalent of the datum instantiating this one.
 */
/datum/gang_handler/New(list/given_candidates, list/revised_restricted)
	antag_candidates = given_candidates
	restricted_jobs = revised_restricted

/**
 * pre_setup() or pre_execute() equivalent.
 *
 * This proc is always called externally, by the instantiating game_mode / dynamic_ruleset.
 * This is done during the pre_setup() or pre_execute() phase, after first instantiation
 * and the modification of gangs_to_generate, gang_balance_cap, and midround_ruleset.
 * It is intended to take the place of the code that would normally occupy the pre_setup()
 * or pre_execute() proc, were the code localized to the game_mode or dynamic_ruleset datum respectively
 * as opposed to this handler. As such, it picks players to be chosen for starting familiy members
 * or undercover cops prior to assignment to jobs. Sets start_time, default end_time,
 * and the current value of deaths_during_shift, to ensure the wanted level only cares about
 * the deaths since this proc has been called.
 * Takes no arguments.
 */
/datum/gang_handler/proc/pre_setup_analogue()
	if(!GLOB.families_override_theme)
		var/theme_to_use = pick(subtypesof(/datum/gang_theme))
		current_theme = new theme_to_use
	else
		current_theme = new GLOB.families_override_theme
	message_admins("Families has chosen the theme: [current_theme.name]")
	log_game("FAMILIES: The following theme has been chosen: [current_theme.name]")
	var/gangsters_to_make = length(current_theme.involved_gangs) * current_theme.starting_gangsters
	for(var/i in 1 to gangsters_to_make)
		if (!antag_candidates.len)
			break
		var/taken = pick_n_take(antag_candidates) // original used antag_pick, but that's local to game_mode and rulesets use pick_n_take so this is fine maybe
		var/datum/mind/gangbanger
		if(istype(taken, /mob))
			var/mob/T = taken
			gangbanger = T.mind
		else
			gangbanger = taken
		gangbangers += gangbanger
		gangbanger.restricted_roles = restricted_jobs
		log_game("[key_name(gangbanger)] has been selected as a starting gangster!")
		if(!midround_ruleset)
			GLOB.pre_setup_antags += gangbanger
	deaths_during_shift_at_beginning = GLOB.deaths_during_shift // don't want to mix up pre-families and post-families deaths
	start_time = world.time
	end_time = start_time + ((60 MINUTES) / (midround_ruleset ? 2 : 1)) // midround families rounds end quicker
	return TRUE

/**
 * post_setup() or execute() equivalent.
 *
 * This proc is always called externally, by the instantiating game_mode / dynamic_ruleset.
 * This is done during the post_setup() or execute() phase, after the pre_setup() / pre_execute() phase.
 * It is intended to take the place of the code that would normally occupy the pre_setup()
 * or pre_execute() proc. As such, it ensures that all prospective starting family members /
 * undercover cops are eligible, and picks replacements if there were ineligible cops / family members.
 * It then assigns gear to the finalized family members and undercover cops, adding them to its lists,
 * and sets the families announcement proc (that does the announcing) to trigger in five minutes.
 * Additionally, if given the argument TRUE, it will return FALSE if there are no eligible starting family members.
 * This is only to be done if the instantiating datum is a dynamic_ruleset, as these require returns
 * while a game_mode is not expected to return early during this phase.
 * Arguments:
 * * return_if_no_gangs - Boolean that determines if the proc should return FALSE should it find no eligible family members. Should be used for dynamic only.
 */
/datum/gang_handler/proc/post_setup_analogue(return_if_no_gangs = FALSE)
	var/list/gangs_to_use = current_theme.involved_gangs
	var/amount_of_gangs = gangs_to_use.len
	var/amount_of_gangsters = amount_of_gangs * current_theme.starting_gangsters
	for(var/_ in 1 to amount_of_gangsters)
		if(!gangbangers.len) // We ran out of candidates!
			break
		if(!gangs_to_use.len)
			gangs_to_use = current_theme.involved_gangs
		var/gang_to_use = pick_n_take(gangs_to_use) // Evenly distributes Leaders among the gangs
		var/datum/mind/gangster_mind = pick_n_take(gangbangers)
		var/datum/antagonist/gang/new_gangster = new gang_to_use()
		new_gangster.handler = src
		new_gangster.starter_gangster = TRUE
		gangster_mind.add_antag_datum(new_gangster)


		// see /datum/antagonist/gang/create_team() for how the gang team datum gets instantiated and added to our gangs list

	addtimer(CALLBACK(src, .proc/announce_gang_locations), 5 MINUTES)
	return TRUE

/**
 * process() or rule_process() equivalent.
 *
 * This proc is always called externally, by the instantiating game_mode / dynamic_ruleset.
 * This is done during the process() or rule_process() phase, after post_setup() or
 * execute() and at regular intervals thereafter. process() and rule_process() are optional
 * for a game_mode / dynamic_ruleset, but are important for this gamemode. It is of central
 * importance to the gamemode's flow, calculating wanted level updates, family point gain,
 * and announcing + executing the arrival of the space cops, achieved through calling internal procs.
 * Takes no arguments.
 */
/datum/gang_handler/proc/process_analogue()

/**
 * set_round_result() or round_result() equivalent.
 *
 * This proc is always called externally, by the instantiating game_mode / dynamic_ruleset.
 * This is done by the set_round_result() or round_result() procs, at roundend.
 * Sets the ticker subsystem to the correct result based off of the relative populations
 * of space cops and family members.
 * Takes no arguments.
 */
/datum/gang_handler/proc/set_round_result_analogue()
	SSticker.mode_result = "win - gangs survived"
	SSticker.news_report = GANG_OPERATING
	return TRUE

/// Internal. Announces the presence of families to the entire station and sets sent_announcement to true to allow other checks to occur.
/datum/gang_handler/proc/announce_gang_locations()
	priority_announce(current_theme.description, current_theme.name, 'sound/voice/beepsky/radio.ogg')
	sent_announcement = TRUE

/// Internal. Checks if our wanted level has changed; calls update_wanted_level. Only updates wanted level post the initial announcement and until the cops show up. After that, it's locked.
/datum/gang_handler/proc/check_wanted_level()
	if(cops_arrived)
		update_wanted_level(wanted_level) // at this point, we still want to update people's star huds, even though they're mostly locked, because not everyone is around for the last update before the rest of this proc gets shut off forever, and that's when the wanted bar switches from gold stars to red / blue to signify the arrival of the space cops
		return
	if(!sent_announcement)
		return
	var/new_wanted_level
	if(GLOB.joined_player_list.len > LOWPOP_FAMILIES_COUNT)
		switch(GLOB.deaths_during_shift - deaths_during_shift_at_beginning) // if this is a midround ruleset, we only care about the deaths since the families were activated, not since shiftstart
			if(0 to TWO_STARS_HIGHPOP-1)
				new_wanted_level = 1
			if(TWO_STARS_HIGHPOP to THREE_STARS_HIGHPOP-1)
				new_wanted_level = 2
			if(THREE_STARS_HIGHPOP to FOUR_STARS_HIGHPOP-1)
				new_wanted_level = 3
			if(FOUR_STARS_HIGHPOP to FIVE_STARS_HIGHPOP-1)
				new_wanted_level = 4
			if(FIVE_STARS_HIGHPOP to INFINITY)
				new_wanted_level = 5
	else
		switch(GLOB.deaths_during_shift - deaths_during_shift_at_beginning)
			if(0 to TWO_STARS_LOW-1)
				new_wanted_level = 1
			if(TWO_STARS_LOW to THREE_STARS_LOW-1)
				new_wanted_level = 2
			if(THREE_STARS_LOW to FOUR_STARS_LOW-1)
				new_wanted_level = 3
			if(FOUR_STARS_LOW to FIVE_STARS_LOW-1)
				new_wanted_level = 4
			if(FIVE_STARS_LOW to INFINITY)
				new_wanted_level = 5
	update_wanted_level(new_wanted_level)

/// Internal. Updates the icon states for everyone, and calls procs that send out announcements / change the end_time if the wanted level has changed.
/datum/gang_handler/proc/update_wanted_level(newlevel)
	if(newlevel > wanted_level)
		on_gain_wanted_level(newlevel)
	else if (newlevel < wanted_level)
		on_lower_wanted_level(newlevel)
	wanted_level = newlevel
	for(var/i in GLOB.player_list)
		var/mob/M = i
		if(!M.hud_used?.wanted_lvl)
			continue
		var/datum/hud/H = M.hud_used
		H.wanted_lvl.level = newlevel
		H.wanted_lvl.cops_arrived = cops_arrived
		H.wanted_lvl.update_appearance()

/// Internal. Updates the end_time and sends out an announcement if the wanted level has increased. Called by update_wanted_level().
/datum/gang_handler/proc/on_gain_wanted_level(newlevel)
	var/announcement_message
	switch(newlevel)
		if(2)
			if(!sent_second_announcement) // when you hear that they're "arriving in 5 minutes," that's a goddamn guarantee
				end_time = start_time + ((50 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "Small amount of police vehicles have been spotted en route towards [station_name()]."
		if(3)
			if(!sent_second_announcement)
				end_time = start_time + ((40 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "A large detachment police vehicles have been spotted en route towards [station_name()]."
		if(4)
			if(!sent_second_announcement)
				end_time = start_time + ((35 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "A detachment of top-trained agents has been spotted on their way to [station_name()]."
		if(5)
			if(!sent_second_announcement)
				end_time = start_time + ((30 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "The fleet enroute to [station_name()] now consists of national guard personnel."
	if(!midround_ruleset) // stops midround rulesets from announcing janky ass times
		announcement_message += "  They will arrive at the [(end_time - start_time) / (1 MINUTES)] minute mark."
	if(newlevel == 1) // specific exception to stop the announcement from triggering right after the families themselves are announced because aesthetics
		return
	priority_announce(announcement_message, "Station Spaceship Detection Systems")

/// Internal. Updates the end_time and sends out an announcement if the wanted level has decreased. Called by update_wanted_level().
/datum/gang_handler/proc/on_lower_wanted_level(newlevel)
	var/announcement_message
	switch(newlevel)
		if(1)
			if(!sent_second_announcement)
				end_time = start_time + ((60 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "There are now only a few police vehicle headed towards [station_name()]."
		if(2)
			if(!sent_second_announcement)
				end_time = start_time + ((50 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "There seem to be fewer police vehicles headed towards [station_name()]."
		if(3)
			if(!sent_second_announcement)
				end_time = start_time + ((40 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "There are no longer top-trained agents in the fleet headed towards [station_name()]."
		if(4)
			if(!sent_second_announcement)
				end_time = start_time + ((35 MINUTES) / (use_dynamic_timing ? 2 : 1))
			announcement_message = "The convoy enroute to [station_name()] seems to no longer consist of national guard personnel."
	if(!midround_ruleset)
		announcement_message += "  They will arrive at the [(end_time - start_time) / (1 MINUTES)] minute mark."
	priority_announce(announcement_message, "Station Spaceship Detection Systems")
