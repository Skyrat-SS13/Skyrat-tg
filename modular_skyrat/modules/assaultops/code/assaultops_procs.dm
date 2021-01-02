//These are sort of shitcode right now

/proc/check_assaultops_target(mob/user) //Should only be passed mobs
	if(!istype(user))
		stack_trace("Check assaultops target was passed an incorrect type.")
		return FALSE
	if(isnull(user))
		stack_trace("Check assaultops target was passed a null value.")
		return FALSE
	if(isnull(user.mind))
		stack_trace("Check assaultops target was given a mob without a mind: [user]")
		return FALSE
	if(!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/H = user
	if(H.job == "Captain" || H.job == "Head of Personnel" || H.job == "Quartermaster" || H.job == "Head of Security" || H.job == "Chief Engineer" || H.job == "Research Director" || H.job == "Blueshield" || H.job == "Security Officer" || H.job == "Warden" || H.job == "Detective")
		return TRUE
	return FALSE

/proc/add_assaultops_target(mob/user, notify=TRUE, notify_target=FALSE, override=FALSE)
	if(!override)
		if(GLOB.assaultops_targets.len >= MAX_ASSAULTOPS_TARGETS)
			return FALSE

	if(isnull(user.mind))
		stack_trace("Critical error, add assaultops target was given a user with no mind, this should never happen.")
		return FALSE

	GLOB.assaultops_targets.Add(user.mind)

	if(notify)
		send_to_assaultops_watch("<span class='redtext'>Newly assigned target: [user] - [user.mind.assigned_role], capture them!</span>")
	if(notify_target)
		to_chat(user, "<span class='danger'>An intense feeling of dread washes over you!</span>")

	forge_assaultops_targets()

	return TRUE

/proc/remove_assaultops_target(datum/mind/M, notify=TRUE, original=FALSE)
	GLOB.assaultops_targets.Remove(M)

	if(notify)
		send_to_assaultops_watch("<span class='greentext'>[original ? M.original_character : M.current] has been removed from your targets list! You no longer need to care about them!</span>")
		to_chat(M.current, "<span class='notice'>You feel at ease.</span>")

	forge_assaultops_targets()

/proc/forge_assaultops_targets()
	var/datum/team/assaultops/team = get_assaultops_team()
	for(var/i in team.members)
		var/datum/mind/M = i
		var/datum/antagonist/assaultops/assops = M.has_antag_datum(/datum/antagonist/assaultops)
		assops.memorise_kills()

/proc/send_to_assaultops_watch(message, buzz=TRUE)
	if(!SSticker.mode.name == "assaultops")
		return
	if(!message)
		return FALSE

	var/datum/team/assaultops/team = get_assaultops_team()

	for(var/i in team.members)
		var/datum/mind/M = i
		to_chat(M.current, "<span class='notice'>Your watch SyndIwatch buzzes!</span>")
		to_chat(M.current, message)
		if(buzz)
			M.current.playsound_local(get_turf(M.current), 'sound/machines/triple_beep.ogg', 100, 0, use_reverb = FALSE)
	return TRUE

/proc/sanity_check_assaultops_targets()
	for(var/i in GLOB.assaultops_targets)
		if(isnull(i))
			GLOB.assaultops_targets.Remove(i)
			message_admins("Warning, null detected in antag assault operatives target list and was removed. Contact a maintainer.")
			stack_trace("Null detected in global list assaultops_targets!")
			continue
		if(!istype(i, /datum/mind))
			GLOB.assaultops_targets.Remove(i)
			message_admins("Warning, invalid list datum type in assault operatives target list and was removed. Contact a maintainer.")
			stack_trace("Invalid type detected in global list assaultops_targets!")
			continue

		var/datum/mind/M = i

		if(!check_assaultops_target(M.current))
			if(!check_assaultops_target(M.original_character))
				remove_assaultops_target(M)

/proc/is_assaultops_target(datum/mind/M)
	for(var/i in GLOB.assaultops_targets)
		var/datum/mind/them = i
		if(them == M)
			return TRUE
	return FALSE

/proc/is_assault_operative(mob/user)
	if(!ishuman(user))
		return
	if(!user.mind)
		return
	if(user.mind.has_antag_datum(/datum/antagonist/assaultops))
		return TRUE
	return FALSE

/proc/get_assaultops_team() //Is there an easier way to do this?!!!
	if(!SSticker.mode.name == "assaultops")
		return
	var/datum/game_mode/assaultops/assteam = SSticker.mode
	return assteam.assault_team

/proc/get_assault_loadout(mob/M)
	if(istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/assaultops))
		var/datum/antagonist/assaultops/assops = M.mind.has_antag_datum(/datum/antagonist/assaultops)
		return assops.loadout
