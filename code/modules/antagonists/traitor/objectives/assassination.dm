/datum/traitor_objective_category/assassinate_kidnap
	name = "Assassination/Kidnap"
	objectives = list(
		list(
			/datum/traitor_objective/target_player/assassinate/calling_card = 1,
			/datum/traitor_objective/target_player/assassinate/calling_card/heads_of_staff = 1,
		) = 1,
		list(
			list(
				/datum/traitor_objective/target_player/kidnapping/common = 20,
				/datum/traitor_objective/target_player/kidnapping/common/assistant = 1,
			) = 4,
			/datum/traitor_objective/target_player/kidnapping/uncommon = 3,
			/datum/traitor_objective/target_player/kidnapping/rare = 2,
			/datum/traitor_objective/target_player/kidnapping/captain = 1
		) = 1,
	)

/datum/traitor_objective/target_player/assassinate
	name = "Assassinate %TARGET% the %JOB TITLE%"
	description = "Simply kill your target to accomplish this objective."

	abstract_type = /datum/traitor_objective/target_player/assassinate

	progression_minimum = 30 MINUTES

	/**
	 * Makes the objective only set heads as targets when true, and block them from being targets when false.
	 * This also blocks the objective from generating UNTIL the un-heads_of_staff version (WHICH SHOULD BE A DIRECT PARENT) is completed.
	 * example: calling card objective, you kill someone, you unlock the chance to roll a head of staff target version of calling card.
	 */
	var/heads_of_staff = FALSE

	duplicate_type = /datum/traitor_objective/target_player

/datum/traitor_objective/target_player/assassinate/supported_configuration_changes()
	. = ..()
	. += NAMEOF(src, objective_period)
	. += NAMEOF(src, maximum_objectives_in_period)

/datum/traitor_objective/target_player/assassinate/calling_card
	name = "Assassinate %TARGET% the %JOB TITLE%, and plant a calling card"
	description = "Kill your target and plant a calling card in the pockets of your victim. If your calling card gets destroyed before you are able to plant it, this objective will fail."
	progression_reward = 2 MINUTES
	telecrystal_reward = list(1, 2)

	var/obj/item/paper/calling_card/card

/datum/traitor_objective/target_player/assassinate/calling_card/heads_of_staff
	progression_reward = 4 MINUTES
	telecrystal_reward = list(2, 3)

	heads_of_staff = TRUE

/datum/traitor_objective/target_player/assassinate/calling_card/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(!card)
		buttons += add_ui_button("", "Pressing this will materialize a calling card, which you must plant to succeed.", "paper-plane", "summon_card")
	return buttons

/datum/traitor_objective/target_player/assassinate/calling_card/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if("summon_card")
			if(card)
				return
			card = new(user.drop_location())
			user.put_in_hands(card)
			card.balloon_alert(user, "the card materializes in your hand")
			RegisterSignal(card, COMSIG_ITEM_EQUIPPED, PROC_REF(on_card_planted))
			AddComponent(/datum/component/traitor_objective_register, card, \
				succeed_signals = null, \
				fail_signals = list(COMSIG_QDELETING), \
				penalty = TRUE)

/datum/traitor_objective/target_player/assassinate/calling_card/proc/on_card_planted(datum/source, mob/living/equipper, slot)
	SIGNAL_HANDLER
	if(equipper != target)
		return //your target please
	if(equipper.stat != DEAD)
		return //kill them please
	if(!(slot & (ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET)))
		return //in their pockets please
	succeed_objective()

/datum/traitor_objective/target_player/assassinate/calling_card/ungenerate_objective()
	. = ..() //unsets kill target
	if(card)
		UnregisterSignal(card, COMSIG_ITEM_EQUIPPED)
	card = null

/datum/traitor_objective/target_player/assassinate/calling_card/target_deleted()
	//you cannot plant anything on someone who is gone gone, so even if this happens after you're still liable to fail
	fail_objective(penalty_cost = telecrystal_penalty)

/datum/traitor_objective/target_player/assassinate/New(datum/uplink_handler/handler)
	. = ..()
	AddComponent(/datum/component/traitor_objective_limit_per_time, \
		/datum/traitor_objective/target_player, \
		time_period = objective_period, \
		maximum_objectives = maximum_objectives_in_period \
	)

/datum/traitor_objective/target_player/assassinate/generate_objective(datum/mind/generating_for, list/possible_duplicates)

	var/list/already_targeting = list() //List of minds we're already targeting. The possible_duplicates is a list of objectives, so let's not mix things
	for(var/datum/objective/task as anything in handler.primary_objectives)
		if(!istype(task.target, /datum/mind))
			continue
		already_targeting += task.target //Removing primary objective kill targets from the list

	var/parent_type = type2parent(type)
	//don't roll head of staff types if you haven't completed the normal version
	if(heads_of_staff && !handler.get_completion_count(parent_type))
		// Locked if they don't have any of the risky bug room objective completed
		return FALSE

	var/list/possible_targets = list()
	var/try_target_late_joiners = FALSE
	if(generating_for.late_joiner)
		try_target_late_joiners = TRUE
	for(var/datum/mind/possible_target as anything in get_crewmember_minds())
		if(possible_target in already_targeting)
			continue
		var/target_area = get_area(possible_target.current)
		if(possible_target == generating_for)
			continue
		if(!ishuman(possible_target.current))
			continue
		if(possible_target.current.stat == DEAD)
			continue
		var/datum/antagonist/traitor/traitor = possible_target.has_antag_datum(/datum/antagonist/traitor)
		if(traitor && traitor.uplink_handler.telecrystals >= 0)
			continue
		if(!HAS_TRAIT(SSstation, STATION_TRAIT_LATE_ARRIVALS) && istype(target_area, /area/shuttle/arrival))
			continue
		//removes heads of staff from being targets from non heads of staff assassinations, and vice versa
		if(heads_of_staff)
			if(!(possible_target.assigned_role.job_flags & JOB_HEAD_OF_STAFF))
				continue
		else
			if((possible_target.assigned_role.job_flags & JOB_HEAD_OF_STAFF))
				continue
		possible_targets += possible_target
	for(var/datum/traitor_objective/target_player/objective as anything in possible_duplicates)
		possible_targets -= objective.target
	if(try_target_late_joiners)
		var/list/all_possible_targets = possible_targets.Copy()
		for(var/datum/mind/possible_target as anything in all_possible_targets)
			if(!possible_target.late_joiner)
				possible_targets -= possible_target
		if(!possible_targets.len)
			possible_targets = all_possible_targets
	special_target_filter(possible_targets)
	if(!possible_targets.len)
		return FALSE //MISSION FAILED, WE'LL GET EM NEXT TIME

	var/datum/mind/target_mind = pick(possible_targets)
	set_target(target_mind.current)
	replace_in_name("%TARGET%", target.real_name)
	replace_in_name("%JOB TITLE%", target_mind.assigned_role.title)
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_target_death))
	return TRUE

/datum/traitor_objective/target_player/assassinate/ungenerate_objective()
	UnregisterSignal(target, COMSIG_LIVING_DEATH)
	set_target(null)

///proc for checking for special states that invalidate a target
/datum/traitor_objective/target_player/assassinate/proc/special_target_filter(list/possible_targets)
	return

/datum/traitor_objective/target_player/assassinate/target_deleted()
	if(objective_state == OBJECTIVE_STATE_INACTIVE)
		//don't take an objective target of someone who is already obliterated
		fail_objective()
	return ..()

/datum/traitor_objective/target_player/assassinate/proc/on_target_death()
	SIGNAL_HANDLER
	if(objective_state == OBJECTIVE_STATE_INACTIVE)
		//don't take an objective target of someone who is already dead
		fail_objective()

/obj/item/paper/calling_card
	name = "calling card"
	icon_state = "syndicate_calling_card"
	color = "#ff5050"
	show_written_words = FALSE
	default_raw_text = {"
	<b>**Death to Nanotrasen.**</b><br><br>

	Only through the inviolable cooperation of corporations known as The Syndicate, can Nanotrasen and its autocratic tyrants be silenced.
	The outcries of Nanotrasen's employees are squelched by the suffocating iron grip of their leaders. If you read this, and understand
	why we fight, then you need only to look where Nanotrasen doesn't want you to find us to join our cause. Any number of our companies
	may be fighting with your interests in mind.<br><br>

	<b>SELF:</b> They fight for the protection and freedom of silicon life all across the galaxy.<br><br>

	<b>Tiger Cooperative:</b> They fight for religious freedom and their righteous concoctions.<br><br>

	<b>Waffle Corporation:</b> They fight for the return of healthy corporate competition, snuffed out by Nanotrasen's monopoly.<br><br>

	<b>Animal Rights Consortium:</b> They fight for nature and the right for all biological life to exist.
	"}
