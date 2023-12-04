// Oil shamblers
#define OIL_SHAMBLER_OVERLAY "oil_shambler_overlay"
#define OIL_SHAMBLER_OVERLAY_LAYER 0

// Centaur
#define CENTAUR_DEATH_SPLASH_RANGE 5
#define CENTAUR_DEATH_SPLAT_VOLUME 50
#define CENTAUR_RAD_PULSE_RANGE 300
#define CENTAUR_RAD_PULSE_THRESHOLD 1
#define CENTAUR_ATTACK_SCREAM_VOLUME 60

/mob/living/basic/mold
	name = "mold mob"
	desc = "A debug mob for molds. You should report seeing this."
	icon = 'modular_skyrat/modules/mold/icons/blob_mobs.dmi'
	gold_core_spawnable = NO_SPAWN
	faction = list(FACTION_MOLD)
	basic_mob_flags = DEL_ON_DEATH

/**
 * OIL SHAMBLERS
 *
 * The mob for the fire mold - humanoids that are (visually) on fire
 * They're immune to burn damage and have a chance to add fire stacks on melee attack
 */
/mob/living/basic/mold/oil_shambler
	name = "oil shambler"
	desc = "Humanoid figure covered in oil, or maybe they're just oil? They seem to be perpetually on fire."
	icon_state = "oil_shambler"
	icon_living = "oil_shambler"
	icon_dead = "oil_shambler"
	speak_emote = list("crackles")

	maxHealth = 150
	health = 150
	damage_coeff = list(BRUTE = 1, BURN = 0, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY

	melee_damage_type = BURN
	melee_damage_lower = 10
	melee_damage_upper = 15
	obj_damage = 40
	attack_sound = 'sound/effects/attackblob.ogg'

	basic_mob_flags = DEL_ON_DEATH
	gold_core_spawnable = HOSTILE_SPAWN
	death_message = "evaporates!"

	light_system = MOVABLE_LIGHT
	light_color = LIGHT_COLOR_FIRE
	light_range = 2
	light_power = 1

	ai_controller = /datum/ai_controller/basic_controller/oil_shambler

	/// The chance to apply fire stacks on melee hit
	var/ignite_chance = 20
	/// How many fire stacks to apply on hit
	var/additional_fire_stacks = 2

/mob/living/basic/mold/oil_shambler/Initialize(mapload)
	. = ..()
	update_overlays()

/mob/living/basic/mold/oil_shambler/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, OIL_SHAMBLER_OVERLAY, layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, OIL_SHAMBLER_OVERLAY, OIL_SHAMBLER_OVERLAY_LAYER, EMISSIVE_PLANE, dir, alpha)

/mob/living/basic/mold/oil_shambler/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(!isliving(target))
		return

	var/mob/living/ignite_target = target
	if(prob(ignite_chance))
		ignite_target.adjust_fire_stacks(additional_fire_stacks)

	ignite_target.ignite_mob()

/datum/ai_controller/basic_controller/oil_shambler
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/oil_shambler,
	)

/datum/ai_planning_subtree/random_speech/oil_shambler
	speech_chance = 3
	emote_hear = list("bubbles.", "crackles.", "groans.")
	emote_see = list("bubbles.")


/**
 * DISEASE MOLD
 *
 * Giant rats that are created by the disease mold
 * They try to inject their target on melee attacks and, if successful, make them contract a disease
 */
/mob/living/basic/mold/diseased_rat
	name = "diseased rat"
	desc = "An incredibly large, rabid looking rat. There are shrooms growing out of it"
	icon_state = "diseased_rat"
	icon_living = "diseased_rat"
	icon_dead = "diseased_rat_dead"
	speak_emote = list("chitters")

	maxHealth = 70
	health = 70

	melee_damage_lower = 7
	melee_damage_upper = 13
	obj_damage = 30
	attack_sound = 'sound/weapons/bite.ogg'
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"

	pass_flags = PASSTABLE
	basic_mob_flags = DEL_ON_DEATH
	butcher_results = list(/obj/item/food/meat/slab = 1)
	gold_core_spawnable = HOSTILE_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/diseased_rat

	/// The disease given on melee attacks
	var/datum/disease/given_disease = /datum/disease/cryptococcus

/mob/living/basic/mold/diseased_rat/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!isliving(target))
		return

	var/mob/living/carbon/disease_target = target
	if(can_inject(disease_target))
		to_chat(disease_target, span_danger("[src] manages to penetrate your clothing with its teeth!"))
		disease_target.ForceContractDisease(new given_disease(), FALSE, TRUE)

/datum/ai_controller/basic_controller/diseased_rat
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/diseased_rat,
	)

/datum/ai_planning_subtree/random_speech/diseased_rat
	speech_chance = 3
	emote_hear = list("squeaks.", "gnashes.", "hisses.")
	emote_see = list("drools.")


/**
 * ELECTRIC MOLD
 *
 * Giant mosquitos spawned by the electric mold
 * They inject their target with teslium on melee attacks
 */
/mob/living/basic/mold/electric_mosquito
	name = "electric mosquito"
	desc = "An oversized mosquito with what seems like electricity inside its body."
	icon_state = "electric_mosquito"
	icon_living = "electric_mosquito"
	icon_dead = "electric_mosquito_dead"
	speak_emote = list("buzzes")

	maxHealth = 70
	health = 70

	melee_damage_lower = 7
	melee_damage_upper = 10
	obj_damage = 20
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/effects/attackblob.ogg'
	basic_mob_flags = DEL_ON_DEATH

	ai_controller = /datum/ai_controller/basic_controller/electric_mosquito

	pass_flags = PASSTABLE

	/// What the mob injects per bite
	var/inject_reagent = /datum/reagent/teslium
	/// How many units to inject per bite
	var/inject_amount = 2

/mob/living/basic/mold/electric_mosquito/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/venomous, inject_reagent, inject_amount)

/datum/ai_controller/basic_controller/electric_mosquito
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/electric_mosquito,
	)

/datum/ai_planning_subtree/random_speech/electric_mosquito
	speech_chance = 3
	emote_hear = list("zaps.", "buzzes.", "crackles.")
	emote_see = list("arcs.")

/**
 * RADIATION MOLD
 *
 * Weird centipede things that spawn with a rad mold
 * They have a chance to irradiate their target on hit
 */
/mob/living/basic/mold/centaur
	name = "centaur"
	desc = "A horrific combination of bone and flesh with multiple sets of legs and feet."
	icon_state = "centaur"
	icon_living = "centaur"
	icon_dead = "centaur_dead"
	speak_emote = list("groans")

	maxHealth = 120
	health = 120
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY

	speed = 0.5

	melee_damage_lower = 10
	melee_damage_upper = 15
	basic_mob_flags = DEL_ON_DEATH
	wound_bonus = 15
	obj_damage = 40
	attack_sound = 'sound/effects/wounds/crackandbleed.ogg'

	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_GREEN

	ai_controller = /datum/ai_controller/basic_controller/centaur

	/// The chance to irradiate on hit
	var/irradiate_chance = 20

/mob/living/basic/mold/centaur/Initialize(mapload)
	. = ..()
	update_overlays()

/mob/living/basic/mold/centaur/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()

	if(!isliving(target))
		return

	var/mob/living/radiation_target = target
	if(prob(irradiate_chance))
		radiation_pulse(radiation_target, CENTAUR_RAD_PULSE_RANGE, CENTAUR_RAD_PULSE_THRESHOLD, FALSE, TRUE)
		playsound(src, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', CENTAUR_ATTACK_SCREAM_VOLUME, TRUE)

/datum/ai_controller/basic_controller/centaur
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/centaur,
	)

/datum/ai_planning_subtree/random_speech/centaur
	speech_chance = 3
	emote_hear = list("chitters.", "groans.", "wails.")
	emote_see = list("writhes.")



#undef OIL_SHAMBLER_OVERLAY
#undef OIL_SHAMBLER_OVERLAY_LAYER
#undef CENTAUR_DEATH_SPLASH_RANGE
#undef CENTAUR_DEATH_SPLAT_VOLUME
#undef CENTAUR_RAD_PULSE_RANGE
#undef CENTAUR_RAD_PULSE_THRESHOLD
#undef CENTAUR_ATTACK_SCREAM_VOLUME
