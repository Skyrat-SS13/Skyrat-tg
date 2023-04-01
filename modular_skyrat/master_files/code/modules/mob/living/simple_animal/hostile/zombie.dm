/mob/living/simple_animal/hostile/zombie
	var/no_corpse = FALSE

/mob/living/simple_animal/hostile/zombie/nocorpse
	no_corpse = TRUE

/mob/living/simple_animal/hostile/zombie/cheesezombie
	name = "Cheese Zombie"
	desc = "Oh God it stinks!!"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "cheesezomb"
	icon_living = "cheesezomb"
	maxHealth = 100
	health = 100
	del_on_death = 1
	loot = list(/obj/effect/gibspawner/human)

