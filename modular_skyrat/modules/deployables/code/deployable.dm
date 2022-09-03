#define FOLD "fold"

#define UNLOCK "unlock"
#define LOCK "lock"

#define STOP_MODE "stop"
#define DRAIN_MODE "drain"
#define PUMP_MODE "pump"

#define MAX_POWER 40000	/// BS cell capacity, a potato battery would still outplay this
#define TRANSFER_INC 1000 /// Amount of power per tick pumped/drained
#define SETUP_TIME 2 SECONDS /// How quick does it (un)fold? Warning: this tries to match an animation

// Automapper
/datum/area_spawn/borg_action_pacifier
	target_areas = list(/area/station/security/lockers, /area/station/security/office)
	desired_atom = /obj/item/grenade/borg_action_pacifier_grenade
	amount_to_spawn = 3
	mode = AREA_SPAWN_MODE_OPEN

/datum/area_spawn/borg_action_pacifier_deployed
	target_areas = list(/area/station/science/robotics/mechbay, /area/station/science/robotics/lab)
	desired_atom = /obj/structure/bed/borg_action_pacifier
	optional = TRUE
	amount_to_spawn = 2
	mode = AREA_SPAWN_MODE_OPEN

// Research
/datum/techweb_node/cyborg_security
	id = "cyborg_security"
	display_name = "Cyborg security"
	description = "Tools for security."
	prereq_ids = list("robotics", "sec_basic")
	design_ids = list(
		"BAPgrenade",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3500)

/datum/design/BAPgrenade
	name = "B.A.P. unit"
	id = "BAPgrenade"
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/gold = 2000, /datum/material/silver = 2000)
	build_path = /obj/item/grenade/borg_action_pacifier_grenade
	build_type = AUTOLATHE | PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE
	category = list(RND_CATEGORY_EQUIPMENT)

// The item
/obj/structure/bed/borg_action_pacifier
	name = "deployed B.A.P. unit"
	desc = "An inactivated device to constrain silicons with."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "up"
	anchored = FALSE
	resistance_flags = FIRE_PROOF | FREEZE_PROOF
	flags_1 = NODECONSTRUCT_1

	bolts = FALSE
	/// The cyborg currently buckled to the BAP
	var/mob/living/silicon/robot/buckled_cyborg
	/// If the BAP is deployed or not
	var/deployed = TRUE
	/// Wether or not the machine is locking the cyborg
	var/locked = FALSE
	/// To distinguish if the machine is pumping or draining
	var/enabled_function = NONE
	/// Amount of power drained from the cyborg, which we are now storing
	var/power_storage = 0

/obj/structure/bed/borg_action_pacifier/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/check_alt_clicked_radial)
	update_appearance(UPDATE_ICON)

/obj/structure/bed/borg_action_pacifier/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_CLICK_ALT)
	if(buckled_cyborg)
		unlock()

/obj/structure/bed/borg_action_pacifier/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]-em", alpha = src.alpha)

/obj/structure/bed/borg_action_pacifier/atom_destruction(damage_flag)
	var/turf/debris = get_turf(src)
	if(power_storage && power_storage >= 5000)
		explosion(src, -1, (power_storage / 12500), (power_storage / 12500), (power_storage / 5000), -1)

	new /obj/effect/decal/cleanable/robot_debris(debris)
	return ..()

/obj/structure/bed/borg_action_pacifier/examine(mob/user)
	. = ..()
	if(locked)
		. += span_notice("It's locked.")
	if(enabled_function != NONE)
		. += span_notice("It's [enabled_function]ing power...")
	. += span_notice("It's currently holding [power_storage] units worth of charge.")
	if(power_storage == MAX_POWER)
		. += span_warning("It cannot store any more power.")

// The grenade
/obj/item/grenade/borg_action_pacifier_grenade
	name = "B.A.P. grenade"
	desc = "A deactivated device to restrain silicons with."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "folded"
	lefthand_file = 'modular_skyrat/modules/deployables/icons/mob/inhand/deployable_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deployables/icons/mob/inhand/deployable_righthand.dmi'
	inhand_icon_state = "BAPer_inhand"
	worn_icon = 'modular_skyrat/modules/deployables/icons/mob/deployable_worn.dmi'
	worn_icon_state = "BAPer_worn"
	w_class = WEIGHT_CLASS_NORMAL

	custom_price = PAYCHECK_CREW * 2
	det_time = 3 SECONDS
	/// Amount of power drained from the cyborg, from when we were still deployed
	var/power_storage = 0

/obj/item/grenade/borg_action_pacifier_grenade/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/check_alt_clicked_grenade)

/obj/item/grenade/borg_action_pacifier_grenade/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_CLICK_ALT)

/obj/item/grenade/borg_action_pacifier_grenade/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	var/obj/structure/bed/borg_action_pacifier/BAPer = new (get_turf(src))
	BAPer.power_storage = power_storage
	if(obj_flags & EMAGGED)
		BAPer.obj_flags |= EMAGGED
	BAPer.deployed = FALSE //Unlike roundstarts we have to perform the whole song and dance
	BAPer.icon_state = "down"
	BAPer.deploy()
	qdel(src)

/obj/item/grenade/borg_action_pacifier_grenade/examine(mob/user)
	. = ..()
	. += span_notice("It's currently holding [power_storage] units worth of charge.")
	if(power_storage == MAX_POWER)
		. += span_warning("It cannot store any more power.")

// Alt-click control
// Venting the power out of the grenade-form
/obj/item/grenade/borg_action_pacifier_grenade/proc/check_alt_clicked_grenade(datum/source, mob/living/clicker)
	SIGNAL_HANDLER

	if(!istype(clicker))
		return
	. = COMPONENT_CANCEL_CLICK_ALT
	INVOKE_ASYNC(src, .proc/alt_clicked_grenade, clicker)

/obj/item/grenade/borg_action_pacifier_grenade/proc/alt_clicked_grenade(mob/living/clicker)
	if(!power_storage || !clicker)
		return

	var/turf/open/pos = get_turf(src)
	var/vent_scale // A factor of how big the fake vapor will be
	vent_scale = (power_storage / (MAX_POWER / 6)) // Max tile-range of 6

	if(istype(pos))
		for(var/i in 1 to vent_scale)
			ventilate_effect(pos, vent_scale)
	clicker.visible_message(span_warning("[clicker] ventilates the power stored inside [src]..."))
	playsound(src, 'sound/effects/spray.ogg', (vent_scale * 10), TRUE)
	power_storage = 0

/obj/structure/bed/borg_action_pacifier/proc/deploy()
	if(deployed)
		return
	name = "deploying B.A.P. unit"

	balloon_alert_to_viewers("unfolding...")
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_trap.ogg', 25, TRUE, falloff_exponent = 10)
	addtimer(CALLBACK(src, .proc/finish_deploy), SETUP_TIME)
	flick("deploying", src)

/obj/structure/bed/borg_action_pacifier/proc/finish_deploy()
	name = "deployed B.A.P. unit"
	icon_state = "up"
	deployed = TRUE

	if(obj_flags & EMAGGED)
		// MEATBAG TERMINATION MODE ONLINE - line 478~
		var/mob/living/simple_animal/hostile/borg_action_pacifier/BAPer = new (get_turf(src))
		BAPer.power_storage = power_storage // Gotta keep that boom
		BAPer.check_smoke() // Telegraph how bigly we explode on death
		BAPer.balloon_alert_to_viewers("ERROR!")
		BAPer.emote("exclaim")
		qdel(src)
	else
		balloon_alert_to_viewers("deployed")
		playsound(src, 'sound/machines/ping.ogg', 25, FALSE, falloff_exponent = 10)

/obj/structure/bed/borg_action_pacifier/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if((over_object == usr) && Adjacent(usr))
		if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
			return FALSE
		if(has_buckled_mobs() || deployed)
			return FALSE

		usr.visible_message(span_notice("[usr] collapses [src]."), span_notice("You collapse [src]."))
		var/obj/item/grenade/borg_action_pacifier_grenade/BAPer = new (get_turf(src))
		usr.put_in_hands(BAPer)
		BAPer.power_storage = power_storage
		qdel(src)

// Radial menu for the deployed model's function controls
/obj/structure/bed/borg_action_pacifier/proc/check_alt_clicked_radial(datum/source, mob/living/clicker)
	SIGNAL_HANDLER

	if(!istype(clicker))
		return
	. = COMPONENT_CANCEL_CLICK_ALT
	INVOKE_ASYNC(src, .proc/alt_clicked_radial, clicker)

/obj/structure/bed/borg_action_pacifier/proc/alt_clicked_radial(mob/living/clicker)
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
			balloon_alert_to_viewers("locked")
			lock(clicker)
		if(UNLOCK)
			balloon_alert_to_viewers("unlocked")
			unlock(clicker)
		if(STOP_MODE)
			balloon_alert(clicker, "stopped [enabled_function]ing")
			stop_mode()
		if(DRAIN_MODE)
			balloon_alert(clicker, "draining...")
			drain_mode()
		if(PUMP_MODE)
			balloon_alert(clicker, "pumping...")
			pump_mode()
		if(FOLD)
			balloon_alert(clicker, "folding up...")
			if(do_after(clicker, 3 SECONDS, src))
				balloon_alert_to_viewers("resetting...")
				undeploy()

/obj/structure/bed/borg_action_pacifier/proc/check_menu(mob/user)
	if(!istype(user))
		CRASH("A non-mob is trying to issue an order.")
	if(user.incapacitated() || !can_see(user, src) || user == buckled_cyborg)
		return FALSE
	return TRUE

// Functions for the radial choices
/obj/structure/bed/borg_action_pacifier/process()
	if(!buckled_cyborg)
		return

	/// The cyborg's current cell
	var/obj/item/stock_parts/cell/cell = buckled_cyborg.cell

	switch(enabled_function)
		if(DRAIN_MODE)
			if(cell.charge > 0)
				drain_cell(cell, TRANSFER_INC)

			if(cell.charge <= 0)
				cell.charge = 0
				stop_mode()

			else if(power_storage > MAX_POWER)
				power_storage = MAX_POWER
				stop_mode()

		if(PUMP_MODE)
			if(power_storage > 0)
				pump_cell(cell, TRANSFER_INC)

			if(power_storage <= 0)
				power_storage = 0
				stop_mode()

			else if(cell.charge > cell.maxcharge)
				cell.charge = cell.maxcharge
				stop_mode()

		if(NONE)
			return

/obj/structure/bed/borg_action_pacifier/proc/drain_cell(obj/item/stock_parts/cell/cell)
	if(locked)
		render_lock()
	else
		buckled_cyborg.regenerate_icons()

	cell.charge = cell.charge - TRANSFER_INC
	power_storage = power_storage + TRANSFER_INC

	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_drain.ogg', 25, FALSE, falloff_exponent = 10)
	do_sparks(1, TRUE, buckled_cyborg)

/obj/structure/bed/borg_action_pacifier/proc/pump_cell(obj/item/stock_parts/cell/cell)
	if(locked)
		render_lock()
	else
		buckled_cyborg.regenerate_icons()

	power_storage = power_storage - TRANSFER_INC
	cell.charge = cell.charge + TRANSFER_INC

	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_pump.ogg', 25, FALSE, falloff_exponent = 10)
	do_sparks(1, TRUE, buckled_cyborg)

/obj/structure/bed/borg_action_pacifier/proc/drain_mode()
	enabled_function = DRAIN_MODE

/obj/structure/bed/borg_action_pacifier/proc/pump_mode()
	enabled_function = PUMP_MODE

/obj/structure/bed/borg_action_pacifier/proc/stop_mode()
	playsound(src, 'sound/machines/ping.ogg', 50, FALSE, falloff_exponent = 10)
	enabled_function = NONE

/obj/structure/bed/borg_action_pacifier/proc/lock(mob/living/clicker)
	if(clicker)
		log_combat(clicker, buckled_cyborg, "locked down cyborg")

	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_lock.ogg', 50, TRUE, falloff_exponent = 10)
	buckled_cyborg.SetLockdown(TRUE)
	locked = TRUE
	render_lock()

/obj/structure/bed/borg_action_pacifier/proc/unlock(mob/living/clicker)
	if(clicker)
		log_combat(clicker, buckled_cyborg, "released cyborg")

	buckled_cyborg.SetLockdown(FALSE)
	buckled_cyborg.regenerate_icons()
	locked = FALSE

/obj/structure/bed/borg_action_pacifier/proc/render_lock()
	// Emergency lights which are otherwise shamefully unused
	buckled_cyborg.cut_overlay(buckled_cyborg.eye_lights)
	buckled_cyborg.eye_lights = new()
	buckled_cyborg.eye_lights.icon_state = "[buckled_cyborg.model.cyborg_base_icon]_e_r"
	buckled_cyborg.eye_lights.plane = ABOVE_LIGHTING_PLANE
	buckled_cyborg.eye_lights.icon = buckled_cyborg.icon
	buckled_cyborg.add_overlay(buckled_cyborg.eye_lights)

/obj/structure/bed/borg_action_pacifier/proc/undeploy(mob/living/clicker)
	if(!deployed)
		return
	if(locked)
		unlock()
	if(buckled_cyborg)
		unbuckle_mob(buckled_cyborg, TRUE)

	addtimer(CALLBACK(src, .proc/finish_undeploy), SETUP_TIME)
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_trap.ogg', 25, TRUE, falloff_exponent = 10)
	flick("undeploying", src)

/obj/structure/bed/borg_action_pacifier/proc/finish_undeploy()
	var/obj/item/grenade/borg_action_pacifier_grenade/BAPer = new (get_turf(src))
	BAPer.power_storage = power_storage
	BAPer.balloon_alert_to_viewers("reset")
	if(obj_flags & EMAGGED)
		BAPer.obj_flags |= EMAGGED
	qdel(src)

// Buckle overwrites
/obj/structure/bed/borg_action_pacifier/buckle_mob(mob/living/target, force, check_loc)
	if(!deployed)
		return
	if(iscarbon(target))
		var/mob/living/carbon/carbon = target
		carbon.rotate_on_lying = 0
	..()

/obj/structure/bed/borg_action_pacifier/user_buckle_mob(mob/living/target, mob/user, check_loc)
	if(!target || !user)
		return

	if(target && (target != user))
		user.visible_message(span_warning("[user] starts buckling [target] to [src]!"))
	else
		target.visible_message(span_warning("[target] starts buckling [target.p_them()]self to [src]!"))
		if(!do_after(target, 1.5 SECONDS, src)) // The added delay is to prevent accidental buckling
			return
	..()

/obj/structure/bed/borg_action_pacifier/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(!iscarbon(buckled_mob))
		var/mob/living/carbon/carbon = buckled_mob
		carbon.rotate_on_lying = 1
		return ..()
	if(!force)
		return
	..()

/obj/structure/bed/borg_action_pacifier/post_buckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = (target.base_pixel_y + 18)
		return
	buckled_cyborg = target
	set_density(TRUE)

	// Offset managing
	if(R_TRAIT_TALL in buckled_cyborg.model.model_features)
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + 18)
	if(R_TRAIT_SMALL in buckled_cyborg.model.model_features)
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + 12)
	else if(!((R_TRAIT_SMALL || R_TRAIT_TALL) in buckled_cyborg.model.model_features))
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + 16)

	START_PROCESSING(SSobj, src)

/obj/structure/bed/borg_action_pacifier/post_unbuckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = initial(target.pixel_y)
		return
	unlock() // Just in case
	buckled_cyborg = null
	set_density(FALSE)

	target.pixel_y = target.base_pixel_y + target.body_position_pixel_y_offset

	enabled_function = NONE
	STOP_PROCESSING(SSobj, src)

/obj/structure/bed/borg_action_pacifier/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	if(!(buckled_mob in buckled_mobs) || !user.CanReach(buckled_mob))
		return

	if(buckled_mob && (buckled_mob != user))
		if(locked)
			user.visible_message(span_notice("[user] begins to overwrite the lock to unbuckle [buckled_mob] from [src]."),\
				span_notice("You begin to free [buckled_mob] from [src]."))
			if(!do_after(user, 6 SECONDS, src))
				return
		else
			user.visible_message(span_notice("[user] begins to unbuckle [buckled_mob] from [src]."),\
				span_notice("You begin to unbuckle [buckled_mob] from [src]."))
			if(!do_after(user, 3 SECONDS, src))
				return

	else
		if(locked)
			if(buckled_cyborg.low_power_mode)
				to_chat(buckled_mob, span_notice("Without power, attempting to break free is hopeless..."))
				return
			buckled_mob.visible_message(span_notice("[buckled_mob] begins to break out of [buckled_mob.p_their()] restraints."),\
				span_notice("You begin to free yourself from [src]."))
			if(!do_after(buckled_mob, 20 SECONDS, src))
				return
		else
			buckled_mob.visible_message(span_notice("[buckled_mob] begins to unbuckle [buckled_mob.p_them()]self from [src]."),\
				span_notice("You begin to unbuckle yourself from [src]."))
			if(!do_after(buckled_mob, 6 SECONDS, src))
				return

	add_fingerprint(user)
	if(isliving(buckled_mob.pulledby))
		var/mob/living/living = buckled_mob.pulledby
		living.set_pull_offsets(buckled_mob, living.grab_state)

	var/mob/living/target = unbuckle_mob(buckled_mob, TRUE)
	return target

// Fluff
/mob/living/simple_animal/hostile/borg_action_pacifier
	name = "BAPer"
	desc = ""
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "emagged"
	faction = list("silicon")
	friends = list(/mob/living/silicon)
	layer = LOW_MOB_LAYER
	stat_attack = HARD_CRIT
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	speak_chance = 25
	speak = list("Die, meatbags!")
	maxHealth = 180
	health = 180
	damage_coeff = list(BRUTE = 1, BURN = 1.2, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	speed = 0.5
	melee_damage_lower = 10
	melee_damage_upper = 15
	wound_bonus = -15
	bare_wound_bonus = 5
	rapid_melee = 2
	dodging = TRUE
	dodge_prob = 25
	environment_smash = ENVIRONMENT_SMASH_WALLS
	can_buckle = TRUE
	can_buckle_to = FALSE
	healable = 0
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch4.ogg'
	robust_searching = TRUE
	loot = list(/obj/effect/decal/cleanable/robot_debris)
	flip_on_death = TRUE
	var/power_storage //Hope you remembered to discharge...

/mob/living/simple_animal/hostile/borg_action_pacifier/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, .proc/dir_change)
	update_appearance(UPDATE_ICON)

/mob/living/simple_animal/hostile/borg_action_pacifier/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)

/mob/living/simple_animal/hostile/borg_action_pacifier/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "up-em", alpha = src.alpha)

/obj/structure/bed/borg_action_pacifier/emag_act(mob/clicker)
	if(obj_flags & EMAGGED)
		return
	to_chat(clicker, span_notice("You override the cheat code menu and skip to Cheat #[rand(1, 50)]: Realism Mode."))
	clicker.log_message("emagged [src], activating Realism Mode.", LOG_GAME)
	name = "The Orion Trail: Realism Edition"
	desc = "Learn how our ancestors got to Orion, and try not to die in the process!"
	undeploy()
	do_sparks(2, TRUE, src)
	obj_flags |= EMAGGED

/obj/item/grenade/borg_action_pacifier_grenade/emag_act(mob/clicker)
	if(obj_flags & EMAGGED)
		return
	to_chat(clicker, span_notice("You override the cheat code menu and skip to Cheat #[rand(1, 50)]: Realism Mode."))
	clicker.log_message("emagged [src], activating Realism Mode.", LOG_GAME)
	name = "The Orion Trail: Realism Edition"
	desc = "Learn how our ancestors got to Orion, and try not to die in the process!"
	do_sparks(2, TRUE, src)
	obj_flags |= EMAGGED

/mob/living/simple_animal/hostile/borg_action_pacifier/user_buckle_mob(mob/living/target, mob/user, check_loc)
	if(!do_after(target, 1.5 SECONDS, src))
		return
	..()

/mob/living/simple_animal/hostile/borg_action_pacifier/post_buckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = (target.base_pixel_y + 18)
		return
	var/mob/living/silicon/robot/buckled_cyborg = target
	if(R_TRAIT_TALL in buckled_cyborg.model.model_features)
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + 18)
	if(R_TRAIT_SMALL in buckled_cyborg.model.model_features)
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + 12)
	else if(!((R_TRAIT_SMALL || R_TRAIT_TALL) in buckled_cyborg.model.model_features))
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + 16)

/mob/living/simple_animal/hostile/borg_action_pacifier/post_unbuckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = initial(target.pixel_y)
		return

	target.pixel_y = target.base_pixel_y + target.body_position_pixel_y_offset

/mob/living/simple_animal/hostile/borg_action_pacifier/CanAttack(the_target)
	if(ismob(the_target)) //Can't kick up! :-)
		var/mob/target = the_target
		if(target in buckled_mobs)
			return FALSE
	return ..()

/mob/living/simple_animal/hostile/borg_action_pacifier/death(gibbed)
	if(power_storage && power_storage >= 5000)
		explosion(src, -1, (power_storage / 12500), (power_storage / 12500), (power_storage / 5000), -1)
	QDEL_NULL(particles)
	return ..()

/mob/living/simple_animal/hostile/borg_action_pacifier/proc/check_smoke()
	if(power_storage)
		if(power_storage >= 5000)
			particles = new /particles/smoke/robot/BAPer/mild()
		if(power_storage >= 20000)
			particles = new /particles/smoke/robot/BAPer/bad()
		if(power_storage >= 35000)
			particles = new /particles/smoke/robot/BAPer/full()
		else if (power_storage < 5000)
			return

/mob/living/simple_animal/hostile/borg_action_pacifier/proc/dir_change(datum/source, olddir, newdir)
	SIGNAL_HANDLER

	if(!particles)
		return
	var/truedir = dir
	if(newdir && (truedir != newdir))
		truedir = newdir

	switch(truedir)
		if(NORTH)
			particles.position = list(-4, 8, 0)
			particles.drift = generator("vector", list(0, 0.4), list(0.2, -0.2))
		if(EAST)
			particles.position = list(4, 8, 0)
			particles.drift = generator("vector", list(0, 0.4), list(-0.8, 0.2))
		if(SOUTH)
			particles.position = list(4, 0, 0)
			particles.drift = generator("vector", list(0, 0.4), list(0.2, -0.2))
		if(WEST)
			particles.position = list(-4, 0, 0)
			particles.drift = generator("vector", list(0, 0.4), list(0.8, -0.2))

/particles/smoke/robot/BAPer
	position = list(4, 8, 0)
	scale = 0.8
	icon_state = list("steam_1" = 1, "steam_2" = 1, "steam_3" = 2)
/particles/smoke/robot/BAPer/mild
	color = "#FFFFFF"
/particles/smoke/robot/BAPer/bad
	color = "#ababab"
/particles/smoke/robot/BAPer/full
	color = "#636363"

/mob/living/simple_animal/hostile/borg_action_pacifier/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(has_gravity())
		playsound(src, 'modular_skyrat/master_files/sound/effects/robot_step.ogg', 100, TRUE)
	// I know footstep is a mob variable but its so hardcoded and nonmodular...

/obj/structure/bed/borg_action_pacifier/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(has_gravity())
		playsound(src, 'modular_skyrat/master_files/sound/effects/robot_step.ogg', 100, TRUE)

/obj/item/grenade/borg_action_pacifier_grenade/proc/ventilate_effect(turf/open/location, vent_scale)
	var/list/turfs_affected = list(location)
	var/list/turfs_to_spread = list(location)
	var/spread_stage = vent_scale
	for(var/i in 1 to vent_scale)
		if(!length(turfs_to_spread))
			break
		var/list/new_spread_list = list()
		for(var/turf/open/turf_to_spread as anything in turfs_to_spread)
			if(isspaceturf(turf_to_spread))
				continue
			var/obj/effect/abstract/fake_steam/fake_steam = locate() in turf_to_spread
			var/at_edge = FALSE
			if(!fake_steam)
				at_edge = TRUE
				fake_steam = new(turf_to_spread)
			fake_steam.stage_up(spread_stage)

			if(!at_edge)
				for(var/turf/open/open_turf as anything in turf_to_spread.atmos_adjacent_turfs)
					if(open_turf in turfs_affected)
						continue
					new_spread_list += open_turf
					turfs_affected += open_turf

		turfs_to_spread = new_spread_list
		spread_stage--

#undef FOLD

#undef UNLOCK
#undef LOCK

#undef STOP_MODE
#undef DRAIN_MODE
#undef PUMP_MODE

#undef MAX_POWER
#undef TRANSFER_INC
#undef SETUP_TIME
