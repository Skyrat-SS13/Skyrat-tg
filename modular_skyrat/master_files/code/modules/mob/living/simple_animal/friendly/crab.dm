/mob/living/simple_animal/crab/shuffle
	name = "Shuffle"
	real_name = "Shuffle"
	desc = "Oh no, it's him!"
	color = "#ff0000"
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/crab/shuffle/Initialize(mapload)
	. = ..()
	resize = 0.5
	update_transform()
