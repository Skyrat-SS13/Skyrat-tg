/*
	Lesser Necromorph base code

	Lesser Necromorphs are not human, they use simple animal base.
	They come in one piece, and can't be dismembered.

	They should only be used for simple creatures, not for anything with multiple limbs or a humanoid shape

	Currently used for:
		Divider Arm
		Divider Leg
		Divider Head

	Planned future use:
		Swarmer
		The Swarm (DS3)
		Guardian Pod
		Guardian (premature form)
*/
/mob/living/simple_animal/necromorph
	min_gas = null
	max_gas = null
	harm_intent_damage = 5
	mass = 1
	biomass = 0
	density = FALSE
	var/lifespan = 10 MINUTES	//Minor necromorphs don't last forever, their health gradually ticks down
	stompable = TRUE

	mob_size = MOB_SMALL

	response_help   = "curiously touches"
	response_disarm = "frantically tries to clear off"
	response_harm   = "flails wildly at"

	var/list/attack_sounds = list()

	var/list/pain_sounds = list()

/mob/living/simple_animal/necromorph/Initialize()
	.=..()
	SSnecromorph.minor_vessels |= src
	if (get_biomass())
		add_massive_atom(src)
	if (lifespan)
		var/time_per_tick = lifespan / max_health
		addtimer(CALLBACK(src, /mob/living/simple_animal/necromorph/proc/decay), time_per_tick)

//Take 1 point of lasting damage and queue another timer
/mob/living/simple_animal/necromorph/proc/decay()
	if (stat == DEAD)
		return
	adjustLastingDamage(1)


	if (stat == DEAD)
		return

	var/time_per_tick = lifespan / max_health
	addtimer(CALLBACK(src, /mob/living/simple_animal/necromorph/proc/decay), time_per_tick)

/mob/living/simple_animal/necromorph/is_necromorph()
	return TRUE


//Screaming sounds on taking damage
/mob/living/simple_animal/necromorph/adjustBruteLoss(var/damage)
	.=..()
	if (damage > 0 && LAZYLEN(pain_sounds) && check_audio_cooldown(SOUND_PAIN))
		playsound(src, pick(pain_sounds), VOLUME_MID, TRUE)
		set_audio_cooldown(SOUND_PAIN, 3 SECONDS)

//Guaranteed sound on death, ignores cooldowns
/mob/living/simple_animal/necromorph/death()
	if (LAZYLEN(pain_sounds))
		playsound(src, pick(pain_sounds), VOLUME_LOUD, TRUE)
	SSnecromorph.minor_vessels -= src
	remove_massive_atom(src)
	.=..()

//Attack sounds when hitting
/mob/living/simple_animal/necromorph/UnarmedAttack(var/atom/A, var/proximity)
	if (LAZYLEN(attack_sounds) && check_audio_cooldown(SOUND_ATTACK))
		playsound(src, pick(attack_sounds), VOLUME_HIGH, TRUE)
		set_audio_cooldown(SOUND_ATTACK, 3 SECONDS)

	.=..()



/mob/living/simple_animal/necromorph/Destroy()
	SSnecromorph.minor_vessels -= src
	remove_massive_atom(src)
	.=..()









//Parasite Extension: The mob latches onto another mob and periodically bites it for some constant damage
/datum/extension/mount/parasite
	var/damage = 5
	var/damage_chance = 30

	var/base_offset_y = 16

/datum/extension/mount/parasite/on_mount()
	.=..()
	START_PROCESSING(SSprocessing, src)



	var/mob/living/biter = mountee
	spawn(0.5 SECONDS)
		if (!QDELETED(biter) && !QDELETED(src) && mountpoint && mountee)
			//Lets put the parasite somewhere nice looking on the mob
			var/new_rotation = rand(-70, 70)
			var/vector2/attach_offset = biter.get_icon_size()
			attach_offset.SelfMultiply(0.5)
			attach_offset.x -= WORLD_ICON_SIZE * 0.5
			attach_offset.y -= WORLD_ICON_SIZE * 0.5
			attach_offset.SelfMultiply(-1)

			var/vector2/base_offset = get_new_vector(0, base_offset_y)
			base_offset.SelfTurn(new_rotation)

			attach_offset.SelfAdd(base_offset)


			attach_offset.x += rand(-4, 4)
			attach_offset.y += rand(0, 12)

			var/matrix/M = matrix()
			M = M.Scale(0.75)
			M = M.Turn(new_rotation)

			animate(biter, transform = M, pixel_x = attach_offset.x, pixel_y = attach_offset.y, time = 5, flags = ANIMATION_END_NOW)
			release_vector(attach_offset)
			release_vector(base_offset)



/datum/extension/mount/parasite/on_dismount()
	.=..()
	STOP_PROCESSING(SSprocessing, src)
	var/mob/living/biter = mountee
	if (biter)
		biter.animate_to_default()

/datum/extension/mount/parasite/proc/safety_check()
	var/mob/living/biter = mountee
	var/mob/living/victim = mountpoint

	if (!istype(biter) || QDELETED(biter))
		return FALSE

	if (!istype(victim) || QDELETED(victim))
		return FALSE

	//Biter must be able bodied and alive
	if (biter.incapacitated())
		return FALSE

	//Victim must not be dead yet
	if (victim.stat == DEAD)
		return FALSE

	//We must still be on them
	if (get_turf(victim) != get_turf(biter))
		return FALSE

	return TRUE

/datum/extension/mount/parasite/Process()
	if (!safety_check())
		dismount()
		return PROCESS_KILL

	var/mob/living/biter = mountee
	var/mob/living/victim = mountpoint

	//If the biter is being grabbed, it doesnt fall off, but it can't bite either
	if (biter.grabbed_by.len)
		return

	if(prob(damage_chance))


		biter.launch_strike(target = victim, damage = src.damage, used_weapon = biter, damage_flags = DAM_SHARP, armor_penetration = 5, damage_type = BRUTE, armor_type = "melee", target_zone = ran_zone(), difficulty = 100)
		playsound(biter, 'sound/weapons/bite.ogg', VOLUME_LOW, 1)
		biter.heal_overall_damage(damage*0.25)	//The biter heals itself by nomming
		victim.shake_animation(10)
		biter.set_click_cooldown(4 SECONDS) //It can't do normal attacks while attached
		return TRUE

	return FALSE