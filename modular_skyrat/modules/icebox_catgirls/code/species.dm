/mob/living/carbon/human/species/felinid/primitive
	race = /datum/species/human/felinid/primitive

/datum/language_holder/primitive_felinid
	understood_languages = list(
		/datum/language/uncommon = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/uncommon = list(LANGUAGE_ATOM),
	)

/datum/species/human/felinid/primitive
	name = "Primitive Felinid"
	id = SPECIES_FELINE_PRIMITIVE

	species_language_holder = /datum/language_holder/primitive_felinid

	liked_food = SEAFOOD | MEAT | GORE

	always_customizable = TRUE

/datum/species/human/felinid/primitive/prepare_human_for_preview(mob/living/carbon/human/human_for_preview)
	human_for_preview.hairstyle = "Blunt Bangs Alt"
	human_for_preview.hair_color = "#323442"
	human_for_preview.skin_tone = "mediterranean"

	human_for_preview.update_body_parts()

	human_for_preview.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list(human_for_preview.hair_color))
	human_for_preview.dna.species.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list(human_for_preview.hair_color))

	human_for_preview.update_mutant_bodyparts(TRUE)
	human_for_preview.update_body(TRUE)

/datum/species/human/felinid/primitive/get_species_description()
	return "Felinids are one of the many types of bespoke genetic \
		modifications to come of humanity's mastery of genetic science, and are \
		also one of the most common. Meow?"

/datum/species/human/felinid/primitive/get_species_lore()
	return list(
		"The galaxy is a large place, and every now and then people and things will just go missing never to be seen. \
			Everything that goes missing ends up somewhere, people, things, if you look hard enough you can find long \
			forgotten stuff in just about any part of space.",

		"Sometimes when people go missing, they survive the ordeal. While not common, many incidents have been recorded \
			where a ship will crash on a distant frontier world without rescue, and the crew will simply survive and thrive.",

		"In cases like this, sometimes the crew is only rediscovered through their offspring several generations later. \
			If they get rediscovered at all, that is.",

		"Why do I tell you all of this you ask? Reports trickle in from many of our icemoon outposts that they've either \
			sighted, or been harassed by a group of felinids that look like stuff right out of the history books. \
			Look at the logbooks and you'll see plenty of ships assumed missing decades ago with a felinid crew on board. \
			Doesn't take a mastermind to put two and two together.",

		"- Nanotrasen commander who requested anonymity",
	)
