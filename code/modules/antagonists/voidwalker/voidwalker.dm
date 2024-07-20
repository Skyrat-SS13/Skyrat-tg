/// Space antagonist that harasses people near space and cursed them if they get the chance
/datum/antagonist/voidwalker
	name = "\improper Voidwalker"
	antagpanel_category = ANTAG_GROUP_ABOMINATIONS
	job_rank = ROLE_VOIDWALKER
	show_in_antagpanel = TRUE
	antagpanel_category = "Voidwalker"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	ui_name = "AntagInfoVoidwalker"
	suicide_cry = "FOR THE VOID!!"
	preview_outfit = /datum/outfit/voidwalker

/datum/antagonist/voidwalker/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/voidwalker/on_gain()
	. = ..()

	var/mob/living/carbon/human/body = owner.current
	if(ishuman(body))
		body.set_species(/datum/species/voidwalker)

	forge_objectives()

/datum/antagonist/voidwalker/on_removal()
	var/mob/living/carbon/human/body = owner.current
	if(ishuman(body))
		body.set_species(/datum/species/human)

	return ..()

/datum/antagonist/voidwalker/forge_objectives()
	var/datum/objective/voidwalker_fluff/objective = new
	objective.owner = owner
	objectives += objective

/datum/outfit/voidwalker
	name = "Voidwalker (Preview only)"

/datum/outfit/voidwalker/post_equip(mob/living/carbon/human/human, visualsOnly)
	human.set_species(/datum/species/voidwalker)

/datum/objective/voidwalker_fluff

/datum/objective/voidwalker_fluff/New()
	var/list/explanation_texts = list(
		"Show them the beauty of the void.",
		"They must see what you have seen. They must walk where you have walked.",
		"Recover what you have lost.",
		"Obliterate the tyranny of matter.",
		"Make them all just like you."
	)
	if(prob(20))
		explanation_text += "Man I fucking love glass."
	explanation_text = pick(explanation_texts)
	..()

/datum/objective/voidwalker_fluff/check_completion()
	return owner.current.stat != DEAD
