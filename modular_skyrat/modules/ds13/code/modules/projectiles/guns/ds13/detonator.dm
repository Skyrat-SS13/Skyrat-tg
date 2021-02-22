/*
	Detonator Gun
*/
/obj/item/weapon/gun/projectile/detonator
	name = "detonator"
	desc = "A unique gun that can place tripmines from a distance."
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "detonator"
	item_state = "detonator"
	wielded_item_state = "detonator-wielded"
	slot_flags = SLOT_BELT | SLOT_BACK
	w_class = ITEM_SIZE_HUGE
	max_shells = 6
	caliber = "tripmine"
	handle_casings = CLEAR_CASINGS
	fire_delay = 5
	fire_sound = ""
	load_sound = ""
	projectile_type = /obj/item/projectile/deploy/detonator
	one_hand_penalty = 6	//Don't try to fire this with one hand
	var/list/deployed_mines = list()

	firemodes = list(list(mode_name = "minelayer", mode_type = /datum/firemode, require_aiming = TRUE),\
	list(mode_name = "mine retrieval", mode_type = /datum/firemode/tripmine))

	load_sound = 'sound/weapons/guns/interaction/detonator_reload.ogg'


/obj/item/weapon/gun/projectile/detonator/enable_aiming_mode()
	.=..()
	if (.)
		playsound(src, 'sound/weapons/guns/interaction/detonator_ready.ogg', VOLUME_MID, TRUE)
		update_icon()

/obj/item/weapon/gun/projectile/detonator/disable_aiming_mode()
	.=..()
	if (.)
		playsound(src, 'sound/weapons/guns/interaction/detonator_unready.ogg', VOLUME_MID, TRUE)
		update_icon()


/*
	Firemode
	Detonates all rivets
*/
/datum/firemode/tripmine
	override_fire = TRUE

/datum/firemode/tripmine/fire(var/atom/target, var/mob/living/user, var/clickparams, var/pointblank=0, var/reflex=0)
	var/obj/item/weapon/gun/projectile/detonator/R = gun
	if (R.deployed_mines.len)
		var/obj/effect/mine/trip/M = R.deployed_mines[R.deployed_mines.len]
		R.deployed_mines -= M
		M.disarm()
	else
		to_chat(user, "There are no active mines.")


/obj/item/weapon/gun/projectile/detonator/loaded

	ammo_type = /obj/item/ammo_casing/tripmine

/obj/item/weapon/gun/projectile/detonator/update_icon()
	if(get_remaining_ammo())
		icon_state = "detonator_loaded"
	else
		icon_state = "detonator"

	.=..()


/*
	Unfired mine
*/
/obj/item/ammo_casing/tripmine
	name = "detonator mine"
	caliber = "tripmine"
	icon = 'icons/obj/weapons/ds13_deployables.dmi'
	icon_state = "detonator_mine"
	randpixel = 12

/obj/item/ammo_casing/tripmine/Initialize()
	.=..()
	transform = transform.Turn(rand(0, 360))

/*
	Mount extension
*/
/datum/extension/mount/sticky/mine
	pixel_offset_magnitude = -12
	mount_round = 90


/*
	Deployment projectile
*/
/obj/item/projectile/deploy/detonator
	mount_type = /datum/extension/mount/sticky/mine
	deploy_type = /obj/effect/mine/trip
	icon = 'icons/obj/weapons/ds13_deployables.dmi'
	icon_state = "detonator_mine"
	fire_sound = 'sound/weapons/guns/fire/detonator_fire.ogg'


/obj/item/projectile/deploy/detonator/deploy_to_floor(var/turf/T)
	set waitfor = FALSE
	if (deployed)
		return
	deployed = TRUE
	sleep()
	var/obj/effect/mine/trip/trip = new deploy_type(T, src)
	trip.floor_deployed(T)

//Detonator can be used as an impact grenade launcher, but its less effective
/obj/item/projectile/deploy/detonator/attack_mob(var/mob/living/victim)
	set waitfor = FALSE
	if (deployed)
		return
	deployed = TRUE
	var/obj/effect/mine/trip/trip = new deploy_type(get_turf(victim), src)
	trip.explode()	//We don't pass in the victim so it won't fire shrapnel

/*
	Laser effect
*/
/obj/effect/projectile/tether/triplaser
	icon = 'icons/effects/tethers.dmi'
	icon_state = "triplaser"
	base_length = WORLD_ICON_SIZE*2
	start_offset = new /vector2(-16,0)
	end_offset = new /vector2(-16,0)
	alpha = 220

/*
	Deployed mine
*/
/obj/effect/mine/trip
	name = "Laser Tripmine"
	icon = 'icons/obj/weapons/ds13_deployables.dmi'
	icon_state = "detonator_mine"
	var/setup_time = 1.1 SECONDS
	var/obj/effect/projectile/tether/triplaser/laser
	var/max_laser_range = 20	//How far the laser extends, in tiles
	var/gunref	//We'll save a weak link to our launcher
	var/disarmed_type = /obj/item/ammo_casing/tripmine
	triggerproc = /obj/effect/mine/trip/explode
	density = FALSE

/obj/effect/mine/trip/New(var/atom/newloc, var/obj/item/projectile/deploy/projectile)

	.=..()
	var/obj/item/weapon/gun/projectile/detonator/D = projectile.launcher
	D.deployed_mines += src
	gunref = "\ref[D]"

/obj/effect/mine/trip/explode(var/atom/victim)
	triggered = TRUE

	playsound(get_turf(src), pick(list('sound/weapons/guns/blast/detonator_explosion_1.ogg',
	'sound/weapons/guns/blast/detonator_explosion_2.ogg',
	'sound/weapons/guns/blast/detonator_explosion_3.ogg',
	'sound/weapons/guns/blast/detonator_explosion_4.ogg')),
	VOLUME_HIGH,
	FALSE)
	if (victim)
		shoot_ability(subtype = /datum/extension/shoot/det1, target = victim, projectile_type = /obj/item/projectile/bullet/detonator_round, accuracy = 140, cooldown = 0)
		shoot_ability(subtype = /datum/extension/shoot/det2, target = victim, projectile_type = /obj/item/projectile/bullet/detonator_round, accuracy = 140, cooldown = 0)
		shoot_ability(subtype = /datum/extension/shoot/det3, target = victim, projectile_type = /obj/item/projectile/bullet/detonator_round, accuracy = 140, cooldown = 0)
	explosion(4, 2)
	spawn(0)
		qdel(src)

/obj/effect/mine/trip/proc/disarm()
	if (triggered || QDELETED(src))
		return
	playsound(get_turf(src), 'sound/weapons/guns/misc/detonator_mine_disarm.ogg',VOLUME_HIGH,FALSE)
	triggered = TRUE
	icon_state = "detonator_mine_undeploy"
	sleep(6)
	new disarmed_type(get_turf(src))
	qdel(src)

/obj/effect/mine/trip/Destroy()
	var/obj/item/weapon/gun/projectile/detonator/D 	= locate(gunref)
	if (D)
		D.deployed_mines -= src
	gunref = null
	QDEL_NULL(laser)
	.=..()

/obj/effect/mine/trip/on_mount(var/datum/extension/mount/ME)
	icon_state = "detonator_mine_deployed"
	spawn(0.3 SECONDS)
		playsound(get_turf(src), 'sound/weapons/guns/misc/detonator_mine_arm.ogg',VOLUME_HIGH,FALSE)
	spawn(setup_time)
		laser = new (loc)
		//Which way are we pointing our laser?
		var/vector2/laser_direction = Vector2.NewFromDir(NORTH)//Vector2.SmartDirectionBetween(ME.mountpoint, src)
		var/laser_angle = ME.mount_angle
		//We will make the angle bound to a cardinal
		laser_direction.SelfTurn(laser_angle)

		set_light(0.8, 1, 3, l_falloff_curve = NONSENSICAL_VALUE, l_color = COLOR_DEEP_SKY_BLUE)


		var/vector2/tile_offset = laser_direction * max_laser_range

		var/turf/target_turf = locate(x + tile_offset.x, y+tile_offset.y, z)

		if (!target_turf)
			return

		var/list/results = check_trajectory_verbose(target_turf, src)

		var/obstacle = results[3]
		//If the laser is blocked by a mob, we detonate instantly
		if (isliving(obstacle))
			var/mob/living/L = obstacle
			if (L.stat != DEAD)
				detonate(L)
				return

		target_turf = results[2]	//This contains the turf that the projectile managed to reach, its where we will aim

		var/vector2/start = get_global_pixel_loc()
		var/vector2/start_offset = get_new_vector(0, -8)
		start_offset.SelfTurn(ME.mount_angle)
		start.SelfAdd(start_offset)

		var/vector2/end = target_turf.get_global_pixel_loc()

		laser.set_ends(start, end)


		//Setup a trigger to track nearby mobs
		var/datum/proximity_trigger/solidline/PT = new (holder = src, on_turf_entered = /obj/effect/mine/trip/proc/tripped, range = max_laser_range, extra_args = list(target_turf))
		PT.register_turfs()
		set_extension(src, /datum/extension/proximity_manager, PT)

		release_vector(start)
		release_vector(start_offset)
		release_vector(end)
		release_vector(laser_direction)
		release_vector(tile_offset)



/obj/effect/mine/trip/proc/floor_deployed()
	transform = transform.Scale(1, 0.8)
	icon_state = "detonator_mine_deployed"
	spawn(0.3 SECONDS)
		playsound(get_turf(src), 'sound/weapons/guns/misc/detonator_mine_arm.ogg',VOLUME_HIGH,FALSE)
	spawn(setup_time)
		laser = new (loc)

		var/vector2/start = get_global_pixel_loc()

		var/vector2/end = start.Copy()
		end.y += 48

		laser.set_ends(start, end)
		release_vector(start)
		release_vector(end)

/obj/effect/mine/trip/proc/tripped(var/atom/movable/enterer)
	var/trigger = is_valid_target(enterer)

	if (trigger)
		detonate(enterer)


/*
	Hypersonic Rounds
	On detonation, the mine fires three bullets along the laser, which do most of the damage
*/
/obj/item/projectile/bullet/detonator_round
	name = "heavy shrapnel"
	icon_state = "slimbullet"
	damage = 35
	embed = 1
	structure_damage_factor = 3
	penetration_modifier = 1.25
	penetrating = TRUE
	step_delay = 0.5	//veryyyy fast
	expiry_method = EXPIRY_FADEOUT
	fire_sound = ""
	stun = 3
	weaken = 3
	paralyze = 1
	penetrating = 5
	armor_penetration = 15
	accuracy = 150


//Shoot extensions, just used for the sake of cooldowns
/datum/extension/shoot/det1
	base_type = /datum/extension/shoot/det1

/datum/extension/shoot/det2
	base_type = /datum/extension/shoot/det2

/datum/extension/shoot/det3
	base_type = /datum/extension/shoot/det3


/*
	Acquisition
*/
/decl/hierarchy/supply_pack/mining/detonator_mines
	name = "Mining - Detonator Charges"
	contains = list(/obj/item/ammo_casing/tripmine = 12)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "\improper detonator charges crate"


/decl/hierarchy/supply_pack/mining/detonator
	name = "Mining Tool - Detonator Mine Launcher"
	contains = list(/obj/item/ammo_casing/tripmine = 6,
	/obj/item/weapon/gun/projectile/detonator = 1)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "\improper detonator crate"

