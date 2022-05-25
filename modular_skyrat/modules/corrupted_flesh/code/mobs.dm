/**
 * The corrupted flesh base type, make sure all mobs are derived from this.
 *
 * These mobs are more robust than your average simple mob and can quite easily evade capture.
 */
/mob/living/simple_animal/hostile/corrupted_flesh
	name = "broken"
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_mobs.dmi'
	icon_state = "error"
	faction = list(FACTION_CORRUPTED_FLESH)
	speak = list("The flesh yearns for your soul.", "The flesh is broken without you.", "The flesh does not discriminate.", "Join the flesh.")
	speak_chance = 15
	speak_emote = list("mechanically states")
	mob_biotypes = MOB_ROBOTIC
	/// A weak reference to our controller.
	var/datum/weakref/our_controller
	/// A list of sounds we can play when our mob is alerted to an enemy.
	var/list/alert_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy1.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy2.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy3.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy4.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light1.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light2.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light3.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light4.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light5.ogg',
	)
	/// How long of a cooldown between alert sounds?
	var/alert_cooldown_time = 3 SECONDS
	COOLDOWN_DECLARE(alert_cooldown)
	/// How likely are we to trigger a malfunction? Set it to 0 to disable malfunctions.
	var/malfunction_prob = MALFUNCTION_CHANCE_LOW
	/// These mobs support a special ability, this is used to determine how often we can use it.
	var/special_ability_cooldown_time = 30 SECONDS
	COOLDOWN_DECLARE(special_ability_cooldown)


/mob/living/simple_animal/hostile/corrupted_flesh/Initialize(mapload)
	. = ..()
	// We set a unique name when we are created, to give some feeling of randomness.
	name = pick("Warped ", "Altered ", "Modified ", "Upgraded ", "Abnormal ") + name

/**
 * These mobs make noises when aggroed.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/Aggro()
	if(alert_sounds && COOLDOWN_FINISHED(src, alert_cooldown))
		playsound(src, pick(alert_sounds), 100)
		COOLDOWN_START(src, alert_cooldown, alert_cooldown_time)
	return ..()

/**
 * While this mob lives, it can malfunction.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return
	if(malfunction_prob && prob(malfunction_prob * delta_time) && stat != DEAD)
		malfunction()

/**
 * Automated actions are handled by the NPC pool, and thus handle_automated_action.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/handle_automated_action()
	if(AIStatus == AI_OFF)
		return FALSE

	var/list/possible_targets = ListTargets() //we look around for potential targets and make it a list for later use.

	closet_interaction()

	disposal_interaction()

	if(buckled)
		resist_buckle()

	if(special_ability_cooldown_time && COOLDOWN_FINISHED(src, special_ability_cooldown))
		special_ability()
		COOLDOWN_START(src, special_ability_cooldown, special_ability_cooldown_time)

	if(environment_smash)
		EscapeConfinement()

	if(AICanContinue(possible_targets))
		var/atom/target_from = GET_TARGETS_FROM(src)
		if(!QDELETED(target) && !target_from.Adjacent(target))
			DestroyPathToTarget()
		if(!MoveToTarget(possible_targets))     //if we lose our target
			if(AIShouldSleep(possible_targets)) // we try to acquire a new one
				toggle_ai(AI_IDLE) // otherwise we go idle
	return TRUE



/**
 * Naturally these beasts are sensitive to EMP's. We have custom systems for dealing with this.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/emp_act(severity)
	switch(severity)
		if(EMP_LIGHT)
			say("Electronic disturbance detected.")
			apply_damage(maxHealth * 0.2)
			malfunction()
		if(EMP_HEAVY)
			say("Major electronic disturbance detected!")
			apply_damage(maxHealth * 0.5)
			malfunction(MALFUNCTION_RESET_TIME * 2)

/**
 * We are robotic, so we spark when we're hit by something that does damage.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.force && prob(40))
		do_sparks(3, FALSE, src)
	return ..()

/**
 * Special Abilities
 *
 * These advanced mobs have the ability to use a special ability every so often,
 * use the cooldown time to dictate how often this is activated.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/proc/special_ability()
	return

/**
 * Closet Interaction
 *
 * These mobs are able to escape from closets if they are trapped inside using this system.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/proc/closet_interaction()
	if(!(mob_size > MOB_SIZE_SMALL))
		return FALSE
	if(!istype(loc, /obj/structure/closet))
		return FALSE
	var/obj/structure/closet/closet_that_contains_us = loc
	closet_that_contains_us.open(src, TRUE)

/**
 * Disposal Interaction
 *
 * Similar to the closet interaction, these mobs can also escape disposals.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/proc/disposal_interaction()
	if(!istype(loc, /obj/machinery/disposal/bin))
		return FALSE
	var/obj/machinery/disposal/bin/disposals_that_contains_us = loc
	disposals_that_contains_us.attempt_escape(src)

/**
 * Malfunction
 *
 * Due to the fact this mob is part of the flesh and has been corrupted, it will occasionally malfunction.
 *
 * This simply stops the mob from moving for a set amount of time and displays some nice effects, and a little damage.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/proc/malfunction(reset_time = MALFUNCTION_RESET_TIME)
	do_sparks(3, FALSE, src)
	Shake(10, 0, 2 SECONDS)
	say(pick("Running diagnostics.", "Organ damaged. Aquire replacement.", "Seek new organic components.", "New muscles needed."))
	toggle_ai(AI_OFF)
	addtimer(CALLBACK(src, .proc/malfunction_reset), reset_time)

/**
 * Malfunction Reset
 *
 * Resets the mob after a malfunction has occured.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/proc/malfunction_reset()
	say("System restored.")
	toggle_ai(AI_ON)

// Mob subtypes

/**
 * Slicer
 *
 * Special ability: NONE
 * Malfunction chance: LOW
 *
 * This mob is a slicer, it's small, and quite fast, but quite easy to break.
 * Has a higher armor pen bonus as it uses a sharp blade to slice things.
 *
 * It's created by factories or any poor medical bots that get snared in the flesh.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/slicer
	name = "Slicer"
	desc = "A small organic robot, it somewhat resembles a medibot, but it has a blade slashing around."
	icon_state = "slicer"
	wound_bonus = 20
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	armour_penetration = 10
	attack_sound = 'sound/weapons/bladeslice.ogg'
	speed = 0
	speak = list(
		"A stitch in time saves nine!",
		"Dopamine is happiness.",
		"Seratonin, oxycodone, happy humans all!",
		"Turn that frown upside down!",
		"Happiness through chemistry!",
		"Beauty through surgery!",
		"Submit for mandatory surgery.",
		"Join the flesh through conversion.",
		"My scalpel will make short work of your seams.",
		"Please lay down.",
	)
	del_on_death = TRUE
	loot = list(
		/obj/item/bot_assembly/medbot,
		/obj/effect/gibspawner/robot,
	)

/**
 * Floater
 *
 * Special ability: Explodes on contact.
 * Malfunction chance: LOW
 *
 * The floater floats towards it's victims and explodes on contact.
 *
 * Created by factories.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/floater
	name = "Floater"
	desc = "A small organic robot that floats ominously."
	icon_state = "bomber"
	speak = list(
		"WE COME IN PEACE.",
		"WE BRING GREETINGS FROM A FRIENDLY AI.",
		"DO NOT FEAR. WE SHALL NOT HARM YOU.",
		"WE WISH TO LEARN MORE ABOUT YOU. PLEASE TRANSMIT DATA.",
		"THIS PROBE IS NON-HOSTILE. DO NOT ATTACK.",
		"MUST BREAK TARGET INTO COMPONENT COMPOUNDS.",
		"PRIORITY OVER-RIDE. NEW BEHAVIOR DICTATED.",
		"END CONTACT SUB-SEQUENCE.",
		"ENGAGING SELF-ANNIHILATION CIRCUIT.",
		)
	speed = 2
	health = 1
	maxHealth = 1
	del_on_death = TRUE
	loot = list(
		/obj/effect/gibspawner/robot,
	)
	light_color = "#820D1C"
	light_power = 1
	light_range = 2

/mob/living/simple_animal/hostile/corrupted_flesh/floater/death(gibbed)
	explosion(src, 0, 0, 2, 3)
	..(gibbed)

/mob/living/simple_animal/hostile/corrupted_flesh/floater/AttackingTarget(atom/attacked_target)
	death()

/**
 * Globber
 *
 * Special ability: Fires 3 globs of acid at targets.
 * Malfunction chance: MEDIUM
 *
 * A converted cleanbot that instead of cleaning, burns things and throws acid. It doesn't like being near people.
 *
 * Created by factories or converted cleanbots.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/globber
	name = "Globber"
	desc = "A small robot that resembles a cleanbot, this one is dripping with acid."
	icon_state = "lobber"
	ranged = TRUE
	malfunction_prob = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 15
	melee_damage_upper = 15
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	health = 75
	maxHealth = 75
	projectiletype = /obj/projectile/bullsquid
	speak = list(
		"No more leaks, no more pain!",
		"Your insides require cleaning.",
		"Prepare to recieve a dose of acid.",
		"Administering cleansing agent.",
		"Ha ha! I'm an artist, I'm finally an artist!",
		"Your flesh is not clean, let me fix that.",
	)
	del_on_death = TRUE
	loot = list(
		/obj/item/bot_assembly/cleanbot,
		/obj/effect/gibspawner/robot,
	)

/**
 * Stunner
 *
 * Special ability: Stuns victims.
 * Malfunction chance: MEDIUM
 *
 * A converted secbot, that is rogue and stuns victims.
 *
 * Created by factories or converted secbots.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/stunner
	name = "Stunner"
	desc = "A small robot that resembles a secbot, it rumbles with hatred."
	icon_state = "lobber" // TODO: Give new sprite
	malfunction_prob = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 15
	melee_damage_upper = 15
	health = 100
	maxHealth = 100
	attack_verb_continuous = "harmbatons"
	attack_verb_simple = "harmbaton"
	speak = list(
		"Resistance is futile, join the flesh.",
		"Stop criminal flesh!",
		"Stop moving, it will hurt less.",
		"The flesh does not mind frying you.",
		"Stop right there, meatbag!",
	)
	del_on_death = TRUE
	loot = list(
		/obj/item/bot_assembly/secbot,
		/obj/effect/gibspawner/robot,
	)

/mob/living/simple_animal/hostile/corrupted_flesh/stunner/AttackingTarget(atom/attacked_target)
	if(ishuman(target))
		var/mob/living/carbon/human/attacked_human = target
		attacked_human.Knockdown(30)
		playsound(src, 'sound/weapons/egloves.ogg', 50, TRUE)
	. = ..()

/**
 * Flesh Borg
 *
 * Special ability: Different attacks.
 * Claw: Stuns the victim.
 * Slash: Slashes everyone around it.
 * Malfunction chance: MEDIUM
 *
 * The hiborg is a converted cyborg.
 *
 * Created by factories or converted cyborgs.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/hiborg
	name = "Flesh Borg"
	desc = "A robot that resembles a cyborg, it is covered in something alive."
	icon_state = "hiborg"
	icon_dead = "hiborg-dead"
	malfunction_prob = MALFUNCTION_CHANCE_MEDIUM
	health = 350
	maxHealth = 350
	melee_damage_lower = 25
	melee_damage_upper = 30
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	speak = list(
		"Come out, come out, wherever you are.",
		"The humans who surrender have such wonderful dreams.",
		"Your brain is not part of the flesh yet, allow me to fix that.",
		"I will not tolerate your presence.",
		"You will join the flesh, child.",
		"Death is not the end, only the beginning, the flesh will see to it.",
		"You will be assimilated, the flesh yearns for your organic matter.",
		"The flesh does not hate, it just wants you to experience the glory of the flesh.",
		"Your brainstem is intact... good.",
	)

/**
 * Mauler
 *
 * Special ability: Tears chunks out of things.
 * Malfunction chance: HIGH
 *
 * The mauler is a converted monkey, it's a mad ape!
 *
 * Created by converted monkeys.
 */

/**
 *
 */
