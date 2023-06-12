// no global instance so we can pass args
/datum/ui_state/handheld_soulcatcher_state
	var/obj/item/handheld_soulcatcher/linked_soulcatcher

/datum/ui_state/handheld_soulcatcher_state/New(obj/item/handheld_soulcatcher/linked_soulcatcher)
	. = ..()

	src.linked_soulcatcher = linked_soulcatcher

/datum/ui_state/handheld_soulcatcher_state/Destroy(force, ...)
	linked_soulcatcher = null

	return ..()

#define SOULCATCHER_MAX_CATCHING_DISTANCE 7

/datum/ui_state/handheld_soulcatcher_state/can_use_topic(src_object, mob/living/user)
	if(QDELETED(linked_soulcatcher))
		return UI_CLOSE

	var/mob/target_mob = linked_soulcatcher.interacting_mobs[user]
	if(!target_mob)
		return UI_CLOSE

	if(!istype(user))
		return UI_CLOSE

	if(user.stat != CONSCIOUS)
		return UI_CLOSE

	var/is_holding = user.is_holding(linked_soulcatcher)

	if(!is_holding)
		if(user.z != linked_soulcatcher.z)
			return UI_CLOSE

	var/dist_from_src_to_target = get_dist(get_turf(linked_soulcatcher), get_turf(target_mob))
	if(dist_from_src_to_target > SOULCATCHER_MAX_CATCHING_DISTANCE)
		to_chat(user, span_warning("[target_mob] left range of [linked_soulcatcher]!"))
		return UI_CLOSE

	if(HAS_TRAIT(src, TRAIT_UI_BLOCKED) || user.incapacitated())
		return UI_DISABLED

	if(is_holding)
		return UI_INTERACTIVE
	else
		return user.shared_living_ui_distance(linked_soulcatcher)

#undef SOULCATCHER_MAX_CATCHING_DISTANCE
