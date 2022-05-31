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
	/// A list of sounds we can play when our mob is alerted to an enemy.
	var/list/alert_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy1.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy2.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy3.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy4.ogg',
	)
	/// Sounds we will play passively.
	var/passive_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light1.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light2.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light3.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light4.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_light5.ogg',
	)
	/// How likely we are to speak passively.
	var/passive_speak_chance = 1
	/// Lines we will passively speak.
	var/list/passive_speak_lines
	/// How long of a cooldown between alert sounds?
	var/alert_cooldown_time = 5 SECONDS
	COOLDOWN_DECLARE(alert_cooldown)
	/// How likely are we to trigger a malfunction? Set it to 0 to disable malfunctions.
	var/malfunction_prob = MALFUNCTION_CHANCE_LOW
	/// These mobs support a special ability, this is used to determine how often we can use it.
	var/special_ability_cooldown_time = 30 SECONDS
	/// Are we suffering from a malfunction?
	var/suffering_malfunction = FALSE
	COOLDOWN_DECLARE(special_ability_cooldown)


/mob/living/simple_animal/hostile/corrupted_flesh/Initialize(mapload)
	. = ..()
	// We set a unique name when we are created, to give some feeling of randomness.
	name = "[pick(CORRUPTED_FLESH_NAME_MODIFIER_LIST)] [name]"

/**
 * These mobs make noises when aggroed.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/Aggro()
	alert_sound()
	return ..()

/**
 * While this mob lives, it can malfunction.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return
	if(!suffering_malfunction && malfunction_prob && prob(malfunction_prob * delta_time) && stat != DEAD)
		malfunction()
	if(passive_speak_lines && prob(passive_speak_chance * delta_time))
		say_passive_speech()

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

/mob/living/simple_animal/hostile/corrupted_flesh/MoveToTarget(list/possible_targets)
	if(suffering_malfunction)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/proc/say_passive_speech()
	say(pick(passive_speak_lines))
	if(passive_sounds)
		playsound(src, pick(passive_sounds), 70)

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
	suffering_malfunction = TRUE
	addtimer(CALLBACK(src, .proc/malfunction_reset), reset_time)

/**
 * Malfunction Reset
 *
 * Resets the mob after a malfunction has occured.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/proc/malfunction_reset()
	say("System restored.")
	toggle_ai(AI_ON)
	suffering_malfunction = FALSE

/**
 * Alert sound
 *
 * Sends an alert sound if we can.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/proc/alert_sound()
	if(alert_sounds && COOLDOWN_FINISHED(src, alert_cooldown))
		playsound(src, pick(alert_sounds), 100)
		COOLDOWN_START(src, alert_cooldown, alert_cooldown_time)

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
	health = 50
	maxHealth = 50
	wound_bonus = 20
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	armour_penetration = 10
	attack_sound = 'sound/weapons/bladeslice.ogg'
	speed = 0
	speak = list(
		"Submit for mandatory surgery.",
		"Join the flesh through conversion.",
		"My scalpel will make short work of your seams.",
		"Please lay down.",
		"Always trust your doctor!",
		"I knew I'd be a good plastic surgeon!",
	)
	passive_speak_lines = list(
		"A stitch in time saves nine!",
		"Dopamine is happiness!",
		"Seratonin, oxycodone, happy humans all!",
		"Turn that frown upside down!",
		"Happiness through chemistry!",
		"Beauty through surgery!"
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
		"MUST BREAK TARGET INTO COMPONENT COMPOUNDS.",
		"PRIORITY OVER-RIDE. NEW BEHAVIOR DICTATED.",
		"END CONTACT SUB-SEQUENCE.",
		"ENGAGING SELF-ANNIHILATION CIRCUIT.",
	)
	passive_speak_lines = list(
		"WE COME IN PEACE.",
		"WE BRING GREETINGS FROM A FRIENDLY AI.",
		"DO NOT FEAR. WE SHALL NOT HARM YOU.",
		"WE WISH TO LEARN MORE ABOUT YOU. PLEASE TRANSMIT DATA.",
		"THIS PROBE IS NON-HOSTILE. DO NOT ATTACK.",
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
	melee_damage_lower = 1 // Ranged only
	melee_damage_upper = 1
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	health = 75
	maxHealth = 75
	projectiletype = /obj/projectile/bullsquid
	speak = list(
		"Your insides require cleaning.",
		"Prepare to recieve a dose of acid.",
		"Administering cleansing agent.",
		"Ha ha! I'm an artist, I'm finally an artist!",
		"Your flesh is not clean, let me fix that.",
		"Hold still! I think I know just the thing to make you beautiful!",
		"This might hurt a little! Don't worry - it'll be worth it!",
	)

	passive_speak_lines = list(
		"No more leaks, no more pain!",
		"Steel is strong.",
		"All humankind is good for - is to serve the Hivemind.",
		"I'm still working on those bioreactors I promise!",
		"I have finally arisen!",
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
	icon_state = "stunner"
	malfunction_prob = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 1 // Not very harmful, just annoying.
	melee_damage_upper = 2
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
	passive_speak_lines = list(
		"The flesh is the law, abide by the flesh.",
		"Joining the flesh is required by spacelaw.",
		"Hurting eachother is now legal.",
		"The only authority is that of the flesh, join the flesh.",
		"Resistance is futile, you will be converted to the flesh."
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
	attack_verb_continuous = "saws"
	attack_verb_simple = "saw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	alert_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/aggro_01.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/aggro_02.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/aggro_03.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/aggro_04.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/aggro_05.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/aggro_06.ogg',
	)
	passive_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/passive_01.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/passive_02.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/passive_03.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/passive_04.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/hiborg/passive_05.ogg',
	)
	speak = list(
		"You will join the flesh, child!",
		"You will be assimilated, the flesh yearns for your organic matter!",
		"Your brainstem is intact... for now!",
		"You have not felt the pleasure of the flesh, but you will now!",
		"Stop squirming!",
		"Prepare for assimilation!",
	)
	passive_speak_lines = list(
		"Come out, come out, wherever you are.",
		"The humans who surrender have such wonderful dreams.",
		"Death is not the end, only the beginning, the flesh will see to it.",
		"The flesh does not hate, it just wants you to experience the glory of the flesh.",
		"Glory to the flesh.",
	)
	/// The chance of performing a stun attack.
	var/stun_attack_prob = 30
	/// The chance of performing an AOE attack.
	var/aoe_attack_prob = 15
	/// The range on our AOE attaack
	var/aoe_attack_range = 1

/mob/living/simple_animal/hostile/corrupted_flesh/hiborg/AttackingTarget(atom/attacked_target)
	. = ..()
	if(prob(stun_attack_prob))
		if(ishuman(target))
			var/mob/living/carbon/human/attacked_human = target
			attacked_human.Paralyze(10)
			playsound(src, 'sound/weapons/egloves.ogg', 50, TRUE)
	if(prob(aoe_attack_prob))
		visible_message("[src] spins around violently!")
		spin(100, 10)
		for(var/mob/living/iterating_mob in view(aoe_attack_range, src))
			playsound(iterating_mob, 'sound/weapons/whip.ogg', 70, TRUE)
			new /obj/effect/temp_visual/kinetic_blast(get_turf(iterating_mob))

			var/atom/throw_target = get_edge_target_turf(iterating_mob, get_dir(src, get_step_away(iterating_mob, src)))
			iterating_mob.throw_at(throw_target, 20, 2)


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
/mob/living/carbon/human/species/monkey/angry/mauler

/**
 * Himan
 *
 * Special ability: Shriek that stuns, the ability to play dead.
 *
 * Created by converted humans.
 */

/mob/living/simple_animal/hostile/corrupted_flesh/himan
	name = "Human"
	desc = "Once a man, now metal plates and tubes weave in and out of their oozing sores."
	icon_state = "himan"
	icon_dead = "himan"
	maxHealth = 250
	health = 250
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	melee_damage_lower = 25
	melee_damage_upper = 35
	malfunction_prob = MALFUNCTION_CHANCE_HIGH
	speak = list(
		"Don't try and fix me! We love this!",
		"Just make it easy on yourself!",
		"Stop fighting progress!",
		"Join us! Receive these gifts!",
		"Yes! Hit me! It feels fantastic!",
		"Come on coward, take a swing!",
	)
	passive_speak_lines = list(
		"The dreams. The dreams.",
		"Nothing hurts anymore.",
		"Pain feels good now. Its like I've been rewired.",
		"I wanted to cry at first, but I can't.",
		"They took away all misery.",
		"This isn't so bad. This isn't so bad.",
		"My brain feels pleasure from this, the flesh is good.",
		"I don't remember who I am, but that's fine. The flesh provides.",
	)
	alert_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_01.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_02.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_03.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_04.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_05.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_06.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_07.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/aggro_08.ogg',
	)
	passive_sounds = list(
		'modular_skyrat/modules/corrupted_flesh/sound/himan/passive_01.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/passive_02.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/passive_03.ogg',
		'modular_skyrat/modules/corrupted_flesh/sound/himan/passive_04.ogg',
	)
	/// Are we currently faking our death? ready to pounce?
	var/faking_death = FALSE
	/// Fake death cooldown.
	var/fake_death_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(fake_death)
	/// The cooldown between screams.
	var/scream_cooldown = 20 SECONDS
	COOLDOWN_DECLARE(scream_ability)
	var/scream_effect_range = 10

/mob/living/simple_animal/hostile/corrupted_flesh/himan/Life(delta_time, times_fired)
	. = ..()
	if(health < (maxHealth * 0.5) && !faking_death && COOLDOWN_FINISHED(src, fake_death))
		fake_our_death()

	if(faking_death)
		stop_automated_movement = TRUE

/mob/living/simple_animal/hostile/corrupted_flesh/himan/malfunction(reset_time)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/MoveToTarget(list/possible_targets)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/AttackingTarget(atom/attacked_target)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/Aggro()
	if(faking_death)
		if(!Adjacent(target))
			return
		awake()
	if(COOLDOWN_FINISHED(src, scream_ability))
		scream()
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/say_passive_speech()
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/alert_sound()
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/corrupted_flesh/himan/examine(mob/user)
	. = ..()
	if(faking_death)
		. += span_deadsay("Upon closer examination, [p_they()] appear[p_s()] to be dead.")

/mob/living/simple_animal/hostile/corrupted_flesh/himan/proc/scream()
	COOLDOWN_START(src, scream_ability, scream_cooldown)
	playsound(src, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', 100, TRUE)
	manual_emote("screams violently!")
	for(var/mob/living/iterating_mob in get_hearers_in_range(scream_effect_range, src))
		if(!iterating_mob.can_hear())
			continue
		if(faction_check(faction, iterating_mob.faction))
			continue
		iterating_mob.Knockdown(100)
		iterating_mob.apply_status_effect(/datum/status_effect/jitter, 20 SECONDS)
		to_chat(iterating_mob, span_userdanger("A terrible howl tears through your mind, the voice senseless, soulless."))

/mob/living/simple_animal/hostile/corrupted_flesh/himan/proc/fake_our_death()
	manual_emote("stops moving...")
	LoseAggro()
	LoseTarget()
	faking_death = TRUE
	icon_state = "[icon_state]-dead"
	COOLDOWN_START(src, fake_death, fake_death_cooldown)

/mob/living/simple_animal/hostile/corrupted_flesh/himan/proc/awake()
	faking_death = FALSE
	icon_state = initial(icon_state)

/**
 * Treader
 *
 * Special ability: releases healing gas that heals other friendly mobs, ranged
 *
 * Created via assemblers.
 */
/mob/living/simple_animal/hostile/corrupted_flesh/treader
	name = "Treader"
	desc = "A strange tracked robot with an appendage, on the end of which is a human head, it is shrieking in pain."
	icon_state = "treader"
	malfunction_prob = MALFUNCTION_CHANCE_HIGH
	melee_damage_lower = 15
	melee_damage_upper = 15
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	health = 100
	maxHealth = 100
	speed = 2
	ranged_cooldown_time = 4 SECONDS
	attack_sound = 'sound/weapons/bladeslice.ogg'
	projectiletype = /obj/projectile/treader
	light_color = CORRUPTED_FLESH_LIGHT_BLUE
	light_range = 2
	speak = list(
		"You there! Cut off my head, I beg you!",
		"I-..I'm so sorry! I c-..can't control myself anymore!",
		"S-shoot the screen, please! God I hope it wont hurt!"
	)
	speak = list(
		"Hey, at least I got my head.",
		"I cant... I cant feel my arms...",
		"Oh god... my legs... where are my legs!",
		"God it hurts, please help me!",
	)
	special_ability_cooldown = 20 SECONDS

/mob/living/simple_animal/hostile/corrupted_flesh/treader/special_ability()
	manual_emote("vomits out a burst of nanites!")
	do_smoke(3, 4, get_turf(src))
	for(var/mob/living/iterating_mob in view(5, src))
		if(faction_check(iterating_mob.faction, faction))
			iterating_mob.heal_overall_damage(10, 10)

/obj/projectile/treader
	name = "nasty ball of ooze"
	icon_state = "neurotoxin"
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	knockdown = 20
	armor_flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin
	hitsound = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/splat1.ogg'
	hitsound_wall = 'modular_skyrat/modules/black_mesa/sound/mobs/bullsquid/splat1.ogg'

/obj/projectile/treader/on_hit(atom/target, blocked, pierce_hit)
	new /obj/effect/decal/cleanable/greenglow(target.loc)
	return ..()

/**
 * Mechiver
 *
 * Special abilities: Can grab someone and shove them inside, does DOT and flavour text, can convert dead corpses into living ones that work for the flesh.
 *
 *
 */
/mob/living/simple_animal/hostile/corrupted_flesh/mechiver
	name = "Mechiver"
	icon_state = "mechiver"

/**
 * Phaser
 *
 * Special abilities: Phases about next to it's target, can split itself into 4, only one is actually the mob.
 */
