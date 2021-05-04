/*********************************
*******Interactions code by HONKERTRON feat TestUnit********
**Contains a lot ammount of ERP and MEHANOYEBLYA**
**CREDIT TO ATMTA STATION FOR MOST OF THIS CODE, I ONLY MADE IT WORK IN /vg/ - Matt
** Rewritten 30/08/16 by Zuhayr, sry if I removed anything important.
**I removed ERP and replaced it with handholding. Nothing of worth was lost. - Vic
**Fuck you, Vic. ERP is back. - TT
**>using var/ on everything, also TRUE
**"TGUIzes" the panel because yes - SandPoot
***********************************/


// Rectum? Damn near killed 'em.
var/list/interactions

/proc/make_interactions(interaction)
	if(!interactions)
		interactions = list()
		for(var/itype in subtypesof(/datum/interaction))
			var/datum/interaction/I = new itype()
			interactions[I.command] = I

/mob/living/proc/list_interaction_attributes()
	var/dat = list()
	if(has_hands())
		dat += "...have hands."
	if(has_mouth())
		dat += "...have a mouth, which is [mouth_is_free() ? "uncovered" : "covered"]."
	return dat

/datum/interaction
	var/command = "interact"
	var/description = "Interact with them."
	var/simple_message
	var/simple_style = "notice"
	var/write_log_user
	var/write_log_target

	var/interaction_sound

	var/max_distance = 1
	var/require_ooc_consent = FALSE
	var/require_user_mouth
	var/require_user_hands
	var/require_target_mouth
	var/require_target_hands
	var/needs_physical_contact

	var/user_is_target = FALSE //Boolean. Pretty self explanatory.

//Action check added because please stop deleting my buttons.
/datum/interaction/proc/evaluate_user(mob/living/user, silent = TRUE, action_check = TRUE)
	if(user.get_refraction_dif())
		if(!silent) //bye spam
			to_chat(user, "<span class='warning'>You're still exhausted from the last time. You need to wait [DisplayTimeText(user.get_refraction_dif(), TRUE)] until you can do that!</span>")
		if(action_check)
			return FALSE

	if(require_user_mouth)
		if(!user.has_mouth() && !issilicon(user)) //Again, silicons do not have the required parts normally.
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a mouth.</span>")
			return FALSE

		if(!user.mouth_is_free() && !issilicon(user)) //Borgs cannot wear mouthgear, bypassing the check.
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your mouth is covered.</span>")
			return FALSE

	if(require_user_hands && !user.has_hands() && !issilicon(user)) //Edited to allow silicons to interact.
		if(!silent)
			to_chat(user, "<span class = 'warning'>You don't have hands.</span>")
		return FALSE

	if(user.last_interaction_time < world.time)
		return TRUE

	if(action_check)
		return FALSE
	else
		return TRUE

/datum/interaction/proc/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	if(!user_is_target)
		if(user == target)
			if(!silent)
				to_chat(user, "<span class = 'warning'>You can't do that to yourself.</span>")
			return FALSE

	if(require_target_mouth)
		if(!target.has_mouth())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a mouth.</span>")
			return FALSE

		if(!target.mouth_is_free() && !issilicon(target))
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their mouth is covered.</span>")
			return FALSE

	if(require_target_hands && !target.has_hands() && !issilicon(target))
		if(!silent)
			to_chat(user, "<span class = 'warning'>They don't have hands.</span>")
		return FALSE

	return TRUE

/datum/interaction/proc/do_action(mob/living/user, mob/living/target)
	if(!user_is_target)
		if(user == target) //tactical href fix
			to_chat(user, "<span class='warning'>You cannot target yourself.</span>")
			return
	if(get_dist(user, target) > max_distance)
		//user << "<span class='warning'>They are too far away.</span>"
		user.visible_message("<span class='warning'>They are too far away.</span>")
		return
	if(needs_physical_contact && !(user.Adjacent(target) && target.Adjacent(user)))
		//user << "<span class='warning'>You cannot get to them.</span>"
		user.visible_message("<span class='warning'>You cannot get to them.</span>")
		return
	if(!evaluate_user(user, silent = FALSE))
		return
	if(!evaluate_target(user, target, silent = FALSE))
		return

	if(write_log_user)
		user.log_message("[write_log_user] [target]", INDIVIDUAL_ATTACK_LOG)
	if(write_log_target)
		target.log_message("[write_log_target] [user]", INDIVIDUAL_ATTACK_LOG)

	display_interaction(user, target)
	post_interaction(user, target)

	//if(write_log_user)
		//add_logs(target, user, "fucked")
	//user.attack_log += text("\[[time_stamp()]\] <font color='red'>[write_log_user] [target.name] ([target.ckey])</font>")
	//if(write_log_target)
		//add_logs(target, user, "fucked2")
	//target.attack_log += text("\[[time_stamp()]\] <font color='orange'>[write_log_target] [user.name] ([user.ckey])</font>")

/datum/interaction/proc/display_interaction(mob/living/user, mob/living/target)
	if(simple_message)
		var/use_message = replacetext(simple_message, "USER", "\the [user]")
		use_message = replacetext(use_message, "TARGET", "\the [target]")
		user.visible_message("<span class='[simple_style]'>[capitalize(use_message)]</span>")

/datum/interaction/proc/post_interaction(mob/living/user, mob/living/target)
	user.last_interaction_time = world.time + 6
	if(interaction_sound)
		playsound(get_turf(user), interaction_sound, 50, 1, -1)
	return
/*
/atom/movable/attack_hand(mob/living/user)
	. = ..()
	if(can_buckle && buckled_mob)
		if(user_unbuckle_mob(user))
			return TRUE

/atom/movable/MouseDrop_T(mob/living/M, mob/living/user)
	. = ..()
	if(can_buckle && istype(M) && !buckled_mob)
		if(user_buckle_mob(M, user))
			return TRUE


/atom/movable/attack_hand(mob/living/user)
	. = ..()
	if(can_buckle && buckled_mob)
		if(user_unbuckle_mob(user))
			return TRUE

/atom/movable/MouseDrop_T(mob/living/carbon/human/M, mob/living/user)
	. = ..()
	if(can_buckle && istype(M) && !buckled_mob)
		if(user_buckle_mob(M, user))
			return TRUE
*/
