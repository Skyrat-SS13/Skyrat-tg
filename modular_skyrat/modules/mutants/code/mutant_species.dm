#define REGENERATION_DELAY (5 SECONDS)  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/mutant
	name = "High-Functioning mutant"
	id = SPECIES_MUTANT
	meat = /obj/item/food/meat/slab/human/mutant/zombie
	eyes_icon = 'modular_skyrat/modules/mutants/icons/mutant_eyes.dmi'
	inherent_traits = list(
		TRAIT_NOBLOOD,
		TRAIT_NODISMEMBER,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_LIVERLESS_METABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBREATH,
		TRAIT_NO_ZOMBIFY,
	)
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	mutanttongue = /obj/item/organ/internal/tongue/zombie
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | ERT_SPAWN
	bodytemp_normal = T0C // They have no natural body heat, the environment regulates body temp
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // Take damage at fire temp
	bodytemp_cold_damage_limit = MINIMUM_TEMPERATURE_TO_MOVE // take damage below minimum movement temp
	/// A list of spooky sounds we can play intermittantly.
	var/static/list/spooks = list(
		'sound/hallucinations/growl1.ogg',
		'sound/hallucinations/growl2.ogg',
		'sound/hallucinations/growl3.ogg',
		'sound/hallucinations/veryfar_noise.ogg',
		'sound/hallucinations/wail.ogg'
		)
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant_zombie,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant_zombie,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant_zombie,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant_zombie,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant_zombie,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant_zombie
	)

/datum/species/mutant/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE
	return ..()

/mob/living/carbon/human/species/mutant
	race = /datum/species/mutant

/mob/living/carbon/human/species/mutant/infectious
	race = /datum/species/mutant/infectious

/datum/species/mutant/infectious
	name = "Mutated Abomination"
	id = SPECIES_MUTANT_INFECTIOUS
	damage_modifier = 10
	mutanteyes = /obj/item/organ/internal/eyes/zombie
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant_zombie,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant_zombie,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant_zombie,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant_zombie,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant_zombie/infectious,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant_zombie/infectious,
	)
	var/hands_to_give = /obj/item/hnz_mutant_hand
	/// The rate the mutants regenerate at
	var/heal_rate = 1
	/// The cooldown before the mutant can start regenerating
	COOLDOWN_DECLARE(regen_cooldown)

/datum/species/mutant/infectious/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	. = ..()
	human_who_gained_species.AddComponent(/datum/component/mutant_hands, mutant_hand_path = hands_to_give)
	RegisterSignal(human_who_gained_species, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(queue_regeneration))

/datum/species/mutant/infectious/on_species_loss(mob/living/carbon/human/human_who_lost_species, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(human_who_lost_species, COMSIG_MOB_AFTER_APPLY_DAMAGE)

/obj/item/bodypart/leg/left/mutant_zombie/infectious
	speed_modifier = 0.5

/obj/item/bodypart/leg/right/mutant_zombie/infectious
	speed_modifier = 0.5

/datum/species/mutant/infectious/fast
	name = "Fast Mutated Abomination"
	id = SPECIES_MUTANT_FAST
	hands_to_give = /obj/item/hnz_mutant_hand/fast
	damage_modifier = 0
	/// The rate the mutants regenerate at
	heal_rate = 0.5
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant_zombie,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant_zombie,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant_zombie,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant_zombie,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant_zombie/fast,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant_zombie/fast,
	)

/obj/item/bodypart/leg/left/mutant_zombie/fast
	speed_modifier = 0.25

/obj/item/bodypart/leg/right/mutant_zombie/fast
	speed_modifier = 0.25

/datum/species/mutant/infectious/slow
	name = "Slow Mutated Abomination"
	id = SPECIES_MUTANT_SLOW
	damage_modifier = 15
	/// The rate the mutants regenerate at
	heal_rate = 1.5
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant_zombie,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant_zombie,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant_zombie,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant_zombie,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant_zombie/slow,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant_zombie/slow,
	)

/obj/item/bodypart/leg/left/mutant_zombie/slow
	speed_modifier = 0.75

/obj/item/bodypart/leg/right/mutant_zombie/slow
	speed_modifier = 0.75

/// mutants do not stabilize body temperature they are the walking dead and are cold blooded
/datum/species/mutant/body_temperature_core(mob/living/carbon/human/humi, seconds_per_tick, times_fired)
	return

/datum/species/mutant/infectious/check_roundstart_eligible()
	return FALSE

/datum/species/mutant/infectious/spec_stun(mob/living/carbon/human/H,amount)
	. = min(20, amount)

/// Start the cooldown to regenerate - 5 seconds after taking damage
/datum/species/mutant/infectious/proc/queue_regeneration()
	SIGNAL_HANDLER

	if(COOLDOWN_FINISHED(src, regen_cooldown))
		COOLDOWN_START(src, regen_cooldown, REGENERATION_DELAY)

/datum/species/mutant/infectious/spec_life(mob/living/carbon/carbon_mob, seconds_per_tick, times_fired)
	. = ..()
	//mutants never actually die, they just fall down until they regenerate enough to rise back up.
	if(COOLDOWN_FINISHED(src, regen_cooldown))
		var/heal_amt = heal_rate
		if(HAS_TRAIT(carbon_mob, TRAIT_CRITICAL_CONDITION))
			heal_amt *= 2
		carbon_mob.heal_overall_damage(heal_amt * seconds_per_tick, heal_amt * seconds_per_tick)
		carbon_mob.adjustStaminaLoss(-heal_amt * seconds_per_tick)
		carbon_mob.adjustToxLoss(-heal_amt * seconds_per_tick)
		for(var/i in carbon_mob.all_wounds)
			var/datum/wound/iter_wound = i
			if(SPT_PROB(2-(iter_wound.severity/2), seconds_per_tick))
				iter_wound.remove_wound()
	if(!HAS_TRAIT(carbon_mob, TRAIT_CRITICAL_CONDITION) && SPT_PROB(2, seconds_per_tick))
		playsound(carbon_mob, pick(spooks), 50, TRUE, 10)

#undef REGENERATION_DELAY

/mob/living/carbon/human/canBeHandcuffed()
	if(is_species(src, /datum/species/mutant/infectious))
		return FALSE
	else
		. = ..()

/obj/item/hnz_mutant_hand
	name = "mutant claw"
	desc = "A mutant's claw is its primary tool, capable of infecting \
		humans, butchering all other living things to \
		sustain the mutant, smashing open airlock doors and opening \
		child-safe caps on bottles."
	item_flags = ABSTRACT | DROPDEL
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	icon = 'icons/effects/blood.dmi'
	icon_state = "bloodhand_left"
	inhand_icon_state = "mutant"
	lefthand_file = 'modular_skyrat/modules/mutants/icons/mutant_hand_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mutants/icons/mutant_hand_righthand.dmi'
	hitsound = 'sound/hallucinations/growl1.ogg'
	force = 26
	sharpness = SHARP_EDGED
	wound_bonus = -20
	damtype = BRUTE
	var/icon_left = "bloodhand_left"
	var/icon_right = "bloodhand_right"

/obj/item/hnz_mutant_hand/fast
	name = "weak mutant claw"
	force = 21
	sharpness = NONE
	wound_bonus = -40

/obj/item/hnz_mutant_hand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/hnz_mutant_hand/equipped(mob/user, slot)
	. = ..()
	//these are intentionally inverted
	var/i = user.get_held_index_of_item(src)
	if(!(i % 2))
		icon_state = icon_left
	else
		icon_state = icon_right

/obj/item/hnz_mutant_hand/afterattack(atom/target, mob/user, click_parameters)
	if(isliving(target))
		if(ishuman(target))
			try_to_mutant_infect(target, user = user)
		else
			check_feast(target, user)

#define INFECT_CHANCE 70

/proc/try_to_mutant_infect(mob/living/carbon/human/target, forced = FALSE, mob/user)
	CHECK_DNA_AND_SPECIES(target)

	if(forced)
		target.AddComponent(/datum/component/mutant_infection)
		return TRUE

	if(HAS_TRAIT(target, TRAIT_NO_ZOMBIFY))
		// cannot infect any NOZOMBIE subspecies (such as high functioning
		// mutants)
		return FALSE

	if(target.GetComponent(/datum/component/mutant_infection))
		return FALSE

	if(!target.can_inject(user))
		return FALSE

	if(prob(INFECT_CHANCE))
		return FALSE

	if(HAS_TRAIT(target, TRAIT_MUTANT_IMMUNE))
		return FALSE

	target.AddComponent(/datum/component/mutant_infection)
	return TRUE

#undef INFECT_CHANCE

/proc/try_to_mutant_cure(mob/living/carbon/target) //For things like admin procs
	var/datum/component/mutant_infection/infection = target.GetComponent(/datum/component/mutant_infection)
	if(infection)
		qdel(infection)

/obj/item/hnz_mutant_hand/proc/check_feast(mob/living/target, mob/living/user)
	if(target.stat == DEAD)
		var/hp_gained = target.maxHealth
		target.investigate_log("has been feasted upon by the mutant [user].", INVESTIGATE_DEATHS)
		target.gib()
		// zero as argument for no instant health update
		var/need_health_update
		need_health_update += user.adjustBruteLoss(-hp_gained, updating_health = FALSE)
		need_health_update += user.adjustToxLoss(-hp_gained, updating_health = FALSE)
		need_health_update += user.adjustFireLoss(-hp_gained, updating_health = FALSE)
		if(need_health_update)
			user.updatehealth()
		user.adjustOrganLoss(ORGAN_SLOT_BRAIN, -hp_gained) // Zom Bee gibbers "BRAAAAISNSs!1!"
		user.set_nutrition(min(user.nutrition + hp_gained, NUTRITION_LEVEL_FULL))
