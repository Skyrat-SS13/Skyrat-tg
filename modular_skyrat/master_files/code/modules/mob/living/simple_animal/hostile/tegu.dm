/mob/living/simple_animal/hostile/retaliate/tegu
	name = "tegu"
	desc = "That's a tegu."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead ="tegu_dead"
	speak_emote = list("hisses")
	emote_see = list("hisses.", "flicks their tongue.")
	health = 20
	maxHealth = 20
	faction = list("Lizard")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	footstep_type = FOOTSTEP_MOB_CLAW
	melee_damage_lower = 16 //They do have a nasty bite
	melee_damage_upper = 16
	response_help_continuous = "pets the"
	response_help_simple = "pet"
	response_disarm_continuous = "rolls over the"
	response_disarm_simple = "roll over"
	response_harm_continuous = "stomps on"
	response_harm_simple = "stomp on"
	pass_flags = PASSTABLE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_REPTILE
	gold_core_spawnable = FRIENDLY_SPAWN
	turns_per_move = 10
	can_be_held = TRUE
	ai_controller = /datum/ai_controller/dog //Tegus can be taught to fetch
	stop_automated_movement = TRUE

/mob/living/simple_animal/hostile/retaliate/tegu/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "sticks its tongue out contentedly!")

/mob/living/simple_animal/hostile/retaliate/tegu/gus
	name = "Gus"
	real_name = "Gus"
	desc = "The Research Department's beloved pet tegu."
	gender = MALE
	gold_core_spawnable = NO_SPAWN
