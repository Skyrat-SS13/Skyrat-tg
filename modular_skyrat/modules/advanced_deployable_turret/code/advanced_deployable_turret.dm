/obj/machinery/advanced_deployable_turret
	name = "\improper T90 Heavy Machine Gun"
	desc = "A high calibre heavy machine gun capable of laying down copious amounts of suppressive fire."
	icon = 'modular_skyrat/modules/advanced_deployable_turret/icons/turret.dmi'
	icon_state = "heavy_machine_gun"
	can_buckle = TRUE
	anchored = FALSE
	density = TRUE
	max_integrity = 100
	buckle_lying = 0
	base_pixel_x = -8
	base_pixel_y = -8
	pixel_x = -8
	pixel_y = -8
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	/// The extra range that this turret gives regarding viewrange.
	var/view_range = 2.5
	/// Sound to play at the end of a burst
	var/overheatsound = 'sound/weapons/sear.ogg'
	/// Sound to play when firing
	var/firesound = 'modular_skyrat/modules/advanced_deployable_turret/sound/50cal_box_01.ogg'
	/// If using a wrench on the turret will start undeploying it
	var/can_be_undeployed = FALSE
	/// What gets spawned if the object is undeployed
	var/obj/spawned_on_undeploy = /obj/item/advanced_deployable_turret_folded
	/// How long it takes for a wrench user to undeploy the object
	var/undeploy_time = 3 SECONDS
	/// Our currently loaded ammo box.
	var/obj/item/ammo_box/magazine/ammo_box
	/// Our ammo box type.
	var/ammo_box_type = /obj/item/ammo_box/magazine/hmg_box
	/// A reference to our current user.
	var/mob/living/current_user
	/// The delay between each shot that is sent downrange.
	var/fire_delay = 0.3 SECONDS
	/// The current timer to fire the next round.
	var/nextshot_timer_id
	/// A weakref to our last dragged object.
	var/datum/weakref/last_dragged_atom
	/// Is our cover open? Used to access the ammo box!
	var/cover_open = FALSE
	/// Do we have a supressor or something installed?
	var/suppressed = FALSE
	/// How much spread we have for projectiles.
	var/spread = 0
	/// The position of our bolt. TRUE = locked(ready to fire) FALSE = forward(not ready to fire)
	var/bolt = TRUE

	COOLDOWN_DECLARE(trigger_cooldown)


/obj/machinery/advanced_deployable_turret/Initialize(mapload)
	. = ..()
	ammo_box = new ammo_box_type(src)

/obj/machinery/advanced_deployable_turret/Destroy()
	QDEL_NULL(ammo_box)
	if(current_user)
		unregister_mob(current_user)
		current_user = null
	return ..()

/obj/machinery/advanced_deployable_turret/update_overlays()
	. = ..()
	if(ammo_box)
		. += "ammo_box"
	if(cover_open)
		. += "cover_open"

/// Undeploying, for when you want to move your big dakka around
/obj/machinery/advanced_deployable_turret/wrench_act(mob/living/user, obj/item/wrench/used_wrench)
	. = ..()
	if(!can_be_undeployed)
		return
	if(!ishuman(user))
		return
	used_wrench.play_tool_sound(user)
	user.balloon_alert(user, "undeploying...")
	if(!do_after(user, undeploy_time))
		return
	var/obj/undeployed_object = new spawned_on_undeploy(src)
	//Keeps the health the same even if you redeploy the gun
	undeployed_object.modify_max_integrity(max_integrity)
	qdel(src)

//BUCKLE HOOKS
/obj/machinery/advanced_deployable_turret/unbuckle_mob(mob/living/buckled_mob, force = FALSE, can_fall = TRUE)
	playsound(src,'sound/mecha/mechmove01.ogg', 50, TRUE)
	for(var/obj/item/I in buckled_mob.held_items)
		if(istype(I, /obj/item/gun_control))
			qdel(I)
	if(istype(buckled_mob))
		buckled_mob.pixel_x = buckled_mob.base_pixel_x
		buckled_mob.pixel_y = buckled_mob.base_pixel_y
		if(buckled_mob.client)
			buckled_mob.client.view_size.resetToDefault()
	set_anchored(FALSE)
	unregister_mob(current_user)
	current_user = null
	. = ..()

/obj/machinery/advanced_deployable_turret/user_buckle_mob(mob/living/user_to_buckle, mob/buckling_user, check_loc = TRUE)
	if(user_to_buckle.incapacitated() || !istype(user_to_buckle))
		return
	user_to_buckle.forceMove(get_turf(src))
	. = ..()
	if(!.)
		return

	register_user(user_to_buckle)

	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	setDir(SOUTH)
	playsound(src,'sound/mecha/mechmove01.ogg', 50, TRUE)
	set_anchored(TRUE)

	update_positioning()

/obj/machinery/advanced_deployable_turret/AltClick(mob/user)
	. = ..()
	if(!can_interact(user))
		return
	toggle_cover(user)

/obj/machinery/advanced_deployable_turret/attack_hand_secondary(mob/living/user, list/modifiers)
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

/obj/machinery/advanced_deployable_turret/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(!istype(weapon, ammo_box_type))
		return
	if(ammo_box)
		balloon_alert("already loaded!")
		return
	ammo_box = weapon
	weapon.forceMove(src)
	playsound(src, 'modular_skyrat/modules/advanced_deployable_turret/sound/insert_ammobox.ogg', 100)
	balloon_alert("ammo box inserted!")

/obj/machinery/advanced_deployable_turret/proc/remove_ammo_box(mob/living/user)
	ammo_box.forceMove(drop_location())
	user.put_in_hands(ammo_box)
	ammo_box = null
	playsound(src, 'modular_skyrat/modules/advanced_deployable_turret/sound/remove_ammobox.ogg', 100)
	balloon_alert("ammo box removed!")
	update_appearance()

/obj/machinery/advanced_deployable_turret/proc/toggle_cover(mob/user)
	cover_open = !cover_open
	balloon_alert(user, "cover [cover_open ? "opened" : "closed"]!")
	playsound(src, cover_open ? 'modular_skyrat/modules/advanced_deployable_turret/sound/open_lid.ogg' : 'modular_skyrat/modules/advanced_deployable_turret/sound/close_lid.ogg', 100)

/// Registers all the required signals and sets up the client to work with the turret.
/obj/machinery/advanced_deployable_turret/proc/register_user(mob/living/user_to_buckle)
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

	RegisterSignal(current_user, COMSIG_MOB_LOGIN, .proc/reregister_trigger) // I really really hate byond.
	RegisterSignal(current_user.client, COMSIG_CLIENT_MOUSEDOWN, .proc/trigger_pulled)
	RegisterSignal(current_user.client, COMSIG_CLIENT_MOUSEUP, .proc/trigger_released)

	user_to_buckle.client?.view_size.setTo(view_range)
	user_to_buckle.pixel_y = 14

/obj/machinery/advanced_deployable_turret/proc/unregister_mob(mob/living/user)
	UnregisterSignal(user, COMSIG_MOB_LOGIN)
	UnregisterSignal(user.client, COMSIG_CLIENT_MOUSEDOWN)
	UnregisterSignal(user.client, COMSIG_CLIENT_MOUSEUP)

/obj/machinery/advanced_deployable_turret/proc/trigger_pulled(client/shooting_client, atom/_target, turf/location, control, params)
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

	INVOKE_ASYNC(src, .proc/process_fire, shooting_client, params)

/obj/machinery/advanced_deployable_turret/proc/process_fire(client/shooting_client, params)
	if(!shooting_client)
		return

	if(!fire_at(shooting_client, params))
		return

	nextshot_timer_id = addtimer(CALLBACK(src, .proc/process_fire, shooting_client), fire_delay, TIMER_STOPPABLE)

/obj/machinery/advanced_deployable_turret/proc/fire_at(client/shooting_client, params)
	if(!current_user)
		return FALSE
	if(!shooting_client)
		return FALSE
	var/atom/target_atom = shooting_client?.mouse_object_ref?.resolve()
	if(!target_atom || !get_turf(target_atom))
		return FALSE
	if(!can_fire())
		return FALSE
	var/obj/item/ammo_casing/casing = ammo_box.get_round()
	if(!casing)
		return FALSE

	update_positioning()

	if(!casing.fire_casing(target_atom, current_user, params, 0, suppressed, null, spread, src))// Actually firing the gun.
		return

	COOLDOWN_START(src, trigger_cooldown, fire_delay)

	playsound(src, firesound, 100)
	casing.forceMove(drop_location()) //Eject casing onto ground.
	casing.bounce_away(TRUE)

	ammo_box.update_appearance()

	return TRUE

// Used to stop firing after the trigger is released.
/obj/machinery/advanced_deployable_turret/proc/trigger_released(datum/source, atom/object, turf/location, control, params)
	SIGNAL_HANDLER
	if(nextshot_timer_id)
		deltimer(nextshot_timer_id)
		nextshot_timer_id = null

// Re-registers the required signals to the client after they reconnect.
/obj/machinery/advanced_deployable_turret/proc/reregister_trigger(mob/source_mob)
	SIGNAL_HANDLER
	RegisterSignal(source_mob, COMSIG_CLIENT_MOUSEDOWN, .proc/trigger_pulled, TRUE)
	RegisterSignal(source_mob.client, COMSIG_CLIENT_MOUSEUP, .proc/trigger_released, TRUE)

// Performs all checks and plays a sound if we can't fire.
/obj/machinery/advanced_deployable_turret/proc/can_fire()
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
	if(!fire_result)
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 50, TRUE)
	if(!bolt && fire_result)
		cock_bolt()
	return fire_result

/obj/machinery/advanced_deployable_turret/proc/drop_bolt()
	if(!bolt)
		return
	bolt = FALSE

/obj/machinery/advanced_deployable_turret/proc/cock_bolt()
	if(bolt)
		return
	bolt = TRUE
	playsound(src, 'modular_skyrat/modules/advanced_deployable_turret/sound/cock_bolt.ogg', 100)

/obj/machinery/advanced_deployable_turret/proc/check_click_modifiers(modifiers)
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

/obj/machinery/advanced_deployable_turret/proc/update_positioning()
	if(!current_user)
		return FALSE
	var/client/controlling_client = current_user.client
	if(controlling_client)
		var/atom/target_atom = controlling_client.mouse_object_ref?.resolve()
		var/turf/target_turf = get_turf(target_atom)
		if(istype(target_turf)) //They're hovering over something in the map.
			direction_track(current_user, target_turf)

/obj/machinery/advanced_deployable_turret/proc/direction_track(mob/user, atom/targeted)
	if(user.incapacitated())
		return
	setDir(get_dir(src,targeted))
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
			plane = GAME_PLANE_UPPER
			user.pixel_x = -22
			user.pixel_y = 0
		if(SOUTHEAST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = -18
			user.pixel_y = 14
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
			plane = GAME_PLANE_UPPER
			user.pixel_x = 0
			user.pixel_y = 22
		if(SOUTHWEST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = 18
			user.pixel_y = 14
		if(WEST)
			layer = ABOVE_MOB_LAYER
			plane = GAME_PLANE_UPPER
			user.pixel_x = 22
			user.pixel_y = 0
		if(NORTHWEST)
			layer = BELOW_MOB_LAYER
			plane = GAME_PLANE
			user.pixel_x = 18
			user.pixel_y = -8

/obj/item/advanced_deployable_turret_folded
	name = "folded heavy machine gun"
	desc = "A folded and unloaded heavy machine gun, ready to be deployed and used."
	icon = 'modular_skyrat/modules/advanced_deployable_turret/icons/turret_objects.dmi'
	icon_state = "folded_hmg"
	max_integrity = 250
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	/// The type we deploy.
	var/type_to_deploy = /obj/machinery/advanced_deployable_turret
	/// How long it takes to deploy.
	var/deploy_time = 5 SECONDS

/obj/item/advanced_deployable_turret_folded/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/deployable, deploy_time, type_to_deploy, delete_on_use = TRUE)
