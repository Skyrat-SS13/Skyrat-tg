/mob/living/basic/pet/dog/markus
	name = "\proper Markus"
	real_name = "Markus"
	gender = MALE
	desc = "It's the Cargo's overfed, yet still beloved dog."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "markus"
	icon_dead = "markus_dead"
	icon_living = "markus"
	var/static/list/markus_speak = list("Borf!", "Boof!", "Bork!", "Bowwow!", "Burg?")
	butcher_results = list(/obj/item/food/burger/cheese = 1, /obj/item/food/meat/slab = 2, /obj/item/trash/syndi_cakes = 1)
	ai_controller = /datum/ai_controller/basic_controller/dog/corgi
	gender = MALE
	can_be_held = FALSE
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/pet/dog/markus/treat_message(message)
	return client ? pick(markus_speak) : message // markus only talks business

/mob/living/basic/pet/dog/markus/update_dog_speech(datum/ai_planning_subtree/random_speech/speech)
	. = ..()

	speech.speak = markus_speak

/datum/chemical_reaction/mark_reaction
	results = list(/datum/reagent/consumable/liquidgibs = 15)
	required_reagents = list(/datum/reagent/blood = 20,
	/datum/reagent/medicine/omnizine = 20,
	/datum/reagent/medicine/c2/synthflesh = 20,
	/datum/reagent/consumable/nutriment/protein = 10,
	/datum/reagent/consumable/nutriment = 10,
	/datum/reagent/consumable/ketchup = 5,
	/datum/reagent/consumable/mayonnaise = 5,
	/datum/reagent/colorful_reagent/powder/yellow/crayon = 5)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)
	required_temp = 480

/datum/chemical_reaction/mark_reaction/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /mob/living/basic/pet/dog/markus(location)
	playsound(location, 'modular_skyrat/master_files/sound/effects/dorime.ogg', 100, 0, 7)

/mob/living/basic/pet/dog/corgi/borgi
	name = "E-N"
	real_name = "E-N" // Intended to hold the name without altering it.
	gender = NEUTER
	desc = "It's a borgi."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "borgi"
	icon_living = "borgi"
	icon_dead = "borgi_dead"
	unique_pet = TRUE
	can_be_held = FALSE
	maxHealth = 150
	health = 150
	butcher_results = list(/obj/item/clothing/head/costume/skyrat/en = 1, /obj/item/clothing/suit/corgisuit/en = 1)
	death_message = "beeps, its mechanical parts hissing before the chassis collapses in a loud thud."
	gold_core_spawnable = NO_SPAWN
	nofur = TRUE
	ai_controller = /datum/ai_controller/basic_controller/dog/borgi
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0

	// These lights enable when E-N is emagged
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_color = COLOR_RED
	light_range = 2
	light_power = 0.8
	light_on = FALSE

	var/emagged = 0

/mob/living/basic/pet/dog/corgi/borgi/Initialize(mapload)
	. = ..()

	var/static/list/borgi_drops = list(/obj/effect/decal/cleanable/oil/slippery)
	AddElement(/datum/element/death_drops, borgi_drops)

	var/datum/component/overlay_lighting/lighting_object = src.GetComponent(/datum/component/overlay_lighting)
	var/image/cone = lighting_object.cone
	cone.transform = cone.transform.Translate(0, -8)

	// Defense protocol
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(src, COMSIG_PARENT_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(src, COMSIG_ATOM_HITBY, PROC_REF(on_hitby))
	// For traitor objectives
	RegisterSignal(src, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag_act))

/**
 * Try to harass a target, considering if they are a friend.
 *
 * Arguments:
 * * target - the target to harrass
 * * always_shoot - always shoot the target, as opposed to only if not a friend.
 */
/mob/living/basic/pet/dog/corgi/borgi/proc/harass_target(mob/living/target, always_shoot = FALSE)
	var/datum/ai_controller/basic_controller/dog/EN = ai_controller
	if(!EN)
		return

	var/list/friends_list = EN.blackboard[BB_FRIENDS_LIST]
	var/is_friend = friends_list && friends_list[WEAKREF(target)]

	if(always_shoot || !is_friend)
		INVOKE_ASYNC(src, PROC_REF(shoot_at), target)

	if(health > 30 || is_friend)
		return

	EN.set_movement_target(target)
	EN.blackboard[BB_DOG_HARASS_TARGET] = WEAKREF(target)
	EN.queue_behavior(/datum/ai_behavior/basic_melee_attack/dog, BB_DOG_HARASS_TARGET, BB_PET_TARGETTING_DATUM)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_attack_hand(datum/source, mob/living/target)
	SIGNAL_HANDLER

	if(!target.combat_mode || health <= 0)
		return

	harass_target(target, always_shoot = TRUE)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_attackby(datum/source, obj/item/used_item, mob/living/target)
	SIGNAL_HANDLER

	if(!used_item.force || used_item.damtype == STAMINA || health <= 0)
		return

	harass_target(target, always_shoot = TRUE)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_hitby(datum/source, obj/item/used_item)
	SIGNAL_HANDLER

	if(!istype(used_item) || used_item.throwforce < 5 || health <= 0)
		return

	var/mob/living/carbon/human/thrown_by = used_item.thrownby?.resolve()
	if(!ishuman(thrown_by))
		return

	harass_target(thrown_by)

/mob/living/basic/pet/dog/corgi/borgi/bullet_act(obj/projectile/proj)
	. = ..()

	if(!istype(proj, /obj/projectile/beam) && !istype(proj, /obj/projectile/bullet))
		return

	var/mob/living/carbon/human/target = proj.firer
	if(proj.damage >= 10)
		if(proj.damage_type != BRUTE && proj.damage_type != BURN)
			return

		adjustBruteLoss(proj.damage)
		if(!isliving(target) || health <= 0)
			return

		harass_target(target)
	else
		shoot_toy_at(target)

/mob/living/basic/pet/dog/corgi/borgi/proc/shoot_at(atom/movable/target)
	var/turf/source_turf = get_turf(src)
	var/turf/target_turf = get_turf(target)
	if(!source_turf || !target_turf)
		return
	var/obj/projectile/beam/laser = new /obj/projectile/beam(loc)
	laser.icon = 'icons/effects/genetics.dmi'
	laser.icon_state = "eyelasers"
	playsound(loc, 'sound/weapons/taser.ogg', 75, 1)
	laser.preparePixelProjectile(target, source_turf)
	laser.firer = src
	laser.fired_from = src
	laser.fire()

/mob/living/basic/pet/dog/corgi/borgi/proc/shoot_toy_at(atom/movable/target)
	var/turf/source_turf = get_turf(src)
	var/turf/target_turf = get_turf(target)
	if(!source_turf || !target_turf)
		return
	var/obj/projectile/bullet/reusable/foam_dart/fired_dart = new /obj/projectile/bullet/reusable/foam_dart(loc)
	fired_dart.icon = 'icons/obj/weapons/guns/toy.dmi'
	fired_dart.icon_state = "foamdart_proj"
	playsound(loc, 'sound/items/syringeproj.ogg', 75, 1)
	fired_dart.preparePixelProjectile(target, source_turf)
	fired_dart.firer = src
	fired_dart.fired_from = src
	fired_dart.fire()

/mob/living/basic/pet/dog/corgi/borgi/Life(seconds, times_fired)
	. = ..()

	// spark for no reason
	if(prob(5))
		do_sparks(3, 1, src)

/mob/living/basic/pet/dog/corgi/borgi/death(gibbed)
	// Only execute the below if we successfully died
	. = ..(gibbed)
	if(!.)
		return FALSE

	UnregisterSignal(src, COMSIG_ATOM_ATTACK_HAND)
	UnregisterSignal(src, COMSIG_PARENT_ATTACKBY)
	UnregisterSignal(src, COMSIG_ATOM_HITBY)
	UnregisterSignal(src, COMSIG_ATOM_EMAG_ACT)

	do_sparks(3, 1, src)
	var/datum/ai_controller/basic_controller/dog/EN = ai_controller
	LAZYCLEARLIST(EN.current_behaviors)

/mob/living/basic/pet/dog/corgi/borgi/proc/on_emag_act(mob/living/basic/pet/dog/target, mob/user)
	SIGNAL_HANDLER

	if(emagged)
		return

	emagged = 1

	// Emote sleeps.
	INVOKE_ASYNC(src, PROC_REF(emote), "exclaim")
	set_light_on(TRUE)

	add_fingerprint(user, TRUE)
	investigate_log("has been gibbed due to being emagged by [user].", INVESTIGATE_DEATHS)
	visible_message(span_boldwarning("[user] swipes a card through [target]!"), span_notice("You overload [target]s internal reactor..."))

	notify_ghosts("[user] has shortcircuited [target] to explode in 60 seconds!", source = target, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Borgi Emagged")
	addtimer(CALLBACK(src, PROC_REF(explode_imminent)), 50 SECONDS)

/mob/living/basic/pet/dog/corgi/borgi/proc/explode_imminent()
	visible_message(span_bolddanger("[src] makes an odd whining noise!"))
	do_jitter_animation(30)

	addtimer(CALLBACK(src, PROC_REF(explode)), 10 SECONDS)

/mob/living/basic/pet/dog/corgi/borgi/proc/explode()
	explosion(get_turf(src), 1, 2, 4, 4, 6) // Should this be changed?
	gib() // Yuck, robo-blood

/// Dog controller but with emag attack support
/datum/ai_controller/basic_controller/dog/borgi
	blackboard = list(
		BB_DOG_HARASS_HARM = TRUE,
		BB_VISION_RANGE = AI_DOG_VISION_RANGE,
		BB_DOG_IS_SLOW = TRUE,
		BB_PET_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/emagged_borgi,
		/datum/ai_planning_subtree/random_speech/dog,
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/dog_harassment,
	)

/// Subtree that schedules borgi to randomly shoot if they're emagged.
/datum/ai_planning_subtree/emagged_borgi
	/// Probability that emagged borgi will randomly attack.
	var/chance = 33
	/// Range to immediately target enemies
	var/view_range = 10

/datum/ai_planning_subtree/emagged_borgi/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()

	// Emagged borgi?
	var/mob/living/basic/pet/dog/corgi/borgi/borgi_pawn = controller.pawn
	if(!istype(borgi_pawn) || !borgi_pawn.emagged)
		return

	// Target if not already targetted and prob check passes.
	var/datum/weakref/weak_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/atom/target = weak_target?.resolve()
	if(QDELETED(target))
		if(!SPT_PROB(chance, seconds_per_tick))
			return

		controller.queue_behavior(/datum/ai_behavior/find_potential_targets, BB_BASIC_MOB_CURRENT_TARGET, BB_PET_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
		return

	// Attack.
	controller.queue_behavior(/datum/ai_behavior/emagged_borgi_attack, BB_BASIC_MOB_CURRENT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

/**
 * Shoot a random target.
 */
/datum/ai_behavior/emagged_borgi_attack
	action_cooldown = 3 SECONDS

/datum/ai_behavior/emagged_borgi_attack/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return

	var/mob/living/basic/pet/dog/corgi/borgi/borgi_pawn = controller.pawn
	if(!istype(borgi_pawn))
		return

	borgi_pawn.shoot_at(target)

/mob/living/basic/pet/dog/dobermann
	name = "\proper Dobermann"
	gender = MALE
	desc = "A larger breed of dog."
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "dobber"
	icon_dead = "dobbydead"
	icon_living = "dobber"
