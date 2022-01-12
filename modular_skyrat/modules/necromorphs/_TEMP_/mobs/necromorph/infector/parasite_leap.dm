/*
	Parasite Leap:

	The infector attempts to leap onto a targeted human. If successful, it latches onto them.

	Once attached, it begins probing the skull with its proboscis through repeated light attacks.
	These are affected by armor, a helmet makes it much harder.

	If it manages to deal enough total damage to max out the head's damage capacity, the operation is successful.
	The victim will be converted where they stand into a necromorph, with a higher compatibilty value used

	If the infector is grappled, the attacks are paused.  If it is thrown away or otherwise pulled off the victim, it is cancelled
	Execution will end in failure if the victim loses their head, but succeed if they die during the process from any other means
*/

//Entrypoint
//This calls charge impact on hit, which mounts to the victim, and then starts the execution
/mob/living/carbon/human/proc/infector_execution(var/atom/A)
	set name = "Parasite Leap"
	set category = "Abilities"


	//Leap autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)

	var/mob/living/L = A
	if (!istype(L) || L.lying || L.is_necromorph())
		to_chat(src, SPAN_DANGER("This must target a living, standing human."))
		return



	var/mob/living/carbon/human/H = src

	if (!can_charge(A))
		return


	if (!can_execute(/datum/extension/execution/infector))
		return

	var/obj/item/organ/external/arm/tentacle/proboscis/P = get_organ(BP_HEAD)
	if (!P || P.is_stump())
		to_chat(src, SPAN_DANGER("You need your proboscis to perform this move!"))
		return

	//The infector can't flap if its missing too many wings. Specifically, it must have at least one, though there are penalties for not having both

	var/missing = 0
	if (!H.has_organ(BP_R_ARM))
		missing++

	if (!H.has_organ(BP_L_ARM))
		missing++


	var/cooldown = FLAP_COOLDOWN
	var/speed = 3.5

	if (missing >= 2)
		to_chat(src, SPAN_DANGER("You need at least one wing to leap!"))
		return
	else if (missing == 1)
		//Flapping with one wing is inaccurate and slower
		speed /= 1 + FLAP_SINGLE_WING_IMPAIRMENT


	//Do a chargeup animation. Pulls back and down, and then launches forwards
	//The time is equal to the windup time of the attack, plus 0.5 seconds to prevent a brief stop and ensure launching is a fluid motion
	var/vector2/pixel_offset = get_new_vector(0, -6)
	var/vector2/cached_pixels = get_new_vector(src.pixel_x, src.pixel_y)
	animate(src, pixel_x = src.pixel_x + pixel_offset.x, pixel_y = src.pixel_y + pixel_offset.y, time = 0.2 SECONDS, easing = EASE_OUT|CUBIC_EASING, flags = ANIMATION_PARALLEL)
	animate(pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, easing = EASE_IN|CUBIC_EASING, time = 0.2 SECONDS)
	release_vector(pixel_offset)
	release_vector(cached_pixels)

	//Long shout when targeting mobs
	H.play_species_audio(H, SOUND_SHOUT_LONG, 100, 1, 3)


	return leap_attack(A, _cooldown = cooldown, _delay = 0.35 SECONDS, _speed = speed, _maxrange = 9,_lifespan = 3 SECONDS, subtype = /datum/extension/charge/leap/flap/execution)


//A subtype that just exists to be typechecked
/datum/extension/charge/leap/flap/execution











/*
	The Execution Extension
*/
/datum/extension/execution/infector
	name = "Parasite Leap"
	cooldown = 60 SECONDS
	base_type	=	/datum/extension/execution/infector
	require_grab = FALSE
	reward_biomass = 0
	reward_energy = 80
	reward_heal = 0
	range = 0
	all_stages = list(/datum/execution_stage/wingwrap,
	/datum/execution_stage/infector_headstab,
	/datum/execution_stage/finisher/skullbore,
	/datum/execution_stage/convert)

	weapon_check = /datum/extension/execution/proc/weapon_check_organ


/datum/extension/execution/infector/can_start()
	.=..()
	//Core first
	if (. == EXECUTION_CANCEL)
		return

	//Now in addition

	//Can't target necros
	if (victim.is_necromorph())
		return EXECUTION_CANCEL

	//The target must have a head for us to penetrate
	if (!victim.get_organ(BP_HEAD))
		return EXECUTION_CANCEL

	//The target must be standing
	if (victim.lying)
		return EXECUTION_CANCEL


	//To prevent stacking, there must be no other infectors in the victim's turf
	for (var/mob/living/carbon/human/H in get_turf(victim))
		if (H == victim || H == user)
			continue

		if (istype(H.species, /datum/species/necromorph/infector))
			return EXECUTION_CANCEL


/datum/extension/execution/infector/safety_check()

	.=..()
	if (. == EXECUTION_CANCEL)
		return

	//The target must have a head for us to penetrate
	if (!victim.get_organ(BP_HEAD))
		return EXECUTION_CANCEL


	//If the target is dead but still has their head, mission success!
	if (victim.stat == DEAD)
		return EXECUTION_SUCCESS

	//Being grappled causes us to pause our progress, we can't keep hitting the enemy until they let go
	if (user.is_grabbed())
		return EXECUTION_RETRY


/datum/extension/execution/infector/stop()
	unmount(user)
	.=..()

/*
	Stages
*/
/datum/execution_stage/wingwrap
	duration = 1.5 SECONDS

	var/cached_layer

/datum/execution_stage/wingwrap/enter()

	//The user cannot move or take any action
	host.user.Stun(2)

	host.victim.losebreath += 4
	host.user.visible_message(SPAN_EXECUTION("[host.user] wraps their wings around [host.victim]'s head!"))
	var/mob/living/carbon/human/H = host.user
	H.play_species_audio(SOUND_ATTACK)



	.=..()
/datum/execution_stage/wingwrap/stop()
	host.user.layer = cached_layer
	.=..()

/datum/execution_stage/infector_headstab
	duration = 2.5 SECONDS

/datum/execution_stage/infector_headstab/enter()
	.=..()
	//If we've already won, skip this and just return
	if (host.success)
		duration =0 //Setting duration to 0 will prevent any waiting after this proc
		return

	var/obj/item/organ/external/arm/tentacle/proboscis/P = host.user.get_organ(BP_HEAD)
	if (istype(P))
		P.extend()

	var/done = FALSE
	while (!done)

		//First of all, safety check
		var/safety_result = host.safety_check()

		//This only happens if we are grappled, we skip this tick and try again in a second
		if (safety_result == EXECUTION_RETRY)
			sleep(duration)
			continue
		else if (safety_result != EXECUTION_CONTINUE)

			//If we've either failed or won, we quit this
			if (safety_result == EXECUTION_SUCCESS)
				duration =0 //Setting duration to 0 will prevent any waiting after this proc
			done = TRUE
			continue



		//Okay now lets check the victim's health. We know they still have a head
		var/obj/item/organ/external/E = host.victim.get_organ(BP_HEAD)
		var/dampercent = E.damage / E.max_damage
		if (dampercent >= 1)
			done = TRUE
			continue


		//They are being strangled, can't breathe. Even if they had an eva suit, the air supply hose is constricted
		host.victim.losebreath++

		//Do the actual damage.
		host.user.launch_unarmed_strike(host.victim, /datum/unarmed_attack/proboscis/execution,	BP_HEAD)

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




/datum/execution_stage/finisher/skullbore/enter()


	host.user.visible_message(SPAN_EXECUTION("[host.user] drives the [host.weapon] into [host.victim]'s forehead, with a sickening crunch."))

	playsound(host.victim, "fracture", VOLUME_MID, TRUE)

	host.victim.shake_animation()

	var/obj/item/organ/external/head/H = host.victim.get_organ(BP_HEAD)

	//Deal heavy non-dismembering external damage to the head, this is mostly for the sake of blood graphics
	H.take_external_damage(9999, 0, DAM_SHARP, host.weapon, allow_dismemberment = FALSE)

	//Create a wound which we will use later
	H.createwound(type = PIERCE, damage = 9999, surgical = FALSE, forced_type = /datum/wound/puncture/massive/skullbore)

	//Create this extension, used for conversion
	set_extension(H, /datum/extension/skullbore)


	//Destroy the brain. This kills the man
	var/obj/item/organ/internal/brain/B = host.victim.get_organ(BP_BRAIN)
	if (B)
		B.take_internal_damage(9999)	//Victim is now ded

	//Lets just be sure because braindeath doesnt seem to kill instantly
	host.victim.death()
	.=..()

/datum/execution_stage/convert
	duration = 30

/datum/execution_stage/convert/enter()
	//We are done
	host.victim.start_necromorph_conversion(duration * 0.1)

	.=..()

/datum/execution_stage/convert/exit()
	unmount(host.user)



















/*
	Mounting
*/
/datum/species/necromorph/infector/charge_impact(var/datum/extension/charge/leap/charge)
	shake_camera(charge.user,5,3)
	.=TRUE
	if (istype(charge, /datum/extension/charge/leap/flap/execution) && ishuman(charge.last_obstacle))
		var/mob/living/L = charge.last_obstacle

		//We cannot attach to lying down targets, but we can stay attached if they fall over afterwards
		if (L.lying)
			return

		//Move onto the target
		charge.user.forceMove(get_turf(charge.last_obstacle))

		//Lets make mount parameters for posterity. We're just using the default settings at time of writing, but maybe they'll change in future
		var/datum/mount_parameters/WP = new()
		WP.attach_walls	=	FALSE	//Can this be attached to wall turfs?
		WP.attach_anchored	=	FALSE	//Can this be attached to anchored objects, eg heaving machinery
		WP.attach_unanchored	=	FALSE	//Can this be attached to unanchored objects, like janicarts?
		WP.dense_only = FALSE	//If true, only sticks to dense atoms
		WP.attach_mob_standing		=	TRUE		//Can this be attached to mobs, like brutes?
		WP.attach_mob_downed		=	TRUE	//Can this be/remain attached to mobs that are lying down?
		WP.attach_mob_dead	=	FALSE	//Can this be/remain attached to mobs that are dead?
		charge.do_winddown_animation = FALSE
		mount_to_atom(charge.user, charge.last_obstacle, /datum/extension/mount/infector, WP, override = FALSE)	//We do NOT override the existing mount, only want to do it once
		return FALSE	//Returning false terminates the charge/leap here

	else
		.=..()





//Mount extension
/datum/extension/mount/infector/on_mount()
	.=..()
	var/mob/living/carbon/human/user = mountee
	var/mob/living/carbon/human/H = mountpoint
	var/obj/item/organ/external/arm/tentacle/proboscis/P = user.get_organ(BP_HEAD)
	if (!user.perform_execution(/datum/extension/execution/infector, H, P))
		dismount()
		return


	spawn(0.5 SECONDS)
		if (!QDELETED(user) && !QDELETED(src) && mountpoint && mountee)
			//Lets put the parasite somewhere nice looking on the mob
			var/new_rotation = rand(-45, 45)

			if (mountee.dir != SOUTH)
				LAZYASET(statmods, STATMOD_LAYER, mountpoint.layer + 0.1)


			user.default_rotation = new_rotation
			user.default_pixel_y += 12
			user.default_pixel_x -= 8
			LAZYASET(statmods, STATMOD_SCALE,	-0.40)
			register_statmods(TRUE) //This will call animate_to_default and apply the changes we've recorded above


/datum/extension/mount/infector/on_dismount()
	sleep(1)
	var/mob/living/carbon/human/user = mountee

	user.default_rotation = 0
	user.default_pixel_y -= 12
	user.default_pixel_x += 8
	user.animate_to_default(4)
	.=..()







