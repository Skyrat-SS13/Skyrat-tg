

/datum/action/bloodsucker/cloak
	name = "Cloak of Darkness"
	desc = "Blend into the shadows and become invisible to the untrained eye. Movement is slowed in brightly lit areas, and you cannot dissapear while mortals watch you."
	button_icon_state = "power_cloak"
	bloodcost = 5
	cooldown = 50
	bloodsucker_can_buy = TRUE
	amToggle = TRUE
	warn_constant_cost = TRUE
	var/moveintent_was_run
	var/runintent
	var/walk_threshold = 0.4 // arbitrary number, to be changed. edit in last commit: this is fine after testing on box station for a bit
	var/lum

/datum/action/bloodsucker/cloak/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	// must have nobody around to see the cloak
	for(var/mob/living/M in fov_viewers(9, owner) - owner)
		to_chat(owner, "<span class='warning'>You may only vanish into the shadows unseen.</span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/cloak/ActivatePower()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	var/mob/living/user = owner

	moveintent_was_run = (user.m_intent == MOVE_INTENT_RUN)

	while(bloodsuckerdatum && ContinueActive(user))
		// Pay Blood Toll (if awake)
		owner.alpha = max(35, owner.alpha - min(75, 10 + 5 * level_current))
		bloodsuckerdatum.AddBloodVolume(-0.2)

		runintent = (user.m_intent == MOVE_INTENT_RUN)
		var/turf/T = get_turf(user)
		lum = T.get_lumcount()

		if(istype(owner.loc))
			if(lum > walk_threshold)
				if(runintent)
					user.toggle_move_intent()
					ADD_TRAIT(user, TRAIT_NORUNNING, "cloak of darkness")

			if(lum < walk_threshold)
				if(!runintent)
					user.toggle_move_intent()
					REMOVE_TRAIT(user, TRAIT_NORUNNING, "cloak of darkness")

		sleep(5) // Check every few ticks

/datum/action/bloodsucker/cloak/ContinueActive(mob/living/user, mob/living/target)
	if (!..())
		return FALSE
	if(user.stat == !CONSCIOUS) // Must be CONSCIOUS
		to_chat(owner, "<span class='warning'>Your cloak failed due to you falling unconcious! </span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/cloak/DeactivatePower(mob/living/user = owner, mob/living/target)
	..()
	REMOVE_TRAIT(user, TRAIT_NORUNNING, "cloak of darkness")
	user.alpha = 255

	runintent = (user.m_intent == MOVE_INTENT_RUN)

	if(!runintent && moveintent_was_run)
		user.toggle_move_intent()
