/mob/living/simple_animal/pet/poppy
	name = "Poppy the Safety Possum"
	desc = "Safety first!"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"
	maxHealth = 30
	health = 30
	speak = list("Hiss!","HISS!","Hissss?")
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("runs in a circle.", "shakes.")
	speak_chance = 2
	turns_per_move = 3
	see_in_dark = 5
	butcher_results = list(/obj/item/food/meat/slab = 1, /obj/item/clothing/head/hardhat = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "stamps on"
	response_harm_simple = "stamp"
	density = FALSE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/poppy/Initialize()
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/pet/poppy/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if (resting)
		icon_state = "[icon_living]_rest"
	else
		icon_state = "[icon_living]"
	regenerate_icons()

/mob/living/simple_animal/pet/poppy/handle_automated_movement()
	. = ..()

/mob/living/simple_animal/pet/poppy/Life(delta_time = SSMOBS_DT, times_fired)
	if(!stat && !buckled && !client)
		if(DT_PROB(0.5, delta_time))
			manual_emote(pick("lets out a hiss before resting.", "catches a break.", "gives a simmering hiss before lounging.", "exams her surroundings before relaxing."))
			set_resting(TRUE)
		else if(DT_PROB(0.5, delta_time))
			if (resting)
				manual_emote(pick("stretches her claws, rising!", "diligently gets up, ready to inspect!", "stops resting..."))
			else
				manual_emote(pick("hisses!"))
	..()
