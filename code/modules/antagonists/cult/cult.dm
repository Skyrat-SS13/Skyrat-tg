/datum/antagonist/cult
	name = "Cultist"
	roundend_category = "cultists"
	antagpanel_category = "Cult"
	antag_moodlet = /datum/mood_event/cult
	suicide_cry = "FOR NAR'SIE!!"
	preview_outfit = /datum/outfit/cultist
	job_rank = ROLE_CULTIST
	antag_hud_name = "cult"

	///The vote ability Cultists have to elect someone to be the leader.
	var/datum/action/innate/cult/mastervote/vote_ability = new

	///Boolean on whether the starting equipment should be given to their inventory.
	var/give_equipment = FALSE
	///Reference to the Blood cult team they are part of.
	var/datum/team/cult/cult_team

/datum/antagonist/cult/can_be_owned(datum/mind/new_owner)
	if(!is_convertable_to_cult(new_owner.current, cult_team))
		return FALSE
	return ..()

/datum/antagonist/cult/greet()
	. = ..()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/bloodcult.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)//subject to change
	owner.announce_objectives()

/datum/antagonist/cult/on_gain()
	objectives |= cult_team.objectives
	. = ..()
	var/mob/living/current = owner.current
	if(give_equipment)
		equip_cultist(TRUE)
	current.log_message("has been converted to the cult of Nar'Sie!", LOG_ATTACK, color="#960000")

	if(cult_team.blood_target && cult_team.blood_target_image && current.client)
		current.client.images += cult_team.blood_target_image

	ADD_TRAIT(current, TRAIT_HEALS_FROM_CULT_PYLONS, CULT_TRAIT)

/datum/antagonist/cult/on_removal()
	REMOVE_TRAIT(owner.current, TRAIT_HEALS_FROM_CULT_PYLONS, CULT_TRAIT)
	if(!silent)
		owner.current.visible_message(span_deconversion_message("[owner.current] looks like [owner.current.p_theyve()] just reverted to [owner.current.p_their()] old faith!"), ignored_mobs = owner.current)
		to_chat(owner.current, span_userdanger("An unfamiliar white light flashes through your mind, cleansing the taint of the Geometer and all your memories as her servant."))
		owner.current.log_message("has renounced the cult of Nar'Sie!", LOG_ATTACK, color="#960000")
	if(cult_team.blood_target && cult_team.blood_target_image && owner.current.client)
		owner.current.client.images -= cult_team.blood_target_image

	return ..()

<<<<<<< HEAD
/datum/antagonist/cult/get_preview_icon()
	var/icon/icon = render_preview_outfit(preview_outfit)

	// The longsword is 64x64, but getFlatIcon crunches to 32x32.
	// So I'm just going to add it in post, screw it.

	// Center the dude, because item icon states start from the center.
	// This makes the image 64x64.
	icon.Crop(-15, -15, 48, 48)

	var/obj/item/melee/cultblade/longsword = new
	icon.Blend(icon(longsword.lefthand_file, longsword.inhand_icon_state), ICON_OVERLAY)
	qdel(longsword)

	// Move the guy back to the bottom left, 32x32.
	icon.Crop(17, 17, 48, 48)

	return finish_preview_icon(icon)

/datum/antagonist/cult/proc/equip_cultist(metal=TRUE)
	var/mob/living/carbon/H = owner.current
	if(!istype(H))
		return
	. += cult_give_item(/obj/item/melee/cultblade/dagger, H)
	if(metal)
		. += cult_give_item(/obj/item/stack/sheet/runed_metal/ten, H)
	to_chat(owner, "These will help you start the cult on this station. Use them well, and remember - you are not the only one.</span>")


/datum/antagonist/cult/proc/cult_give_item(obj/item/item_path, mob/living/carbon/human/mob)
	var/list/slots = list(
		"backpack" = ITEM_SLOT_BACKPACK,
		"left pocket" = ITEM_SLOT_LPOCKET,
		"right pocket" = ITEM_SLOT_RPOCKET
	)

	var/T = new item_path(mob)
	var/item_name = initial(item_path.name)
	var/where = mob.equip_in_one_of_slots(T, slots)
	if(!where)
		to_chat(mob, span_userdanger("Unfortunately, you weren't able to get a [item_name]. This is very bad and you should adminhelp immediately (press F1)."))
		return FALSE
	else
		to_chat(mob, span_danger("You have a [item_name] in your [where]."))
		if(where == "backpack")
			mob.back.atom_storage?.show_contents(mob)
		return TRUE

=======
>>>>>>> 32afa856dbb (Makes cult leader handling work off of the Cult datum (#76556))
/datum/antagonist/cult/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current || mob_override
	handle_clown_mutation(current, mob_override ? null : "Your training has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself.")
	current.faction |= FACTION_CULT
	current.grant_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_CULTIST)

	var/datum/action/innate/cult/comm/communion = new
	communion.Grant(current)
	if(isnull(cult_team.cult_leader_datum))
		vote_ability.Grant(current)
	if(ishuman(current))
		var/datum/action/innate/cult/blood_magic/magic = new
		magic.Grant(current)

	current.throw_alert("bloodsense", /atom/movable/screen/alert/bloodsense)
	if(cult_team.cult_risen)
		current.AddElement(/datum/element/cult_eyes, initial_delay = 0 SECONDS)
	if(cult_team.cult_ascendent)
		current.AddElement(/datum/element/cult_halo, initial_delay = 0 SECONDS)

	add_team_hud(current)

/datum/antagonist/cult/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current || mob_override
	handle_clown_mutation(current, removing = FALSE)
	current.faction -= FACTION_CULT
	current.remove_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_CULTIST)

	QDEL_NULL(vote_ability)
	for(var/datum/action/innate/cult/cult_buttons in owner.current.actions)
		qdel(cult_buttons)
	current.update_mob_action_buttons()

	current.clear_alert("bloodsense")
	if (HAS_TRAIT(current, TRAIT_UNNATURAL_RED_GLOWY_EYES))
		current.RemoveElement(/datum/element/cult_eyes)
	if (HAS_TRAIT(current, TRAIT_CULT_HALO))
		current.RemoveElement(/datum/element/cult_halo)

/datum/antagonist/cult/on_mindshield(mob/implanter)
	if(!silent)
		to_chat(owner.current, span_warning("You feel something interfering with your mental conditioning, but you resist it!"))
	return

/datum/antagonist/cult/admin_add(datum/mind/new_owner,mob/admin)
	give_equipment = FALSE
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has cult-ed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has cult-ed [key_name(new_owner)].")

/datum/antagonist/cult/admin_remove(mob/user)
	silent = TRUE
	return ..()

/datum/antagonist/cult/get_admin_commands()
	. = ..()
	.["Dagger"] = CALLBACK(src, PROC_REF(admin_give_dagger))
	.["Dagger and Metal"] = CALLBACK(src, PROC_REF(admin_give_metal))
	.["Remove Dagger and Metal"] = CALLBACK(src, PROC_REF(admin_take_all))

	if(is_cult_leader())
		.["Demote From Leader"] = CALLBACK(src, PROC_REF(demote_from_leader))
	else if(isnull(cult_team.cult_leader_datum))
		.["Make Cult Leader"] = CALLBACK(src, PROC_REF(make_cult_leader))

/datum/antagonist/cult/get_team()
	return cult_team

/datum/antagonist/cult/create_team(datum/team/cult/new_team)
	if(!new_team)
		//todo remove this and allow admin buttons to create more than one cult
		for(var/datum/antagonist/cult/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.cult_team)
				cult_team = H.cult_team
				return
		cult_team = new /datum/team/cult
		cult_team.setup_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	cult_team = new_team

///Equips the cultist with a dagger and runed metal.
/datum/antagonist/cult/proc/equip_cultist(metal = TRUE)
	var/mob/living/carbon/H = owner.current
	if(!istype(H))
		return
	. += cult_give_item(/obj/item/melee/cultblade/dagger, H)
	if(metal)
		. += cult_give_item(/obj/item/stack/sheet/runed_metal/ten, H)
	to_chat(owner, "These will help you start the cult on this station. Use them well, and remember - you are not the only one.</span>")

///Attempts to make a new item and put it in a potential inventory slot in the provided mob.
/datum/antagonist/cult/proc/cult_give_item(obj/item/item_path, mob/living/carbon/human/mob)
	var/list/slots = list(
		"backpack" = ITEM_SLOT_BACKPACK,
		"left pocket" = ITEM_SLOT_LPOCKET,
		"right pocket" = ITEM_SLOT_RPOCKET,
	)

	var/T = new item_path(mob)
	var/item_name = initial(item_path.name)
	var/where = mob.equip_in_one_of_slots(T, slots)
	if(!where)
		to_chat(mob, span_userdanger("Unfortunately, you weren't able to get a [item_name]. This is very bad and you should adminhelp immediately (press F1)."))
		return FALSE
	else
		to_chat(mob, span_danger("You have a [item_name] in your [where]."))
		if(where == "backpack")
			mob.back.atom_storage?.show_contents(mob)
		return TRUE

/datum/antagonist/cult/proc/admin_give_dagger(mob/admin)
	if(!equip_cultist(metal = FALSE))
		to_chat(admin, span_danger("Spawning dagger failed!"))

/datum/antagonist/cult/proc/admin_give_metal(mob/admin)
	if (!equip_cultist(metal = TRUE))
		to_chat(admin, span_danger("Spawning runed metal failed!"))

/datum/antagonist/cult/proc/admin_take_all(mob/admin)
	var/mob/living/current = owner.current
	for(var/o in current.get_all_contents())
		if(istype(o, /obj/item/melee/cultblade/dagger) || istype(o, /obj/item/stack/sheet/runed_metal))
			qdel(o)

///Returns whether or not this datum is its team's leader.
/datum/antagonist/cult/proc/is_cult_leader()
	return (cult_team.cult_leader_datum == src)

///Turns this antag datum into its team's leader, assigning them their unique abilities, hud, and deathrattle.
/datum/antagonist/cult/proc/make_cult_leader()
	if(cult_team.cult_leader_datum)
		return FALSE
	cult_team.cult_leader_datum = src

	antag_hud_name = "cultmaster"
	add_team_hud(owner.current)
	RegisterSignal(owner.current, COMSIG_MOB_STATCHANGE, PROC_REF(deathrattle))

	if(!cult_team.reckoning_complete)
		var/datum/action/innate/cult/master/finalreck/reckoning = new
		reckoning.Grant(owner.current)
	var/datum/action/innate/cult/master/cultmark/bloodmark = new
	var/datum/action/innate/cult/master/pulse/throwing = new
	bloodmark.Grant(owner.current)
	throwing.Grant(owner.current)
	owner.current.update_mob_action_buttons()

	for(var/datum/mind/cult_mind as anything in cult_team.members)
		vote_ability.Remove(cult_mind.current)
		to_chat(cult_mind.current, span_cultlarge("[owner.current] has won the cult's support and is now their master. \
			Follow [owner.current.p_their()] orders to the best of your ability!"))

	to_chat(owner.current, span_cultlarge("<span class='warningplain'>You are the cult's Master</span>. \
		As the cult's Master, you have a unique title and loud voice when communicating, are capable of marking \
		targets, such as a location or a noncultist, to direct the cult to them, and, finally, you are capable of \
		summoning the entire living cult to your location <b><i>once</i></b>. Use these abilities to direct the cult \
		to victory at any cost."))

	return TRUE

///Admin-only helper to demote someone from Cult leader, taking away their HUD, abilities, and deathrattle
///And gives all cultists from their team back their ability to vote for a new leader.
/datum/antagonist/cult/proc/demote_from_leader()
	if(!cult_team.cult_leader_datum)
		return FALSE
	cult_team.cult_leader_datum = null

	antag_hud_name = initial(antag_hud_name)
	add_team_hud(owner.current)
	UnregisterSignal(owner.current, COMSIG_MOB_STATCHANGE)

	var/datum/action/innate/cult/master/finalreck/reckoning = locate() in owner.current.actions
	if(reckoning)
		reckoning.Remove(owner.current)
	var/datum/action/innate/cult/master/cultmark/bloodmark = locate() in owner.current.actions
	if(bloodmark)
		bloodmark.Remove(owner.current)
	var/datum/action/innate/cult/master/pulse/throwing = locate() in owner.current.actions
	if(throwing)
		throwing.Remove(owner.current)
	owner.current.update_mob_action_buttons()
	for(var/datum/mind/cult_mind as anything in cult_team.members)
		vote_ability.Grant(cult_mind.current)

	to_chat(owner.current, span_cultlarge("You have been demoted from being the cult's Master, you are now an acolyte once more!"))

	return TRUE

<<<<<<< HEAD
/datum/team/cult/proc/check_size()
	if(cult_ascendent)
		return

	// This proc is unnecessary clutter whilst running cult related unit tests
	// Remove this if, at some point, someone decides to test that halos and eyes are added at expected ratios
#ifndef UNIT_TESTS
	var/alive = 0
	var/cultplayers = 0
	for(var/I in GLOB.player_list)
		var/mob/M = I
		if(M.stat != DEAD)
			if(IS_CULTIST(M))
				++cultplayers
			else
				++alive

	ASSERT(cultplayers) //we shouldn't be here.
	var/ratio = alive ? cultplayers/alive : 1
	if(ratio > CULT_RISEN && !cult_risen)
		for(var/datum/mind/mind as anything in members)
			if(mind.current)
				SEND_SOUND(mind.current, 'sound/hallucinations/i_see_you2.ogg')
				to_chat(mind.current, span_cultlarge(span_warning("The veil weakens as your cult grows, your eyes begin to glow...")))
				mind.current.AddElement(/datum/element/cult_eyes)
		cult_risen = TRUE
		log_game("The blood cult has risen with [cultplayers] players.")

	if(ratio > CULT_ASCENDENT && !cult_ascendent)
		for(var/datum/mind/mind as anything in members)
			if(mind.current)
				SEND_SOUND(mind.current, 'sound/hallucinations/im_here1.ogg')
				to_chat(mind.current, span_cultlarge(span_warning("Your cult is ascendent and the red harvest approaches - you cannot hide your true nature for much longer!!")))
				mind.current.AddElement(/datum/element/cult_halo)
		cult_ascendent = TRUE
		log_game("The blood cult has ascended with [cultplayers] players.")
#endif

/datum/team/cult/add_member(datum/mind/new_member)
	. = ..()
	// A little hacky, but this checks that cult ghosts don't contribute to the size at maximum value.
	if(is_unassigned_job(new_member.assigned_role))
		return
	size_at_maximum++

/datum/team/cult/proc/make_image(datum/objective/sacrifice/sac_objective)
	var/datum/job/job_of_sacrifice = sac_objective.target.assigned_role
	var/datum/preferences/prefs_of_sacrifice = sac_objective.target.current.client.prefs
	var/icon/reshape = get_flat_human_icon(null, job_of_sacrifice, prefs_of_sacrifice, list(SOUTH))
	reshape.Shift(SOUTH, 4)
	reshape.Shift(EAST, 1)
	reshape.Crop(7,4,26,31)
	reshape.Crop(-5,-3,26,30)
	sac_objective.sac_image = reshape

/datum/team/cult/proc/setup_objectives()
	var/datum/objective/sacrifice/sacrifice_objective = new
	sacrifice_objective.team = src
	sacrifice_objective.find_target()
	objectives += sacrifice_objective

	var/datum/objective/eldergod/summon_objective = new
	summon_objective.team = src
	objectives += summon_objective

/datum/objective/sacrifice
	var/sacced = FALSE
	var/sac_image

/// Unregister signals from the old target so it doesn't cause issues when sacrificed of when a new target is found.
/datum/objective/sacrifice/proc/clear_sacrifice()
	if(!target)
		return
	UnregisterSignal(target, COMSIG_MIND_TRANSFERRED)
	if(target.current)
		UnregisterSignal(target.current, list(COMSIG_QDELETING, COMSIG_MOB_MIND_TRANSFERRED_INTO))
	target = null

/datum/objective/sacrifice/find_target(dupe_search_range, list/blacklist)
	clear_sacrifice()
	if(!istype(team, /datum/team/cult))
		return
	var/datum/team/cult/cult = team
	var/list/target_candidates = list()
	for(var/mob/living/carbon/human/player in GLOB.player_list)
		// SKYRAT EDIT ADDITION START - Players in the interlink can't be obsession targets
		if(SSticker.IsRoundInProgress() && istype(get_area(player), /area/centcom/interlink))
			continue
		// SKYRAT EDIT END
		if(player.mind && !player.mind.has_antag_datum(/datum/antagonist/cult) && !is_convertable_to_cult(player) && player.stat != DEAD)
			target_candidates += player.mind
	if(target_candidates.len == 0)
		message_admins("Cult Sacrifice: Could not find unconvertible target, checking for convertible target.")
		for(var/mob/living/carbon/human/player in GLOB.player_list)
			// SKYRAT EDIT ADDITION START - Players in the interlink can't be obsession targets
			if(SSticker.IsRoundInProgress() && istype(get_area(player), /area/centcom/interlink))
				continue
			// SKYRAT EDIT END
			if(player.mind && !player.mind.has_antag_datum(/datum/antagonist/cult) && player.stat != DEAD)
				target_candidates += player.mind
	list_clear_nulls(target_candidates)
	if(LAZYLEN(target_candidates))
		target = pick(target_candidates)
		update_explanation_text()
		// Register a bunch of signals to both the target mind and its body
		// to stop cult from softlocking everytime the target is deleted before being actually sacrificed.
		RegisterSignal(target, COMSIG_MIND_TRANSFERRED, PROC_REF(on_mind_transfer))
		RegisterSignal(target.current, COMSIG_QDELETING, PROC_REF(on_target_body_del))
		RegisterSignal(target.current, COMSIG_MOB_MIND_TRANSFERRED_INTO, PROC_REF(on_possible_mindswap))
	else
		message_admins("Cult Sacrifice: Could not find unconvertible or convertible target. WELP!")
		sacced = TRUE // Prevents another hypothetical softlock. This basically means every PC is a cultist.
	if(!sacced)
		cult.make_image(src)
	for(var/datum/mind/mind in cult.members)
		if(mind.current)
			mind.current.clear_alert("bloodsense")
			mind.current.throw_alert("bloodsense", /atom/movable/screen/alert/bloodsense)

/datum/objective/sacrifice/proc/on_target_body_del()
=======
///If dead (and Narsie isn't summoned), will alert all Cultists of their death, sending their location out.
/datum/antagonist/cult/proc/deathrattle(datum/source)
>>>>>>> 32afa856dbb (Makes cult leader handling work off of the Cult datum (#76556))
	SIGNAL_HANDLER

	if(owner.current.stat != DEAD)
		return
	if(!QDELETED(GLOB.cult_narsie))
		return
	if(!is_cult_leader())
		return

	var/area/current_area = get_area(owner.current)
	for(var/datum/mind/cult_mind as anything in cult_team.members)
		SEND_SOUND(cult_mind, sound('sound/hallucinations/veryfar_noise.ogg'))
		to_chat(cult_mind, span_cultlarge("The Cult's Master, [owner.current.name], has fallen in \the [current_area]!"))

/datum/antagonist/cult/get_preview_icon()
	var/icon/icon = render_preview_outfit(preview_outfit)

	// The longsword is 64x64, but getFlatIcon crunches to 32x32.
	// So I'm just going to add it in post, screw it.

	// Center the dude, because item icon states start from the center.
	// This makes the image 64x64.
	icon.Crop(-15, -15, 48, 48)

	var/obj/item/melee/cultblade/longsword = new
	icon.Blend(icon(longsword.lefthand_file, longsword.inhand_icon_state), ICON_OVERLAY)
	qdel(longsword)

	// Move the guy back to the bottom left, 32x32.
	icon.Crop(17, 17, 48, 48)

	return finish_preview_icon(icon)

/datum/outfit/cultist
	name = "Cultist (Preview only)"

	uniform = /obj/item/clothing/under/color/black
	suit = /obj/item/clothing/suit/hooded/cultrobes/alt
	head = /obj/item/clothing/head/hooded/cult_hoodie/alt
	shoes = /obj/item/clothing/shoes/cult/alt
	r_hand = /obj/item/melee/blood_magic/stun

/datum/outfit/cultist/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	equipped.eye_color_left = BLOODCULT_EYE
	equipped.eye_color_right = BLOODCULT_EYE
	equipped.update_body()

///Returns whether the given mob is convertable to the blood cult
/proc/is_convertable_to_cult(mob/living/target, datum/team/cult/specific_cult)
	if(!istype(target))
		return FALSE
	if(isnull(target.mind) || !GET_CLIENT(target))
		return FALSE
	if(target.mind.unconvertable)
		return FALSE
	if(ishuman(target) && target.mind.holy_role)
		return FALSE
	if(specific_cult?.is_sacrifice_target(target.mind))
		return FALSE
	var/mob/living/master = target.mind.enslaved_to?.resolve()
	if(master && !IS_CULTIST(master))
		return FALSE
	if(IS_HERETIC_OR_MONSTER(target))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD) || issilicon(target) || isbot(target) || isdrone(target))
		return FALSE //can't convert machines, shielded, or braindead
	return TRUE
<<<<<<< HEAD

/// Sets a blood target for the cult.
/datum/team/cult/proc/set_blood_target(atom/new_target, mob/marker, duration = 90 SECONDS)
	if(QDELETED(new_target))
		CRASH("A null or invalid target was passed to set_blood_target.")

	if(duration != INFINITY && blood_target_reset_timer)
		return FALSE

	deltimer(blood_target_reset_timer)
	blood_target = new_target
	RegisterSignal(blood_target, COMSIG_QDELETING, PROC_REF(unset_blood_target_and_timer))
	var/area/target_area = get_area(new_target)

	blood_target_image = image('icons/effects/mouse_pointers/cult_target.dmi', new_target, "glow", ABOVE_MOB_LAYER)
	blood_target_image.appearance_flags = RESET_COLOR
	blood_target_image.pixel_x = -new_target.pixel_x
	blood_target_image.pixel_y = -new_target.pixel_y

	for(var/datum/mind/cultist as anything in members)
		if(!cultist.current)
			continue
		if(cultist.current.stat == DEAD || !cultist.current.client)
			continue

		to_chat(cultist.current, span_bold(span_cultlarge("[marker] has marked [blood_target] in the [target_area.name] as the cult's top priority, get there immediately!")))
		SEND_SOUND(cultist.current, sound(pick('sound/hallucinations/over_here2.ogg','sound/hallucinations/over_here3.ogg'), 0, 1, 75))
		cultist.current.client.images += blood_target_image

	if(duration != INFINITY)
		blood_target_reset_timer = addtimer(CALLBACK(src, PROC_REF(unset_blood_target)), duration, TIMER_STOPPABLE)
	return TRUE

/// Unsets out blood target, clearing the images from all the cultists.
/datum/team/cult/proc/unset_blood_target()
	blood_target_reset_timer = null

	for(var/datum/mind/cultist as anything in members)
		if(!cultist.current)
			continue
		if(cultist.current.stat == DEAD || !cultist.current.client)
			continue

		if(QDELETED(blood_target))
			to_chat(cultist.current, span_bold(span_cultlarge("The blood mark's target is lost!")))
		else
			to_chat(cultist.current, span_bold(span_cultlarge("The blood mark has expired!")))
		cultist.current.client.images -= blood_target_image

	UnregisterSignal(blood_target, COMSIG_QDELETING)
	blood_target = null

	QDEL_NULL(blood_target_image)

/// Unsets our blood target when they get deleted.
/datum/team/cult/proc/unset_blood_target_and_timer(datum/source)
	SIGNAL_HANDLER

	deltimer(blood_target_reset_timer)
	unset_blood_target()

/datum/outfit/cultist
	name = "Cultist (Preview only)"

	uniform = /obj/item/clothing/under/color/black
	suit = /obj/item/clothing/suit/hooded/cultrobes/alt
	shoes = /obj/item/clothing/shoes/cult/alt
	r_hand = /obj/item/melee/blood_magic/stun

/datum/outfit/cultist/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	equipped.eye_color_left = BLOODCULT_EYE
	equipped.eye_color_right = BLOODCULT_EYE
	equipped.update_body()

#undef CULT_LOSS
#undef CULT_NARSIE_KILLED
#undef CULT_VICTORY
#undef SUMMON_POSSIBILITIES
=======
>>>>>>> 32afa856dbb (Makes cult leader handling work off of the Cult datum (#76556))
