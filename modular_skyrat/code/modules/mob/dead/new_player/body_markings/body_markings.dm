//This datum is quite close to the sprite accessory one, containing a bit of copy pasta code
//Those DO NOT have a customizable cases for rendering, or any special stuff, and are meant to be simpler than accessories
//One definition can stand for a whole set of accessories, make sure to set affected bodyparts
/datum/body_marking
	///The icon file the body markign is located in
	var/icon
	///The icon_state of the body marking
	var/icon_state
	///The preview name of the body marking. NEEDS A UNIQUE NAME
	var/name
	///How many colors are we using? either USE_ONE_COLOR or USE_MATRIXED_COLORS. Matrixed requires a R/G/B sprite
	var/color_src = USE_ONE_COLOR
	///The color the marking defaults to, important for randomisations. either a hex color ie."FFF" or a define like DEFAULT_PRIMARY
	var/default_color
	///Which bodyparts does the marking affect in BITFLAGS!! (HEAD, CHEST, ARM_LEFT, ARM_RIGHT, HAND_LEFT, HAND_RIGHT, LEG_RIGHT, LEG_LEFT)
	var/affected_bodyparts
	///Which species is this marking recommended to. Important for randomisations.
	var/recommended_species
	///If this is on the color customization will show up despite the pref settings, it will also cause the marking to not reset colors to match the defaults
	var/always_color_customizable

/datum/body_marking/New()
	if(!default_color)
		switch(color_src)
			if(USE_ONE_COLOR)
				default_color = DEFAULT_PRIMARY
			if(USE_MATRIXED_COLORS)
				default_color = DEFAULT_MATRIXED
			else
				default_color = "FFF"

/datum/body_marking/proc/get_default_color(var/list/features, var/datum/species/pref_species) //Needs features for the color information
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
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(pref_species && pref_species.use_skintones)
				colors = list(features["skin_color"])
			else
				colors = list(features["mcolor"])
		else
			colors = list(default_color)

	return colors

/datum/body_marking/secondary
	icon = 'modular_skyrat/icons/mob/body_markings/secondary_markings.dmi'
	default_color = DEFAULT_SECONDARY

/datum/body_marking/secondary/tajaran
	name = "Tajaran"
	icon_state = "tajaran"
	affected_bodyparts = HEAD | CHEST | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/sergal
	name = "Sergal"
	icon_state = "sergal"
	affected_bodyparts = HEAD | CHEST 

/datum/body_marking/secondary/husky
	name = "Husky"
	icon_state = "husky"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT
