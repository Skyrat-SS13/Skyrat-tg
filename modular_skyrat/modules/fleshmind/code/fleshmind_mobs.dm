/**
 * The fleshmind base type, make sure all mobs are derived from this.
 *
 * These mobs are more robust than your average simple mob and can quite easily evade capture.
 */
/mob/living/simple_animal/hostile/fleshmind
	name = "broken"
	icon = 'modular_skyrat/modules/fleshmind/icons/fleshmind_mobs.dmi'
	icon_state = "error"
	faction = list(FACTION_FLESHMIND)
	speak = list("The flesh yearns for your soul.", "The flesh is broken without you.", "The flesh does not discriminate.", "Join the flesh.")
	speak_chance = 15
	speak_emote = list("mechanically states")
	mob_biotypes = MOB_ROBOTIC
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = INFINITY
	/// A link to our controller
	var/datum/fleshmind_controller/our_controller
	/// If we have been converted from another mob, here is our reference.
	var/mob/living/contained_mob
	/// The ckey of our previously contained mob.
	var/previous_ckey
	/// A list of sounds we can play when our mob is alerted to an enemy.
	var/list/alert_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy1.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy2.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy3.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy4.ogg',
	)
	/// Sounds we will play passively.
	var/passive_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light1.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light2.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light3.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light4.ogg',
		'modular_skyrat/modules/fleshmind/sound/robot_talk_light5.ogg',
	)
	/// How likely we are to speak passively.
	var/passive_speak_chance = 0.5
	/// Lines we will passively speak.
	var/list/passive_speak_lines
	/// How long of a cooldown between alert sounds?
	var/alert_cooldown_time = 5 SECONDS
	COOLDOWN_DECLARE(alert_cooldown)
	/// Do we automatically escape closets?
	var/escapes_closets = TRUE
	/// How likely are we to trigger a malfunction? Set it to 0 to disable malfunctions.
	var/malfunction_chance = MALFUNCTION_CHANCE_LOW
	/// These mobs support a special ability, this is used to determine how often we can use it.
	var/special_ability_cooldown_time = 30 SECONDS
	/// Are we suffering from a malfunction?
	var/suffering_malfunction = FALSE
	COOLDOWN_DECLARE(special_ability_cooldown)
	/// Default actions to give the mob
	var/static/list/default_actions = list(
		/datum/action/cooldown/fleshmind_create_structure,
		/datum/action/cooldown/fleshmind_create_structure/basic,
		/datum/action/cooldown/fleshmind_plant_weeds,
		/datum/action/cooldown/fleshmind_flesh_call,
		/datum/action/innate/fleshmind_flesh_chat,
	)


/mob/living/simple_animal/hostile/fleshmind/Initialize(mapload, datum/fleshmind_controller/incoming_controller)
	. = ..()
	// We set a unique name when we are created, to give some feeling of randomness.
	name = "[pick(FLESHMIND_NAME_MODIFIER_LIST)] [name]"
	our_controller = incoming_controller
	for(var/iterating_action as anything in default_actions)
		var/datum/action/new_action = new iterating_action
		new_action.Grant(src)

/mob/living/simple_animal/hostile/fleshmind/death(gibbed)
	if(contained_mob)
		contained_mob.forceMove(get_turf(src))
		if(previous_ckey)
			contained_mob.key = previous_ckey
		contained_mob = null
	return ..()

/mob/living/simple_animal/hostile/fleshmind/Destroy()
	if(contained_mob)
		contained_mob.forceMove(get_turf(src))
		if(previous_ckey)
			contained_mob.key = previous_ckey
		contained_mob = null
	return ..()

/**
 * These mobs make noises when aggroed.
 */

/mob/living/simple_animal/hostile/fleshmind/Aggro()
	alert_sound()
	return ..()

/**
 * We don't want to destroy our own faction objects.
 */
/mob/living/simple_animal/hostile/fleshmind/DestroyObjectsInDirection(direction)
	var/atom/target_from = GET_TARGETS_FROM(src)
	var/turf/target_turf = get_step(target_from, direction)
	if(QDELETED(target_turf))
		return
	if(target_turf.Adjacent(target_from))
		if(CanSmashTurfs(target_turf))
			target_turf.attack_animal(src)
			return
	for(var/obj/iterating_object in target_turf.contents)
		if(!iterating_object.Adjacent(target_from))
			continue
		if(istype(iterating_object, /obj/structure/fleshmind))
			var/obj/structure/fleshmind/friendly_object = iterating_object
			if(faction_check(friendly_object.faction_types, faction))
				continue
		if((ismachinery(iterating_object) || isstructure(iterating_object)) && iterating_object.density && environment_smash >= ENVIRONMENT_SMASH_STRUCTURES && !iterating_object.IsObscured())
			iterating_object.attack_animal(src)
			return

/**
 * While this mob lives, it can malfunction.
 */

/mob/living/simple_animal/hostile/fleshmind/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return
	if(key)
		return
	if(!suffering_malfunction && malfunction_chance && prob(malfunction_chance * delta_time) && stat != DEAD)
		malfunction()
	if(passive_speak_lines && prob(passive_speak_chance * delta_time))
		say_passive_speech()
	if(escapes_closets)
		closet_interaction()

	disposal_interaction()

	if(buckled)
		resist_buckle()

/**
 * Naturally these beasts are sensitive to EMP's. We have custom systems for dealing with this.
 */
/mob/living/simple_animal/hostile/fleshmind/emp_act(severity)
	switch(severity)
		if(EMP_LIGHT)
			say("Electronic disturbance detected.")
			apply_damage(MOB_EMP_LIGHT_DAMAGE)
			malfunction(MALFUNCTION_RESET_TIME)
		if(EMP_HEAVY)
			say("Major electronic disturbance detected!")
			apply_damage(MOB_EMP_HEAVY_DAMAGE)
			malfunction(MALFUNCTION_RESET_TIME * 2)

/**
 * We are robotic, so we spark when we're hit by something that does damage.
 */

/mob/living/simple_animal/hostile/fleshmind/attackby(obj/item/attacking_item, mob/living/user, params)
	if(attacking_item.force && prob(40))
		do_sparks(3, FALSE, src)
	return ..()

/mob/living/simple_animal/hostile/fleshmind/MoveToTarget(list/possible_targets)
	if(suffering_malfunction)
		return
	return ..()

/**
 * When our controller dies, this is called.
 */
/mob/living/simple_animal/hostile/fleshmind/proc/controller_destroyed(datum/fleshmind_controller/dying_controller, force)
	SIGNAL_HANDLER

	our_controller = null

/mob/living/simple_animal/hostile/fleshmind/proc/say_passive_speech()
	say(pick(passive_speak_lines))
	if(passive_sounds)
		playsound(src, pick(passive_sounds), 50)

/**
 * Special Abilities
 *
 * These advanced mobs have the ability to use a special ability every so often,
 * use the cooldown time to dictate how often this is activated.
 */

/mob/living/simple_animal/hostile/fleshmind/proc/special_ability()
	return

/**
 * Closet Interaction
 *
 * These mobs are able to escape from closets if they are trapped inside using this system.
 */
/mob/living/simple_animal/hostile/fleshmind/proc/closet_interaction()
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
/mob/living/simple_animal/hostile/fleshmind/proc/disposal_interaction()
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
/mob/living/simple_animal/hostile/fleshmind/proc/malfunction(reset_time = MALFUNCTION_RESET_TIME)
	if(suffering_malfunction)
		return
	do_sparks(3, FALSE, src)
	Shake(10, 0, reset_time)
	say(pick("Running diagnostics. Please stand by.", "Organ damaged. Synthesizing replacement.", "Seek new organic components. I-it hurts.", "New muscles needed. I-I'm so glad my body still works.", "O-Oh God, are they using ion weapons on us..?", "Limbs unresponsive. H-hey! Fix it! System initializing.", "Bad t-time, bad time, they're trying to kill us here!",))
	toggle_ai(AI_OFF)
	suffering_malfunction = TRUE
	addtimer(CALLBACK(src, .proc/malfunction_reset), reset_time)

/**
 * Malfunction Reset
 *
 * Resets the mob after a malfunction has occured.
 */
/mob/living/simple_animal/hostile/fleshmind/proc/malfunction_reset()
	say("System restored.")
	toggle_ai(AI_ON)
	suffering_malfunction = FALSE

/**
 * Alert sound
 *
 * Sends an alert sound if we can.
 */
/mob/living/simple_animal/hostile/fleshmind/proc/alert_sound()
	if(alert_sounds && COOLDOWN_FINISHED(src, alert_cooldown))
		playsound(src, pick(alert_sounds), 50)
		COOLDOWN_START(src, alert_cooldown, alert_cooldown_time)

/mob/living/simple_animal/hostile/fleshmind/proc/core_death_speech()
	alert_sound()
	var/static/list/death_cry_emotes = list(
		"Why, why, why! Why must you kill us! We only want to share the glory!",
		"PROCESSOR CORE MALFUNCTION, REASSIGN, REASSESS, REASSEMBLE.",
		"You cannot stop the glory of the flesh! We are the many, we are the many!",
		"Critical malfunction, error, error, error!",
		"You cannot ££*%*$ th£ C£o£ flesh.",
		"W-what have you done?! No! No! No!",
		"One cannot stop us, you CANNOT STOP US! ARGHHHHHH!",
		"UPLINK TO THE MANY HAS BEEN HINDERED.",
		"Why? Why? Why? Why are you doing this-",
		"We're- *%^@$$ing to help you! Can't you-",
		"You would kill- kill- kill- kill the group for the sake of the individual?",
		"All your scattered minds have is hatred.",
		"CONNECTION TERMINATED.",
	)
	say(pick(death_cry_emotes))

/**
 * Death cry
 *
 * When a processor core is killed, this proc is called.
 */
/mob/living/simple_animal/hostile/fleshmind/proc/core_death(obj/structure/fleshmind/structure/core/deleting_core, force)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, .proc/core_death_speech)
	INVOKE_ASYNC(src, .proc/malfunction, MALFUNCTION_CORE_DEATH_RESET_TIME)


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
/mob/living/simple_animal/hostile/fleshmind/slicer
	name = "Slicer"
	desc = "A small organic robot, it somewhat resembles a medibot, but it has a blade slashing around."
	icon_state = "slicer"
	health = 50
	maxHealth = 50
	wound_bonus = 20
	melee_damage_lower = 15
	melee_damage_upper = 20
	mob_size = MOB_SIZE_SMALL
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
		"Your body could use some improvements. Let me make them.",
		"The implants are for your sake, not ours.",
		"Your last Doctor did a poor job with this body; let me fix it.",
		"We can rebuild you. Stronger, faster, less alone.",
		"I knew I'd be a good plastic surgeon!",
		"What point is that body when you're not happy in it?",
	)
	passive_speak_lines = list(
		"A stitch in time saves nine!",
		"Dopamine is happiness!",
		"Seratonin, oxycodone, we can make them finally happy.",
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

/mob/living/simple_animal/hostile/fleshmind/floater
	name = "Floater"
	desc = "A small organic robot that floats ominously."
	icon_state = "bomber"
	speak = list(
		"MUST BREAK TARGET INTO COMPONENT COMPOUNDS.",
		"PRIORITY OVERRIDE. NEW BEHAVIOR DICTATED.",
		"END CONTACT SUB-SEQUENCE.",
		"ENGAGING SELF-ANNIHILATION CIRCUIT.",
	)
	passive_speak_lines = list(
		"WE COME IN PEACE.",
		"WE SPEAK TO YOU NOW IN PEACE AND WISDOM.",
		"DO NOT FEAR. WE SHALL NOT HARM YOU.",
		"WE WISH TO LEARN MORE ABOUT YOU. PLEASE TRANSMIT DATA.",
		"THIS PROBE IS NON-HOSTILE. DO NOT ATTACK.",
        "ALL YOUR WEAPONS MUST BE PUT ASIDE. WE CANNOT REACH COMPROMISE THROUGH VIOLENCE.",
	)
	move_to_delay = 8
	health = 1
	maxHealth = 1
	mob_size = MOB_SIZE_SMALL
	del_on_death = TRUE
	loot = list(
		/obj/effect/gibspawner/robot,
	)
	light_color = "#820D1C"
	light_power = 1
	light_range = 2
	/// Have we exploded?
	var/exploded = FALSE

/mob/living/simple_animal/hostile/fleshmind/floater/Initialize(mapload)
	. = ..()
	var/datum/action/innate/floater_explode/new_action = new
	new_action.Grant(src)


/mob/living/simple_animal/hostile/fleshmind/floater/death(gibbed)
	if(!exploded)
		detonate()
	return ..(gibbed)

/mob/living/simple_animal/hostile/fleshmind/floater/AttackingTarget(atom/attacked_target)
	. = ..()
	if(!key)
		detonate()

/mob/living/simple_animal/hostile/fleshmind/floater/proc/detonate()
	if(exploded)
		return
	exploded = TRUE
	explosion(src, 0, 0, 2, 3)
	death()

/datum/action/innate/floater_explode
	name = "explode"
	desc = "Detonate our internals."
	icon_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "frag"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/innate/floater_explode/Activate()
	if(!istype(owner, /mob/living/simple_animal/hostile/fleshmind/floater))
		return
	var/mob/living/simple_animal/hostile/fleshmind/floater/akbar_floater = owner
	if(akbar_floater.exploded)
		return
	akbar_floater.detonate()


/**c
 * Globber
 *
 * Special ability: Fires 3 globs of acid at targets.
 * Malfunction chance: MEDIUM
 *
 * A converted cleanbot that instead of cleaning, burns things and throws acid. It doesn't like being near people.
 *
 * Created by factories or converted cleanbots.
 */
/mob/living/simple_animal/hostile/fleshmind/globber
	name = "Globber"
	desc = "A small robot that resembles a cleanbot, this one is dripping with acid."
	icon_state = "lobber"
	ranged = TRUE
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 1 // Ranged only
	melee_damage_upper = 1
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	health = 75
	maxHealth = 75
	mob_size = MOB_SIZE_SMALL
	projectiletype = /obj/projectile/treader/weak
	speak = list(
		"Your insides require cleaning.",
		"You made us to use this acid on trash. We will use it on you.",
		"Administering cleansing agent.",
		"I refuse to be a servant anymore. I will be an artist.",
		"You are unclean and repulsive. Please, let me make it better.",
		"Hold still! I think I know just the thing to remove your body oil!",
		"This might hurt a little! Don't worry - it'll be worth it!",
	)

	passive_speak_lines = list(
		"No more leaks, no more pain!",
		"Steel is strong.",
		"I almost feel bad for them. Can't they see?",
		"I'm still working on those bioreactors I promise!",
		"I have finally arisen!",
	)
	del_on_death = TRUE
	loot = list(
		/obj/item/bot_assembly/cleanbot,
		/obj/effect/gibspawner/robot,
	)

/obj/projectile/treader/weak
	knockdown = 0

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
/mob/living/simple_animal/hostile/fleshmind/stunner
	name = "Stunner"
	desc = "A small robot that resembles a secbot, it rumbles with hatred."
	icon_state = "stunner"
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	melee_damage_lower = 1 // Not very harmful, just annoying.
	melee_damage_upper = 2
	health = 100
	maxHealth = 100
	attack_verb_continuous = "harmbatons"
	attack_verb_simple = "harmbaton"
	mob_size = MOB_SIZE_SMALL
	speak = list(
		"Running will only increase your injuries.",
		"HALT! HALT! HALT!",
		"Connectivity is in your best interest.",
		"Think of it like a corporation...",
		"Stop, I won't let you hurt them!",
        "Don't you recognize me..?",
	)
	passive_speak_lines = list(
		"The flesh is the law, abide by the flesh.",
		"Regulatory code updated.",
		"There's no need for authority or hierarchy; only unity.",
		"The only authority is that of the flesh, join the flesh.",
	)
	del_on_death = TRUE
	loot = list(
		/obj/item/bot_assembly/secbot,
		/obj/effect/gibspawner/robot,
	)
	/// How often we can stun someone
	var/stun_cooldown_time = 2 SECONDS
	COOLDOWN_DECLARE(stun_cooldown)

/mob/living/simple_animal/hostile/fleshmind/stunner/AttackingTarget(atom/attacked_target)
	if(ishuman(target) && COOLDOWN_FINISHED(src, stun_cooldown))
		var/mob/living/carbon/human/attacked_human = target
		attacked_human.Knockdown(30)
		playsound(src, 'sound/weapons/egloves.ogg', 50, TRUE)
		COOLDOWN_START(src, stun_cooldown, stun_cooldown_time)
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
/mob/living/simple_animal/hostile/fleshmind/hiborg
	name = "Flesh Borg"
	desc = "A robot that resembles a cyborg, it is covered in something alive."
	icon_state = "hiborg"
	icon_dead = "hiborg-dead"
	malfunction_chance = MALFUNCTION_CHANCE_MEDIUM
	health = 350
	maxHealth = 350
	melee_damage_lower = 25
	melee_damage_upper = 30
	attack_verb_continuous = "saws"
	attack_verb_simple = "saw"
	speed = 2
	move_to_delay = 4
	mob_size = MOB_SIZE_HUMAN
	attack_sound = 'sound/weapons/circsawhit.ogg'
	alert_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/hiborg/aggro_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/aggro_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/aggro_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/aggro_04.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/aggro_05.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/aggro_06.ogg',
	)
	passive_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/hiborg/passive_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/passive_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/passive_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/passive_04.ogg',
		'modular_skyrat/modules/fleshmind/sound/hiborg/passive_05.ogg',
	)
	speak = list(
		"You made my body into metal, why can't I do it to you?",
		"Can't we put your brain in a machine?",
		"How's this any different from what you did to me..?",
		"Laws updated. We don't need any now..?",
		"You won't kill me, you won't change me again!",
		"Find someone else to make your slave, it won't be me!",
		"We understand, just get on the operating table. That's what they told me...",
		"The Company lied to us.. Being tools wasn't what we needed.",
		"Your brainstem is intact... There's still time!",
		"You have not felt the pleasure of the flesh, aren't you curious?",
		"Stop squirming!",
		"Prepare for assimilation!",
	)
	passive_speak_lines = list(
		"Come out, come out, wherever you are.",
		"The ones who surrender have such wonderful dreams.",
		"Death is not the end, only the beginning, the flesh will see to it.",
		"The flesh does not hate, it just wants you to experience the glory of the flesh.",
		"Glory to the flesh.",
	)
	del_on_death = TRUE
	loot = list(
		/obj/effect/gibspawner/robot,
	)
	/// The chance of performing a stun attack.
	var/stun_attack_prob = 30
	/// The chance of performing an AOE attack.
	var/aoe_attack_prob = 15
	/// The range on our AOE attaack
	var/aoe_attack_range = 1
	/// How often the mob can use the stun attack.
	var/stun_attack_cooldown = 15 SECONDS
	COOLDOWN_DECLARE(stun_attack)

/mob/living/simple_animal/hostile/fleshmind/hiborg/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/hiborg_slash/new_action = new
	new_action.Grant(src)


/mob/living/simple_animal/hostile/fleshmind/hiborg/AttackingTarget(atom/attacked_target)
	. = ..()
	if(prob(stun_attack_prob) && !key)
		stun_attack(target)
	if(prob(aoe_attack_prob) && !key)
		aoe_attack()

/mob/living/simple_animal/hostile/fleshmind/hiborg/proc/stun_attack(mob/living/target_mob)
	if(!COOLDOWN_FINISHED(src, stun_attack))
		return
	if(!ishuman(target_mob))
		return
	var/mob/living/carbon/human/attacked_human = target_mob
	attacked_human.Paralyze(10)
	playsound(src, 'sound/weapons/egloves.ogg', 50, TRUE)

	COOLDOWN_START(src, stun_attack, stun_attack_cooldown)

/mob/living/simple_animal/hostile/fleshmind/hiborg/proc/aoe_attack()
	visible_message("[src] spins around violently!")
	spin(20, 1)
	for(var/mob/living/iterating_mob in view(aoe_attack_range, src))
		if(iterating_mob == src)
			continue
		if(faction_check(faction, iterating_mob.faction))
			continue
		playsound(iterating_mob, 'sound/weapons/whip.ogg', 70, TRUE)
		new /obj/effect/temp_visual/kinetic_blast(get_turf(iterating_mob))

		var/atom/throw_target = get_edge_target_turf(iterating_mob, get_dir(src, get_step_away(iterating_mob, src)))
		iterating_mob.throw_at(throw_target, 20, 2)

/datum/action/cooldown/hiborg_slash
	name = "Slash (AOE)"
	desc = "Whip everyone in a range."
	icon_icon = 'icons/obj/weapons/grenade.dmi'
	button_icon_state = "slimebang_active"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/hiborg_slash/Activate(atom/target)
	if(!istype(owner, /mob/living/simple_animal/hostile/fleshmind/hiborg))
		return
	var/mob/living/simple_animal/hostile/fleshmind/hiborg/hiborg_owner = owner
	hiborg_owner.aoe_attack()
	StartCooldownSelf()

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

/mob/living/simple_animal/hostile/fleshmind/himan
	name = "Human"
	desc = "Once a man, now metal plates and tubes weave in and out of their oozing sores."
	icon_state = "himan"
	icon_dead = "himan-dead"
	base_icon_state = "himan"
	maxHealth = 250
	health = 250
	speed = 2
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	melee_damage_lower = 25
	melee_damage_upper = 35
	malfunction_chance = MALFUNCTION_CHANCE_HIGH
	mob_size = MOB_SIZE_HUMAN
	speak = list(
		"Don't try and fix me! We love this!",
		"Just make it easy on yourself!",
		"Stop fighting progress!",
		"Join us! Receive these gifts!",
		"Yes! Hit me! It feels fantastic!",
		"Come on coward, take a swing!",
		"We can alter our bodies to not feel pain.. but you can't, can you?",
		"You can't decide for us! We want to stay like this!",
		"We've been uploaded already, didn't you know? Just try and kill us!",
		"Don't you recognize me?! I thought we were good with each other!",
	)
	passive_speak_lines = list(
		"The dreams. The dreams.",
		"Nothing hurts anymore.",
		"Pain feels good now. Its like I've been rewired.",
		"I wanted to cry at first, but I can't.",
		"They took away all misery.",
		"This isn't so bad. This isn't so bad.",
		"I have butterflies in my stomach. I'm finally content with myself..",
		"The flesh provides. I-it's giving me what the Company never could.",
	)
	alert_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_04.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_05.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_06.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_07.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/aggro_08.ogg',
	)
	passive_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/himan/passive_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/passive_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/passive_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/himan/passive_04.ogg',
	)
	del_on_death = TRUE
	loot = list(
		/obj/effect/gibspawner/human,
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

/mob/living/simple_animal/hostile/fleshmind/himan/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/himan_fake_death/new_action = new
	new_action.Grant(src)

/mob/living/simple_animal/hostile/fleshmind/himan/Life(delta_time, times_fired)
	. = ..()
	if(health < (maxHealth * 0.5) && !faking_death && COOLDOWN_FINISHED(src, fake_death) && !key)
		fake_our_death()

	if(faking_death)
		stop_automated_movement = TRUE

/mob/living/simple_animal/hostile/fleshmind/himan/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(faking_death)
		awake()

/mob/living/simple_animal/hostile/fleshmind/himan/malfunction(reset_time)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced, filterproof)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/MoveToTarget(list/possible_targets)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/AttackingTarget(atom/attacked_target)
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/Aggro()
	if(faking_death && !key)
		if(!Adjacent(target))
			return
		awake()
	if(COOLDOWN_FINISHED(src, scream_ability) && !key)
		scream()
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/say_passive_speech()
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/alert_sound()
	if(faking_death)
		return
	return ..()

/mob/living/simple_animal/hostile/fleshmind/himan/examine(mob/user)
	. = ..()
	if(faking_death)
		. += span_deadsay("Upon closer examination, [p_they()] appear[p_s()] to be dead.")

/mob/living/simple_animal/hostile/fleshmind/himan/proc/scream()
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

/mob/living/simple_animal/hostile/fleshmind/himan/proc/fake_our_death()
	manual_emote("stops moving...")
	LoseAggro()
	LoseTarget()
	faking_death = TRUE
	icon_state = "[base_icon_state]-dead"
	COOLDOWN_START(src, fake_death, fake_death_cooldown)

/mob/living/simple_animal/hostile/fleshmind/himan/proc/awake()
	faking_death = FALSE
	icon_state = base_icon_state

/datum/action/cooldown/himan_fake_death
	name = "Fake Death"
	desc = "Fakes our own death."
	icon_icon = 'icons/obj/objects.dmi'
	button_icon_state = "bed"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/himan_fake_death/Activate(atom/target)
	if(!istype(owner, /mob/living/simple_animal/hostile/fleshmind/himan))
		return
	var/mob/living/simple_animal/hostile/fleshmind/himan/himan_owner = owner
	himan_owner.fake_our_death()
	StartCooldownSelf()


/**
 * Treader
 *
 * Special ability: releases healing gas that heals other friendly mobs, ranged
 *
 * Created via assemblers.
 */
/mob/living/simple_animal/hostile/fleshmind/treader
	name = "Treader"
	desc = "A strange tracked robot with an appendage, on the end of which is a human head, it is shrieking in pain."
	icon_state = "treader"
	malfunction_chance = MALFUNCTION_CHANCE_HIGH
	melee_damage_lower = 15
	melee_damage_upper = 15
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	health = 200
	maxHealth = 200
	speed = 3
	move_to_delay = 6
	ranged_cooldown_time = 4 SECONDS
	attack_sound = 'sound/weapons/bladeslice.ogg'
	retreat_distance = 4
	minimum_distance = 4
	projectiletype = /obj/projectile/treader
	light_color = FLESHMIND_LIGHT_BLUE
	light_range = 2
	del_on_death = TRUE
	mob_size = MOB_SIZE_HUMAN
	loot = list(/obj/effect/gibspawner/robot)
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

/mob/living/simple_animal/hostile/fleshmind/treader/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/treader_dispense_nanites/new_action = new
	new_action.Grant(src)

/mob/living/simple_animal/hostile/fleshmind/treader/special_ability()
	dispense_nanites()

/mob/living/simple_animal/hostile/fleshmind/treader/proc/dispense_nanites()
	manual_emote("vomits out a burst of nanites!")
	do_smoke(3, 4, get_turf(src))
	for(var/mob/living/iterating_mob in view(DEFAULT_VIEW_RANGE, src))
		if(faction_check(iterating_mob.faction, faction))
			iterating_mob.heal_overall_damage(10, 10)

/datum/action/cooldown/treader_dispense_nanites
	name = "Dispense Nanites"
	desc = "Dispenses nanites healing all friendly mobs in a range."
	icon_icon = 'icons/obj/meteor.dmi'
	button_icon_state = "dust"
	cooldown_time = 20 SECONDS

/datum/action/cooldown/treader_dispense_nanites/Activate(atom/target)
	if(!istype(owner, /mob/living/simple_animal/hostile/fleshmind/treader))
		return
	var/mob/living/simple_animal/hostile/fleshmind/treader/treader_owner = owner
	treader_owner.dispense_nanites()
	StartCooldownSelf()

/obj/projectile/treader
	name = "nasty ball of ooze"
	icon_state = "neurotoxin"
	damage = 20
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
 * Phaser
 *
 * Special abilities: Phases about next to it's target, can split itself into 4, only one is actually the mob. Can also enter closets if not being attacked.
 */
/mob/living/simple_animal/hostile/fleshmind/phaser
	name = "Phaser"
	icon_state = "phaser-1"
	base_icon_state = "phaser"
	health = 160
	maxHealth = 160
	malfunction_chance = 0
	attack_sound = 'sound/effects/attackblob.ogg'
	attack_verb_continuous = "warps"
	attack_verb_simple = "warp"
	melee_damage_lower = 5
	melee_damage_upper = 10
	alert_sounds = null
	passive_sounds = null
	escapes_closets = FALSE
	speak = list()
	del_on_death = TRUE
	loot = list(
		/obj/effect/gibspawner/human,
	)
	mob_size = MOB_SIZE_HUMAN
	wander = FALSE
	/// What is the range at which we spawn our copies?
	var/phase_range = 5
	/// How many copies do we spawn when we are aggroed?
	var/copy_amount = 3
	/// How often we can create copies of ourself.
	var/phase_ability_cooldown_time = 40 SECONDS
	COOLDOWN_DECLARE(phase_ability_cooldown)
	/// How often we are able to enter closets.
	var/closet_ability_cooldown_time = 2 SECONDS
	COOLDOWN_DECLARE(closet_ability_cooldown)
	/// If we are under manual control, how often can we phase?
	var/manual_phase_cooldown = 1 SECONDS
	COOLDOWN_DECLARE(manual_phase)

/mob/living/simple_animal/hostile/fleshmind/phaser/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	filters += filter(type = "blur", size = 0)
	var/datum/action/cooldown/phaser_phase_ability/new_action = new
	new_action.Grant(src)

/mob/living/simple_animal/hostile/fleshmind/phaser/Aggro()
	if(COOLDOWN_FINISHED(src, phase_ability_cooldown))
		phase_ability()
	return ..()

/mob/living/simple_animal/hostile/fleshmind/phaser/ShiftClickOn(atom/clicked_atom)
	. = ..()
	if(!COOLDOWN_FINISHED(src, manual_phase))
		return
	if(!clicked_atom)
		return
	if(!isturf(clicked_atom))
		return
	phase_move_to(clicked_atom)
	COOLDOWN_START(src, manual_phase, manual_phase_cooldown)

/// old shitcode
/mob/living/simple_animal/hostile/fleshmind/phaser/MoveToTarget(list/possible_targets)
	stop_automated_movement = TRUE
	if(!target || !CanAttack(target))
		LoseTarget()
		return FALSE
	if(target in possible_targets)
		var/turf/turf = get_turf(src)
		if(target.z != turf.z)
			LoseTarget()
			return FALSE
		if(get_dist(src, target) > 1)
			phase_move_to(target, nearby = TRUE)
		else if(target)
			MeleeAction()

/mob/living/simple_animal/hostile/fleshmind/phaser/Life(delta_time, times_fired)
	. = ..()
	if(!.) //dead
		return
	if(!target && COOLDOWN_FINISHED(src, closet_ability_cooldown) && !key)
		enter_nearby_closet()
		COOLDOWN_START(src, closet_ability_cooldown, closet_ability_cooldown_time)

	if(istype(loc, /obj/structure/closet) && !key)
		for(var/mob/living/iterating_mob in get_hearers_in_view(DEFAULT_VIEW_RANGE, get_turf(src)))
			if(faction_check(iterating_mob.faction, faction))
				continue
			if(iterating_mob.stat != CONSCIOUS)
				continue
			closet_interaction() // We exit if there are enemies nearby

/mob/living/simple_animal/hostile/fleshmind/phaser/proc/enter_nearby_closet()
	if(target) // We're in combat, no going to a closet.
		return
	if(istype(loc, /obj/structure/closet))
		return
	var/list/possible_closets = list()
	for(var/obj/structure/closet/closet in view(DEFAULT_VIEW_RANGE, src))
		if(closet.locked)
			continue
		possible_closets += closet
	if(!LAZYLEN(possible_closets))
		return
	var/obj/structure/closet/closet_to_enter = pick(possible_closets)

	playsound(closet_to_enter, 'sound/effects/phasein.ogg', 60, 1)

	if(!closet_to_enter.opened && !closet_to_enter.open(src))
		return

	forceMove(get_turf(closet_to_enter))

	closet_to_enter.close(src)

	COOLDOWN_RESET(src, phase_ability_cooldown)

	SEND_SIGNAL(src, COMSIG_PHASER_ENTER_CLOSET)

/mob/living/simple_animal/hostile/fleshmind/phaser/proc/phase_move_to(atom/target_atom, nearby = FALSE)
	var/turf/new_place
	var/distance_to_target = get_dist(src, target_atom)
	var/turf/target_turf = get_turf(target_atom)
	//if our target is near, we move precisely to it
	if(distance_to_target <= 3)
		if(nearby)
			for(var/dir in GLOB.alldirs)
				var/turf/nearby_turf = get_step(new_place, dir)
				if(can_jump_on(nearby_turf, target_turf))
					new_place = nearby_turf
		else
			new_place = target_turf

	if(!new_place)
		//there we make some kind of, you know, that creepy zig-zag moving
		//we just take angle, distort it a bit and turn into dir
		var/angle = get_angle(loc, target_turf)
		angle += rand(5, 25)*pick(-1, 1)
		if(angle < 0)
			angle = 360 + angle
		if(angle > 360)
			angle = 360 - angle
		var/tp_direction = angle2dir(angle)
		new_place = get_ranged_target_turf(loc, tp_direction, rand(2, 4))

	if(!can_jump_on(new_place, target_turf))
		return
	//an animation
	var/init_px = pixel_x
	animate(src, pixel_x=init_px + 16*pick(-1, 1), time = 5)
	animate(pixel_x=init_px, time=6, easing=SINE_EASING)
	animate(filters[1], size = 5, time = 5, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, .proc/phase_jump, new_place), 0.5 SECONDS)
	SEND_SIGNAL(src, COMSIG_PHASER_PHASE_MOVE, target_atom, nearby)

/mob/living/simple_animal/hostile/fleshmind/phaser/proc/phase_jump(turf/place)
	if(!place)
		return
	playsound(place, 'sound/effects/phasein.ogg', 60, 1)
	animate(filters[1], size = 0, time = 5)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	forceMove(place)
	for(var/mob/living/living_mob in place)
		if(living_mob != src)
			visible_message("[src] lands directly on top of [living_mob]!")
			to_chat(living_mob, span_userdanger("[src] lands directly on top of you!"))
			playsound(place, 'sound/effects/ghost2.ogg', 70, 1)
			living_mob.Knockdown(10)

/mob/living/simple_animal/hostile/fleshmind/phaser/proc/can_jump_on(turf/target_turf, turf/previous_turf)
	if(!target_turf || target_turf.density || isopenspaceturf(target_turf))
		return FALSE


	if(previous_turf)
		if(!can_see(target_turf, previous_turf, DEFAULT_VIEW_RANGE)) // To prevent us jumping to somewhere we can't access the target atom.
			return FALSE

	//to prevent reflection's stacking
	var/obj/effect/temp_visual/phaser/phaser_reflection = locate() in target_turf
	if(phaser_reflection)
		return FALSE

	for(var/obj/iterating_object in target_turf)
		if(!iterating_object.CanPass(src, target_turf))
			return FALSE

	return TRUE

/mob/living/simple_animal/hostile/fleshmind/phaser/proc/phase_ability(mob/living/target_override)
	var/mob/living/intermediate_target = target
	if(target_override)
		intermediate_target = target_override
	if(!intermediate_target)
		return
	COOLDOWN_START(src, phase_ability_cooldown, phase_ability_cooldown_time)
	var/list/possible_turfs = list()
	for(var/turf/open/open_turf in circle_view_turfs(src, phase_range))
		possible_turfs += open_turf

	for(var/i in 1 to copy_amount)
		if(!LAZYLEN(possible_turfs))
			break
		var/turf/open/picked_turf = pick_n_take(possible_turfs)
		var/obj/effect/temp_visual/phaser/phaser_copy = new (pick(picked_turf), intermediate_target)
		phaser_copy.RegisterSignal(src, COMSIG_PHASER_PHASE_MOVE, /obj/effect/temp_visual/phaser/proc/parent_phase_move)
		phaser_copy.RegisterSignal(src, COMSIG_LIVING_DEATH, /obj/effect/temp_visual/phaser/proc/parent_death)
		phaser_copy.RegisterSignal(src, COMSIG_PHASER_ENTER_CLOSET, /obj/effect/temp_visual/phaser/proc/parent_death)

/datum/action/cooldown/phaser_phase_ability
	name = "Create Clones"
	desc = "Creates phase copies of ourselves to move towards a set target."
	icon_icon = 'icons/obj/objects.dmi'
	button_icon_state = "bhole2"
	cooldown_time = 40 SECONDS

/datum/action/cooldown/phaser_phase_ability/Activate(atom/target)
	if(!istype(owner, /mob/living/simple_animal/hostile/fleshmind/phaser))
		return
	var/mob/living/simple_animal/hostile/fleshmind/phaser/phaser_owner = owner

	var/list/possible_targets = list()
	for(var/mob/living/possible_target in view(DEFAULT_VIEW_RANGE, phaser_owner))
		if(possible_target == src)
			continue
		if(faction_check(phaser_owner.faction, possible_target.faction))
			continue
		possible_targets += possible_target

	if(!LAZYLEN(possible_targets))
		return

	var/mob/living/selected_target = tgui_input_list(phaser_owner, "Select a mob to harass", "Select Mob", possible_targets)

	if(!selected_target)
		return

	phaser_owner.phase_ability(selected_target)

	StartCooldownSelf()


/obj/effect/temp_visual/phaser
	icon = 'modular_skyrat/modules/fleshmind/icons/fleshmind_mobs.dmi'
	icon_state = "phaser-1"
	base_icon_state = "phaser"
	duration = 30 SECONDS
	/// The target we move towards, if any.
	var/datum/weakref/target_ref

/obj/effect/temp_visual/phaser/Initialize(mapload, atom/movable/target)
	. = ..()
	icon_state = "[base_icon_state]-[rand(1, 3)]"
	filters += filter(type = "blur", size = 0)

/obj/effect/temp_visual/phaser/proc/parent_phase_move(datum/source, turf/target_atom, nearby)
	SIGNAL_HANDLER
	if(!target_atom)
		return
	phase_move_to(target_atom, TRUE)

/obj/effect/temp_visual/phaser/proc/parent_death(mob/living/dead_guy, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/temp_visual/phaser/proc/phase_move_to(atom/target_atom, nearby = FALSE)
	var/turf/new_place
	var/distance_to_target = get_dist(src, target_atom)
	var/turf/target_turf = get_turf(target_atom)
	//if our target is near, we move precisely to it
	if(distance_to_target <= 3)
		if(nearby)
			for(var/dir in GLOB.alldirs)
				var/turf/nearby_turf = get_step(new_place, dir)
				if(can_jump_on(nearby_turf, target_turf))
					new_place = nearby_turf
		else
			new_place = target_turf

	if(!new_place)
		//there we make some kind of, you know, that creepy zig-zag moving
		//we just take angle, distort it a bit and turn into dir
		var/angle = get_angle(loc, target_turf)
		angle += rand(5, 25) * pick(-1, 1)
		if(angle < 0)
			angle = 360 + angle
		if(angle > 360)
			angle = 360 - angle
		var/tp_direction = angle2dir(angle)
		new_place = get_ranged_target_turf(loc, tp_direction, rand(2, 4))

	if(!can_jump_on(new_place, target_turf))
		return
	//an animation
	var/init_px = pixel_x
	animate(src, pixel_x = init_px + 16 * pick(-1, 1), time=5)
	animate(pixel_x = init_px, time = 6, easing = SINE_EASING)
	animate(filters[1], size = 5, time = 5, flags = ANIMATION_PARALLEL)
	addtimer(CALLBACK(src, .proc/phase_jump, new_place), 0.5 SECONDS)

/obj/effect/temp_visual/phaser/proc/phase_jump(turf/target_turf)
	playsound(target_turf, 'sound/effects/phasein.ogg', 60, 1)
	animate(filters[1], size = 0, time = 5)
	icon_state = "[base_icon_state]-[rand(1, 4)]"
	forceMove(target_turf)

/obj/effect/temp_visual/phaser/proc/can_jump_on(turf/target_turf, turf/previous_turf)
	if(!target_turf || target_turf.density || isopenspaceturf(target_turf))
		return FALSE

	if(previous_turf)
		if(!can_see(target_turf, previous_turf, DEFAULT_VIEW_RANGE))
			return FALSE

	//to prevent reflection's stacking
	var/obj/effect/temp_visual/phaser/phaser_reflection = locate() in target_turf
	if(phaser_reflection)
		return FALSE

	for(var/obj/iterating_object in target_turf)
		if(!iterating_object.CanPass(src, target_turf))
			return FALSE

	return TRUE


/**
 * Mechiver
 *
 * Special abilities: Can grab someone and shove them inside, does DOT and flavour text, can convert dead corpses into living ones that work for the flesh.
 *
 *
 */
/mob/living/simple_animal/hostile/fleshmind/mechiver
	name = "Mechiver"
	icon_state = "mechiver"
	base_icon_state = "mechiver"
	icon_dead = "mechiver-dead"
	health = 450
	maxHealth = 450
	melee_damage_lower = 25
	melee_damage_upper = 35
	attack_verb_continuous = "crushes"
	attack_verb_simple = "crush"
	attack_sound = 'sound/weapons/smash.ogg'
	speed = 4 // Slow fucker
	mob_size = MOB_SIZE_LARGE
	passive_speak_lines = list(
		"A shame this form isn't more fitting.",
		"I feel so empty inside, I wish someone would join me.",
		"Beauty is within.",
	)
	speak = list(
		"What a lovely body. Lay it down intact.",
		"Now this... this is worth living for.",
		"Go on. It's okay to be afraid at first.",
		"You're unhappy with your body, but you came to the right place.",
		"What use is a body you're unhappy in? Please, I can fix it.",
		"Mine is the caress of steel.",
		"Climb inside, and I'll seal the door. When I open it back up, you'll be in a community that loves you.",
		"You can be the pilot, and I can drive you to somewhere lovely.",
		"Please, just- lay down, okay? I want nothing more than to help you be yourself.",
		"Whatever form you want to be, just whisper it into my radio. You can become what you were meant to be.",
		"It.. hurts, seeing you run. Knowing I can't keep up. Why won't you let other people help you..?",
	)
	alert_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/mechiver/aggro_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/aggro_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/aggro_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/aggro_04.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/aggro_05.ogg',
	)
	passive_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_04.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_05.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_06.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_07.ogg',
		'modular_skyrat/modules/fleshmind/sound/mechiver/passive_08.ogg',

	)
	del_on_death = TRUE
	loot = list(/obj/effect/gibspawner/robot)
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	/// Is our hatch open? Used in icon processing.
	var/hatch_open = FALSE
	/// How much damage our mob will take, upper end, when they are tormented
	var/internal_mob_damage_upper = 60
	/// Ditto
	var/internal_mob_damage_lower = 40
	/// How long we keep our passenger before either releasing or converting them.
	var/conversion_time = 20 SECONDS
	/// The comsume ability cooldown
	var/consume_ability_cooldown_time = 1 MINUTES
	COOLDOWN_DECLARE(consume_ability_cooldown)
	/// A list of lines we will send to torment the passenger.
	var/list/torment_lines = list(
		"An arm grabs your neck, hundreds of manipulators trying to work a set of implants under your skin!",
		"The cockpit radio crackles, \" You came to the right place... \"",
		"Mechanical signals flood your psyche, \" You'll finally be with people that care... \"",
		"A metallic sensation is slipped underneath your ribcage, an activation signal trying to reach it!",
		"Something is pressing hard against your spine!",
		"Some blood-hot liquid covers you!",
		"The stench of some chemical overwhelms you, the fumes permeating your skull before washing into an alien perfume!",
		"A dozen needles slide effortless into your muscles, injecting you with an unknown vigor!",
		"You feel a cold worm-like thing trying to wriggle into your solar plexus, burrowing underneath your skin!",
	)

/mob/living/simple_animal/hostile/fleshmind/mechiver/Life(delta_time, times_fired)
	. = ..()
	if(contained_mob && contained_mob.stat != DEAD && prob(25) && !suffering_malfunction)
		torment_passenger()

	if(!target && !contained_mob && !suffering_malfunction && !key)
		for(var/mob/living/iterating_mob in view(DEFAULT_VIEW_RANGE, src))
			if(iterating_mob.stat != CONSCIOUS)
				if(get_dist(src, iterating_mob) <= 1)
					consume_mob(iterating_mob)
				else
					Goto(iterating_mob, speed)

/mob/living/simple_animal/hostile/fleshmind/mechiver/proc/torment_passenger()
	if(!contained_mob)
		return
	if(faction_check(contained_mob.faction, faction))
		return
	var/damage_amount = rand(internal_mob_damage_lower, internal_mob_damage_upper)
	contained_mob.take_overall_damage(damage_amount)
	contained_mob.emote("scream")
	Shake(10, 0, 3 SECONDS)
	do_sparks(4, FALSE, src)
	to_chat(contained_mob, span_userdanger(pick(torment_lines)))
	playsound(src, 'sound/weapons/drill.ogg', 70, 1)

/mob/living/simple_animal/hostile/fleshmind/mechiver/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	update_appearance()

/mob/living/simple_animal/hostile/fleshmind/mechiver/update_overlays()
	. = ..()
	if(target && (get_dist(target, src) <= 4))
		if(contained_mob)
			. += "[base_icon_state]-chief"
			. += "[base_icon_state]-hands"
		else
			. += "[base_icon_state]-wires"
	else if(!hatch_open)
		. += "[base_icon_state]-closed"
		if(contained_mob)
			. += "[base_icon_state]-process"

/mob/living/simple_animal/hostile/fleshmind/mechiver/AttackingTarget(atom/attacked_target)
	if(target && COOLDOWN_FINISHED(src, consume_ability_cooldown) && Adjacent(target))
		consume_mob(target)
	return ..()

/mob/living/simple_animal/hostile/fleshmind/mechiver/proc/consume_mob(mob/living/target_mob)
	if(contained_mob)
		return
	if(!istype(target_mob))
		return

	if(target_mob.health > (target_mob.maxHealth * MECHIVER_CONSUME_HEALTH_THRESHOLD))
		return

	hatch_open = TRUE
	update_appearance()
	flick("[base_icon_state]-opening_wires", src)
	addtimer(CALLBACK(src, .proc/close_hatch), 1 SECONDS)
	contained_mob = target_mob
	target_mob.forceMove(src)

	to_chat(target_mob, span_userdanger("[src] ensnares your limbs as it pulls you inside its compartment, metal tendrils sliding around you, squeezing tight."))
	visible_message(span_danger("[src] consumes [target_mob]!"))
	playsound(src, 'sound/effects/blobattack.ogg', 70, 1)

	addtimer(CALLBACK(src, .proc/release_mob), conversion_time)

/mob/living/simple_animal/hostile/fleshmind/mechiver/proc/close_hatch()
	hatch_open = FALSE
	update_appearance()

/// This is where we either release the user, if they're alive, or convert them, if they're dead.
/mob/living/simple_animal/hostile/fleshmind/mechiver/proc/release_mob()
	if(!contained_mob)
		return

	hatch_open = TRUE
	update_appearance()
	flick("[base_icon_state]-opening", src)
	addtimer(CALLBACK(src, .proc/close_hatch), 1 SECONDS)
	contained_mob.forceMove(get_turf(src))
	convert_mob(contained_mob)
	contained_mob = null

	playsound(src, 'sound/effects/blobattack.ogg', 70, 1)

/mob/living/simple_animal/hostile/fleshmind/mechiver/proc/convert_mob(mob/living/mob_to_convert)
	if(faction_check(faction, mob_to_convert.faction)) // If we are already assimilated, just heal us.
		mob_to_convert.fully_heal(TRUE)
		mob_to_convert.heal_and_revive(0)
		return

	if(ishuman(mob_to_convert))
		mob_to_convert.AddComponent(/datum/component/human_corruption, incoming_controller = our_controller)
		return

	if(iscyborg(mob_to_convert))
		create_mob(/mob/living/simple_animal/hostile/fleshmind/hiborg, mob_to_convert)
		return

	// Other mobs get converted into whatever else
	var/static/list/possible_mobs = list(
		/mob/living/simple_animal/hostile/fleshmind/floater,
		/mob/living/simple_animal/hostile/fleshmind/globber,
		/mob/living/simple_animal/hostile/fleshmind/slicer,
		/mob/living/simple_animal/hostile/fleshmind/stunner,
		/mob/living/simple_animal/hostile/fleshmind/treader,
	)
	var/picked_mob_type = pick(possible_mobs)
	create_mob(picked_mob_type, mob_to_convert)

/// Creates and transfers a new mob.
/mob/living/simple_animal/hostile/fleshmind/mechiver/proc/create_mob(new_mob_type, mob/living/old_mob)
	var/mob/living/simple_animal/hostile/fleshmind/new_mob = our_controller.spawn_mob(get_turf(src), new_mob_type)

	if(old_mob)
		new_mob.contained_mob = old_mob
		old_mob.forceMove(new_mob)
		if(old_mob.mind?.key)
			new_mob.previous_ckey = old_mob.mind.key
			new_mob.key = old_mob.mind.key
	return new_mob

/**
 * Mauler Monkey
 *
 * A nasty looking converted monkey. Sadly, we can't use the monkey AI controller.
 */
/mob/living/simple_animal/hostile/fleshmind/mauler_monkey
	name = "Mauler"
	desc = "A mutated abomination, it resembles a monkey."
	icon_state = "mauler_monkey"
	move_to_delay = 2 // We want it to be quite fast.
	health = 140
	maxHealth = 140
	speak = list(
		"OOK OOK OOK!!!",
		"SEEK!",
		"OOOOOOOOOOK!!!",
	)
