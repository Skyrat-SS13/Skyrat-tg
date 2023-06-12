// no global instance so we can pass args
/datum/ui_state/handheld_soulcatcher_state
	var/obj/item/handheld_soulcatcher/our_item

/datum/ui_state/handheld_soulcatcher_state/New(obj/item/handheld_soulcatcher/our_item)
	. = ..()

	src.our_item = our_item

/datum/ui_state/handheld_soulcatcher_state/Destroy(force, ...)
	our_item = null

	return ..()

#define SOULCATCHER_MAX_CATCHING_DISTANCE 7

/datum/ui_state/handheld_soulcatcher_state/can_use_topic(src_object, mob/living/user)
	if(QDELETED(our_item))
		return UI_CLOSE

	var/mob/target_mob = our_item.interacting_mobs[user]
	if(!target_mob)
		return UI_CLOSE

	if(!istype(user))
		return UI_CLOSE

	if(user.stat != CONSCIOUS)
		return UI_CLOSE

	var/is_holding = user.is_holding(our_item)

	if(!is_holding)
		if(user.z != our_item.z)
			return UI_CLOSE

	var/dist_from_src_to_target = get_dist(get_turf(our_item), get_turf(target_mob))
	if(dist_from_src_to_target > SOULCATCHER_MAX_CATCHING_DISTANCE)
		to_chat(user, span_warning("[target_mob] left range of [our_item]!"))
		return UI_CLOSE

	if(HAS_TRAIT(src, TRAIT_UI_BLOCKED) || user.incapacitated())
		return UI_DISABLED

	if(is_holding)
		return UI_INTERACTIVE
	else
		return user.shared_living_ui_distance(our_item)

#undef SOULCATCHER_MAX_CATCHING_DISTANCE
