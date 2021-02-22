/*
	Tongue Attack

	Fires a projectile which leads the tongue.
	The actual tongue is drawn as a tracer effect which follows the projectile

	If it hits a mob, wraps around their neck and begins an execution move. At this point, the tongue becomes a targetable object
*/
#define TONGUE_PROJECTILE_SPEED	4.5
#define	TONGUE_OFFSET	-8,40
#define TONGUE_RANGE	5
/*
	Ability
*/
/mob/living/carbon/human/proc/divider_tongue(var/atom/A)
	set name = "Tonguetacle"
	set category = "Abilities"
	set desc = "Launches out your tongue to grab a human and strangle them. HK: Ctrl+alt+click"

	face_atom(A)
	.= shoot_ability(/datum/extension/shoot/tongue, A , /obj/item/projectile/tongue, accuracy = 200, dispersion = 0, num = 1, windup_time = 0.5 SECONDS, fire_sound = null, nomove = 1 SECOND, cooldown = 10 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)



/*
	Extension
*/
/datum/extension/shoot/tongue
	name = "Divider Tongue"
	base_type = /datum/extension/shoot/tongue
	var/obj/effect/projectile/tether/tongue/tongue
	var/tongue_out = FALSE

/datum/extension/shoot/tongue/start()
	tongue_out = TRUE
	.=..()

/datum/extension/shoot/tongue/stop()
	if (tongue_out)
		return

	status = SHOOT_STATUS_COOLING
	deltimer(ongoing_timer)
	stopped_at = world.time
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/shoot/proc/finish_cooldown), cooldown)

/*
	Lead Projectile
*/
/obj/item/projectile/tongue
	name = "tongue leader"
	icon_state = ""
	fire_sound = null
	damage = 0
	nodamage = TRUE
	step_delay = (10 / TONGUE_PROJECTILE_SPEED)
	kill_count = TONGUE_RANGE	//Short-ish range
	var/obj/effect/projectile/tether/tongue/tongue = null


/obj/item/projectile/tongue/expire()
	set waitfor = FALSE
	//On expiring the tongue projectile flies back towards the host
	expired = TRUE
	if (tongue)
		var/vector2/return_loc = firer.get_global_pixel_offset(src)
		var/return_time = (return_loc.Magnitude() / WORLD_ICON_SIZE) * (step_delay*1.5)

		sleep(1 SECOND)
		tongue.retract(return_time)
		sleep(return_time)

	.=..()



/*
	The firer will be set just before this proc is called
*/
/obj/item/projectile/tongue/launch(atom/target, var/target_zone, var/x_offset=0, var/y_offset=0, var/angle_offset=0)
	tongue = new(get_turf(src))
	tongue.set_origin(firer)

	var/datum/extension/shoot/tongue/T = get_extension(firer, /datum/extension/shoot/tongue)
	if (T)
		T.tongue = src.tongue
		T.tongue_out = TRUE

	//We'll start it at the mouth pointing towards enemy slightly
	var/vector2/origin_pixels = firer.get_global_pixel_loc()
	var/vector2/offset_pixels = target.get_global_pixel_loc()
	offset_pixels.SelfSubtract(origin_pixels)
	offset_pixels.SelfToMagnitude(10)
	offset_pixels.SelfAdd(origin_pixels)
	tongue.set_ends(origin_pixels, offset_pixels, FALSE)

	.=..()


/obj/item/projectile/tongue/Move(NewLoc,Dir=0)

	.=..()
	if (tongue)
		update_tongue()

/obj/item/projectile/tongue/proc/update_tongue(var/animate = TRUE)
	var/vector2/origin_pixels = firer.get_global_pixel_loc()
	var/vector2/current_pixels = get_global_pixel_loc()
	tongue.set_ends(origin_pixels, current_pixels, (animate ? step_delay : FALSE))
	release_vector(origin_pixels)
	release_vector(current_pixels)


/obj/item/projectile/tongue/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)

	//Are they a valid execution target?
	if (divider_tongue_start(firer, target_mob) == EXECUTION_CONTINUE)
		var/vector2/targetloc = target_mob.get_global_pixel_loc()
		tongue.set_ends(tongue.start, targetloc, step_delay, 2)
		release_vector(targetloc)

		//Yes, lets do this!
		tongue.set_target(target_mob)
		tongue.set_turf_maintain_pixels(get_turf(target_mob))

		var/temp_tongue = tongue
		tongue = null //The tongue is no longer our business

		//Here we start the execution, and transfer ownership of the tongue tether
		firer.perform_execution(/datum/extension/execution/divider_tongue, target_mob, temp_tongue)
		qdel(src)//Delete ourselves WITHOUT calling expire
		return
	return PROJECTILE_CONTINUE


/*
	Tether
*/
/obj/effect/projectile/tether/tongue
	icon = 'icons/effects/tethers.dmi'
	icon_state = "tongue"
	base_length = WORLD_ICON_SIZE*2
	start_offset = new /vector2(TONGUE_OFFSET)
	end_offset = new /vector2(-16, 8)//Elevated a bit so it wraps around the victim's neck
	plane = HUMAN_PLANE
	layer = BELOW_HUMAN_LAYER
	atom_flags = 0
	obj_flags = 0

//Tongue takes double damage from edged weapons
/obj/effect/projectile/tether/tongue/take_damage(var/amount, var/damtype = BRUTE, var/user, var/used_weapon, var/bypass_resist = FALSE)
	var/obj/item/I = used_weapon
	if (I && istype(I) && I.edge)
		amount *= 2

	.=..()


/obj/effect/projectile/tether/tongue/retract(var/time = 1 SECOND, var/delete_on_finish = TRUE, var/steps = 3)
	if (origin_atom)
		var/datum/extension/shoot/tongue/T = get_extension(origin_atom, /datum/extension/shoot/tongue)
		if (T && T.tongue == src)
			T.tongue = null
			T.tongue_out = FALSE
			T.stop()	//Start the cooldown
	.=..()
/*
	Safety Checks

	Core checks. It is called as part of other check procs on initial tongue contact, and periodically while performing the execution.
	If it returns false, the execution is denied or cancelled.
*/
/proc/divider_tongue_safety(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)

	//We only target humans
	if (!istype(user) || !istype(target))
		return EXECUTION_CANCEL

	//Abort if either mob is deleted
	if (QDELETED(user) || QDELETED(target))
		return EXECUTION_CANCEL

	//Don't target our allies
	if (target.is_necromorph())
		return EXECUTION_CANCEL

	//The divider needs its head to have a tongue
	if (!user.get_organ(BP_HEAD))
		return EXECUTION_CANCEL

	//The divider needs to be awake and able bodied. Needs a firm footing
	if (user.incapacitated(INCAPACITATION_FORCELYING))
		return EXECUTION_CANCEL

	return EXECUTION_CONTINUE


/*
	Start check, called to see if we can grab the mob
*/
/proc/divider_tongue_start(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
	//Core first
	.=divider_tongue_safety(user, target)
	if (. == EXECUTION_CANCEL)
		return

	//Now in addition

	//The target must be alive when we start.
	if (target.stat == DEAD)
		return EXECUTION_CANCEL

	//The target must have a head for us to rip off
	if (!target.get_organ(BP_HEAD))
		return EXECUTION_CANCEL

	//The target must be standing
	if (target.lying)
		return EXECUTION_CANCEL

	if (target.is_necromorph())
		return EXECUTION_CANCEL

	return EXECUTION_CONTINUE


/*
	Continue check, called during the execution, this has three return values
	0 = FAIL, the execution is cancelled
	1 = continue, keep going
	2 = win, the execution ends successfully, the victim is killed and we skip to the final stage
*/
/proc/divider_tongue_continue(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
	//Core first
	.=divider_tongue_safety(user, target)
	if (. == EXECUTION_CANCEL)
		return

	//Now in addition

	//If the target's head has been removed since we started, then we win! Decapitating them is our goal
	if (!target.get_organ(BP_HEAD))
		return EXECUTION_SUCCESS

	//If the target died from anything other than losing their head, we have failed
	if (target.stat == DEAD)
		return EXECUTION_CANCEL


	return EXECUTION_CONTINUE


/*
	Execution
*/
/datum/extension/execution/divider_tongue
	name = "Tonguetacle"
	base_type = /datum/extension/execution/divider_tongue
	cooldown = 0	//Cooldown isnt handled here
	require_grab = FALSE
	reward_biomass = 5
	reward_energy = 100
	reward_heal = 40
	range = TONGUE_RANGE
	//
	all_stages = list(/datum/execution_stage/wrap,
	/datum/execution_stage/strangle/first,
	/datum/execution_stage/strangle/second,
	/datum/execution_stage/strangle/third,
	/datum/execution_stage/finisher/decapitate,
	/datum/execution_stage/retract/divider,
	/datum/execution_stage/scream)



	vision_mod = -4


/datum/extension/execution/divider_tongue/safety_check()

	var/obj/effect/projectile/tether/tongue/T = weapon



	var/safety_result = divider_tongue_continue(user, victim)

	if (safety_result == EXECUTION_SUCCESS)
		success = TRUE
		return EXECUTION_SUCCESS
	else if (safety_result == EXECUTION_CONTINUE)
		//If the tongue is cut or gone, we have failed
		if (!istype(T) || QDELETED(T) || T.health <= 0)
			return EXECUTION_CANCEL
		.=..()
	else
		return EXECUTION_CANCEL


/datum/execution_stage/retract/divider
	duration = 2 SECONDS


/datum/extension/execution/divider_tongue/interrupt()
	.=..()
	user.play_species_audio(src, SOUND_PAIN, VOLUME_MID, 1, 2)
	var/obj/effect/projectile/tether/T = weapon
	if (istype(T))
		T.retract(1 SECOND)

/datum/extension/execution/divider_tongue/can_start()
	if (divider_tongue_start(user, victim) != EXECUTION_CONTINUE)
		return FALSE
	.=..()


/*
	Stages
*/
/datum/execution_stage/wrap
	var/datum/movement_handler/root/user_root
	var/datum/movement_handler/root/target_root

/datum/execution_stage/wrap/enter()

	//The target cannot move, but can still fight back
	target_root = host.victim.root()


	//The user cannot move or take any action
	user_root = host.user.root()
	host.user.Stun(2)

	host.victim.losebreath += 4
	host.user.visible_message(SPAN_EXECUTION("[host.user] wraps their tongue around [host.victim]'s throat, constricting their airways and holding them in place!"))
	host.user.do_shout(SOUND_SHOUT_LONG, FALSE)

/datum/execution_stage/wrap/stop()
	if (user_root)
		user_root.remove()
		host.user.stunned = 0

	if (target_root)
		target_root.remove()

/*
	Strangle stages are the meat of this attack.
	They keep hitting every 2 seconds until the total damage of the host.victim's head is at or above the specified percentage of max
*/
/datum/execution_stage/strangle
	var/head_damage_threshold = 0.33
	var/damage_per_hit = 7
	duration = 2 SECONDS


/datum/execution_stage/strangle/enter()
	//If we've already won, skip this and just return
	if (host.success)
		duration =0 //Setting duration to 0 will prevent any waiting after this proc
		return

	var/done = FALSE
	while (!done)

		//First of all, safety check
		var/safety_result = host.safety_check()
		if (safety_result != EXECUTION_CONTINUE)
			//If we've either failed or won, we quit this
			if (safety_result == EXECUTION_SUCCESS)
				duration =0 //Setting duration to 0 will prevent any waiting after this proc
			done = TRUE
			continue



		//Okay now lets check the victim's health. We know they still have a head
		var/obj/item/organ/external/E = host.victim.get_organ(BP_HEAD)
		var/dampercent = E.damage / E.max_damage
		if (dampercent >= head_damage_threshold)
			done = TRUE
			continue


		//The victim is weak enough to keep hitting, and they are still alive
		//They are being strangled, can't breathe. Even if they had an eva suit, the air supply hose is constricted
		host.victim.losebreath++

		//Do the actual damage. The functionally infinite difficulty means it cant be blocked, but armor may still help resist it
		host.user.launch_strike(host.victim, damage_per_hit, host.weapon, DAM_EDGE, 0, BRUTE, armor_type = "melee", target_zone = BP_HEAD, difficulty = 999999)


		//We repeat the safety check now, since that damage might have just removed the head
		safety_result = host.safety_check()
		if (safety_result != EXECUTION_CONTINUE)
			//If we've either failed or won, we quit this
			if (safety_result == EXECUTION_SUCCESS)
				duration =0 //Setting duration to 0 will prevent any waiting after this proc
			done = TRUE
			continue

		//The victim and their camera shake wildly as they struggle
		shake_camera(host.victim, 2, 3)
		host.victim.shake_animation(12)
		host.user.shake_animation(12)

		//Make sure the user stays stunned during this process
		host.user.Stun(1+(duration*0.1))

		sleep(duration)


/datum/execution_stage/strangle/first
	head_damage_threshold = 0.33

/datum/execution_stage/strangle/second
	head_damage_threshold = 0.66

/datum/execution_stage/strangle/third
	head_damage_threshold = 0.99


/datum/execution_stage/finisher/decapitate
	duration = 0
/datum/execution_stage/finisher/decapitate/enter()
	host.user.visible_message(SPAN_EXECUTION("[host.user] makes one final pull as [host.victim]'s soft flesh yields under the assault, and their head tumbles to the floor!"))

	var/obj/item/organ/external/E = host.victim.get_organ(BP_HEAD)

	//Chop!
	if (E && !E.is_stump())
		E.droplimb(TRUE, DROPLIMB_EDGE, FALSE, FALSE, host.weapon)
	host.user.do_shout(SOUND_SHOUT_LONG, FALSE)
	.=..()