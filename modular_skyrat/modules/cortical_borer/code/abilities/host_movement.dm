//to either get inside, or out, of a host
/datum/action/cooldown/mob_cooldown/borer/choosing_host
	name = "Inhabit/Uninhabit Host"
	cooldown_time = 10 SECONDS
	button_icon_state = "host"
	click_to_activate = TRUE

/datum/action/cooldown/mob_cooldown/borer/choosing_host/Activate(atom/target)
	. = ..()




	if(get_dist(owner, target) > 1)
		owner.balloon_alert(owner, "Too far")
		return
	if(!ishuman(target))
		return

	var/mob/living/carbon/human/victim = target

/datum/action/cooldown/mob_cooldown/borer/choosing_host/proc/try_enter_host(atom/target)


/datum/action/cooldown/mob_cooldown/borer/choosing_host/proc/try_leave_host(atom/target)


/datum/action/cooldown/mob_cooldown/borer/choosing_host/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	// Check if we already have a human_host
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(cortical_owner.human_host)
		try_leave_host()
		StartCooldown()

/*
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner

	//having a host means we need to leave them then
	if(cortical_owner.human_host)
		if(cortical_owner.host_sugar())
			owner.balloon_alert(owner, "cannot function with sugar in host")
			return
		owner.balloon_alert(owner, "detached from host")
		if(!(cortical_owner.upgrade_flags & BORER_STEALTH_MODE))
			to_chat(cortical_owner.human_host, span_notice("Something carefully tickles your inner ear..."))
		var/obj/item/organ/internal/borer_body/borer_organ = locate() in cortical_owner.human_host.organs
		//log the interaction
		var/turf/human_turfone = get_turf(cortical_owner.human_host)
		var/logging_text = "[key_name(cortical_owner)] left [key_name(cortical_owner.human_host)] at [loc_name(human_turfone)]"
		cortical_owner.log_message(logging_text, LOG_GAME)
		cortical_owner.human_host.log_message(logging_text, LOG_GAME)
		if(borer_organ)
			borer_organ.Remove(cortical_owner.human_host)
		cortical_owner.forceMove(human_turfone)
		cortical_owner.human_host = null
		REMOVE_TRAIT(cortical_owner, TRAIT_WEATHER_IMMUNE, "borer_in_host")
		StartCooldown()
		return

	//we dont have a host so lets inhabit one
	var/list/usable_hosts = list()
	for(var/mob/living/carbon/human/listed_human in range(1, cortical_owner))
		// no non-human hosts
		if(!ishuman(listed_human) || ismonkey(listed_human))
			continue
		// cannot have multiple borers (for now)
		if(listed_human.has_borer())
			continue
		// hosts need to be organic
		if(!(listed_human.dna.species.inherent_biotypes & MOB_ORGANIC) && cortical_owner.organic_restricted)
			continue
		// hosts need to be organic
		if(!(listed_human.mob_biotypes & MOB_ORGANIC) && cortical_owner.organic_restricted)
			continue
		//hosts cannot be changelings
		if(IS_CHANGELING(listed_human) && cortical_owner.changeling_restricted)
			continue
		usable_hosts += listed_human

	//if the list of possible hosts is one, just go straight in, no choosing
	if(length(usable_hosts) == 1)
		enter_host(usable_hosts[1])
		return

	//if the list of possible host is more than one, allow choosing a host
	var/choose_host = tgui_input_list(cortical_owner, "Choose your host!", "Host Choice", usable_hosts)
	if(!choose_host)
		owner.balloon_alert(owner, "no target selected")
		return
	enter_host(choose_host)
*/

/datum/action/cooldown/mob_cooldown/borer/choosing_host/proc/enter_host(mob/living/carbon/human/singular_host)

/*	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(check_for_bio_protection(singular_host))
		owner.balloon_alert(owner, "target head too protected!")
		return
	if(singular_host.has_borer())
		owner.balloon_alert(owner, "target already occupied")
		return
	if(!do_after(cortical_owner, (((cortical_owner.upgrade_flags & BORER_FAST_BORING) && !(cortical_owner.upgrade_flags & BORER_HIDING)) ? 3 SECONDS : 6 SECONDS), target = singular_host))
		owner.balloon_alert(owner, "you and target must be still")
		return
	if(get_dist(singular_host, cortical_owner) > 1)
		owner.balloon_alert(owner, "target too far away")
		return
	cortical_owner.human_host = singular_host
	cortical_owner.forceMove(cortical_owner.human_host)
	if(!(cortical_owner.upgrade_flags & BORER_STEALTH_MODE))
		to_chat(cortical_owner.human_host, span_notice("A chilling sensation goes down your spine..."))
	cortical_owner.copy_languages(cortical_owner.human_host)
	var/obj/item/organ/internal/borer_body/borer_organ = new(cortical_owner.human_host)
	borer_organ.borer = owner
	borer_organ.Insert(cortical_owner.human_host)
	var/turf/human_turftwo = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] went into [key_name(cortical_owner.human_host)] at [loc_name(human_turftwo)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	ADD_TRAIT(cortical_owner, TRAIT_WEATHER_IMMUNE, "borer_in_host")
	StartCooldown()*/

/// Checks if the target's head is bio protected, returns true if this is the case
/datum/action/cooldown/mob_cooldown/borer/choosing_host/proc/check_for_bio_protection(mob/living/carbon/human/target)
	if(isobj(target.head))
		if(target.head.get_armor_rating(BIO) >= 100)
			return TRUE
	if(isobj(target.wear_mask))
		if(target.wear_mask.get_armor_rating(BIO) >= 100)
			return TRUE
	if(isobj(target.wear_neck))
		if(target.wear_neck.get_armor_rating(BIO) >= 100)
			return TRUE
	return FALSE

/mob/living/basic/cortical_borer/proc/enter_host()


//leave the host, forced or not
/mob/living/basic/cortical_borer/proc/leave_host()
	if(!human_host)
		return
	var/obj/item/organ/internal/borer_body/borer_organ = locate() in human_host.organs
	if(borer_organ)
		borer_organ.Remove(human_host)
	var/turf/human_turf = get_turf(human_host)
	forceMove(human_turf)
	human_host = null
