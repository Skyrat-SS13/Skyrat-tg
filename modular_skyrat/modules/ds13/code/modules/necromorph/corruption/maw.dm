/*
	Fairly simple but useful node, the maw acts as a corpse dropoff point. It will start eating bodies nearby

	In addition, it will also act as a floor trap, nomming on mobs that step in it

*/

/obj/structure/corruption_node/maw
	icon_state = "maw"
	name = "maw"
	desc = "The abyss stares back at you."
	default_scale = 1.4
	biomass = 8
	biomass_reclamation = 1
	reclamation_time = 5 MINUTES

	max_health = 50
	resistance = 12	//Gotta bring a tough weapon

	pixel_y = -16	//So that mobs trapped in it appear to be standing in the hole

	var/eat_range = MAW_EAT_RANGE
	var/list/eating = list()	//Things we're currently eating. Keep chewing as long as one is nearby
	var/chomp_chance = 10	//The chance, per tick, per mob, to do a chomp animation. max 1 per tick
	//Also used as the chance to damage trapped mobs

	var/base_damage = 15
	var/fail_damage = 4
	var/base_difficulty = 85
	var/time_to_escape = 40
	var/target_zone
	var/struggle_prob = 2

/obj/structure/corruption_node/maw/get_blurb()
	. = "The maw is a simple and useful node with two functions. <br><br>\
	Firstly, it acts as a corpose disposal location for necromorphs. Maws will slowly devour any human corpses brought within a [eat_range] range, sending their biomass on to the marker. This means that bodies don't need to be dragged as far. <br>\
	Secondly, the maw acts as a floor trap. Any non-necromorph who walks over it will fall in and get stuck. forced to gradually work their way out while it takes bites out of them. This will usually not prove fatal to a healthy crewmember, but the time it holds them for can be enough for necromorphs to arrive and cut them down."


/obj/structure/corruption_node/maw/Initialize()
	.=..()
	if (!dummy)
		//Lets create a proximity tracker to detect corpses being dragged into our vicinity
		var/datum/proximity_trigger/view/PT = new (holder = src, on_turf_entered = /obj/structure/corruption_node/maw/proc/nearby_movement, range = 2)
		PT.register_turfs()
		set_extension(src, /datum/extension/proximity_manager, PT)


//A mob was detected nearby, can we absorb it?
/obj/structure/corruption_node/maw/proc/nearby_movement(var/atom/movable/AM, var/atom/old_loc)

	if (isliving(AM) && get_marker())
		var/mob/living/L = AM
		if (!L.is_necromorph())
			//Yes we can
			var/obj/machinery/marker/marker = get_marker()
			var/datum/biomass_source/S = marker.add_biomass_source(L, L.mass, 8 MINUTES, /datum/biomass_source/convergence)
			if (S)
				eating |= S
				animate_chomp()
				START_PROCESSING(SSobj, src)
				//We can only absorb dead mobs, but we don't check that here
				//We'll add a still-living mob to the list and it'll be checked each tick to see if it died yet

	//Organs and blood are succed up instantly but don't yield biomass
	if (istype(AM, /obj/item/organ) || istype(AM, /obj/effect/decal/cleanable/blood))
		spawn(1)
			if (!QDELETED(AM))
				qdel(AM)



/obj/structure/corruption_node/maw/proc/animate_chomp()
	var/chompstate = pick("maw_v", "maw_h")
	flick(chompstate, src)


//While eating mobs, the maw will do chomp animations
/obj/structure/corruption_node/maw/Process()
	for (var/datum/biomass_source/S as anything in eating)
		if (QDELETED(S))
			eating -= S
			continue
		var/check = S.can_absorb()
		if (check == MASS_READY)
			if (prob(chomp_chance))
				animate_chomp()
				var/atom/A = locate(S.source)
				if (A)//Shake the thing around
					A.shake_animation()

		else
			if (check == MASS_PAUSE)
				continue	//ITs paused, just keep going

			if (check == MASS_EXHAUST || check == MASS_FAIL)
				eating.Remove(S)

	if (buckled_mob)
		var/mob/living/L = buckled_mob

		//If its dead or gone, stop processing
		//Also stop if a player took control of it, they can try to free themselves
		if (QDELETED(L) || L.stat == DEAD || L.loc != loc)
			release_mob()
		else if (prob(chomp_chance))
			damage_mob(L)	//We'll periodically bite the victim


		//Chance each tick that the mob will attempt to free itself
		if (prob(struggle_prob) && !L.incapacitated() && !L.client)
			attempt_release(L)

	//If we're no longer eating anything, stop processing
	if (!eating.len && !buckled_mob)
		return PROCESS_KILL








//TRAP HANDLING
//-------------------
//When a non-necromorph steps into a maw, it bites them and starts chewing
//Most of the below code is copied from beartraps
/obj/structure/corruption_node/maw/Crossed(var/atom/movable/AM)
	if((!AM.is_necromorph()) && isliving(AM) && !(AM.pass_flags & PASS_FLAG_FLYING))
		var/mob/living/L = AM
		L.visible_message(
			"<span class='danger'>[L] steps on \the [src].</span>",
			"<span class='danger'>You step on \the [src]!</span>",
			"<b>You hear a sickening crunch snap!</b>"
			)
		attack_mob(L)
		update_icon()
	..()

//Using a crowbar allows you to lever the trap open, better success rate
/obj/structure/corruption_node/maw/attackby(obj/item/C, mob/living/user)
	if (C.has_quality(QUALITY_PRYING))
		attempt_release(user, C)
		return
	.=..()

/obj/structure/corruption_node/maw/attack_hand(mob/user as mob)
	if (buckled_mob)
		attempt_release(user)
		return
	.=..()

/obj/structure/corruption_node/maw/attack_generic(var/mob/user, var/damage)
	if (buckled_mob)
		attempt_release(user)
		return
	.=..()

/obj/structure/corruption_node/maw/attack_robot(var/mob/user)
	if (buckled_mob)
		attempt_release(user)
		return
	.=..()



/obj/structure/corruption_node/maw/proc/can_use(mob/user)
	return (user.is_advanced_tool_user() && !user.stat && user.Adjacent(src))

/obj/structure/corruption_node/maw/proc/release_mob()
	unbuckle_mob()
	can_buckle = initial(can_buckle)
	update_icon()
	STOP_PROCESSING(SSobj, src)
	GLOB.updatehealth_event.unregister(buckled_mob, src, /obj/structure/corruption_node/maw/proc/check_grip)

//Attempting to resist out of a maw will not work, and you'll get nothing but pain for trying
/obj/structure/corruption_node/maw/resist_buckle(var/mob/user)
	if (user == buckled_mob && !user.stunned)
		//We check stunned here, and a failure stuns the victim. This prevents someone from just spam-resisting and instantly killing themselves
		if (user.client)
			fail_attempt(user)
			to_chat(user, SPAN_WARNING("Struggling out of this isn't going to work, you'll need to try to release \the [src] with your hands or a tool"))
		else
			//Fallback behaviour for possible future use of NPCs
			attempt_release(user, null)
	return FALSE //Returning false prevents the default resist behaviour of instantly releasing the trap



//If an attempt to release the mob fails, it digs in and deals more damage
/obj/structure/corruption_node/maw/proc/fail_attempt(var/user, var/difficulty)
	if (!buckled_mob)
		return

	var/mob/living/L = buckled_mob
	//armour
	damage_mob(L)

	if (ishuman(L))
		var/mob/living/carbon/human/H = L
		visible_message(SPAN_DANGER("\The [src] snaps back, digging deeper into [buckled_mob.name]'s [H.find_target_organ(target_zone).name]"))
	else
		visible_message(SPAN_DANGER("\The [src] snaps back, digging deeper into [buckled_mob.name]"))


	if (!check_grip())
		return
	if (difficulty)
		user << SPAN_NOTICE("You failed break free. There was a [round(100 - difficulty)]% chance of success")
		if (user == buckled_mob)
			user << SPAN_NOTICE("Freeing yourself is very difficult. Perhaps you should call for help?")


/obj/structure/corruption_node/maw/proc/damage_mob(var/mob/living/L)
	var/blocked = L.run_armor_check(target_zone, "melee")
	if(blocked < 100)
		playsound(src, 'sound/weapons/slice.ogg', 10, 1,-2,-2)//Fairly quiet snapping sound
		L.apply_damage(fail_damage, BRUTE, target_zone, blocked, DAM_EDGE|DAM_SHARP, src)
		L.Stun(3) //A short stun prevents spamming failure attempts
		shake_camera(L, 2, 1)
	animate_chomp()
	check_grip()

/obj/structure/corruption_node/maw/proc/attack_mob(mob/living/L)
	//Small mobs won't trigger the trap
	//Imagine a mouse running harmlessly over it
	if (!L )
		return

	if(L.lying)
		target_zone = ran_zone()
	else
		target_zone = pick("l_leg", "r_leg")

	can_buckle = initial(can_buckle)
	playsound(src, 'sound/weapons/slice.ogg', 100, 1,10,10)//Really loud snapping sound


	//armour
	var/blocked = L.run_armor_check(target_zone, "melee")
	if(blocked < 100)

		var/success = L.apply_damage(base_damage, BRUTE, target_zone, blocked, DAM_EDGE|DAM_SHARP, src)
		if(success)
			shake_camera(L, 2, 1)


	//trap the victim in place
	set_dir(L.dir)
	can_buckle = 1
	GLOB.updatehealth_event.register(L, src, /obj/structure/corruption_node/maw/proc/check_grip)
	buckle_mob(L)
	if (check_grip())
		L << "<span class='danger'>The jaws beneath bite into you, trapping you in place!</span>"


		START_PROCESSING(SSobj, src)


//Checks if we can still hold onto this mob
/obj/structure/corruption_node/maw/proc/check_grip()
	if (!ishuman(buckled_mob))
		return TRUE

	var/mob/living/carbon/human/H = buckled_mob
	var/obj/item/organ/external/E = H.get_organ(target_zone)
	if (!E || E.is_stump())
		release_mob()
		return FALSE

	return TRUE

/obj/structure/corruption_node/maw/proc/attempt_release(var/mob/living/user, var/obj/item/I)
	if (!buckled_mob || QDELETED(buckled_mob) || !check_grip())
		return //Nobody there to rescue?

	if (!user)
		return //No user, or too far away

	//How hard will this be? The chance of failure
	var/difficulty = base_difficulty

	//Does the user have the dexterity to operate the trap?
	if (!can_use(user))
		//If they don't, then they're probably some kind of animal trapped in it
		if (user != buckled_mob || user.client)
			//Such a creature can't free someone else
			return

		//But they can attempt to struggle out on their own. At a very low success rate
		difficulty = 96
		/*This will generally not work, and repeated attempts will result in the creature bleeding to
		death as it tries to escape
		Such is nature*/

	else
		if (user != buckled_mob)
			difficulty -= 35 //It's easier to free someone else than to free yourself

		//Is there a tool involved?
		if (istype(I))
			//Using a crowbar helps
			user << SPAN_NOTICE("\The [I] gives you extra leverage")
			var/reduction = I.get_tool_quality(QUALITY_PRYING)*0.5
			if (user == buckled_mob)
				reduction *= 0.66 //But it helps less if you don't have good leverage
			difficulty -= reduction
			I.consume_resources(time_to_escape*3, user)

		if (issilicon(user))
			difficulty += 5 //Robots are less dextrous

		//TODO: Hook in bay stats here
		var/reduction = 0//user.stats.getStat(list(STAT_MAX, STAT_ROB, STAT_MEC))
		if (user == buckled_mob)
			reduction *= 0.66 //But it helps less if you don't have good leverage
		difficulty -= reduction

	//Alright we calculated the difficulty, now lets do the attempt

	//Firstly a visible message
	if (buckled_mob == user)
		user.visible_message(
			"<span class='notice'>\The [user] tries to free themselves from \the [src].</span>",
			"<span class='notice'>You carefully begin to free yourself from \the [src].</span>",
			"<span class='notice'>You hear squelching.</span>"
			)
	else
		user.visible_message(
			"<span class='notice'>\The [user] tries to free \the [buckled_mob] from \the [src].</span>",
			"<span class='notice'>You carefully begin to free \the [buckled_mob] from \the [src].</span>",
			"<span class='notice'>You hear squelching.</span>"
			)

	//TODO: Fleshy audio here
	//playsound(src, 'sound/machines/airlock_creaking.ogg', 10, 1, -3,-3)



	//Now a do_after
	if(!do_after(user, time_to_escape))
		//If you abort it's an automatic fail
		fail_attempt()
		return

	//You completed the doafter, but did you succeed?
	if (difficulty > 0 && prob(difficulty))
		fail_attempt(user, difficulty)
		return

	//You succeeded yay
	user.visible_message(
			"<span class='notice'>[user] successfully releases [buckled_mob] from \the [src].</span>",
			"<span class='notice'>You successfully release [buckled_mob] from \the [src].</span>",
			"<span class='notice'>You hear squelching.</span>"
			)
	release_mob()



