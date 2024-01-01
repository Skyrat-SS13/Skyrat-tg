/mob/living/simple_animal
	/// whether the simple animal can be healed/damaged through reagents
	var/reagent_health = FALSE

/mob/living/simple_animal/Initialize(mapload)
	. = ..()
	if(reagent_health)
		create_reagents(1000, REAGENT_HOLDER_ALIVE)

/mob/living/simple_animal/hostile/megafauna
	reagent_health = TRUE

/mob/living/simple_animal/hostile/asteroid
	reagent_health = TRUE

/mob/living/simple_animal/Life(seconds_per_tick, times_fired)
	. = ..()

	if(!reagent_health)
		return

	if(!reagents)
		return

	if(stat == DEAD)
		return

	for(var/datum/reagent/reagents_within as anything in reagents.reagent_list)
		if(istype(reagents_within, /datum/reagent/toxin))
			var/datum/reagent/toxin/toxin_reagent = reagents_within
			var/toxin_damage = round(toxin_reagent.toxpwr)
			adjustHealth(toxin_damage + 1)
			reagents.remove_reagent(toxin_reagent.type, 0.5)
			continue

		if(istype(reagents_within, /datum/reagent/medicine))
			adjustHealth(-1)
			reagents.remove_reagent(reagents_within.type, 0.5)

/mob/living/basic
	/// whether the simple animal can be healed/damaged through reagents
	var/reagent_health = TRUE

/mob/living/basic/Initialize(mapload)
	. = ..()
	if(reagent_health)
		create_reagents(1000, REAGENT_HOLDER_ALIVE)

/mob/living/basic/Life(seconds_per_tick, times_fired)
	. = ..()

	if(!reagent_health)
		return

	if(!reagents)
		return

	if(stat == DEAD)
		return

	for(var/datum/reagent/reagents_within as anything in reagents.reagent_list)
		if(istype(reagents_within, /datum/reagent/toxin))
			var/datum/reagent/toxin/toxin_reagent = reagents_within
			var/toxin_damage = round(toxin_reagent.toxpwr)
			adjust_health(toxin_damage + 1)
			reagents.remove_reagent(toxin_reagent.type, 0.5)
			continue

		if(istype(reagents_within, /datum/reagent/medicine))
			adjust_health(-1)
			reagents.remove_reagent(reagents_within.type, 0.5)
