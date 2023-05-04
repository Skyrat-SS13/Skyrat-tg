/// To know whether or not we have an officer already
GLOBAL_VAR(first_officer)

/obj/effect/mob_spawn/ghost_role/human/nri_raider
	name = "NRI Raider sleeper"
	desc = "Cozy. You get the feeling you aren't supposed to be here, though..."
	prompt_name = "a NRI Marine"
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	mob_species = /datum/species/human
	faction = list(FACTION_RAIDER)
	you_are_text = "You are a Novaya Rossiyskaya Imperiya task force."
	flavour_text = "The station has refused to pay the fine for breaking Imperial regulations, you are here to recover the debt. Do so by demanding the funds. Force approach is usually recommended, but isn't the only method."
	important_text = "Allowed races are humans, Akulas, IPCs. Follow your field officer's orders. Important mention - while you are listed as the pirates gamewise, you really aren't lore-and-everything-else-wise. Roleplay accordingly."
	outfit = /datum/outfit/pirate/nri/marine
	restricted_species = list(/datum/species/human, /datum/species/akula, /datum/species/synthetic)
	random_appearance = FALSE
	show_flavor = TRUE

/// Applies name wow
/obj/effect/mob_spawn/ghost_role/human/nri_raider/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.numbers_as_words)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[callsign] [number]")

/obj/effect/mob_spawn/ghost_role/human/nri_raider/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_SPAWNER)
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/job/fugitive_hunter
	title = ROLE_FUGITIVE_HUNTER
	policy_index = ROLE_FUGITIVE_HUNTER

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer
	name = "NRI Officer sleeper"
	mob_name = "Novaya Rossiyskaya Imperiya raiding party's field officer"
	outfit = /datum/outfit/pirate/nri/officer
	important_text = "Allowed races are humans, Akulas, IPCs. Important mention - while you are listed as the pirates gamewise, you really aren't lore-and-everything-else-wise. Roleplay accordingly. There is an important document in your pocket I'd advise you to read and keep safe."

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.numbers_as_words)
	spawned_human.fully_replace_character_name(spawned_human.real_name, "[callsign] [number][GLOB.first_officer == spawned_human ? " Actual" : ""]")

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_SPAWNER)

	// if this is the first officer, keep a reference to them
	if(!GLOB.first_officer)
		GLOB.first_officer = spawned_human

	apply_codename(spawned_human)


/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)
