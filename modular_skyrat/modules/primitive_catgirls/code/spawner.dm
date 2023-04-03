/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl
	name = "hole in the ground"
	desc = "A clearly hand dug hole in the ground that appears to lead into a small cave of some kind? It's pretty dark in there."
	prompt_name = "icemoon dweller"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "hole"
	mob_species = /datum/species/human/felinid/primitive
	outfit = /datum/outfit/primitive_catgirl
	density = FALSE
	you_are_text = "You are an icemoon dweller."
	flavour_text = "For as long as you can remember, the icemoon has been your home. \
		It's been the home of your ancestors, and their ancestors, and the ones before them. \
		Currently, you and your kin live in uneasy tension with your nearby human-and-otherwise \
		neighbors. Keep your village and your Kin safe, but bringing death on their heads from \
		being reckless with the outsiders will not have the Gods be so kind."
	spawner_job_path = /datum/job/primitive_catgirl

	/// The team the spawner will assign players to and use to keep track of people that have already used the spawner
	var/datum/team/primitive_catgirls/team

	restricted_species = list(/datum/species/human/felinid/primitive)
	random_appearance = FALSE
	loadout_enabled = FALSE
	uses = 9
	deletes_on_zero_uses_left = FALSE

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/Initialize(mapload)
	. = ..()
	team = new /datum/team/primitive_catgirls()

	important_text = "Read the full policy <a href=\"[CONFIG_GET(string/icecats_policy_link)]\">here</a>."

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/Destroy()
	team = null
	return ..()

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/examine()
	. = ..()

	if(uses)
		. += span_notice("You can see <b>[uses]</b> figures sound asleep down there.")
	else
		. += span_notice("It looks pretty empty.")

	return .

/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/allow_spawn(mob/user, silent = FALSE)
	if(!(user.key in team.players_spawned)) // One spawn per person
		return TRUE
	if(!silent)
		to_chat(user, span_warning("It'd be weird if there were multiple of you in that cave, wouldn't it?"))
	return FALSE

// This stuff is put on equip because it turns out /special sometimes just don't get called because skyrat
/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl/equip(mob/living/carbon/human/spawned_human)
	. = ..()

	spawned_human.mind.add_antag_datum(/datum/antagonist/primitive_catgirl, team)

	// I just have to be REALLY sure they get those languages
	spawned_human.language_holder = new /datum/language_holder/primitive_felinid
	spawned_human.update_atom_languages()

	team.players_spawned += (spawned_human.key)

/datum/job/primitive_catgirl
	title = "Icemoon Dweller"

// Antag and team datums

/datum/team/primitive_catgirls
	name = "Icewalkers"
	show_roundend_report = FALSE

/datum/antagonist/primitive_catgirl
	name = "\improper Icewalker"
	job_rank = ROLE_LAVALAND // If you're ashwalker banned you should also not be playing this, other way around as well
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	prevent_roundtype_conversion = FALSE
	antagpanel_category = "Icemoon Dwellers"
	count_against_dynamic_roll_chance = FALSE
	show_in_roundend = FALSE

	/// Tracks the antag datum's 'team' for showing in the ghost orbit menu
	var/datum/team/primitive_catgirls/feline_team

	antag_recipes = list(
		/datum/crafting_recipe/boneaxe,
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/bonedagger,
	)

/datum/antagonist/primitive_catgirl/Destroy()
	feline_team = null
	return ..()

/datum/antagonist/primitive_catgirl/apply_innate_effects(mob/living/mob_override)
	. = ..()

	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()

	holder.remove_language(/datum/language/common, TRUE, TRUE, LANGUAGE_ALL)

	holder.grant_language(/datum/language/primitive_catgirl, TRUE, TRUE, LANGUAGE_ALL)
	holder.selected_language = /datum/language/primitive_catgirl

/datum/antagonist/primitive_catgirl/create_team(datum/team/team)
	if(team)
		feline_team = team
		objectives |= feline_team.objectives
	else
		feline_team = new

/datum/antagonist/primitive_catgirl/get_team()
	return feline_team
