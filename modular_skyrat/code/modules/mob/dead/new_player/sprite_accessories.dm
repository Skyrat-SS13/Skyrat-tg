/datum/sprite_accessory
	///Unique key of an accessroy. All tails should have "tail", ears "ears" etc.
	var/key = null
	///If an accessory is special, it wont get included in the normal accessory lists
	var/special = FALSE
	var/list/recommended_species
	///Which color we default to on acquisition of the accessory (such as switching species, default color for character customization etc)
	///You can also put down a a HEX color, to be used instead as the default
	var/default_color = DEFAULT_PRIMARY

	var/skip_type = /datum/sprite_accessory

	color_src = USE_ONE_COLOR

/datum/sprite_accessory/proc/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/BP)
	return FALSE

/datum/sprite_accessory/proc/get_default_color(var/list/features) //Needs features for the color information
	if(color_src != USE_ONE_COLOR && color_src != USE_MATRIXED_COLORS) //We're not using a custom color key, return white
		message_admins("Default color returning prematurely")
		return list("FFFFFF")
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = list(features["mcolor"])
		if(DEFAULT_SECONDARY)
			colors = list(features["mcolor2"])
		if(DEFAULT_TERTIARY)
			colors = list(features["mcolor3"])
		if(DEFAULT_MATRIXED)
			colors = list(features["mcolor"], features["mcolor2"], features["mcolor3"])
		else
			message_admins("adding default color")
			colors = default_color

	//Someone set up an accessory wrong. Lets do a fallback
	if(color_src == USE_ONE_COLOR && colors.len != 1)
		colors = list("FFFFFF")
	if(color_src == USE_MATRIXED_COLORS && colors.len != 3)
		colors = list("FFFFFF", "FFFFFF", "FFFFFF")
	message_admins("Default color returning a list of [colors.len] length, containing [colors[1]] as its first index")
	return colors

/datum/sprite_accessory/moth_wings
	key = "moth_wings"
	skip_type = /datum/sprite_accessory/moth_wings

/datum/sprite_accessory/moth_wings/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(H.dna.species, H.wear_suit.species_exception))))
		return TRUE
	return FALSE

/datum/sprite_accessory/moth_markings
	key = "moth_markings"
	skip_type = /datum/sprite_accessory/moth_markings

/datum/sprite_accessory/spines
	key = "spines"
	skip_type = /datum/sprite_accessory/spines

/datum/sprite_accessory/spines/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
		return TRUE
	return FALSE

/datum/sprite_accessory/caps
	key = "caps"
	skip_type = /datum/sprite_accessory/caps

/datum/sprite_accessory/frills
	key = "frills"
	skip_type = /datum/sprite_accessory/frills

/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC)
		return TRUE
	return FALSE

/datum/sprite_accessory/horns
	key = "horns"
	skip_type = /datum/sprite_accessory/horns

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
		return TRUE
	return FALSE

/datum/sprite_accessory/ears
	key = "ears"
	skip_type = /datum/sprite_accessory/ears

/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
		return TRUE
	return FALSE

/datum/sprite_accessory/snouts
	key = "snout"
	skip_type = /datum/sprite_accessory/snouts

/datum/sprite_accessory/snouts/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if((H.wear_mask && (H.wear_mask.flags_inv & HIDEFACE)) || (H.head && (H.head.flags_inv & HIDEFACE)) || !HD || HD.status == BODYPART_ROBOTIC)
		return TRUE
	return FALSE

/datum/sprite_accessory/tails
	key = "tail"
	skip_type = /datum/sprite_accessory/tails

/datum/sprite_accessory/tails/lizard
	recommended_species = list("lizard", "ashwalker")

/datum/sprite_accessory/tails/human
	recommended_species = list("human", "felinid")

/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
		return TRUE
	return FALSE

/datum/sprite_accessory/body_markings
	key = "body_markings"
	skip_type = /datum/sprite_accessory/body_markings

/datum/sprite_accessory/legs
	key = "legs"
	skip_type = /datum/sprite_accessory/legs
