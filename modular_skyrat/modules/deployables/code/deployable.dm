#define FOLD "fold"

#define UNLOCK "unlock"
#define LOCK "lock"

#define STOP_MODE "stop"
#define DRAIN_MODE "drain"
#define PUMP_MODE "pump"

#define RADIAL_UI 'modular_skyrat/modules/deployables/icons/deployable_indicator.dmi'

///	The scale modifier for the undeployed bay existing in the game-world
#define INWORLD_SCALE 0.75
///	BS cell capacity, a potato battery would still outplay this
#define MAX_POWER 40000
///	Amount of power per tick pumped/drained
#define TRANSFER_INC 1000
///	How quick does it (un)fold? Warning: this tries to match an animation
#define SETUP_TIME 2 SECONDS
///	Maximum amount of tile by tile the power ventilation vapor can cover
#define VENT_MAX_RANGE 6
///	Minimum power storage requiremed in order to explode on destruction
#define EXPL_MIN_REQ 5000
///	Explosion capacity will be its power storage divided by this define
#define EXPL_CHARGE_MOD 12500

//	Automapper datums
/datum/area_spawn/cyborg_control_bay
	target_areas = list(/area/station/security/lockers, /area/station/security/office)
	desired_atom = /obj/item/grenade/cyborg_control_bay_undeployed
	amount_to_spawn = 2
	mode = AREA_SPAWN_MODE_OPEN

/datum/area_spawn/cyborg_control_bay_deployed
	target_areas = list(/area/station/science/robotics/mechbay, /area/station/science/robotics/lab)
	desired_atom = /obj/structure/bed/cyborg_control_bay
	optional = TRUE
	amount_to_spawn = 2
	mode = AREA_SPAWN_MODE_OPEN

//	Research node
/datum/techweb_node/cyborg_security
	id = "cyborg_security"
	display_name = "Silicon Malfunction Solutions"
	description = "A portable device which manually overrides and controls a cyborg's OS."
	prereq_ids = list("robotics", "sec_basic")
	design_ids = list(
		"cyborg_control_bay",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)
	discount_experiments = list(/datum/experiment/ordnance/explosive/highyieldbomb = 5000)

/datum/design/cyborg_control_bay
	name = "Deployable Control-Bay"
	id = "cyborg_control_bay"
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/gold = 2000, /datum/material/silver = 2000)
	build_path = /obj/item/grenade/cyborg_control_bay_undeployed
	build_type = AUTOLATHE | PROTOLATHE
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE
	category = list(RND_CATEGORY_EQUIPMENT)

//	The control bay in its deployed state
/obj/structure/bed/cyborg_control_bay
	name = "cyborg control-bay"
	desc = "A nimble device with an electric port suited to connect with station-approved cyborgs. Once attached the control-bay supersedes the cyborg's OS hierarchy to allow for maintenance."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "up"
	anchored = FALSE
	resistance_flags = FIRE_PROOF | FREEZE_PROOF
	flags_1 = NODECONSTRUCT_1

	bolts = FALSE
	///	The cyborg currently buckled to the cyborg_control_bay
	var/mob/living/silicon/robot/buckled_cyborg
	///	If the cyborg_control_bay is deployed or not
	var/deployed = TRUE
	///	Wether or not the machine is locking the cyborg
	var/locked = FALSE
	///	To distinguish if the machine is pumping or draining
	var/enabled_function = NONE
	///	Amount of power drained from the cyborg, which we are now storing
	var/power_storage = 0

/obj/structure/bed/cyborg_control_bay/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/check_alt_clicked_radial)
	update_appearance(UPDATE_ICON)

/obj/structure/bed/cyborg_control_bay/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_CLICK_ALT)
	if(buckled_cyborg)
		unlock()
		buckled_cyborg = null

//	A destruction call to explode if the bay held a decent amount of power
/obj/structure/bed/cyborg_control_bay/atom_destruction(damage_flag)
	var/turf/debris = get_turf(src)
	if(power_storage >= EXPL_MIN_REQ)
		explosion(src, -1, (power_storage / EXPL_CHARGE_MOD), (power_storage / EXPL_CHARGE_MOD), (power_storage / EXPL_CHARGE_MOD), -1)

	new /obj/effect/decal/cleanable/robot_debris(debris)
	return ..()

/obj/structure/bed/cyborg_control_bay/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "[icon_state]-em", alpha = src.alpha)

/obj/structure/bed/cyborg_control_bay/examine(mob/user)
	. = ..()
	if(buckled_cyborg)
		. += span_notice("Alt+Click to operate.")
	else
		. += span_notice("Alt+Click to undeploy.")

	if(power_storage)
		. += span_notice("Its power storage gauge indicates that it is currently storing <b>[power_storage] J</b> out of a maximum of <b>[MAX_POWER] J</b>.")
	if(enabled_function != NONE)
		. += span_notice("It's currently <b>[enabled_function]ing</b> power.")
	if(locked)
		. += span_warning("Its locking mode indicator is currently lit!")

//	Emagging undeploys and becomes a hostile mob on next deploy
/obj/structure/bed/cyborg_control_bay/emag_act(mob/clicker)
	if(obj_flags & EMAGGED)
		return

	to_chat(clicker, span_notice("You activate a sequence remnant from early development, initiating a combat program once the device deploys."))
	clicker.log_message("emagged [src], activating its combat mode.", LOG_GAME)
	undeploy()
	do_sparks(2, TRUE, src)
	obj_flags |= EMAGGED

//	If EMPd, turn off and flag accordingly
/obj/structure/bed/cyborg_control_bay/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return

	obj_flags |= EMPED
	undeploy()

/obj/structure/bed/cyborg_control_bay/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(has_gravity())
		playsound(src, 'modular_skyrat/master_files/sound/effects/robot_step.ogg', 100, TRUE)

//	Radial menu for the deployed model's function controls
/obj/structure/bed/cyborg_control_bay/proc/check_alt_clicked_radial(datum/source, mob/living/clicker)
	SIGNAL_HANDLER

	if(!istype(clicker))
		return

	INVOKE_ASYNC(src, .proc/alt_clicked_radial, clicker)
	return COMPONENT_CANCEL_CLICK_ALT

/* 	If the bay is deployed and has a target, alt+clicking reveals its radial controls.
	Locking and unlocking functions like the RD's console, but can't keep locked without staying active.
	Draining and pumping charges and uncharges the target's cell until at capacity.
	When no target is found alt+clicking begins undeployment of the bay.	*/
/obj/structure/bed/cyborg_control_bay/proc/alt_clicked_radial(mob/living/clicker)
	var/list/choices = list()

	if(buckled_cyborg)
		if(!locked)
			choices += list(LOCK = image(icon = RADIAL_UI, icon_state = "lock"))
		else
			choices += list(UNLOCK = image(icon = RADIAL_UI, icon_state = "unlock"))

		if(!enabled_function)
			if(buckled_cyborg.cell && buckled_cyborg.cell.charge > 0)
				choices += list(DRAIN_MODE = image(icon = RADIAL_UI, icon_state = "drain"))
			if(buckled_cyborg.cell && power_storage > 0)
				choices += list(PUMP_MODE = image(icon = RADIAL_UI, icon_state = "pump"))
		else
			choices += list(STOP_MODE = image(icon = RADIAL_UI, icon_state = "stop"))
	else
		set_mode(clicker, FOLD)
		return

	var/choice = show_radial_menu(clicker, src, choices, custom_check = CALLBACK(src, .proc/check_menu, clicker), tooltips = TRUE)

	if(!choice || !check_menu(clicker))
		return

	set_mode(clicker, choice)

/obj/structure/bed/cyborg_control_bay/proc/set_mode(mob/living/clicker, choice)
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
				say("Resetting...")
				undeploy()

/obj/structure/bed/cyborg_control_bay/proc/check_menu(mob/user)
	if(!istype(user))
		CRASH("A non-mob is trying to issue an order.")

	if(user.incapacitated() || !can_see(user, src) || user == buckled_cyborg)
		return FALSE

	return TRUE

//	Proc that is called once the bay's undeployed version calls detonate()
/obj/structure/bed/cyborg_control_bay/proc/deploy()
	if(deployed)
		return
	name = "deploying control-bay"

	balloon_alert_to_viewers("unfolding...")
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_trap.ogg', 25, TRUE, falloff_exponent = 10)
	addtimer(CALLBACK(src, .proc/finish_deploy), SETUP_TIME)
	flick("deploying", src)

//	Proc to finalize deployement, being called after SETUP_TIME's timer and its animation flick()
//	If emagged it will instead spawn itself as a hostile mob
/obj/structure/bed/cyborg_control_bay/proc/finish_deploy()
	name = "cyborg control-bay"
	icon_state = "up"
	deployed = TRUE

	if(obj_flags & EMAGGED)
		var/mob/living/simple_animal/hostile/cyborg_control_bay/cyborg_control_bay = new (get_turf(src))
		cyborg_control_bay.power_storage = power_storage // Gotta keep that boom
		cyborg_control_bay.check_smoke() // Telegraph how bigly we explode on death
		cyborg_control_bay.say("ERROR!")
		cyborg_control_bay.emote("exclaim")
		qdel(src)
	else
		balloon_alert_to_viewers("deployed")
		playsound(src, 'sound/machines/ping.ogg', 25, FALSE, falloff_exponent = 10)

//	Proc that is called when the bay begins undeploying due to user controls, emag or EMP
/obj/structure/bed/cyborg_control_bay/proc/undeploy()
	if(!deployed)
		return

	if(locked)
		unlock()

	if(buckled_cyborg)
		unbuckle_mob(buckled_cyborg, TRUE)

	addtimer(CALLBACK(src, .proc/finish_undeploy), SETUP_TIME)
	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_trap.ogg', 25, TRUE, falloff_exponent = 10)
	flick("undeploying", src)

//	Proc to finalize undeployment, after SETUP_TIME and its animated flick()
//	If EMPed the bay will force itself to discharge any stored power
/obj/structure/bed/cyborg_control_bay/proc/finish_undeploy()
	var/obj/item/grenade/cyborg_control_bay_undeployed/cyborg_control_bay = new (get_turf(src))

	cyborg_control_bay.power_storage = power_storage
	cyborg_control_bay.balloon_alert_to_viewers("reset")

	if(obj_flags & EMAGGED)
		cyborg_control_bay.obj_flags |= EMAGGED

	if(obj_flags & EMPED)
		cyborg_control_bay.obj_flags |= EMPED

		if(cyborg_control_bay.power_storage)
			cyborg_control_bay.alt_clicked_grenade()

	qdel(src)

//	Functions for the radial choices
//	This gets called every tick if active
/obj/structure/bed/cyborg_control_bay/process()
	if(!buckled_cyborg)
		return

	///	The cyborg's current cell
	var/obj/item/stock_parts/cell/cell = buckled_cyborg.cell
	if(!cell)
		return

	switch(enabled_function)
		if(DRAIN_MODE)
			drain_cell(cell)
		if(PUMP_MODE)
			pump_cell(cell)

//	Uncharging target until either its cell is empty or the control bay is at max capacity
/obj/structure/bed/cyborg_control_bay/proc/drain_cell(obj/item/stock_parts/cell/cell)
	if(locked)
		render_lock()
	else
		buckled_cyborg.regenerate_icons()

	if(power_storage >= MAX_POWER - TRANSFER_INC)
		var/remnant = MAX_POWER - power_storage
		cell.charge = cell.charge - remnant
		power_storage = power_storage + remnant
		stop_mode()
		return

	if(cell.charge <= TRANSFER_INC)
		var/remnant = cell.charge
		cell.charge = cell.charge - remnant
		power_storage = power_storage + remnant
		stop_mode()
		return


	cell.charge = cell.charge - TRANSFER_INC
	power_storage = power_storage + TRANSFER_INC

	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_drain.ogg', 25, FALSE, falloff_exponent = 10)
	do_sparks(1, TRUE, buckled_cyborg)

//	Charging target its cell until its at max capacity or the control bay is out of charge
/obj/structure/bed/cyborg_control_bay/proc/pump_cell(obj/item/stock_parts/cell/cell)
	if(locked)
		render_lock()
	else
		buckled_cyborg.regenerate_icons()

	if(cell.charge >= cell.maxcharge - TRANSFER_INC)
		var/remnant = cell.maxcharge - cell.charge
		power_storage = power_storage - remnant
		cell.charge = cell.charge + remnant
		stop_mode()
		return

	if(power_storage <= TRANSFER_INC)
		var/remnant = power_storage
		power_storage = power_storage - remnant
		cell.charge = cell.charge + remnant
		stop_mode()
		return

	power_storage = power_storage - TRANSFER_INC
	cell.charge = cell.charge + TRANSFER_INC

	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_pump.ogg', 25, FALSE, falloff_exponent = 10)
	do_sparks(1, TRUE, buckled_cyborg)

/obj/structure/bed/cyborg_control_bay/proc/drain_mode()
	enabled_function = DRAIN_MODE

/obj/structure/bed/cyborg_control_bay/proc/pump_mode()
	enabled_function = PUMP_MODE

//	Called on command when active or automatically if a charging error occurs
/obj/structure/bed/cyborg_control_bay/proc/stop_mode()
	playsound(src, 'sound/machines/ping.ogg', 50, FALSE, falloff_exponent = 10)
	enabled_function = NONE

//	Proc for locking the target, useful for logging
/obj/structure/bed/cyborg_control_bay/proc/lock(mob/living/clicker)
	if(clicker)
		log_combat(clicker, buckled_cyborg, "locked down cyborg")
		log_silicon("[key_name(clicker)] locked down [key_name(buckled_cyborg)].")

	playsound(src, 'modular_skyrat/master_files/sound/effects/robot_lock.ogg', 50, TRUE, falloff_exponent = 10)
	buckled_cyborg.SetLockdown(TRUE)
	locked = TRUE
	render_lock()

//	Unlock logging
/obj/structure/bed/cyborg_control_bay/proc/unlock(mob/living/clicker)
	if(clicker)
		log_combat(clicker, buckled_cyborg, "released cyborg")
		log_silicon("[key_name(clicker)] released [key_name(buckled_cyborg)] from lockdown.")

	buckled_cyborg.SetLockdown(FALSE)
	buckled_cyborg.regenerate_icons()
	locked = FALSE

//	Emergency lights which are otherwise shamefully unused
//	Not all cyborg models have a sprite for this, but render fine
/obj/structure/bed/cyborg_control_bay/proc/render_lock()
	buckled_cyborg.cut_overlay(buckled_cyborg.eye_lights)
	buckled_cyborg.eye_lights = new()
	buckled_cyborg.eye_lights.icon_state = "[buckled_cyborg.model.cyborg_base_icon]_e_r"
	buckled_cyborg.eye_lights.plane = ABOVE_LIGHTING_PLANE
	buckled_cyborg.eye_lights.icon = buckled_cyborg.icon
	buckled_cyborg.add_overlay(buckled_cyborg.eye_lights)

//	Buckle overwrites
//	Cannot buckle if not deployed
/obj/structure/bed/cyborg_control_bay/buckle_mob(mob/living/target, force, check_loc)
	if(!deployed)
		return

	return ..()

//	We are overwriting so regular unbuckling does not work
/obj/structure/bed/cyborg_control_bay/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(!force)
		return

	return ..()

//	Pixel y offsets to render buckled targets
///	For Roomba cyborgs
#define SMALL_OFFSET 12
///	For default cyborgs
#define NORMAL_OFFSET 16
///	For tall cyborgs and most carbons
#define TALL_OFFSET 18

/obj/structure/bed/cyborg_control_bay/post_buckle_mob(mob/living/target)
	if(isanimal(target) || isbasicmob(target))
		target.pixel_y = (target.base_pixel_y + TALL_OFFSET)
		return

	if(iscarbon(target))
		target.pixel_y = (target.base_pixel_y + TALL_OFFSET)
		target.set_lying_angle(0)
		return

	else if(iscyborg(target))
		buckled_cyborg = target
		set_density(TRUE)

		if(R_TRAIT_TALL in buckled_cyborg.model.model_features)
			buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + TALL_OFFSET)

		if(R_TRAIT_SMALL in buckled_cyborg.model.model_features)
			buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + SMALL_OFFSET)

		else if(!((R_TRAIT_SMALL || R_TRAIT_TALL) in buckled_cyborg.model.model_features))
			buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + NORMAL_OFFSET)

	//	We found a target we can manipulate, lets begin processing
		START_PROCESSING(SSobj, src)

//	Handling buckling to the emag mob
/mob/living/simple_animal/hostile/cyborg_control_bay/post_buckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = (target.base_pixel_y + TALL_OFFSET)
		return

	var/mob/living/silicon/robot/buckled_cyborg = target
	if(R_TRAIT_TALL in buckled_cyborg.model.model_features)
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + TALL_OFFSET)

	if(R_TRAIT_SMALL in buckled_cyborg.model.model_features)
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + SMALL_OFFSET)

	else if(!((R_TRAIT_SMALL || R_TRAIT_TALL) in buckled_cyborg.model.model_features))
		buckled_cyborg.pixel_y = (buckled_cyborg.base_pixel_y + NORMAL_OFFSET)

#undef SMALL_OFFSET
#undef NORMAL_OFFSET
#undef TALL_OFFSET

//	Called when we lose a target in traditional manner, lets reset
/obj/structure/bed/cyborg_control_bay/post_unbuckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = initial(target.pixel_y)
		return

	unlock() // Just in case
	buckled_cyborg = null
	set_density(FALSE)

	target.pixel_y = target.base_pixel_y + target.body_position_pixel_y_offset

	enabled_function = NONE
	STOP_PROCESSING(SSobj, src)

//	Regular y offset resetting
/mob/living/simple_animal/hostile/cyborg_control_bay/post_unbuckle_mob(mob/living/target)
	if(!iscyborg(target))
		target.pixel_y = initial(target.pixel_y)
		return

	target.pixel_y = target.base_pixel_y + target.body_position_pixel_y_offset

//	(Un)Buckle flavor texts
/obj/structure/bed/cyborg_control_bay/user_buckle_mob(mob/living/target, mob/user, check_loc)
	if(!target || !user)
		return

	if(target && (target != user))
		user.visible_message(span_warning("[user] starts buckling [target] to [src]!"))
	else
		target.visible_message(span_warning("[target] starts buckling [target.p_them()]self to [src]!"))
		if(!do_after(target, 1.5 SECONDS, src)) // The added delay is to prevent accidental buckling
			return

	return ..()

/obj/structure/bed/cyborg_control_bay/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	///	How long it will take for the target to be unbuckled depending on their status
	var/unbuckle_timer = 6 SECONDS

	if(buckled_mob != user)
		if(locked)
			user.visible_message(span_notice("[user] begins to overwrite the lock to unbuckle [buckled_mob] from [src]."),\
				span_notice("You begin to free [buckled_mob] from [src]."))
		else
			user.visible_message(span_notice("[user] begins to unbuckle [buckled_mob] from [src]."),\
				span_notice("You begin to unbuckle [buckled_mob] from [src]."))
			unbuckle_timer = 3 SECONDS
	else
		if(locked)
			if(buckled_cyborg.low_power_mode)
				to_chat(buckled_mob, span_notice("Without power, attempting to break free is hopeless..."))
				return

			buckled_mob.visible_message(span_notice("[buckled_mob] begins to break out of [buckled_mob.p_their()] restraints."),\
				span_notice("You begin to free yourself from [src]."))
			unbuckle_timer = 20 SECONDS
		else
			buckled_mob.visible_message(span_notice("[buckled_mob] begins to unbuckle [buckled_mob.p_them()]self from [src]."),\
				span_notice("You begin to unbuckle yourself from [src]."))

	if(!do_after(user, unbuckle_timer, src))
		return

	add_fingerprint(user)
	if(isliving(buckled_mob.pulledby))
		var/mob/living/living = buckled_mob.pulledby
		living.set_pull_offsets(buckled_mob, living.grab_state)

	var/mob/living/target = unbuckle_mob(buckled_mob, TRUE)
	return target

//	The control bay in its undeployed state
/obj/item/grenade/cyborg_control_bay_undeployed
	name = "deployable control-bay"
	desc = "A portable device with an electric port suited to connect with station-approved cyborgs."
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "folded"
	lefthand_file = 'modular_skyrat/modules/deployables/icons/mob/inhand/deployable_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deployables/icons/mob/inhand/deployable_righthand.dmi'
	inhand_icon_state = "cyborg_control_bay_inhand"
	worn_icon = 'modular_skyrat/modules/deployables/icons/mob/deployable_worn.dmi'
	worn_icon_state = "cyborg_control_bay_worn"
	w_class = WEIGHT_CLASS_NORMAL

	custom_price = PAYCHECK_CREW * 3.3 // Too expensive for round-start, but not crippling to buy later
	det_time = 3 SECONDS
	display_timer = FALSE
	///	Amount of power drained from the cyborg, from when we were still deployed
	var/power_storage = 0

/obj/item/grenade/cyborg_control_bay_undeployed/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/check_alt_clicked_grenade)
	AddElement(/datum/element/item_scaling, INWORLD_SCALE, INWORLD_SCALE)

/obj/item/grenade/cyborg_control_bay_undeployed/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_CLICK_ALT)

/obj/item/grenade/cyborg_control_bay_undeployed/multitool_act(mob/living/user, obj/item/tool)
	return FALSE

/obj/item/grenade/cyborg_control_bay_undeployed/screwdriver_act(mob/living/user, obj/item/tool)
	return FALSE

/obj/item/grenade/cyborg_control_bay_undeployed/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	var/obj/structure/bed/cyborg_control_bay/cyborg_control_bay = new (get_turf(src))
	if(obj_flags & EMAGGED)
		cyborg_control_bay.obj_flags |= EMAGGED

	cyborg_control_bay.power_storage = power_storage
	cyborg_control_bay.deployed = FALSE	//	Unlike roundstarts we have to perform the whole song and dance
	cyborg_control_bay.icon_state = "down"
	cyborg_control_bay.deploy()
	qdel(src)

/obj/item/grenade/cyborg_control_bay_undeployed/examine(mob/user)
	. = ..()
	. += span_notice("Alt+Click to ventilate its powerstorage.")
	if(power_storage)
		. += span_notice("Its currently holding [power_storage] units worth of charge.")
	if(power_storage == MAX_POWER)
		. += span_warning("It cannot store any more power.")

/obj/item/grenade/cyborg_control_bay_undeployed/emag_act(mob/clicker)
	if(obj_flags & EMAGGED)
		return

	to_chat(clicker, span_notice("You activate a sequence remnant from early development, initiating a combat program once the device deploys."))
	clicker.log_message("emagged [src], activating its combat mode.", LOG_GAME)
	do_sparks(2, TRUE, src)
	obj_flags |= EMAGGED

/*	A player may discharge an undeployed bay safely of its stored charge by alt+clicking it
	Doing so will make a fake cloud of water vapor of a size relative to the charge it held
	If the bay was deployed and hit by an EMP, it will force this ventilation effect.	*/
/obj/item/grenade/cyborg_control_bay_undeployed/proc/check_alt_clicked_grenade(datum/source, mob/living/clicker)
	SIGNAL_HANDLER

	if(!istype(clicker))
		return

	INVOKE_ASYNC(src, .proc/alt_clicked_grenade, clicker)
	return COMPONENT_CANCEL_CLICK_ALT

/obj/item/grenade/cyborg_control_bay_undeployed/proc/alt_clicked_grenade(mob/living/clicker)
	if(!power_storage)
		return

	var/turf/open/pos = get_turf(src)
	var/vent_range = VENT_MAX_RANGE * (power_storage / MAX_POWER)

	if(clicker)
		clicker.visible_message(span_warning("[clicker] ventilates the power stored inside [src]..."))

	if(obj_flags & EMPED)
		obj_flags &= ~EMPED
		visible_message(span_warning("[src] overloads and ventilates all of its stored power!"))

	if(istype(pos))
		for(var/i in 1 to vent_range)
			ventilate_effect(pos, vent_range)

	playsound(src, 'sound/effects/spray.ogg', (vent_range * 10), TRUE)
	power_storage = 0


//	The emag mob
/mob/living/simple_animal/hostile/cyborg_control_bay
	name = "cyborg control-bay"
	desc = "A nimble device with an electric port suited to connect with station-approved cyborgs. Why is it glowing red...?"
	icon = 'modular_skyrat/modules/deployables/icons/deployable.dmi'
	icon_state = "emagged"
	faction = list("silicon")
	friends = list(/mob/living/silicon)
	layer = LOW_MOB_LAYER
	stat_attack = HARD_CRIT
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	speak_chance = 5
	speak = list("Device encountered an error!", "Please contact device administration.", "If the issue persists, try a reboot cycle.")
	maxHealth = 140
	health = 140
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
	///	Transferred power storage from previous state, which will decide how big our death explosion will be
	var/power_storage

/mob/living/simple_animal/hostile/cyborg_control_bay/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, .proc/dir_change)
	update_appearance(UPDATE_ICON)

/mob/living/simple_animal/hostile/cyborg_control_bay/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)

/mob/living/simple_animal/hostile/cyborg_control_bay/update_overlays()
	. = ..()
	. += emissive_appearance(icon, "up-em", alpha = src.alpha)

/mob/living/simple_animal/hostile/cyborg_control_bay/user_buckle_mob(mob/living/target, mob/user, check_loc)
	if(!do_after(target, 1.5 SECONDS, src))
		return

	return ..()

/mob/living/simple_animal/hostile/cyborg_control_bay/CanAttack(the_target)
	if(target in buckled_mobs) //	Can't kick up! :-)
		return FALSE

//	If the mob is holding sufficient charge, explode accordingly
/mob/living/simple_animal/hostile/cyborg_control_bay/death(gibbed)
	if(power_storage >= EXPL_MIN_REQ)
		explosion(src, -1, (power_storage / EXPL_CHARGE_MOD), (power_storage / EXPL_CHARGE_MOD), (power_storage / EXPL_CHARGE_MOD), -1)

	QDEL_NULL(particles)
	return ..()

//	Pretty particle effects that telegraph how much charge it is holding, also gives some sense of which which dir its facing
/mob/living/simple_animal/hostile/cyborg_control_bay/proc/check_smoke()
	if(!power_storage)
		return

	switch(power_storage)
		if(EXPL_MIN_REQ to MAX_POWER / 2)
			particles = new /particles/smoke/robot/cyborg_control_bay/mild()
		if(MAX_POWER / 2 to MAX_POWER / 1.25)
			particles = new /particles/smoke/robot/cyborg_control_bay/bad()
		if (MAX_POWER / 1.25 to MAX_POWER)
			particles = new /particles/smoke/robot/cyborg_control_bay/full()

//	Direction updates for the smoke particle effect, because we have to suffer a little for things to look pretty
/mob/living/simple_animal/hostile/cyborg_control_bay/proc/dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER

	if(!particles)
		return

	var/true_dir = dir
	if(new_dir && (true_dir != new_dir))
		true_dir = new_dir

	switch(true_dir)
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

//	Smoke coloring
/particles/smoke/robot/cyborg_control_bay
	position = list(4, 8, 0)
	scale = 0.8
	icon_state = list("steam_1" = 1, "steam_2" = 1, "steam_3" = 2)

/particles/smoke/robot/cyborg_control_bay/mild
	color = "#FFFFFF"

/particles/smoke/robot/cyborg_control_bay/bad
	color = "#ababab"

/particles/smoke/robot/cyborg_control_bay/full
	color = "#636363"

/mob/living/simple_animal/hostile/cyborg_control_bay/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(has_gravity())
		playsound(src, 'modular_skyrat/master_files/sound/effects/robot_step.ogg', 100, TRUE)
	// I know footstep is a mob variable but its so hardcoded and nonmodular...

//	A solution for players to kill the emag mob without an explosion, EMPing will make it discharge like the regular item
/mob/living/simple_animal/hostile/cyborg_control_bay/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return

	if(power_storage)
		power_storage = 0

	if(particles)
		QDEL_NULL(particles)

//	The fake water vapor effect stolen from our modular bong.dm file
/obj/item/grenade/cyborg_control_bay_undeployed/proc/ventilate_effect(turf/open/location, vent_scale)
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
#undef RADIAL_UI

#undef INWORLD_SCALE
#undef MAX_POWER
#undef TRANSFER_INC
#undef SETUP_TIME
#undef VENT_MAX_RANGE
#undef EXPL_MIN_REQ
#undef EXPL_CHARGE_MOD
