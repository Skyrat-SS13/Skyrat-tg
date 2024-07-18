
/// Checks if the target's head is bio protected, returns true if this is the case
/mob/living/basic/cortical_borer/proc/check_for_target_bio_protection(mob/living/carbon/human/target)
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

/mob/living/basic/cortical_borer/proc/try_enter_host(mob/living/carbon/human/victim)
	if(check_for_target_bio_protection(victim))
		balloon_alert(src, "head too protected!")
		return FALSE
	if(victim.has_borer())
		balloon_alert(src, "already occupied")
		return FALSE
	if(!do_after(src, (((upgrade_flags & BORER_FAST_BORING) && !(upgrade_flags & BORER_HIDING)) ? 3 SECONDS : 6 SECONDS), target = victim))
		balloon_alert(src, "keep still")
		return FALSE
	if(get_dist(victim, src) > 1)
		balloon_alert(src, "too far")
		return FALSE
	var/obj/item/organ/internal/brain/brain = victim.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain))
		balloon_alert(src, "no brain")
		return FALSE

	return enter_host(victim, brain)

/mob/living/basic/cortical_borer/proc/enter_host(mob/living/carbon/human/victim, obj/item/organ/internal/brain/brain)
	human_host = victim
	forceMove(human_host)

	if(!(upgrade_flags & BORER_STEALTH_MODE))
		to_chat(human_host, span_notice("A chilling sensation goes down your spine..."))
	copy_languages(human_host)

	var/obj/item/organ/internal/borer_body/borer_organ = new()
	borer_organ.Insert(human_host)

	log_message("[key_name(src)] went into [key_name(human_host)] at [loc_name(get_turf(human_host))]", LOG_GAME)

	ADD_TRAIT(src, TRAIT_WEATHER_IMMUNE, "borer_in_host")

	RegisterSignal(brain, COMSIG_ORGAN_REMOVED, PROC_REF(on_brain_removed))
	return TRUE

/mob/living/basic/cortical_borer/proc/try_leave_host()
	if(host_sugar())
		balloon_alert(src, "cannot function with sugar in host")
		return TRUE // We force a cooldown over sugar
	balloon_alert(src, "left host")
	if(!(upgrade_flags & BORER_STEALTH_MODE))
		to_chat(human_host, span_notice("Something carefully tickles your inner ear..."))
	return leave_host()

/mob/living/basic/cortical_borer/proc/leave_host()
	var/turf/dropoff_turf = get_turf(human_host)
	log_message("[key_name(src)] left [key_name(human_host)] at [loc_name(dropoff_turf)]", LOG_GAME)

	var/obj/item/organ/internal/borer_body/borer_organ = locate() in human_host.organs
	if(borer_organ)
		borer_organ.Remove(human_host)
		qdel(borer_organ)
	forceMove(dropoff_turf)
	UnregisterSignal(human_host.get_organ_slot(ORGAN_SLOT_BRAIN), COMSIG_ORGAN_REMOVED)
	human_host = null

	REMOVE_TRAIT(src, TRAIT_WEATHER_IMMUNE, "borer_in_host")
	return TRUE

///If a person is debrained, the borer is removed with this
/mob/living/basic/cortical_borer/proc/on_brain_removed(atom/source, mob/living/carbon/target)
	SIGNAL_HANDLER
	leave_host()
