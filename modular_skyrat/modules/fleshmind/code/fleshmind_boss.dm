/mob/living/simple_animal/hostile/fleshmind/tyrant
	name = "Tyrant Type 34-C"
	desc = "The will of the many, manifested in flesh and metal. It has fucking rockets."
	icon = 'modular_skyrat/modules/fleshmind/icons/tyrant.dmi'
	icon_state = "tyrant"
	health = 2000
	maxHealth = 2000
	projectiletype = /obj/item/ammo_casing/b50cal
	minimum_distance = 5
	rapid = 6
	speed = 5

/mob/living/simple_animal/hostile/fleshmind/tyrant/Moved()
	. = ..()
	playsound(src, 'sound/mecha/powerloader_step.ogg', 100, TRUE)
