#define NECROMORPH_REFORM_THRESHOLD 1800 //3 minutes by default
#define NECROMORPH_PASSIVE_HEAL 3 //Amount of brute damage restored per tick

//Changelings in their true form.
//Massive health and damage, but move slowly.

/mob/living/simple_animal/hostile/necroslasher
	name = "Slasher"
	real_name = "Necromorph"
	desc = "Holy shit, what the fuck is that thing?!"
	speak_emote = list("says with one of its faces")
	emote_hear = list("says with one of its faces")
	icon = 'modular_skyrat/modules/ds13/icons/mob/necromorph/slasher.dmi'
	icon_state = "slasher_d"
	icon_living = "slasher_d"
	icon_dead = "slasher_d_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	speed = 2
	faction = list(ROLE_NECROMORPH)
	a_intent = "harm"
	stop_automated_movement = 1
	status_flags = CANPUSH
	ventcrawler = 2
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxHealth = 150 //Very durable
	health = 150
	healable = 0
	obj_damage = 40
	environment_smash = 20
	melee_damage_lower = 30
	melee_damage_upper = 40
//	see_in_dark = 8
//	see_invisible = SEE_INVISIBLE_MINIMUM
	wander = 1
	attack_verb_continuous = "rips into"
	attack_verb_simple = "rip into"
	attack_sound = 'modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg'
	next_move_modifier = 0.5 //Faster attacks
	butcher_results = list(/obj/item/food/meat/slab/human = 15) //It's a pretty big dude. Actually killing one is a feat.
	deathsound = 'modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg'
	deathmessage = "lets out a waning scream as it falls, twitching, to the floor."

#undef NECROMORPH_REFORM_THRESHOLD
#undef NECROMORPH_PASSIVE_HEAL

