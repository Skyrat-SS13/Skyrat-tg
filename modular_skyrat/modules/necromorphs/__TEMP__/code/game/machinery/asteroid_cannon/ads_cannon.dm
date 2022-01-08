GLOBAL_DATUM(asteroidcannon, /obj/structure/asteroidcannon)

#define CANNON_FORWARD_DIR	EAST
#define CANNON_FIRING_ARC 55
#define CANNON_ROTATION_SPEED 75
/**

Asteroid cannon!

Links to a control console, can be sabotaged by hitting it a bunch of times.

If the cannon goes offline, you need to repair it with a welder to ensure it won't instantly offline again, then reboot its ADS systems with the console
You'll need two people to do this, one to man the gun while it goes down, one to do the actual repairs.


*/
/obj/structure/asteroidcannon
	name = "Asteroid Defense System"
	desc = "A huge machine that shoots down oncoming asteroids."
	description_antag = "You could sabotage this with some precisely modded wirecutters and some insulated gloves. Electrical skill would help too."
	icon = 'icons/obj/asteroidcannon_centred.dmi'
	icon_state = "asteroidgun"
	bound_height = 128
	bound_width = 128
	density = TRUE
	anchored = TRUE
	dir = EAST //Ship faces east, so does big mega gun.
	light_color="#ff0000" //Glows red when it's out of commission...
	health = 200
	max_health = 200 //Takes a lot of effort to take out.
	layer = ABOVE_WINDOW_LAYER
	atom_flags = ATOM_FLAG_INDESTRUCTIBLE
	var/lead_distance = 0 //How aggressively to lead each shot. If set to 0 the bullets become hitscan.
	var/bullet_origin_offset = 3 //+/-x. Offsets the bullet so it can shoot "through the wall" to more closely mirror the source material's gun.

	var/fire_sound = 'sound/effects/asteroidcannon_fire.ogg'
	var/next_shot = 0
	var/fire_delay = 0.50 SECONDS
	var/operational = TRUE //Is it online?


	var/last_offline = 0 //When was it last taken offline? Used to spawn meteors when it's taken offline. Spite!
	var/firing = FALSE	//Set true when user is holding down fire button
	appearance_flags=KEEP_TOGETHER

	var/datum/extension/asteroidcannon/fire_handler

	var/obj/machinery/computer/asteroidcannon/console

	//Rotation handling
	var/datum/extension/rotate_facing/rotator
	var/atom/target
	var/firing_arc = CANNON_FIRING_ARC
	pixel_y = -64
	pixel_x = -144
	var/cached_plane
	var/deadzone = 10	//The angle towards the target must be <= this amount in order to fire at it
	var/vector2/forward_vector = CANNON_FORWARD_DIR
	var/vector2/offset_vector	//This is the offset we point towards when we return to neutral

	//Extra objects
	var/obj/asteroidover
	var/obj/asteroidunder

/obj/structure/asteroidcannon/Initialize(mapload, d)
	. = ..()
	if(GLOB.asteroidcannon)
		message_admins("Duplicate asteroid cannon at [get_area(src)], [x], [y], [z] spawned!")
		return INITIALIZE_HINT_QDEL
	GLOB.asteroidcannon = src
	forward_vector = Vector2.FromDir(forward_vector)
	offset_vector = forward_vector * bullet_origin_offset
	offset_vector.SelfMultiply(WORLD_ICON_SIZE)

	//Sets up the overlay
	asteroidover = new(loc)
	asteroidover.mouse_opacity = FALSE //Just a fluff overlay.
	asteroidover.plane = plane + 0.1
	asteroidover.layer = layer + 0.1
	asteroidover.icon = icon
	asteroidover.pixel_x = pixel_x
	asteroidover.pixel_y = pixel_y
	asteroidover.icon_state = "asteroidgun_over"

	//And the underlay
	asteroidunder = new(loc)
	asteroidunder.mouse_opacity = FALSE //Just a fluff overlay.
	asteroidunder.plane = plane - 0.1
	asteroidunder.layer = layer - 0.1
	asteroidunder.icon = icon
	asteroidunder.pixel_x = pixel_x
	asteroidunder.pixel_y = pixel_y
	asteroidunder.icon_state = "asteroidgun_under"



	//Give it the shooty bit

	fire_handler = set_extension(src, /datum/extension/asteroidcannon)
	rotator = set_extension(src, /datum/extension/rotate_facing/asteroidcannon)


/obj/structure/asteroidcannon/attackby(obj/item/C, mob/user)
	//. = ..()
	//Antags can sabotage the cannon
	if (user.is_antagonist())

		var/datum/crew_objective/CO = get_crew_objective(/datum/crew_objective/ads)
		if (!CO.can_sabotage())
			to_chat(user, SPAN_NOTICE("You've done enough, This will probably break down soon"))
			return

		if(C.has_quality(QUALITY_WIRE_CUTTING))
			user.visible_message(SPAN_DANGER("[user] starts cutting cables under the [src]"))
			if(C.use_tool(user, src, WORKTIME_SLOW, QUALITY_WIRE_CUTTING, FAILCHANCE_IMPOSSIBLE, required_stat = SKILL_ELECTRICAL))
				to_chat(user, "<span class='notice'>You have carefully sabotaged the Asteroid Defense System, it will surely break down soon...</span>")
				CO.sabotage()

/obj/structure/asteroidcannon/take_damage(amount, damtype, user, used_weapon, bypass_resist)
	return

/obj/structure/asteroidcannon/proc/sabotage()

	var/datum/crew_objective/CO = get_crew_objective(/datum/crew_objective/ads)
	CO.sabotage()

	visible_message("<span class='warning'>[src] sparks wildly!</span>")
	playsound(src, 'sound/effects/caution.ogg', 100, TRUE)
	//sparks
	var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
	spark_system.set_up(5, 0, loc)
	spark_system.start()
	playsound(loc, "sparks", 50, 1)

/obj/structure/asteroidcannon/proc/break_down()
	operational = FALSE
	visible_message("<span class='warning'>[src] sparks wildly!</span>")
	playsound(src, 'sound/effects/caution.ogg', 100, TRUE)
	//sparks
	var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
	spark_system.set_up(5, 0, loc)
	spark_system.start()
	playsound(loc, "sparks", 50, 1)

/obj/structure/asteroidcannon/proc/finish_repair()
	operational = TRUE
	visible_message("<span class='warning'>[src] springs to life as the autotargeting reboots!</span>")
	stop_gunning()
	fire_handler.wake_up()

/obj/structure/asteroidcannon/proc/is_operational()
	return operational

/obj/structure/asteroidcannon/ex_act(severity)
	return FALSE

/obj/structure/asteroidcannon/proc/is_firing()
	return firing


/obj/structure/asteroidcannon/proc/fire_at(atom/T)
	if (!T)
		return

	var/delta = rotator.get_rotation_to_target(T)
	if (abs(delta) > deadzone)
		//We aren't pointed at the target yet, fail
		return

	var/turf/out = rotator.get_turf_infront(bullet_origin_offset)
	if(world.time < next_shot)
		return FALSE
	flick("asteroidgun_firing", src)
	next_shot = world.time + fire_delay
	var/obj/item/projectile/bullet/asteroidcannon/bullet = new(out)
	playsound(src, fire_sound, VOLUME_HIGH, 1, 12)
	bullet.launch(T)


	flick("asteroidgun_over_fire", asteroidover)
	flick("asteroidgun_under_fire", asteroidunder)

/obj/structure/asteroidcannon/attack_hand(mob/user)
	if (fire_handler.gunner)
		stop_gunning()
	else
		start_gunning(user)


/obj/structure/asteroidcannon/proc/start_firing()
	firing = TRUE

/obj/structure/asteroidcannon/proc/stop_firing()
	firing = FALSE

/obj/structure/asteroidcannon/proc/start_gunning(mob/user)
	if(!isliving(user) || user.is_necromorph())
		return FALSE //No.
	if (fire_handler.gunner)
		to_chat(user, SPAN_DANGER("The hotseat is occupied"))
		return
	fire_handler.set_gunner(user)

/obj/structure/asteroidcannon/proc/stop_gunning(mob/user)
	fire_handler.remove_gunner()
	unset_target()




/obj/structure/asteroidcannon/proc/set_target(var/atom/newtarget)
	if (target == newtarget || abs(rotator.get_total_rotation_to_target(newtarget)) > firing_arc || get_dist(src, newtarget) < bullet_origin_offset)
		//Too close or not in our angle
		return

	target = newtarget
	rotator.set_target(target)

/obj/structure/asteroidcannon/proc/unset_target()
	//This causes the gun to rotate back to neutral by aiming at a tile infront
	var/turf/T = get_turf_at_pixel_offset(offset_vector)
	set_target(T)

/*
	Projectile
*/
/obj/item/projectile/bullet/asteroidcannon
	name = "Accelerated Tungsten Slug"
	icon_state = "asteroidcannon"
	damage = 100
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/laser/ads/muzzle
	tracer_type = /obj/effect/projectile/laser/ads/tracer
	impact_type = /obj/effect/projectile/laser/ads/impact
	kill_count = INFINITY


/obj/item/projectile/bullet/asteroidcannon/Bump(atom/A, forced)
	. = ..()
	if(istype(A, /obj/effect/meteor))
		var/obj/effect/meteor/M = A
		M.break_apart()
		qdel(src)




/datum/extension/rotate_facing/asteroidcannon
	max_rotation = CANNON_FIRING_ARC
	angular_speed = CANNON_ROTATION_SPEED
	active_track = TRUE
	forward_vector = CANNON_FORWARD_DIR	//The cannon faces right







//----------------------------
// Cannon laser stuff
//	Has no light color to help performance
//----------------------------
/obj/effect/projectile/laser/ads
	light_color = null

/obj/effect/projectile/laser/ads/tracer
	icon_state = "xray"

/obj/effect/projectile/laser/ads/muzzle
	icon_state = "muzzle_xray"

/obj/effect/projectile/laser/ads/impact
	icon_state = "impact_xray"