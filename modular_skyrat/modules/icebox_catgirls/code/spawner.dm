/obj/effect/mob_spawn/ghost_role/human/icebox_catgirl
	name = "hole in the ground"
	desc = "A clearly hand dug hole in the ground that appears to lead into a small cave of some kind? It's pretty dark in there."
	prompt_name = "icemoon dweller"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "hole"
	mob_species = /datum/species/human/felinid/primitive
	outfit = /datum/outfit/icebox_catgirl
	density = FALSE
	you_are_text = "You are an icemoon dweller."
	flavour_text = "For as long as you can remember, the icemoon has been your home. \
	It's been the home of your ancestors, and their ancestors, and the ones before them, \
	and now outsiders seek to soil these sacred lands. Protect your kin and protect \
	your ancestral homeland from destruction."
	important_text = "Do NOT abandon your kin and your camp."
	spawner_job_path = /datum/job/icebox_catgirl
	var/datum/team/icebox_catgirls/team
	restricted_species = list(/datum/species/human/felinid/primitive)
	random_appearance = FALSE
	uses = 7

/obj/effect/mob_spawn/ghost_role/human/icebox_catgirl/examine()
	. = ..()

	if(uses)
		. += span_notice("You can see <b>[uses]</b> figures sound asleep down there.")
	else
		. += span_notice("It looks pretty empty.")

	return .

/obj/effect/mob_spawn/ghost_role/human/icebox_catgirl/allow_spawn(mob/user, silent = FALSE)
	if(!(user.key in team.players_spawned)) // One spawn per person
		return TRUE
	if(!silent)
		to_chat(user, span_warning("It'd be weird if there were multiple of you in that cave, wouldn't it?"))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/icebox_catgirl/special(mob/living/carbon/human/spawned_human)
	. = ..()

	spawned_human.mind.add_antag_datum(/datum/antagonist/icebox_catgirl, team)

	spawned_human.remove_language(/datum/language/common)
	team.players_spawned += (spawned_human.key)

/obj/effect/mob_spawn/ghost_role/human/icebox_catgirl/Initialize(mapload)
	. = ..()
	team = new /datum/team/icebox_catgirls()

/datum/job/icebox_catgirl
	title = "Icemoon Dweller"

/datum/team/icebox_catgirls
	name = "Icemoon Dwellers"
	show_roundend_report = FALSE

/datum/antagonist/icebox_catgirl
	name = "\improper Icemoon Dweller"
	job_rank = ROLE_LAVALAND // If you're ashwalker banned you should also not be playing this, other way around as well
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	prevent_roundtype_conversion = FALSE
	antagpanel_category = "Icemoon Dwellers"
	count_against_dynamic_roll_chance = FALSE
	var/datum/team/icebox_catgirls/feline_team

/datum/antagonist/icebox_catgirl/create_team(datum/team/team)
	if(team)
		feline_team = team
		objectives |= feline_team.objectives
	else
		feline_team = new

/datum/antagonist/icebox_catgirl/get_team()
	return feline_team
