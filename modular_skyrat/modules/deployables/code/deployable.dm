#define LOCK "lock"
#define DRAIN "drain"
#define PUMP "pump"

////
//	BAP

// The grenade
/obj/item/grenade/borg_action_pacifier_grenade
	name = "B.A.P. module"
	desc = "An inactivated device to constrain silicons with."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "folded"
	inhand_icon_state = "folded"
	worn_icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL

	det_time = 3 SECONDS

/obj/item/grenade/borg_action_pacifier_grenade/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	new /obj/structure/bed/borg_action_pacifier/undeployed(get_turf(src.loc))
	qdel(src)


//	The item
/obj/structure/bed/borg_action_pacifier
	name = "Deployed B.A.P. unit"
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "up"
	anchored = FALSE
	resistance_flags = FIRE_PROOF | FREEZE_PROOF
	flags_1 = NODECONSTRUCT_1
	// The cyborg currently buckled to the BAP
	var/mob/living/silicon/robot/buckled_cyborg
	// If the BAP is deployed or not
	var/deployed = TRUE
	// The functions which are in use
	var/list/enabled_function
	// Amount of power drained from the cyborg, which we are now storing
	var/power_storage

/obj/structure/bed/borg_action_pacifier/undeployed
	name = "B.A.P. unit"
	icon_state = "down"
	resistance_flags = NONE
	deployed = FALSE

/obj/structure/bed/borg_action_pacifier/undeployed/Initialize(mapload)
	. = ..()
	balloon_alert_to_viewers("Begins to unfold!")
	addtimer(CALLBACK(src, .proc/deploy), 3 SECONDS)

/obj/structure/bed/borg_action_pacifier/undeployed/proc/deploy()
	var/obj/structure/bed/borg_action_pacifier/deployed = new /obj/structure/bed/borg_action_pacifier(get_turf(src))
	deployed.balloon_alert_to_viewers("Deployed!")
	qdel(src)

// Buckle overwrites
/obj/structure/bed/borg_action_pacifier/buckle_mob(mob/living/target, force, check_loc)
	if(!deployed)
		return
	if(!iscyborg(target))
		balloon_alert_to_viewers("Only cyborgs can be buckled!")
		return
	..()

/obj/structure/bed/borg_action_pacifier/user_buckle_mob(mob/living/target, mob/user, check_loc)
	if(target)
		if(target != user)
			user.visible_message(span_warning("[user] starts buckling [target] to [src]!"))
		else
			target.visible_message(span_warning("[target] starts buckling [target.p_them()]self to [src]!"))
			if(!do_after(target, 1.5 SECONDS)) // The added delay is to prevent accidental buckling
				return
	..()

/obj/structure/bed/borg_action_pacifier/post_buckle_mob(mob/living/target)
	set_density(TRUE)
	target.pixel_y = (target.base_pixel_y + 12)

	buckled_cyborg = target

/obj/structure/bed/borg_action_pacifier/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(!force)
		return
	..()

/obj/structure/bed/borg_action_pacifier/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(!(buckled_mob in buckled_mobs) || !user.CanReach(buckled_mob))
		return

	if(buckled_mob)
		if(buckled_mob != user)
			if(LOCK in enabled_function)
				user.visible_message(span_notice("[user] begins to overwrite the lock to unbuckle [buckled_mob] from [src]."),\
					span_notice("[user] begins to free you from [src]."))
				if(!do_after(user, 6 SECONDS))
					return
			else
				user.visible_message(span_notice("[user] begins to unbuckle [buckled_mob] from [src]."),\
					span_notice("[user] begins to unbuckle you from [src]."))
				if(!do_after(user, 3 SECONDS))
					return

		else
			if(LOCK in enabled_function)
				if(buckled_cyborg.low_power_mode)
					to_chat(buckled_mob, span_notice("Without power, attempting to break free is hopeless..."))
					return
				buckled_mob.visible_message(span_notice("[buckled_mob] begins to break out of [buckled_mob.p_their()] restraints."),\
					span_notice("You begin to free yourself from [src]."))
				if(!do_after(buckled_mob, 12 SECONDS))
					return
			else
				buckled_mob.visible_message(span_notice("[buckled_mob] begins to unbuckle [buckled_mob.p_them()]self from [src]."),\
					span_notice("You begin to unbuckle yourself from [src]."))
				if(!do_after(buckled_mob, 6 SECONDS))
					return

		add_fingerprint(user)
		if(isliving(buckled_mob.pulledby))
			var/mob/living/living = buckled_mob.pulledby
			living.set_pull_offsets(buckled_mob, living.grab_state)

	var/mob/living/target = unbuckle_mob(buckled_mob, TRUE)
	return target

/obj/structure/bed/borg_action_pacifier/post_unbuckle_mob(mob/living/target)
	set_density(FALSE)
	target.pixel_y = target.base_pixel_y + target.body_position_pixel_y_offset

	buckled_cyborg = null
	QDEL_LIST(enabled_function)


/obj/structure/bed/borg_action_pacifier/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
			return FALSE
		if(has_buckled_mobs())
			return FALSE


		usr.visible_message(span_notice("[usr] collapses \the [src.name]."), span_notice("You collapse \the [src.name]."))
		var/obj/item/grenade/borg_action_pacifier_grenade/BAPer = new /obj/item/grenade/borg_action_pacifier_grenade(get_turf(src))
		usr.put_in_hands(BAPer)
		qdel(src)

/obj/structure/bed/borg_action_pacifier/Moved()
	. = ..()
	if(has_gravity() && deployed)
		playsound(src, 'sound/effects/roll.ogg', 50, TRUE)

#undef LOCK
#undef DRAIN
#undef PUMP
