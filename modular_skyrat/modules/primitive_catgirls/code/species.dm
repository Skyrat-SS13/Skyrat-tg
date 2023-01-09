/mob/living/carbon/human/species/felinid/primitive
	race = /datum/species/human/felinid/primitive

/datum/language_holder/primitive_felinid
	understood_languages = list(
		/datum/language/primitive_catgirl = list(LANGUAGE_ATOM),
		/datum/language/uncommon = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/primitive_catgirl = list(LANGUAGE_ATOM),
		/datum/language/uncommon = list(LANGUAGE_ATOM),
	)

/datum/species/human/felinid/primitive
	name = "Primitive Demihuman"
	id = SPECIES_FELINE_PRIMITIVE

	mutantlungs = /obj/item/organ/internal/lungs/icebox_adapted
	mutanteyes = /obj/item/organ/internal/eyes/low_light_adapted

	species_language_holder = /datum/language_holder/primitive_felinid

	bodytemp_normal = 270 // If a normal human gets hugged by one its gonna feel cold
	bodytemp_heat_damage_limit = 283 // To them normal station atmos would be sweltering
	bodytemp_cold_damage_limit = 213 // Man up bro its not even that cold out here

	liked_food = SEAFOOD | MEAT | GORE // Yum

	inherent_traits = list(
		TRAIT_VIRUSIMMUNE,
		TRAIT_RESISTCOLD,
	)

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
	return list(
		"Though their true origin may be unknown, what is well known is that \
			lavaland's icy moon is home to many types of seemingly primitive demihumans \
			resembling 'genemodders' of the present day. Scientific surveys of the moon \
			logged humanoids sporting features from many of the icemoon's local fauna."
	)

/datum/species/human/felinid/primitive/get_species_lore()
	return list(
		"The galaxy is a large place. Every now and then, people and things will simply go missing, never to be seen again. \
			Everything that goes missing ends up somewhere. People, things… If you look hard enough, you can find \
			long-forgotten stuff in just about any part of space.",

		"Sometimes, when people go missing, they survive the ordeal. While uncommon, many incidents have been recorded where \
			a ship will crash on a distant frontier world without rescue, and the crew will manage to survive and thrive.",

		"In cases such as this, sometimes the crew is only rediscovered through their offspring several generations later… \
		If they get rediscovered at all, that is.",

		"Why do I tell you all of this, you ask? Reports trickle in from many of our icemoon outposts that they've either \
			sighted, or been harassed by a group of modders that look like stuff straight out of the history books. Look \
			at the logbooks and you'll see plenty of ships assumed missing or destroyed decades ago with a crew \
			that had the tech to genemod on board. Doesn't take a mastermind to put two and two together.",

		"- Nanotrasen commander who requested anonymity",
	)
