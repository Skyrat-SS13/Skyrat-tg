/mob/living/simple_animal/opossum
	name = "opossum"
	desc = "It's an opossum, a small scavenging marsupial."
	icon = 'modular_tannhauser/modules/Bestiary/art/mob/possum.dmi'
	icon_state = "possum"
	icon_living = "possum"
	icon_dead = "possum_dead"
	speak = list("Hiss!","HISS!","Hissss?")
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("runs in a circle.", "shakes.")
	speak_chance = 1
	turns_per_move = 3
	blood_volume = 250
	see_in_dark = 5
	maxHealth = 15
	health = 15
	butcher_results = list(/obj/item/food/sosjerky/healthy = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "stamps on"
	response_harm_simple = "stamp"
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN

/*
/mob/living/simple_animal/opossum/poppy
	name = "Poppy the Safety Possum"
	desc = "Safety first!"
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"
	loot = list(/obj/item/clothing/head/hardhat = 1)
*/

/mob/living/simple_animal/opossum/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/* /mob/living/simple_animal/opossum/poppy/Initialize()
	. = ..()
	var/datum/id_trim/job/engi_trim = SSid_access.trim_singletons_by_path[/datum/id_trim/job/station_engineer]
	access_card.add_access(engi_trim.access + engi_trim.wildcard_access)

	ADD_TRAIT(access_card, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT) */
