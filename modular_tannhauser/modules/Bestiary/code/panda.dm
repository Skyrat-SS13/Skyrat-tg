/mob/living/simple_animal/pet/redpanda
	name = "Red panda"
	desc = "Wah't a dork."
	icon = 'modular_tannhauser/modules/Bestiary/art/mob/red_panda.dmi'
	icon_state = "red_panda"
	icon_living = "red_panda"
	icon_dead = "dead_panda"
	speak = list("Churip","Chuuriip","Cheep-cheep","Chiteurp","squueeaacipt")
	speak_emote = list("chirps", "huff-quacks")
	emote_hear = list("squeak-chrips.", "huff-squacks.")
	emote_see = list("shakes its head.", "rolls about.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/reagent_containers/food/drinks/mug/coco = 3)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	gold_core_spawnable = FRIENDLY_SPAWN
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/pet/redpanda/zesty
	name = "Zesty"
	desc = "Wah't a dork. Wash with Like colors"
	butcher_results = list(/obj/item/reagent_containers/food/drinks/mug/tea = 6)
	icon_state = "zest_panda"
	icon_living = "zest_panda"
	icon_dead = "blue_dead_panda"
	gender = MALE
