/* Note from Carnie:
		The way datum/mind stuff works has been changed a lot.
		Minds now represent IC characters rather than following a client around constantly.

	Guidelines for using minds properly:

	- Never mind.transfer_to(ghost). The var/current and var/original of a mind must always be of type mob/living!
		ghost.mind is however used as a reference to the ghost's corpse

	- When creating a new mob for an existing IC character (e.g. cloning a dead guy or borging a brain of a human)
		the existing mind of the old mob should be transfered to the new mob like so:

			mind.transfer_to(new_mob)

	- You must not assign key= or ckey= after transfer_to() since the transfer_to transfers the client for you.
		By setting key or ckey explicitly after transferring the mind with transfer_to you will cause bugs like DCing
		the player.

	- IMPORTANT NOTE 2, if you want a player to become a ghost, use mob.ghostize() It does all the hard work for you.

	- When creating a new mob which will be a new IC character (e.g. putting a shade in a construct or randomly selecting
		a ghost to become a xeno during an event). Simply assign the key or ckey like you've always done.

			new_mob.key = key

		The Login proc will handle making a new mind for that mobtype (including setting up stuff like mind.name). Simple!
		However if you want that mind to have any special properties like being a traitor etc you will have to do that
		yourself.

*/

/datum/mind
	/// Key of the mob
	var/key
	/// The name linked to this mind
	var/name
	/// replaces name for observers name if set
	var/ghostname
	/// Current mob this mind datum is attached to
	var/mob/living/current
	/// Is this mind active?
	var/active = FALSE

	/// a list of /datum/memories. assoc type of memory = memory datum. only one type of memory will be stored, new ones of the same type overriding the last.
	var/list/memories = list()
	/// reference to the memory panel tgui
	var/datum/memory_panel/memory_panel

	/// Job datum indicating the mind's role. This should always exist after initialization, as a reference to a singleton.
	var/datum/job/assigned_role
	var/special_role
	var/list/restricted_roles = list()

	/// Martial art on this mind
	var/datum/martial_art/martial_art
	var/static/default_martial_art = new/datum/martial_art
	/// Mime's vow of silence
	var/miming = FALSE
	/// List of antag datums on this mind
	var/list/antag_datums
	/// this mind's ANTAG_HUD should have this icon_state
	var/antag_hud_icon_state = null
	///this mind's antag HUD
	var/datum/atom_hud/alternate_appearance/basic/antagonist_hud/antag_hud = null
	var/holy_role = NONE //is this person a chaplain or admin role allowed to use bibles, Any rank besides 'NONE' allows for this.

	///If this mind's master is another mob (i.e. adamantine golems)
	var/mob/living/enslaved_to
	var/datum/language_holder/language_holder
	var/unconvertable = FALSE
	var/late_joiner = FALSE
	/// has this mind ever been an AI
	var/has_ever_been_ai = FALSE
	var/last_death = 0

	/// Set by Into The Sunset command of the shuttle manipulator
	var/force_escaped = FALSE

	var/list/learned_recipes //List of learned recipe TYPES.

	///List of skills the user has received a reward for. Should not be used to keep track of currently known skills. Lazy list because it shouldnt be filled often
	var/list/skills_rewarded
	///Assoc list of skills. Use SKILL_LVL to access level, and SKILL_EXP to access skill's exp.
	var/list/known_skills = list()
	///Weakref to thecharacter we joined in as- either at roundstart or latejoin, so we know for persistent scars if we ended as the same person or not
	var/datum/weakref/original_character
	/// The index for what character slot, if any, we were loaded from, so we can track persistent scars on a per-character basis. Each character slot gets PERSISTENT_SCAR_SLOTS scar slots
	var/original_character_slot_index
	/// The index for our current scar slot, so we don't have to constantly check the savefile (unlike the slots themselves, this index is independent of selected char slot, and increments whenever a valid char is joined with)
	var/current_scar_slot_index

	///Skill multiplier, adjusts how much xp you get/loose from adjust_xp. Dont override it directly, add your reason to experience_multiplier_reasons and use that as a key to put your value in there.
	var/experience_multiplier = 1
	///Skill multiplier list, just slap your multiplier change onto this with the type it is coming from as key.
	var/list/experience_multiplier_reasons = list()

	/// A lazy list of statuses to add next to this mind in the traitor panel
	var/list/special_statuses

	///Assoc list of addiction values, key is the type of withdrawal (as singleton type), and the value is the amount of addiction points (as number)
	var/list/addiction_points
	///Assoc list of key active addictions and value amount of cycles that it has been active.
	var/list/active_addictions
	///List of objective-specific equipment that couldn't properly be given to the mind
	var/list/failed_special_equipment
	/// A list to keep track of which books a person has read (to prevent people from reading the same book again and again for positive mood events)
	var/list/book_titles_read

/datum/mind/New(_key)
	key = _key
	martial_art = default_martial_art
	init_known_skills()
	set_assigned_role(SSjob.GetJobType(/datum/job/unassigned)) // Unassigned by default.

/datum/mind/Destroy()
	SSticker.minds -= src
	QDEL_NULL(antag_hud)
	QDEL_LIST(memories)
	QDEL_NULL(memory_panel)
	QDEL_LIST(antag_datums)
	QDEL_NULL(language_holder)
	set_current(null)
	return ..()


/datum/mind/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, assigned_role))
			set_assigned_role(var_value)
			. = TRUE
	if(!isnull(.))
		datum_flags |= DF_VAR_EDITED
		return
	return ..()


/datum/mind/proc/set_current(mob/new_current)
	if(new_current && QDELETED(new_current))
		CRASH("Tried to set a mind's current var to a qdeleted mob, what the fuck")
	if(current)
		UnregisterSignal(src, COMSIG_PARENT_QDELETING)
	current = new_current
	if(current)
		RegisterSignal(src, COMSIG_PARENT_QDELETING, .proc/clear_current)

/datum/mind/proc/clear_current(datum/source)
	SIGNAL_HANDLER
	set_current(null)

/datum/mind/proc/get_language_holder()
	if(!language_holder)
		language_holder = new (src)
	return language_holder

/datum/mind/proc/transfer_to(mob/new_character, force_key_move = 0)
	set_original_character(null)
	if(current) // remove ourself from our old body's mind variable
		current.mind = null
		UnregisterSignal(current, COMSIG_LIVING_DEATH)
		SStgui.on_transfer(current, new_character)

	if(key)
		if(new_character.key != key) //if we're transferring into a body with a key associated which is not ours
			new_character.ghostize(1) //we'll need to ghostize so that key isn't mobless.
	else
		key = new_character.key

	if(new_character.mind) //disassociate any mind currently in our new body's mind variable
		new_character.mind.set_current(null)

	var/mob/living/old_current = current
	if(current)
		current.transfer_observers_to(new_character) //transfer anyone observing the old character to the new one
	set_current(new_character) //associate ourself with our new body
	QDEL_NULL(antag_hud)
	new_character.mind = src //and associate our new body with ourself
	antag_hud = new_character.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/antagonist_hud, "combo_hud", src)
	for(var/a in antag_datums) //Makes sure all antag datums effects are applied in the new body
		var/datum/antagonist/A = a
		A.on_body_transfer(old_current, current)
	if(iscarbon(new_character))
		var/mob/living/carbon/C = new_character
		C.last_mind = src
	transfer_martial_arts(new_character)
	RegisterSignal(new_character, COMSIG_LIVING_DEATH, .proc/set_death_time)
	if(active || force_key_move)
		new_character.key = key //now transfer the key to link the client to our new body
	if(new_character.client)
		LAZYCLEARLIST(new_character.client.recent_examines)
		new_character.client.init_verbs() // re-initialize character specific verbs
	current.update_atom_languages()
	SEND_SIGNAL(src, COMSIG_MIND_TRANSFERRED, old_current)
	SEND_SIGNAL(current, COMSIG_MOB_MIND_TRANSFERRED_INTO)

//I cannot trust you fucks to do this properly
/datum/mind/proc/set_original_character(new_original_character)
	original_character = WEAKREF(new_original_character)

/datum/mind/proc/set_death_time()
	SIGNAL_HANDLER

	last_death = world.time

/datum/mind/Topic(href, href_list)
	if(!check_rights(R_ADMIN))
		return

	var/self_antagging = usr == current

	if(href_list["add_antag"])
		add_antag_wrapper(text2path(href_list["add_antag"]),usr)

	if(href_list["remove_antag"])
		var/datum/antagonist/A = locate(href_list["remove_antag"]) in antag_datums
		if(!istype(A))
			to_chat(usr,span_warning("Invalid antagonist ref to be removed."))
			return
		A.admin_remove(usr)

	if(href_list["open_antag_vv"])
		var/datum/antagonist/to_vv = locate(href_list["open_antag_vv"]) in antag_datums
		if(!istype(to_vv))
			to_chat(usr, span_warning("Invalid antagonist ref to be vv'd."))
			return
		usr.client?.debug_variables(to_vv)

	if (href_list["role_edit"])
		var/new_role = input("Select new role", "Assigned role", assigned_role.title) as null|anything in sort_list(SSjob.name_occupations)
		if(isnull(new_role))
			return
		var/datum/job/new_job = SSjob.GetJob(new_role)
		if (!new_job)
			to_chat(usr, span_warning("Job not found."))
			return
		set_assigned_role(new_job)

	else if (href_list["obj_edit"] || href_list["obj_add"])
		var/objective_pos //Edited objectives need to keep same order in antag objective list
		var/def_value
		var/datum/antagonist/target_antag
		var/datum/objective/old_objective //The old objective we're replacing/editing
		var/datum/objective/new_objective //New objective we're be adding

		if(href_list["obj_edit"])
			for(var/datum/antagonist/A in antag_datums)
				old_objective = locate(href_list["obj_edit"]) in A.objectives
				if(old_objective)
					target_antag = A
					objective_pos = A.objectives.Find(old_objective)
					break
			if(!old_objective)
				to_chat(usr,"Invalid objective.")
				return
		else
			if(href_list["target_antag"])
				var/datum/antagonist/X = locate(href_list["target_antag"]) in antag_datums
				if(X)
					target_antag = X
			if(!target_antag)
				switch(antag_datums.len)
					if(0)
						target_antag = add_antag_datum(/datum/antagonist/custom)
					if(1)
						target_antag = antag_datums[1]
					else
						var/datum/antagonist/target = input("Which antagonist gets the objective:", "Antagonist", "(new custom antag)") as null|anything in sort_list(antag_datums) + "(new custom antag)"
						if (QDELETED(target))
							return
						else if(target == "(new custom antag)")
							target_antag = add_antag_datum(/datum/antagonist/custom)
						else
							target_antag = target

		if(!GLOB.admin_objective_list)
			generate_admin_objective_list()

		if(old_objective)
			if(old_objective.name in GLOB.admin_objective_list)
				def_value = old_objective.name

		var/selected_type = input("Select objective type:", "Objective type", def_value) as null|anything in GLOB.admin_objective_list
		selected_type = GLOB.admin_objective_list[selected_type]
		if (!selected_type)
			return

		if(!old_objective)
			//Add new one
			new_objective = new selected_type
			new_objective.owner = src
			new_objective.admin_edit(usr)
			target_antag.objectives += new_objective
			message_admins("[key_name_admin(usr)] added a new objective for [current]: [new_objective.explanation_text]")
			log_admin("[key_name(usr)] added a new objective for [current]: [new_objective.explanation_text]")
		else
			if(old_objective.type == selected_type)
				//Edit the old
				old_objective.admin_edit(usr)
				new_objective = old_objective
			else
				//Replace the old
				new_objective = new selected_type
				new_objective.owner = src
				new_objective.admin_edit(usr)
				target_antag.objectives -= old_objective
				target_antag.objectives.Insert(objective_pos, new_objective)
			message_admins("[key_name_admin(usr)] edited [current]'s objective to [new_objective.explanation_text]")
			log_admin("[key_name(usr)] edited [current]'s objective to [new_objective.explanation_text]")

	else if (href_list["obj_delete"])
		var/datum/objective/objective
		for(var/datum/antagonist/A in antag_datums)
			objective = locate(href_list["obj_delete"]) in A.objectives
			if(istype(objective))
				A.objectives -= objective
				break
		if(!objective)
			to_chat(usr,"Invalid objective.")
			return
		//qdel(objective) Needs cleaning objective destroys
		message_admins("[key_name_admin(usr)] removed an objective for [current]: [objective.explanation_text]")
		log_admin("[key_name(usr)] removed an objective for [current]: [objective.explanation_text]")

	else if(href_list["obj_completed"])
		var/datum/objective/objective
		for(var/datum/antagonist/A in antag_datums)
			objective = locate(href_list["obj_completed"]) in A.objectives
			if(istype(objective))
				objective = objective
				break
		if(!objective)
			to_chat(usr,"Invalid objective.")
			return
		objective.completed = !objective.completed
		log_admin("[key_name(usr)] toggled the win state for [current]'s objective: [objective.explanation_text]")

	else if (href_list["silicon"])
		switch(href_list["silicon"])
			if("unemag")
				var/mob/living/silicon/robot/R = current
				if (istype(R))
					R.SetEmagged(0)
					message_admins("[key_name_admin(usr)] has unemag'ed [R].")
					log_admin("[key_name(usr)] has unemag'ed [R].")

			if("unemagcyborgs")
				if(isAI(current))
					var/mob/living/silicon/ai/ai = current
					for (var/mob/living/silicon/robot/R in ai.connected_robots)
						R.SetEmagged(0)
					message_admins("[key_name_admin(usr)] has unemag'ed [ai]'s Cyborgs.")
					log_admin("[key_name(usr)] has unemag'ed [ai]'s Cyborgs.")

	else if(href_list["edit_obj_tc"])
		var/datum/traitor_objective/objective = locate(href_list["edit_obj_tc"])
		if(!istype(objective))
			return
		var/telecrystal = input("Set new telecrystal reward for [objective.name]","Syndicate uplink", objective.telecrystal_reward) as null | num
		if(isnull(telecrystal))
			return
		objective.telecrystal_reward = telecrystal
		message_admins("[key_name_admin(usr)] changed [objective]'s telecrystal reward count to [telecrystal].")
		log_admin("[key_name(usr)] changed [objective]'s telecrystal reward count to [telecrystal].")
	else if(href_list["edit_obj_pr"])
		var/datum/traitor_objective/objective = locate(href_list["edit_obj_pr"])
		if(!istype(objective))
			return
		var/progression = input("Set new progression reward for [objective.name]","Syndicate uplink", objective.progression_reward) as null | num
		if(isnull(progression))
			return
		objective.progression_reward = progression
		message_admins("[key_name_admin(usr)] changed [objective]'s progression reward count to [progression].")
		log_admin("[key_name(usr)] changed [objective]'s progression reward count to [progression].")
	else if(href_list["fail_objective"])
		var/datum/traitor_objective/objective = locate(href_list["fail_objective"])
		if(!istype(objective))
			return
		var/performed = objective.objective_state == OBJECTIVE_STATE_INACTIVE? "skipped" : "failed"
		message_admins("[key_name_admin(usr)] forcefully [performed] [objective].")
		log_admin("[key_name(usr)] forcefully [performed] [objective].")
		objective.fail_objective()
	else if(href_list["succeed_objective"])
		var/datum/traitor_objective/objective = locate(href_list["succeed_objective"])
		if(!istype(objective))
			return
		message_admins("[key_name_admin(usr)] forcefully succeeded [objective].")
		log_admin("[key_name(usr)] forcefully succeeded [objective].")
		objective.succeed_objective()
	else if (href_list["common"])
		switch(href_list["common"])
			if("undress")
				for(var/obj/item/W in current)
					current.dropItemToGround(W, TRUE) //The TRUE forces all items to drop, since this is an admin undress.
			if("takeuplink")
				take_uplink()
				wipe_memory()//Remove any memory they may have had.
				log_admin("[key_name(usr)] removed [current]'s uplink.")
			if("crystals")
				if(check_rights(R_FUN))
					var/datum/component/uplink/U = find_syndicate_uplink()
					if(U)
						var/crystals = input("Amount of telecrystals for [key]","Syndicate uplink", U.uplink_handler.telecrystals) as null | num
						if(!isnull(crystals))
							U.uplink_handler.telecrystals = crystals
							message_admins("[key_name_admin(usr)] changed [current]'s telecrystal count to [crystals].")
							log_admin("[key_name(usr)] changed [current]'s telecrystal count to [crystals].")
			if("progression")
				if(!check_rights(R_FUN))
					return
				var/datum/component/uplink/uplink = find_syndicate_uplink()
				if(!uplink)
					return
				var/progression = input("Set new progression points for [key]","Syndicate uplink", uplink.uplink_handler.progression_points) as null | num
				if(isnull(progression))
					return
				uplink.uplink_handler.progression_points = progression
				message_admins("[key_name_admin(usr)] changed [current]'s progression point count to [progression].")
				log_admin("[key_name(usr)] changed [current]'s progression point count to [progression].")
				uplink.uplink_handler.update_objectives()
				uplink.uplink_handler.generate_objectives()
			if("give_objective")
				if(!check_rights(R_FUN))
					return
				var/datum/component/uplink/uplink = find_syndicate_uplink()
				if(!uplink || !uplink.uplink_handler)
					return
				var/list/all_objectives = subtypesof(/datum/traitor_objective)
				var/objective_typepath = tgui_input_list(usr, "Select objective", "Select objective", all_objectives)
				if(!objective_typepath)
					return
				var/datum/traitor_objective/objective = uplink.uplink_handler.try_add_objective(objective_typepath, force = TRUE)
				if(objective)
					message_admins("[key_name_admin(usr)] gave [current] a traitor objective ([objective_typepath]).")
					log_admin("[key_name(usr)] gave [current] a traitor objective ([objective_typepath]).")
				else
					to_chat(usr, span_warning("Failed to generate the objective!"))
					message_admins("[key_name_admin(usr)] failed to give [current] a traitor objective ([objective_typepath]).")
					log_admin("[key_name(usr)] failed to give [current] a traitor objective ([objective_typepath]).")
			if("uplink")
				var/datum/antagonist/traitor/traitor_datum = has_antag_datum(/datum/antagonist/traitor)
				if(!give_uplink(antag_datum = traitor_datum || null))
					to_chat(usr, span_danger("Equipping a syndicate failed!"))
					log_admin("[key_name(usr)] tried and failed to give [current] an uplink.")
				else
					log_admin("[key_name(usr)] gave [current] an uplink.")
			//SKYRAT EDIT ADDITION BEGIN -- EXPLOITABLES
			if("toggle_exploitables")
				has_exploitables_override = !has_exploitables_override //First we set the override to be the opposite of whatever it was apon execution, then we
				handle_exploitables() // use ternaries to convert this into true/false for admin logs.
				log_admin("[key_name(usr)] toggled [current]'s exploitables override to [(has_exploitables_override) ? "true" : "false"].")
				message_admins("[key_name(usr)] toggled [current]'s exploitables override to [(has_exploitables_override) ? "true" : "false"].")
			//SKYRAT EDIT ADDITION END

	else if (href_list["obj_announce"])
		announce_objectives()

	//Something in here might have changed your mob
	if(self_antagging && (!usr || !usr.client) && current.client)
		usr = current
	traitor_panel()

/datum/mind/proc/transfer_martial_arts(mob/living/new_character)
	if(!ishuman(new_character))
		return
	if(martial_art)
		if(martial_art.base) //Is the martial art temporary?
			martial_art.remove(new_character)
		else
			martial_art.teach(new_character)

/datum/mind/proc/has_martialart(string)
	if(martial_art && martial_art.id == string)
		return martial_art
	return FALSE

/datum/mind/proc/get_ghost(even_if_they_cant_reenter, ghosts_with_clients)
	for(var/mob/dead/observer/G in (ghosts_with_clients ? GLOB.player_list : GLOB.dead_mob_list))
		if(G.mind == src)
			if(G.can_reenter_corpse || even_if_they_cant_reenter)
				return G
			break

/datum/mind/proc/grab_ghost(force)
	var/mob/dead/observer/G = get_ghost(even_if_they_cant_reenter = force)
	. = G
	if(G)
		G.reenter_corpse()

///Adds addiction points to the specified addiction
/datum/mind/proc/add_addiction_points(type, amount)
	LAZYSET(addiction_points, type, min(LAZYACCESS(addiction_points, type) + amount, MAX_ADDICTION_POINTS))
	var/datum/addiction/affected_addiction = SSaddiction.all_addictions[type]
	return affected_addiction.on_gain_addiction_points(src)

///Adds addiction points to the specified addiction
/datum/mind/proc/remove_addiction_points(type, amount)
	LAZYSET(addiction_points, type, max(LAZYACCESS(addiction_points, type) - amount, 0))
	var/datum/addiction/affected_addiction = SSaddiction.all_addictions[type]
	return affected_addiction.on_lose_addiction_points(src)


/// Setter for the assigned_role job datum.
/datum/mind/proc/set_assigned_role(datum/job/new_role)
	if(assigned_role == new_role)
		return
	if(!is_job(new_role))
		CRASH("set_assigned_role called with invalid role: [isnull(new_role) ? "null" : new_role]")
	. = assigned_role
	assigned_role = new_role


/mob/proc/sync_mind()
	mind_initialize() //updates the mind (or creates and initializes one if one doesn't exist)
	mind.active = TRUE //indicates that the mind is currently synced with a client

/mob/dead/new_player/sync_mind()
	return

/mob/dead/observer/sync_mind()
	return
