/obj/item/organ/external/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_WINGS
	mutantpart_key = "wings"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Bat", MUTANT_INDEX_COLOR_LIST = list("#335533"))
	color_source = ORGAN_COLOR_OVERRIDE
	///Whether the wings should grant flight on insertion.
	var/unconditional_flight
	///What species get flights thanks to those wings. Important for moth wings
	var/list/flight_for_species
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open
	///Whether an openable wing is currently opened
	var/is_open
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight

/obj/item/organ/external/wings/get_global_feature_list()
	return GLOB.sprite_accessories["wings"]

//TODO: Well you know what this flight stuff is a bit complicated and hardcoded, this is enough for now

/obj/item/organ/external/wings/override_color(rgb_value)
	if(mutantpart_key)
		return mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

	return rgb_value

/obj/item/organ/external/wings/moth
	name = "moth wings"
	desc = "A pair of fuzzy moth wings."
	flight_for_species = list(SPECIES_MOTH)

/obj/item/organ/external/wings/flight
	unconditional_flight = TRUE
	can_open = TRUE

/obj/item/organ/external/wings/flight/angel
	name = "angel wings"
	desc = "A pair of magnificent, feathery wings. They look strong enough to lift you up in the air."
	mutantpart_info = list(MUTANT_INDEX_NAME = "Angel", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/external/wings/flight/dragon
	name = "dragon wings"
	desc = "A pair of intimidating, membranous wings. They look strong enough to lift you up in the air."
	mutantpart_info = list(MUTANT_INDEX_NAME = "Dragon", MUTANT_INDEX_COLOR_LIST = list("#880000"))

/obj/item/organ/external/wings/flight/megamoth
	name = "megamoth wings"
	desc = "A pair of horrifyingly large, fuzzy wings. They look strong enough to lift you up in the air."
	mutantpart_info = list(MUTANT_INDEX_NAME = "Megamoth", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
