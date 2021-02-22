#define TRUE_CHANGELING_REFORM_THRESHOLD 1800 //3 minutes by default
#define TRUE_CHANGELING_PASSIVE_HEAL 3 //Amount of brute damage restored per tick

//Changelings in their true form.
//Massive health and damage, but move slowly.

/mob/living/simple_animal/hostile/necropuker
	name = "puker"
	real_name = "puker"
	desc = "Holy shit, what the fuck is that thing?!"
	speak_emote = list("says with one of its faces")
	emote_hear = list("says with one of its faces")
	icon = 'modular_skyrat/modules/ds13/icons/mob/necromorph/puker.dmi'
	icon_state = "puker"
	icon_living = "puker"
	icon_dead = "puker_lying"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	faction = list(ROLE_NECROMORPH)
	speed = 1
	a_intent = "INTENT_HARM"
	stop_automated_movement = 1
	status_flags = CANPUSH
	ventcrawler = 2
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxHealth = 250 //Very durable
	health = 250
	healable = 0
	environment_smash = 15
	melee_damage_lower = 25
	melee_damage_upper = 25
//	see_in_dark = 8
//	see_invisible = SEE_INVISIBLE_MINIMUM
	wander = 1

	attack_verb_continuous = "rips into"
	attack_verb_simple = "rip into"
	attack_sound = 'modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/puker_attack_1.ogg'
	deathsound = 'modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/puker_death_1.ogg'
	next_move_modifier = 0.5 //Faster attacks
	butcher_results = list(/obj/item/food/meat/slab/human = 15) //It's a pretty big dude. Actually killing one is a feat.
	gold_core_spawnable = 0 //Should stay exclusive to changelings tbh, otherwise makes it much less significant to sight one
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'

/obj/projectile/neurotox
	name = "Puke"
	damage = 30
	icon = 'modular_skyrat/modules/ds13/icons/mob/necromorph/necroprojectiles.dmi'
	icon_state = "pukeshot"
/*
/mob/living/simple_animal/hostile/necromorph/Initialize()
	. = ..()
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_CLAW)
*/
#undef TRUE_CHANGELING_REFORM_THRESHOLD
#undef TRUE_CHANGELING_PASSIVE_HEAL

