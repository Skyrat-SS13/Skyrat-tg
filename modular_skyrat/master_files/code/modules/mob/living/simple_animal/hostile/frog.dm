/mob/living/simple_animal/hostile/retaliate/frog
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/retaliate/frog/silent
	attack_sound = null
	stepped_sound = null
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/hostile/retaliate/frog/silent/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/connect_loc)
