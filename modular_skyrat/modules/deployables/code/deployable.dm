#define UNLOCK "unlock"
#define LOCK "lock"
#define FOLD "fold"
#define STOP "stop"
#define DRAIN "drain"
#define PUMP "pump"

////
//	BAP

// The grenade
/obj/item/grenade/borg_action_pacifier_grenade
	name = "B.A.P. grenade"
	desc = "An inactivated device to constrain silicons with."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "folded"
	inhand_icon_state = "folded"
	worn_icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL

	det_time = 3 SECONDS
	// Amount of power drained from the cyborg, which we are now storing
	var/power_storage = 0

/obj/item/grenade/borg_action_pacifier_grenade/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	var/obj/structure/bed/borg_action_pacifier/undeployed/deploying/deploying = new /obj/structure/bed/borg_action_pacifier/undeployed/deploying(get_turf(src.loc))
	deploying.power_storage = power_storage
	qdel(src)

/obj/item/grenade/borg_action_pacifier_grenade/examine(mob/user)
	. = ..()
	. += span_notice("It's currently holding [power_storage] units worth of charge.")


//	The item in its functional state
/obj/structure/bed/borg_action_pacifier
	name = "Deployed B.A.P. unit"
	desc = "An inactivated device to constrain silicons with."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "up"
	anchored = FALSE
	resistance_flags = FIRE_PROOF | FREEZE_PROOF
	flags_1 = NODECONSTRUCT_1

	bolts = FALSE
	// The cyborg currently buckled to the BAP
	var/mob/living/silicon/robot/buckled_cyborg
	// If the BAP is deployed or not
	var/deployed = TRUE
	// Wether or not the machine is locking the cyborg
	var/locked = FALSE
	// To distinguish if the machine is pumping or draining
	var/enabled_function = NONE
	// Amount of power drained from the cyborg, which we are now storing
	var/power_storage = 0

/obj/structure/bed/borg_action_pacifier/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/check_altclicked)

/obj/structure/bed/borg_action_pacifier/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_CLICK_ALT)

/obj/structure/bed/borg_action_pacifier/examine(mob/user)
	. = ..()
	if(locked)
		. += span_notice("It's locked.")
	if(enabled_function != NONE)
		. += span_notice("It's [enabled_function]ing power...")
	. += span_notice("It's currently holding [power_storage] units worth of charge.")

// The state after popping out of the grenade
/obj/structure/bed/borg_action_pacifier/undeployed/deploying
	name = "Deploying B.A.P. unit"

/obj/structure/bed/borg_action_pacifier/undeployed/deploying/Initialize(mapload)
	. = ..()
	balloon_alert_to_viewers("Unfolding...")
	addtimer(CALLBACK(src, .proc/deploy), 3 SECONDS)

/obj/structure/bed/borg_action_pacifier/undeployed/deploying/proc/deploy()
	var/obj/structure/bed/borg_action_pacifier/deployed = new /obj/structure/bed/borg_action_pacifier(get_turf(src))
	deployed.balloon_alert_to_viewers("Deployed!")
	deployed.power_storage = power_storage
	qdel(src)

// The item in its retrieval state
/obj/structure/bed/borg_action_pacifier/undeployed
	name = "Undeployed B.A.P. unit"
	icon_state = "down"
	resistance_flags = NONE
	deployed = FALSE

/obj/structure/bed/borg_action_pacifier/undeployed/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
			return FALSE
		if(has_buckled_mobs() || deployed)
			return FALSE

	//	usr.visible_message(span_notice("[usr] collapses \the [src.name]."), span_notice("You collapse \the [src.name]."))
		var/obj/item/grenade/borg_action_pacifier_grenade/BAPer = new /obj/item/grenade/borg_action_pacifier_grenade(get_turf(src))
		usr.put_in_hands(BAPer)
		BAPer.power_storage = power_storage
		qdel(src)


// Alt-click control
/obj/structure/bed/borg_action_pacifier/proc/check_altclicked(datum/source, mob/living/clicker)
	SIGNAL_HANDLER

	if(!istype(clicker))
		return
	. = COMPONENT_CANCEL_CLICK_ALT
	INVOKE_ASYNC(src, .proc/alt_clicked, clicker)

/obj/structure/bed/borg_action_pacifier/proc/alt_clicked(mob/living/clicker)
	var/icon/radial_indicator = 'modular_skyrat/modules/deployables/icons/deployable_indicator.dmi'
	var/list/choices = list()

	if(buckled_cyborg)
		if(!locked)
			choices += list(LOCK = image(icon = radial_indicator, icon_state = "lock"))
		else
			choices += list(UNLOCK = image(icon = radial_indicator, icon_state = "unlock"))

		switch(enabled_function)
			if(NONE)
				if(buckled_cyborg.cell && !buckled_cyborg.low_power_mode)
					choices += list(DRAIN = image(icon = radial_indicator, icon_state = "drain"))
				if(buckled_cyborg.cell && power_storage > 0)
					choices += list(PUMP = image(icon = radial_indicator, icon_state = "pump"))
			else
				choices += list(STOP = image(icon = radial_indicator, icon_state = "stop"))
	else
		set_mode(clicker, FOLD)
		return

	var/choice = show_radial_menu(clicker, src, choices, custom_check = CALLBACK(src, .proc/check_menu, clicker), tooltips = TRUE)
	if(!choice || !check_menu(clicker))
		return
	set_mode(clicker, choice)

/obj/structure/bed/borg_action_pacifier/proc/set_mode(mob/living/clicker, choice)
	switch(choice)
		if(LOCK)
			balloon_alert(clicker, "Locked!")
			lock()
		if(UNLOCK)
			balloon_alert(clicker, "Unlocked!")
			unlock()
		if(STOP)
			balloon_alert(clicker, "Stopped [enabled_function]ing.")
			stop()
		if(DRAIN)
			balloon_alert(clicker, "Draining from [buckled_cyborg]...")
			drain()
		if(PUMP)
			balloon_alert(clicker, "Pumping to [buckled_cyborg]...")
			pump()
		if(FOLD)
			balloon_alert(clicker, "Folding up...")
			undeploy(clicker)

/obj/structure/bed/borg_action_pacifier/proc/check_menu(mob/user)
	if(!istype(user))
		CRASH("A non-mob is trying to issue an order.")
	if(user.incapacitated() || !can_see(user, src) || user == buckled_cyborg)
		return FALSE
	return TRUE

// Functions
/obj/structure/bed/borg_action_pacifier/process()
	if(!buckled_cyborg)
		return

	var/obj/item/stock_parts/cell/cell = buckled_cyborg.cell
	var/transfer_inc = 200

	switch(enabled_function)
		if(DRAIN)
			if(cell.charge > 0)
				cell.charge = cell.charge - transfer_inc
				power_storage = power_storage + transfer_inc
			else
				cell.charge = 0
				stop()
		if(PUMP)
			if(power_storage > 0)
				power_storage = power_storage - transfer_inc
				cell.charge = cell.charge + transfer_inc
			else
				power_storage = 0
				stop()
		if(NONE)
			return

/obj/structure/bed/borg_action_pacifier/proc/drain()
	enabled_function = DRAIN

/obj/structure/bed/borg_action_pacifier/proc/pump()
	enabled_function = PUMP

/obj/structure/bed/borg_action_pacifier/proc/stop()
	enabled_function = NONE

/obj/structure/bed/borg_action_pacifier/proc/lock()
	locked = TRUE
	buckled_cyborg.set_lockcharge(TRUE)

/obj/structure/bed/borg_action_pacifier/proc/unlock()
	locked = FALSE
	buckled_cyborg.set_lockcharge(FALSE)

/obj/structure/bed/borg_action_pacifier/proc/undeploy(mob/living/clicker)
	var/obj/structure/bed/borg_action_pacifier/undeployed/undeployed

	if(do_after(clicker, 3 SECONDS))
		undeployed = new /obj/structure/bed/borg_action_pacifier/undeployed(get_turf(src))
		undeployed.balloon_alert_to_viewers("Reset!")
		undeployed.power_storage = power_storage
		qdel(src)
	else
		return


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
	START_PROCESSING(SSobj, src)

/obj/structure/bed/borg_action_pacifier/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(!force)
		return
	..()

/obj/structure/bed/borg_action_pacifier/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(!(buckled_mob in buckled_mobs) || !user.CanReach(buckled_mob))
		return

	if(buckled_mob)
		if(buckled_mob != user)
			if(locked)
				user.visible_message(span_notice("[user] begins to overwrite the lock to unbuckle [buckled_mob] from [src]."),\
					span_notice("You begin to free [buckled_mob] from [src]."))
				if(!do_after(user, 6 SECONDS))
					return
			else
				user.visible_message(span_notice("[user] begins to unbuckle [buckled_mob] from [src]."),\
					span_notice("[user] begins to unbuckle you from [src]."))
				if(!do_after(user, 3 SECONDS))
					return

		else
			if(locked)
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

	unlock() // Just in case
	buckled_cyborg = null
	enabled_function = NONE
	STOP_PROCESSING(SSobj, src)


// Fluff
/obj/structure/bed/borg_action_pacifier/Moved()
	. = ..()
	if(has_gravity() && deployed)
		playsound(src, 'sound/effects/roll.ogg', 50, TRUE)

#undef UNLOCK
#undef LOCK
#undef FOLD
#undef STOP
#undef DRAIN
#undef PUMP
