//CARBON MOBS
/mob/living/carbon/alien
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING

/mob/living/carbon/monkey
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING


/*
	REFER TO code/modules/mob/living/simple_animal/simple_animal_vr.dm for Var information!
*/


//NUETRAL MOBS
/mob/living/simple_animal/crab
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING

/mob/living/simple_animal/cow
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING

/mob/living/simple_animal/chick
	vore_flags = DEVOURABLE | DIGESTABLE

/mob/living/simple_animal/chicken
	vore_flags = DEVOURABLE | DIGESTABLE

/mob/living/simple_animal/mouse
	vore_flags = DEVOURABLE | DIGESTABLE

/mob/living/simple_animal/kiwi
	vore_flags = DEVOURABLE | DIGESTABLE

//STATION PETS
/mob/living/simple_animal/pet
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING
	vore_default_mode = DM_HOLD

/mob/living/simple_animal/sloth
	vore_flags = DEVOURABLE | DIGESTABLE

/mob/living/simple_animal/parrot
	vore_flags = DEVOURABLE | DIGESTABLE

//HOSTILE MOBS
/mob/living/simple_animal/hostile/retaliate/goat
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING
	vore_default_mode = DM_HOLD


/mob/living/simple_animal/hostile/lizard
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/alien
	vore_flags = FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/bear
	vore_flags = FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/poison/giant_spider
	vore_flags = FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/retaliate/poison/snake
	vore_flags = FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/gorilla
	vore_flags = FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/asteroid/goliath
	vore_flags = FEEDING
	vore_default_mode = DM_DIGEST

/mob/living/simple_animal/hostile/carp
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING
	vore_default_mode = DM_DIGEST
