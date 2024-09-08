#define BARREL_HEAT_THRESHOLD_LOW 50
#define BARREL_HEAT_THRESHOLD_HIGH 75
#define REPAIR_WELDER_COST 10

/obj/machinery/mounted_machine_gun
	name = "\improper T90 Mounted Machine Gun"
	desc = "A high calibre mounted machine gun capable of laying down copious amounts of suppressive fire."
	icon = 'modular_skyrat/modules/mounted_machine_gun/icons/turret.dmi'
	icon_state = "mmg"
	base_icon_state = "mmg"
	can_buckle = TRUE
	anchored = FALSE
	density = TRUE
	max_integrity = 250
	buckle_lying = 0
	SET_BASE_PIXEL(-8, -8)
	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	/// The extra range that this turret gives regarding viewrange.
	var/view_range = 2.5
	/// Sound to play when overheated
	var/overheatsound = 'sound/effects/wounds/sizzle2.ogg'
	/// Sound to play when firing
	var/firesound = 'modular_skyrat/modules/mounted_machine_gun/sound/50cal_box_01.ogg'
	/// How long it takes for a wrench user to undeploy the object
	var/undeploy_time = 3 SECONDS
	/// Our currently loaded ammo box.
	var/obj/item/ammo_box/magazine/ammo_box
	/// Our ammo box type.
	var/ammo_box_type = /obj/item/ammo_box/magazine/mmg_box
	/// A reference to our current user.
	var/mob/living/current_user
	/// The delay between each shot that is sent downrange.
	var/fire_delay = 0.2 SECONDS
	/// The current timer to fire the next round.
	var/nextshot_timer_id
	/// Is our cover open? Used to access the ammo box!
	var/cover_open = FALSE
	/// Do we have a supressor or something installed?
	var/suppressed = FALSE
	/// How much spread we have for projectiles.
	var/spread = 0
	/// The position of our bolt. TRUE = locked(ready to fire) FALSE = forward(not ready to fire)
	var/bolt = TRUE
	/// What we drop when undeployed. If null, cannot be undeployed.
	var/undeployed_type = /obj/item/mounted_machine_gun_folded

	// Heat mechanics
	/// How much barrel heat we generate per shot
	var/barrel_heat_per_shot = 2
	/// The current barrel heat.
	var/barrel_heat = 0
	/// Have we overheated?
	var/overheated = FALSE
	/// How long it takes until we can fire again after a heatlock.
	var/cooldown_time = 20 SECONDS
	/// How quickly the barrel naturally cools down
	var/passive_barrel_cooldown_rate = 2
	/// How much heat we can sustain before locking.
	var/max_barrel_heat = 100
	/// Our last registered target atom.
	var/datum/weakref/last_target_atom

	COOLDOWN_DECLARE(trigger_cooldown)

/obj/machinery/mounted_machine_gun/Destroy()
	QDEL_NULL(ammo_box)
	QDEL_NULL(particles)
	QDEL_NULL(last_target_atom)
	if(current_user)
		unregister_mob(current_user)
		current_user = null
	return ..()

/obj/machinery/mounted_machine_gun/process(seconds_per_tick)
	if(barrel_heat)
		barrel_heat -= passive_barrel_cooldown_rate * seconds_per_tick
		update_appearance()

/obj/machinery/mounted_machine_gun/update_overlays()
	. = ..()
	if(ammo_box)
		. += "ammo_box"
	if(cover_open)
		. += "cover_open"

	switch(barrel_heat)
		if(BARREL_HEAT_THRESHOLD_LOW to BARREL_HEAT_THRESHOLD_HIGH)
			. += "[base_icon_state]_barrel_hot"
		if(BARREL_HEAT_THRESHOLD_HIGH to INFINITY)
			. += "[base_icon_state]_barrel_overheat"

/obj/machinery/mounted_machine_gun/examine(mob/user)
	. = ..()
	if(ammo_box)
		. += span_notice("It has [ammo_box] loaded, with [ammo_box.ammo_count()] rounds remaining.")
	else
		. += span_danger("It does not have an ammo box loaded!")
	. += span_notice("The cover is [cover_open ? "open" : "closed"]. <b>Alt+click</b> to [cover_open ? "close" : "open"] it.")
	. += span_notice("Use a welder to repair it.")
	switch(barrel_heat)
		if(BARREL_HEAT_THRESHOLD_LOW to BARREL_HEAT_THRESHOLD_HIGH)
			. += span_warning("The barrel looks hot.")
		if(BARREL_HEAT_THRESHOLD_HIGH to INFINITY)
			. += span_warning("The barrel looks moulten!")
	if(overheated)
		. += span_danger("It is heatlocked!")

/obj/machinery/mounted_machine_gun/welder_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return
	if(atom_integrity >= max_integrity)
		balloon_alert(user, "it doesn't need repairs!")
		return TRUE
	balloon_alert_to_viewers("repairing...")
	if(!tool.use_tool(src, user, 4 SECONDS, amount = REPAIR_WELDER_COST, volume = 100))
		return TRUE
	update_integrity(max_integrity)
	balloon_alert_to_viewers("repaired!")

/// Undeploying, for when you want to move your big dakka around
/obj/machinery/mounted_machine_gun/wrench_act(mob/living/user, obj/item/wrench/used_wrench)
	if(user.combat_mode)
		return
	if(!undeployed_type)
		return TRUE
	if(!ishuman(user))
		return TRUE
	if(ammo_box)
		balloon_alert_to_viewers("remove ammo box!")
		return TRUE
	used_wrench.play_tool_sound(user)
	balloon_alert_to_viewers("undeploying...")
	if(!do_after(user, undeploy_time))
		return TRUE
	var/obj/undeployed_object = new undeployed_type(src)
	//Keeps the health the same even if you redeploy the gun
	undeployed_object.modify_max_integrity(max_integrity)
	qdel(src)

//BUCKLE HOOKS
/obj/machinery/mounted_machine_gun/unbuckle_mob(mob/living/buckled_mob, force = FALSE, can_fall = TRUE)
	playsound(src,'sound/mecha/mechmove01.ogg', 50, TRUE)
	for(var/obj/item/iterating_item in buckled_mob.held_items)
		if(istype(iterating_item, /obj/item/gun_control))
			qdel(iterating_item)
	if(istype(buckled_mob))
		buckled_mob.pixel_x = buckled_mob.base_pixel_x
		buckled_mob.pixel_y = buckled_mob.base_pixel_y
		buckled_mob?.client?.view_size.resetToDefault()
	set_anchored(FALSE)
	unregister_mob(current_user)
	current_user = null
	. = ..()

/obj/machinery/mounted_machine_gun/user_buckle_mob(mob/living/user_to_buckle, mob/buckling_user, check_loc = TRUE)
	if(user_to_buckle.incapacitated || !istype(user_to_buckle))
		return
	user_to_buckle.forceMove(get_turf(src))
	. = ..()
	if(!.)
		return

	register_user(user_to_buckle)

	layer = ABOVE_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	setDir(SOUTH)
	playsound(src,'sound/mecha/mechmove01.ogg', 50, TRUE)
	set_anchored(TRUE)

	update_positioning()

/obj/machinery/mounted_machine_gun/click_alt(mob/user)
	toggle_cover(user)
	return CLICK_ACTION_SUCCESS

/obj/machinery/mounted_machine_gun/attack_hand_secondary(mob/living/user, list/modifiers)
	. = ..()
	if(!istype(user))
		return
	if(!can_interact(user))
		return
	if(!cover_open)
		balloon_alert(user, "cover closed!")
		return
	if(!ammo_box)
		return
	remove_ammo_box(user)

/obj/machinery/mounted_machine_gun/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(!istype(weapon, ammo_box_type))
		return
	if(ammo_box)
		balloon_alert("already loaded!")
		return
	ammo_box = weapon
	weapon.forceMove(src)
	playsound(src, 'modular_skyrat/modules/mounted_machine_gun/sound/insert_ammobox.ogg', 100)
	balloon_alert("ammo box inserted!")

/obj/machinery/mounted_machine_gun/proc/remove_ammo_box(mob/living/user)
	ammo_box.forceMove(drop_location())
	user.put_in_hands(ammo_box)
	ammo_box = null
	playsound(src, 'modular_skyrat/modules/mounted_machine_gun/sound/remove_ammobox.ogg', 100)
	balloon_alert(user, "ammo box removed!")
	update_appearance()

/obj/machinery/mounted_machine_gun/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	balloon_alert(user, "cover [cover_open ? "opened" : "closed"]!")
	playsound(src, cover_open ? 'modular_skyrat/modules/mounted_machine_gun/sound/open_lid.ogg' : 'modular_skyrat/modules/mounted_machine_gun/sound/close_lid.ogg', 100)

/// Registers all the required signals and sets up the client to work with the turret.
/obj/machinery/mounted_machine_gun/proc/register_user(mob/living/user_to_buckle)
	current_user = user_to_buckle

	for(var/hand_item in user_to_buckle.held_items)
		var/obj/item/item = hand_item
		if(istype(item))
			if(user_to_buckle.dropItemToGround(item))
				var/obj/item/gun_control/turret_control = new(src)
				user_to_buckle.put_in_hands(turret_control)
		else //Entries in the list should only ever be items or null, so if it's not an item, we can assume it's an empty hand
			var/obj/item/gun_control/turret_control = new(src)
			user_to_buckle.put_in_hands(turret_control)

	if(!current_user.client) // I hate byond.
		return

	RegisterSignal(current_user, COMSIG_MOB_LOGIN, PROC_REF(reregister_trigger)) // I really really hate byond.
	RegisterSignal(current_user.client, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(trigger_pulled))
	RegisterSignal(current_user.client, COMSIG_CLIENT_MOUSEUP, PROC_REF(trigger_released))
	RegisterSignal(current_user.client, COMSIG_CLIENT_MOUSEDRAG, PROC_REF(update_target_drag))

	user_to_buckle.client?.view_size.setTo(view_range)
	user_to_buckle.pixel_y = 14

/obj/machinery/mounted_machine_gun/proc/update_target_drag(client/shooting_client, atom/src_object, atom/over_object, turf/src_location, turf/over_location, src_control, over_control, params)
	SIGNAL_HANDLER
	if(!istype(over_object))
		return
	if(istype(over_object, /atom/movable/screen))
		return
	last_target_atom = WEAKREF(over_object)

/obj/machinery/mounted_machine_gun/proc/unregister_mob(mob/living/user)
	UnregisterSignal(user, COMSIG_MOB_LOGIN)
	UnregisterSignal(user.client, COMSIG_CLIENT_MOUSEDOWN)
	UnregisterSignal(user.client, COMSIG_CLIENT_MOUSEUP)
	UnregisterSignal(user.client, COMSIG_CLIENT_MOUSEDRAG)

/obj/machinery/mounted_machine_gun/proc/trigger_pulled(client/shooting_client, atom/_target, turf/location, control, params)
	SIGNAL_HANDLER
	if(!check_click_modifiers(params2list(params)))
		return

	if(current_user.throw_mode)
		return

	if(istype(_target, /atom/movable/screen))
		return

	if(nextshot_timer_id) // To prevent spamming timers.
		return

	if(!COOLDOWN_FINISHED(src, trigger_cooldown)) // Prevents spam clicking.
		return

	if(current_user != shooting_client.mob)
		return

	shooting_client.mouse_override_icon = 'icons/effects/mouse_pointers/weapon_pointer.dmi'
	shooting_client.mouse_pointer_icon = shooting_client.mouse_override_icon

	last_target_atom = WEAKREF(_target)

	INVOKE_ASYNC(src, PROC_REF(process_fire), shooting_client, params)

/obj/machinery/mounted_machine_gun/proc/process_fire(client/shooting_client, params)
	if(!shooting_client)
		return

	if(!fire_at(shooting_client, params))
		return

	nextshot_timer_id = addtimer(CALLBACK(src, PROC_REF(process_fire), shooting_client), fire_delay, TIMER_STOPPABLE)

/obj/machinery/mounted_machine_gun/proc/fire_at(client/shooting_client, params)
	if(!current_user)
		return FALSE
	if(!shooting_client)
		return FALSE
	var/atom/target_atom = last_target_atom?.resolve()
	if(QDELETED(target_atom) || !target_atom || !get_turf(target_atom) || istype(target_atom, /atom/movable/screen) || target_atom == src)
		return FALSE
	update_positioning(target_atom)
	if(!can_fire())
		return FALSE
	var/obj/item/ammo_casing/casing = ammo_box.get_round()
	if(!casing)
		return FALSE

	if(!casing.fire_casing(target_atom, current_user, params, 0, suppressed, null, spread, src))// Actually firing the gun.
		return

	COOLDOWN_START(src, trigger_cooldown, fire_delay)

	playsound(src, firesound, 100)
	casing.forceMove(drop_location()) //Eject casing onto ground.
	casing.bounce_away(TRUE)

	barrel_heat += barrel_heat_per_shot
	if(barrel_heat >= max_barrel_heat)
		overheated = TRUE
		playsound(src, overheatsound, 100)
		particles = new /particles/smoke()
		addtimer(CALLBACK(src, PROC_REF(reset_overheat)), cooldown_time)

	update_appearance()

	ammo_box.update_appearance()

	return TRUE

/obj/machinery/mounted_machine_gun/proc/reset_overheat()
	overheated = FALSE
	update_appearance()
	QDEL_NULL(particles)

// Used to stop firing after the trigger is released.
/obj/machinery/mounted_machine_gun/proc/trigger_released(client/shooting_client, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	if(nextshot_timer_id)
		deltimer(nextshot_timer_id)
		nextshot_timer_id = null
	shooting_client.mouse_override_icon = null
	shooting_client.mouse_pointer_icon = shooting_client.mouse_override_icon

// Re-registers the required signals to the client after they reconnect.
/obj/machinery/mounted_machine_gun/proc/reregister_trigger(mob/source_mob)
	SIGNAL_HANDLER
	RegisterSignal(source_mob, COMSIG_CLIENT_MOUSEDOWN, PROC_REF(trigger_pulled), TRUE)
	RegisterSignal(source_mob.client, COMSIG_CLIENT_MOUSEUP, PROC_REF(trigger_released), TRUE)
	RegisterSignal(current_user.client, COMSIG_CLIENT_MOUSEDRAG, PROC_REF(update_target_drag), TRUE)

// Performs all checks and plays a sound if we can't fire.
/obj/machinery/mounted_machine_gun/proc/can_fire()
	var/fire_result = TRUE
	if(!ammo_box)
		drop_bolt()
		fire_result = FALSE
	if(!ammo_box.ammo_count())
		drop_bolt()
		fire_result = FALSE
	if(cover_open)
		balloon_alert_to_viewers("cover open!")
		fire_result = FALSE
	if(overheated)
		balloon_alert_to_viewers("barrel heatlocked!")
		fire_result = FALSE
	if(!fire_result)
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 50, TRUE)
	if(!bolt && fire_result)
		cock_bolt()
	return fire_result

/obj/machinery/mounted_machine_gun/proc/drop_bolt()
	if(!bolt)
		return
	bolt = FALSE

/obj/machinery/mounted_machine_gun/proc/cock_bolt()
	if(bolt)
		return
	bolt = TRUE
	playsound(src, 'modular_skyrat/modules/mounted_machine_gun/sound/cock_bolt.ogg', 100)

/obj/machinery/mounted_machine_gun/proc/check_click_modifiers(modifiers)
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		return FALSE
	if(LAZYACCESS(modifiers, CTRL_CLICK))
		return FALSE
	if(LAZYACCESS(modifiers, MIDDLE_CLICK))
		return FALSE
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return FALSE
	if(LAZYACCESS(modifiers, ALT_CLICK))
		return FALSE
	return TRUE

/obj/machinery/mounted_machine_gun/proc/update_positioning(atom/target_atom)
	if(!current_user)
		return FALSE

	var/client/controlling_client = current_user.client
	if(controlling_client)
		if(!target_atom)
			target_atom = controlling_client.mouse_object_ref?.resolve()
		var/turf/target_turf = get_turf(target_atom)
		if(istype(target_turf)) //They're hovering over something in the map.
			direction_track(current_user, target_turf)

/obj/machinery/mounted_machine_gun/proc/direction_track(mob/user, atom/targeted)
	if(user.incapacitated)
		return
	setDir(get_dir(src, targeted))
	user.setDir(dir)
	switch(dir)
		if(NORTH)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = 0
			user.pixel_y = -14
		if(NORTHEAST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = -18
			user.pixel_y = -8
		if(EAST)
			layer = ABOVE_MOB_LAYER
			plane = ABOVE_GAME_PLANE
			user.pixel_x = -22
			user.pixel_y = 0
		if(SOUTHEAST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = -18
			user.pixel_y = 14
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
			plane = ABOVE_GAME_PLANE
			user.pixel_x = 0
			user.pixel_y = 22
		if(SOUTHWEST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = 18
			user.pixel_y = 14
		if(WEST)
			layer = ABOVE_MOB_LAYER
			plane = ABOVE_GAME_PLANE
			user.pixel_x = 22
			user.pixel_y = 0
		if(NORTHWEST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = 18
			user.pixel_y = -8

/obj/item/mounted_machine_gun_folded
	name = "\improper folded T-90 mounted machine gun"
	desc = "A folded and unloaded mounted machine gun, ready to be deployed and used."
	icon = 'modular_skyrat/modules/mounted_machine_gun/icons/turret_objects.dmi'
	icon_state = "folded_hmg"
	max_integrity = 250
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	/// The type we deploy.
	var/type_to_deploy = /obj/machinery/mounted_machine_gun
	/// How long it takes to deploy.
	var/deploy_time = 5 SECONDS

/obj/item/mounted_machine_gun_folded/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy)
