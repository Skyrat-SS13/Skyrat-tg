/mob/living/simple_animal/hostile/necromorph/slasher
	name = "necroslasher"
	real_name = "Necromorph"
	desc = "Holy shit, what the fuck is that thing?!"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher.dmi'
	icon_state = "slasher_d"
	icon_living = "slasher_d"
	icon_dead = "slasher_d_dead"
	icon_gib = "syndicate_gib"
	pass_flags = PASSBLOB
	faction = list(ROLE_NECROMORPH)
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	dodging = TRUE
	footstep_type = FOOTSTEP_MOB_SHOE
	robust_searching = 1
	mob_biotypes = MOB_ORGANIC
	butcher_results = list(/obj/item/food/meat/slab/xeno = 4,
							/obj/item/stack/sheet/animalhide/xeno = 1)
	// Line of Sight
	vision_range = 9
	aggro_vision_range = 9
	// Health
	maxHealth = 125
	health = 125
	// Attacks
	//a_intent = INTENT_HARM
	harm_intent_damage = 5
	obj_damage = 60
	environment_smash = 20
	melee_damage_lower = 25
	melee_damage_upper = 25
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)
	//a_intent = INTENT_HARM
	attack_sound = 'sound/weapons/bladeslice.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	//faction = list(ROLE_NECROMORPH)
	status_flags = CANPUSH
	minbodytemp = 0
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	unique_name = 1
	gold_core_spawnable = NO_SPAWN
	//Movement
	stop_automated_movement = 1
	speed = 2
	status_flags = CANPUSH
	//ventcrawler = 2
	wander = 1
	//Sounds
	speak_chance = 0
	deathsound = 'sound/voice/hiss6.ogg'
	deathmessage = "lets out a waning guttural screech, green blood bubbling from its maw..."
	attack_sound = 'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg'
	// Emotes
	speak_emote = list("says with one of its faces")
	emote_hear = list("says with one of its faces")
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	speak_emote = list("hisses")


/mob/living/simple_animal/hostile/necromorph/slasher/Initialize(mapload, obj/structure/marker/special/linked_node)
	. = ..()
	AddElement(/datum/element/simple_flying)
	if(istype(linked_node))
		factory = linked_node
		factory.slasher += src
		if(linked_node.overmind && istype(linked_node.overmind) && !istype(src, /mob/living/simple_animal/hostile/necromorph/slasher))
			notify_ghosts("A controllable spore has been created in \the [get_area(src)].", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Sentient Spore Created")


/mob/living/simple_animal/hostile/necromorph/slasher/Destroy()
	if(factory)
		factory.slasher -= src
		factory = null

	return ..()

/mob/living/simple_animal/hostile/necromorph/slasher/death(gibbed)
	if(factory)
		factory.slasher_delay = world.time + factory.slasher_cooldown //put the factory on cooldown

	..()
