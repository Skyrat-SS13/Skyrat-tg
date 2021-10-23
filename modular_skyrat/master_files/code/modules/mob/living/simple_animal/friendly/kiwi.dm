/mob/living/simple_animal/friendly/kiwi
	name = "kiwi"
	desc = "It's a kiwi!"
	icon = 'modular_skyrat/master_files/icons/mob/newmobs.dmi'
	icon_state = "kiwi"
	icon_living = "kiwi"
	icon_dead = "kiwi_dead"
	maxHealth = 15
	health = 15
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "moves aside"
	response_help_simple = "move aside"
	response_harm_continuous = "smacks"
	response_harm_simple = "smack"
	speak_emote = list("cheeps")
	friendly_verb_continuous = "cheeps"
	friendly_verb_simple = "cheep"
	density = FALSE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_LARGE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	verb_say = "cheep"
	verb_ask = "cheeps inquisitively"
	verb_exclaim = "cheeps loudly"
	verb_yell = "screeches"
	emote_see = list("cheeps.", "makes a loud cheep.", "runs around.", "cheeps happily.")
	speak_chance = 1

