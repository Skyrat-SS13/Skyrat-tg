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

/datum/sprite_accessory/proc/can_show(mob/living/carbon/human/H, obj/item/bodypart/BP)
	return TRUE

/datum/sprite_accessory/proc/get_default_color(var/list/features) //Needs features for the color information
	if(color_src != USE_ONE_COLOR && color_src != USE_MATRIXED_COLORS) //We're not using a custom color key, return white
		message_admins("Default color returning prematurely")
		return list("#FFF")
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = list(features[1])
		if(DEFAULT_SECONDARY)
			colors = list(features[2])
		if(DEFAULT_TERTIARY)
			colors = list(features[3])
		if(DEFAULT_MATRIXED)
			colors = list(features[1], features[2], features[3])
		else
			message_admins("adding default color")
			colors = default_color

	//Someone set up an accessory wrong. Lets do a fallback
	if(color_src == USE_ONE_COLOR && colors.len != 1)
		colors = list("#FFF")
	if(color_src == USE_MATRIXED_COLORS && colors.len != 3)
		colors = list("#FFF", "#FFF", "#FFF")
	message_admins("Default color returning a list of [colors.len] length, containing [colors[1]] as its first index")
	return colors

/datum/sprite_accessory/moth_wings
	key = "moth_wings"
	skip_type = /datum/sprite_accessory/moth_wings

/datum/sprite_accessory/moth_markings
	key = "moth_markings"
	skip_type = /datum/sprite_accessory/moth_markings

/datum/sprite_accessory/spines
	key = "spines"
	skip_type = /datum/sprite_accessory/spines

/datum/sprite_accessory/caps
	key = "caps"
	skip_type = /datum/sprite_accessory/caps

/datum/sprite_accessory/frills
	key = "frills"
	skip_type = /datum/sprite_accessory/frills

/datum/sprite_accessory/horns
	key = "horns"
	skip_type = /datum/sprite_accessory/horns

/datum/sprite_accessory/ears
	key = "ears"
	skip_type = /datum/sprite_accessory/ears

/datum/sprite_accessory/snouts
	key = "snout"
	skip_type = /datum/sprite_accessory/snouts

/datum/sprite_accessory/tails
	key = "tail"
	skip_type = /datum/sprite_accessory/tails

/datum/sprite_accessory/body_markings
	key = "body_markings"
	skip_type = /datum/sprite_accessory/body_markings

/datum/sprite_accessory/legs
	key = "legs"
	skip_type = /datum/sprite_accessory/legs
