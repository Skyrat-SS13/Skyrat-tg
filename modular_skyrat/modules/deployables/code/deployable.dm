#define FOLD "fold"

#define UNLOCK "unlock"
#define LOCK "lock"

#define STOP_MODE "stop"
#define DRAIN_MODE "drain"
#define PUMP_MODE "pump"

////
//	BAP

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
	if(power_storage == 40000)
		. += span_warning("It cannot store any more power.")

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
	if(power_storage == 40000)
		. += span_warning("It cannot store any more power.")

// The state after popping out of the grenade
/obj/structure/bed/borg_action_pacifier/undeployed/deploying
	name = "Deploying B.A.P. unit"

/obj/structure/bed/borg_action_pacifier/undeployed/deploying/Initialize(mapload)
	. = ..()
	balloon_alert_to_viewers("Unfolding...")
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_trap.ogg', 25, TRUE, falloff_exponent = 20)
	addtimer(CALLBACK(src, .proc/deploy), 0.8 SECONDS)

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

		usr.visible_message(span_notice("[usr] collapses [src]."), span_notice("You collapse [src]."))
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
				if(buckled_cyborg.cell && buckled_cyborg.cell.charge > 0)
					choices += list(DRAIN_MODE = image(icon = radial_indicator, icon_state = "drain"))
				if(buckled_cyborg.cell && power_storage > 0)
					choices += list(PUMP_MODE = image(icon = radial_indicator, icon_state = "pump"))
			else
				choices += list(STOP_MODE = image(icon = radial_indicator, icon_state = "stop"))
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
			balloon_alert_to_viewers("Locked!")
			lock()
		if(UNLOCK)
			balloon_alert_to_viewers("Unlocked!")
			unlock()
		if(STOP_MODE)
			balloon_alert(clicker, "Stopped [enabled_function]ing.")
			stop_mode()
		if(DRAIN_MODE)
			balloon_alert(clicker, "Draining from [buckled_cyborg]...")
			drain_mode()
		if(PUMP_MODE)
			balloon_alert(clicker, "Pumping to [buckled_cyborg]...")
			pump_mode()
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
	var/transfer_inc = 500
	switch(enabled_function)
		if(DRAIN_MODE)
			if(cell.charge > 0)
				drain_cell(cell, transfer_inc)
			if(cell.charge < 0)
				cell.charge = 0
				stop_mode()
			else if(power_storage > 40000)
				power_storage = 40000
				stop_mode()
		if(PUMP_MODE)
			if(power_storage > 0)
				pump_cell(cell, transfer_inc)
			if(power_storage < 0)
				power_storage = 0
				stop_mode()
			else if(cell.charge > cell.maxcharge)
				cell.charge = cell.maxcharge
				stop_mode()
		if(NONE)
			return

/obj/structure/bed/borg_action_pacifier/proc/drain_cell(obj/item/stock_parts/cell/cell, transfer_inc)
	cell.charge = cell.charge - transfer_inc
	power_storage = power_storage + transfer_inc
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_drain.ogg', 25, FALSE, falloff_exponent = 20)
	do_sparks(1, TRUE, buckled_cyborg)

/obj/structure/bed/borg_action_pacifier/proc/pump_cell(obj/item/stock_parts/cell/cell, transfer_inc)
	power_storage = power_storage - transfer_inc
	cell.charge = cell.charge + transfer_inc
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_pump.ogg', 25, FALSE, falloff_exponent = 20)
	do_sparks(1, TRUE, buckled_cyborg)

/obj/structure/bed/borg_action_pacifier/proc/drain_mode()
	enabled_function = DRAIN_MODE

/obj/structure/bed/borg_action_pacifier/proc/pump_mode()
	enabled_function = PUMP_MODE

/obj/structure/bed/borg_action_pacifier/proc/stop_mode()
	playsound(src, 'sound/machines/ping.ogg', 50, FALSE, falloff_exponent = 10)
	enabled_function = NONE
	buckled_cyborg.regenerate_icons()

/obj/structure/bed/borg_action_pacifier/proc/lock()
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_lock.ogg', 50, TRUE, falloff_exponent = 10)
	locked = TRUE
	buckled_cyborg.SetLockdown(TRUE)
	buckled_cyborg.cut_overlay(buckled_cyborg.eye_lights)

/obj/structure/bed/borg_action_pacifier/proc/unlock()
	locked = FALSE
	buckled_cyborg.SetLockdown(FALSE)
	buckled_cyborg.regenerate_icons()

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
	target.pixel_y = (target.base_pixel_y + 8)

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
				if(!do_after(buckled_mob, 20 SECONDS))
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
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 50, TRUE)

#undef FOLD

#undef UNLOCK
#undef LOCK

#undef STOP_MODE
#undef DRAIN_MODE
#undef PUMP_MODE
