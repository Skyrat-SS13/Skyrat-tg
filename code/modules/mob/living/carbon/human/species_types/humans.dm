/datum/species/human
	name = "\improper Human"
	id = SPECIES_HUMAN
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,HAS_FLESH,HAS_BONE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	mutant_bodyparts = list("wings" = "None")
	use_skintones = 1
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | CLOTH | BUGS
	liked_food = JUNKFOOD | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1

/datum/species/human/prepare_human_for_preview(mob/living/carbon/human/human)
	human.hairstyle = "Business Hair"
	human.hair_color = "#bb9966" // brown
	human.update_hair()

/datum/species/human/get_scream_sound(mob/living/carbon/human/human)
	if(human.gender == MALE)
		if(prob(1))
			return 'sound/voice/human/wilhelm_scream.ogg'
		return pick(
			'sound/voice/human/malescream_1.ogg',
			'sound/voice/human/malescream_2.ogg',
			'sound/voice/human/malescream_3.ogg',
			'sound/voice/human/malescream_4.ogg',
			'sound/voice/human/malescream_5.ogg',
			'sound/voice/human/malescream_6.ogg',
		)

	return pick(
		'sound/voice/human/femalescream_1.ogg',
		'sound/voice/human/femalescream_2.ogg',
		'sound/voice/human/femalescream_3.ogg',
		'sound/voice/human/femalescream_4.ogg',
		'sound/voice/human/femalescream_5.ogg',
	)

/datum/species/human/get_species_description()
	return {"Founders and rightful leaders of the Sol Federation, a Human being, or Human, is any member of the mammalian species Homo sapiens sapiens, \
	a group of ground-dwelling, tailless primates that originate from Sol-3 and are characterized by bipedalism and the capacity for speech and language, with an erect body carriage that frees the hands for manipulating objects. \
	Humans are characterized by their quick technological advancements, extreme perserverance, adaptative capabilities, and unending stupidity - among other skills. \
	In Sol time, it's said humanity had first reached space several centuries ago, but only started their expansion in the past few hundred years."}

/datum/species/human/get_species_lore()
	return list({"Humanity and its history is so diverse that even in the space age it's still hard to make a generalization. One thing is for certain - \
	They are best defined by the words of an ancient, once powerful dictator. \"I came. I saw. I conquered.\" \
	From the exact moment of their appearance over two-million years ago, Humans have extended their habitat from the African continent to the rest of Sol-3, \"Planet Earth\". \
	Over thousands of years, they had managed to become the lone dominant species of their planet of origin - and refused to stop there. More than five-hundred years ago, \
	Humanity set out to find another Earth, a new start - a planet not polluded by hundreds of years of industrialization, with a healthy, thriving ecosystem, unaffected by millenia of warfare and resource exploitation. \
	-"}

/datum/species/human/create_pref_unique_perks()
	var/list/to_add = list()

	if(CONFIG_GET(number/default_laws) == 0) // Default lawset is set to Asimov
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "robot",
			SPECIES_PERK_NAME = "Asimov Superiority",
			SPECIES_PERK_DESC = "The AI and their cyborgs are, by default, subservient only \
				to humans. As a human, silicons are required to both protect and obey you.",
		))

	if(CONFIG_GET(flag/enforce_human_authority))
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bullhorn",
			SPECIES_PERK_NAME = "Chain of Command",
			SPECIES_PERK_DESC = "Nanotrasen only recognizes humans for command roles, such as Captain.",
		))

	return to_add
