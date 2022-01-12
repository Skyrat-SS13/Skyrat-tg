/*
	Remote projectiles are controlled from a gun, but the logic for controlling them is in the firemode
*/
//Totals for damaging objects.An ex_act call at the appropriate strength will be triggered every time the blade deals this much total damage to a dense object
#define EX3_TOTAL 45
#define EX2_TOTAL 90
#define EX1_TOTAL 170


//Sawblade statuses
#define STATE_STABLE	0
#define STATE_MOVING	1
#define STATE_GRINDING	2

/obj/item/projectile/remote
	//var/mob/user

	pass_flags = PASS_FLAG_FLYING | PASS_FLAG_NOMOB

	var/datum/firemode/remote/firemode

	var/override_fire = TRUE

	slot_flags = SLOT_NONE	//No wearing it on your ear

	//If true we have dropped a remnant
	var/dropped = FALSE



	//If true, we are being controlled by gravity tether
	//If false, it was launched as a normal projectile
	var/remote_controlled = FALSE

	//The sawblade has three states
	//STATE_STABLE: The blade is exactly on the user's cursor and is remaining still
	//STATE_MOVING: The blade isnt on the cursor and is moving towards it
	//STATE_GRINDING: The blade ran into a solid object while moving and is now grinding up against it, unable to complete movement
	var/status = STATE_MOVING

	health = 400

	//Damage per second dealt while intersecting with mobs
	var/dps	=	27

	//Damage taken when the projectile is dropped
	var/drop_damage = 25

	//When grinding against dense atoms in another tile, we must stay this many pixels close to the edge of that tile, to continue
	//Only used for objects and turfs, not mobs
	var/damage_radius = 8

	step_delay = 2.5 //Lower air velocity than bullets
	penetrating = 1 //Allows check_penetrate to be called on this projectle when it fails to pass through something.
	//We will override that to make sure it always passes through mobs

	//The turf we are currently attacking. This may be the same one we're in, or an adjacent one.
	//The sawblade will only damage things in the damage tile
	var/turf/damage_tile	= 	null

	//How quickly the blade moves towards the user's cursor. This is measured in pixels per second.
	var/tracking_speed	=	96
	var/tracking_per_tick //Calculated at runtime

	//If nonzero, the projectile takes damage each tick until it dies, in this amount of time, not counting
	var/max_lifespan = 12 SECONDS
	var/damage_per_tick

	//Time in seconds between ticks of damage and movement. The lower this is, the smoother and more granular things are
	var/tick_interval	=	0.2

	//These variables cache where the user's cursor is, and thusly where we are trying to get to.
	var/turf/target_turf	=	null

	//Our X/Y location expressed as pixels from world 0. Useful for interpolation
	var/vector2/global_pixel_loc = new /vector2(0,0)

	var/timer_handle //Used for tick timer

	//A list of atoms we are grinding against and their damage counters. Entries in this list are in the format:
	//list(atom, ex3counter, ex2counter, ex1counter)
	var/list/grind_atoms = list()

	//Used to handle the looping sawblade audio
	var/datum/sound_token/loop_sound
	var/current_loop //Which looped sound is currently playing
	var/sound_active
	var/sound_grind

	//Sound made when hitting a mob. This plays up to 5 times per second, so make it short
	var/mob_hitsound = 'sound/weapons/bladeslice.ogg'

	//The ammo item to drop when we are released but not quite broken
	var/ammo_type = /obj/item/ammo_casing/sawblade

	//The broken sawblade item to drop when we run out of health
	var/trash_type = /obj/item/trash/broken_sawblade


	var/drop_sound = 'sound/effects/weightdrop.ogg'

	var/break_sound = "shatter"

	//This bizarrely named variable is actually projectile lifetime
	kill_count = 1000


	//If this projectile has a visual tether to the source atom, we store a reference to it here
	//This is purely storage, all operations with it are handled by firemode
	var/obj/effect/projectile/tether/tether = null


	var/damage_mobs = TRUE
	var/damage_turfs = TRUE
	var/damage_objects = TRUE


//We don't need to stop the looping audio here, it will do that itself
/obj/item/projectile/remote/Destroy()
	if (firemode)
		firemode.unregister_projectile(src)

	if (!dropped)
		drop()
	grind_atoms = list()
	firemode = null
	QDEL_NULL(loop_sound)
	release_vector(global_pixel_loc)
	damage_tile = null
	QDEL_NULL(tether)
	.=..()


/obj/item/projectile/remote/sawblade/Initialize()
	.=..()
	//When created, lets populate some initial variables


	tracking_per_tick = tracking_speed * tick_interval
	damage_per_tick = (health / (max_lifespan*0.1)) * tick_interval


/obj/item/projectile/remote/proc/control_launched(var/datum/firemode/remote/firemode)

	src.firemode = firemode
	launcher = firemode.gun //Register the ripper
	alpha = default_alpha	//The projectile becomes visible now, when its ready to start moving
	damage = dps * tick_interval //Overwrite the compiletime damage with the calculated value
	animate_movement = 0 //Disable this to prevent byond's built in sliding, we do our own animate calls
	damage_tile = get_turf(src) //Damage tile starts off as wherever we are
	GLOB.moved_event.register(src, src, /obj/item/projectile/remote/proc/entered_new_tile)
	set_status(STATE_MOVING)

/obj/item/projectile/remote/proc/entered_new_tile(var/atom/movable/moving_instance, var/atom/old_loc, var/atom/new_loc)
	remove_all_grind_atoms()
	damage_tile = new_loc

/obj/item/projectile/remote/proc/set_status(var/newstatus)
	status = newstatus
	switch (status)
		if (STATE_GRINDING)
			set_sound(sound_grind)
		if (STATE_STABLE)
			set_sound(sound_active)
		if (STATE_MOVING)
			set_sound(sound_active)

/obj/item/projectile/remote/proc/add_grind_atom(var/atom/A)
	//Adds an atom to our list of grind items. this is stored indefinitely (until this sawblade is deleted)

	if (!QDELETED(A) && !(A in grind_atoms))
		set_status(STATE_GRINDING)
		grind_atoms[A] = list(EX3_TOTAL, EX2_TOTAL, EX1_TOTAL)
		damage_tile = get_turf(A)

/obj/item/projectile/remote/proc/remove_grind_atom(var/atom/A)
	grind_atoms	-= A
	if (!grind_atoms.len)
		set_status(STATE_MOVING)

/obj/item/projectile/remote/proc/remove_all_grind_atoms()
	grind_atoms = list()
	set_status(STATE_MOVING)

/obj/item/projectile/remote/proc/damage_turf()


	if (QDELETED(src))
		return

	//Solid objects will block the blade first
	if (status == STATE_GRINDING)
		//How far are we from the grind tile? We get the normal offset (which is from the tile's center) and subtract half a tile size
		var/distance_from_edge = get_normal_pixel_offset(damage_tile) - (WORLD_ICON_SIZE * 0.5)

		//Are we too far away to keep grinding that tile?
		if (distance_from_edge > damage_radius)
			remove_all_grind_atoms()

		else


			//We iterate through the grind atoms and see if we can hit any of them
			for (var/atom/A as anything in grind_atoms)
				var/list/l = grind_atoms[A]
				//If the atom is gone, remove from this list
				if (QDELETED(A))
					remove_grind_atom(A)
					continue

				//The atom must be in the damage tile
				//Or BE the damage tile
				if (A.loc == damage_tile || A == damage_tile)

					//A destroyed wall turns into a floor with no density, but its still the same memory address.
					//We want to detect that and stop cutting into a floor
					if (A == damage_tile && !A.density)
						remove_grind_atom(A)
						continue

					//Sometimes bullet_act modifies a projectile's damage. To workaround that, we'll cache it here and restore it afterwards
					var/cache_damage = damage

					//We call bullet act, maybe the object has a built in reaction to this. But we'll also build towards our fallback method
					A.bullet_act(src)
					damage = cache_damage

					take_damage(damage)

					A.pixel_x += rand(-1,1)
					A.pixel_y += rand(-1,1)
					//Explosion counters for a blocker decrease by the damage amount each tick.
					//The ripper can cut through almost anything if the blade lasts long enough. Low quality blades generally won't though
					l[1] -= damage
					if (l[1] <= 0)
						l[1] = EX3_TOTAL
						A.shake_animation(2)
						A.ex_act(3, src)


					l[2] -= damage
					if (l[2] <= 0)
						l[2] = EX2_TOTAL
						A.shake_animation(4)
						A.ex_act(2, src)

					l[3] -= damage
					if (l[3] <= 0)
						l[3] = EX1_TOTAL
						A.shake_animation(8)
						A.ex_act(1, src)

					updatehealth()
					set_sound(sound_grind)//We're grinding, play the grind sound
					return //After dealing damage to a single hard target, we return. It prevents us from damaging anything else this tick.
					//Mobs hiding behind something sturdy are safe, temporarily at least


	//If we manage to get here, we aren't grinding on anything, play the normal non-grind sound
	set_sound(sound_active)

	//Deals damage to mobs in our own turf, not the damage tile
	for (var/mob/living/L in loc)
		var/cache_damage = damage
		attack_mob(L, 0, 0)
		damage = cache_damage
		take_damage(damage)
		if (QDELETED(src))
			return

	take_damage(damage_per_tick)


/obj/item/projectile/remote/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)
	//Update our hit location to wherever user is currently aiming
	var/mob/living/user = firemode.get_user()
	if (user)
		def_zone = get_zone_sel(user)

	.=..()
	if (mob_hitsound)
		playsound(target_mob, mob_hitsound, 60, 1, 1)
	global_pixel_loc = get_global_pixel_loc() //Cache this so we know where to drop a remnant, for non remote blades


//Override this so it doesn't delete itself when touching anything
/obj/item/projectile/remote/Bump(atom/A as mob|obj|turf|area, forced=0)

	if (!istype(A, /mob))
		add_grind_atom(A)



//If the blade has health left, this will drop a reuseable sawblade casing on the floor and delete ourself
//Otherwise, it will drop either a broken sawblade or shrapnel, which has no purpose except to recycle for metal
/obj/item/projectile/remote/proc/drop()
	if (dropped)
		return


	dropped = TRUE
	QDEL_NULL(tether)

	if (drop_sound)
		playsound(get_turf(src),drop_sound, 70, 1, 1) //Clunk!
	if (health < drop_damage)
		if (break_sound)
			playsound(src, break_sound, 70, 1)

		if (trash_type)
			var/obj/item/broken = new trash_type(loc)
			broken.set_global_pixel_loc(QDELETED(src) ? global_pixel_loc : get_global_pixel_loc())//Make sure it appears exactly below this disk

			//And lets give it a random rotation to make it look like it just fell there
			var/matrix/M = matrix()
			M.Turn(rand(0,360))
			broken.transform = M

	else
		//If health remains, the sawblade drops on the floor
		if (ammo_type)
			take_damage(drop_damage) //Take some damage from the dropping
			var/obj/item/ammo_casing/sawblade/ammo = new ammo_type(loc)
			ammo.set_global_pixel_loc(QDELETED(src) ? global_pixel_loc : get_global_pixel_loc())//Make sure it appears exactly below this disk
			ammo.health = health //Set its health to ours
			//And lets give it a random rotation to make it look like it just fell there
			var/matrix/M = matrix()
			M.Turn(rand(0,360))
			ammo.transform = M

	//Once we've placed either a blade or a broken remnant, delete this projectile
	//We spawn it off to prevent recursion issues, make sure the launcher does its cleanup first

	spawn()
		if (!QDELETED(src))
			qdel(src)



/obj/item/projectile/remote/proc/set_sound(var/soundin)

	//Null is passed in when the sawblade is deleted. This will stop the sound
	if (!soundin)
		QDEL_NULL(loop_sound)
		return

	if (soundin == current_loop)
		return //Dont restart the sound we're already playing

	//If a sound is already playing, we'll stop it to start the new one, but not immediately
	if (loop_sound)
		qdel(loop_sound)
		//var/datum/sound_token/copied = loop_sound
		//spawn(3)//Let it overlap with the new one for just a little bit, to prevent having any silence
			//qdel(copied)

	var/volume = 15
	var/range = 9
	//The sound is lounder when grinding against objects
	if (soundin == sound_grind)
		volume = 50
		range = 15

	//And start the new sound
	//This random field is an ID, i assume it has to be unique
	loop_sound = GLOB.sound_player.PlayLoopingSound(src, /obj/item/projectile/remote/sawblade, soundin, volume, range)
	current_loop = soundin




//Move towards the cursor
//We do not modify the passed target vector
/obj/item/projectile/remote/proc/track_target(var/vector2/target)

	global_pixel_loc = get_global_pixel_loc()

	//Ok now we're going to decide how much we can move towards the target point
	var/vector2/diff = target - global_pixel_loc //Get a vec2 that represents the difference between our current location and the target

	//If its farther than we can go in one tick...
	if (diff.Magnitude() > tracking_per_tick)
		diff.SelfToMagnitude(tracking_per_tick)//We rescale the magnitude of the diff


	pixel_move(diff, 0.2 SECONDS)

	release_vector(diff)

#undef EX3_TOTAL
#undef EX2_TOTAL
#undef EX1_TOTAL

#undef STATE_STABLE
#undef STATE_GRINDING
#undef STATE_MOVING
