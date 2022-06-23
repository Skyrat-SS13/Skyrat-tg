/mob/living/simple_animal/hostile/megafauna
	/// Has this been harmed by an ashwalker at least once?
	var/ashwalker_harmed = FALSE

/mob/living/simple_animal/hostile/megafauna/attacked_by(obj/item/I, mob/living/user)
	if(!ashwalker_harmed && is_species(user, /datum/species/lizard/ashwalker))
		ashwalker_harmed = TRUE
	return ..()

/mob/living/simple_animal/hostile/megafauna/death(gibbed, list/force_grant)
	if(ashwalker_harmed)
		spawn_crusher_loot()
	return ..()
