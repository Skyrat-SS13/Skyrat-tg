/obj/effect/mob_spawn/ghost_role/human/ancient_milsim
	name = "Bitrunning SNPC CIN Operative"
	prompt_name = "a weird compound operative"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "psykerpod"
	outfit = /datum/outfit/cin_soldier_player
	you_are_text = "You are a smart NPC guarding the exit of a simulated combat domain."
	flavour_text = "You are a smart NPC loaded into the domain as a means of slowing down the bitrunning contestants' progression one way or another, be it combat or drawn out dialogues."
	important_text = "Generally speaking, 'play fair'. Only allowed species is humans."
	restricted_species = list(/datum/species/human)
	random_appearance = FALSE


/obj/effect/mob_spawn/ghost_role/human/ancient_milsim/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(null, "[callsign] [number]")

/obj/effect/mob_spawn/ghost_role/human/ancient_milsim/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/panslavic, source = LANGUAGE_SPAWNER)
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/ancient_milsim/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)
