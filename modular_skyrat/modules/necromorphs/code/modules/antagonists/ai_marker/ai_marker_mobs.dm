/mob/living/simple_animal/hostile/corruption
	gold_core_spawnable = HOSTILE_SPAWN
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	see_in_dark = 4
	mob_biotypes = MOB_ORGANIC
	gold_core_spawnable = NO_SPAWN
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_mobs.dmi'
	vision_range = 5
	aggro_vision_range = 8
	move_to_delay = 6

/mob/living/simple_animal/hostile/corruption/slasher
	name = "Slasher"
	real_name = "Necromorph"
	desc = "Holy shit, what the fuck is that thing?!"
	speak_emote = list("says with one of its faces")
	emote_hear = list("says with one of its faces")
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher.dmi'
	icon_state = "slasher_d"
	icon_living = "slasher_d"
	icon_dead = "slasher_d_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	faction = list(FACTION_NECROMORPH)
	speed = 4
	//faction = list(ROLE_NECROMORPH)
	//a_intent = "harm"
	stop_automated_movement = 1
	status_flags = CANPUSH
	//ventcrawler = 2
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
	speak_chance = 5
	turns_per_move = 4
//	see_in_dark = 8
//	see_invisible = SEE_INVISIBLE_MINIMUM
//	wander = 1
	attack_verb_continuous = "rips into"
	attack_verb_simple = "rip into"
	attack_sound = 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg'
	next_move_modifier = 0.5 //Faster attacks
	butcher_results = list(/obj/item/food/meat/slab/human = 15) //It's a pretty big dude. Actually killing one is a feat.
	deathsound = 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg'
	deathmessage = "lets out a waning scream as it falls, twitching, to the floor."


/mob/living/simple_animal/hostile/corruption/slasher/AttackingTarget()
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(src.can_inject(target))
			to_chat(C, span_danger("[src] manages to penetrate your clothing with it's teeth!"))
			C.ForceContractDisease(new /datum/disease/cordyceps(), FALSE, TRUE)
