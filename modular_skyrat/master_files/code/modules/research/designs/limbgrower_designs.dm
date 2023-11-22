/datum/design/leftarm/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/rightarm/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/leftleg/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/rightleg/New()
	category += list(SPECIES_SNAIL)
	return ..()

/datum/design/tongue/snail
	name = "Snail Tongue"
	id = "snailtongue"
	build_path = /obj/item/organ/internal/tongue/snail
	category = list(SPECIES_SNAIL, RND_CATEGORY_INITIAL)
