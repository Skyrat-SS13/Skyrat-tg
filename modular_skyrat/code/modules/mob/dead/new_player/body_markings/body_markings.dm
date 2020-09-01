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
	affected_bodyparts = HEAD | CHEST //The legs were literally one pixel so I removed them

/datum/body_marking/secondary/sergal
	name = "Sergal"
	icon_state = "sergal"
	affected_bodyparts = HEAD | CHEST 

/datum/body_marking/secondary/husky
	name = "Husky"
	icon_state = "husky"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/fennec
	name = "Fennec"
	icon_state = "fennec"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/redpanda
	name = "Red Panda"
	icon_state = "redpanda"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/dalmatian
	name = "Dalmatian"
	icon_state = "dalmation"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/wolf
	name = "Wolf"
	icon_state = "wolf"
	affected_bodyparts = HEAD | CHEST 

/datum/body_marking/secondary/fox
	name = "Fox"
	icon_state = "fox"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/raccoon
	name = "Raccoon"
	icon_state = "raccoon"
	affected_bodyparts = HEAD | CHEST | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/bovine
	name = "Bovine"
	icon_state = "bovine"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/possum
	name = "Possum"
	icon_state = "possum"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/corgi
	name = "Corgi"
	icon_state = "corgi"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/skunk
	name = "Skunk"
	icon_state = "skunk"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/panther
	name = "Panther"
	icon_state = "panther"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/tiger
	name = "Tiger Spots"
	icon_state = "tiger"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/otter
	name = "Otter"
	icon_state = "otter"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/otie
	name = "Otie"
	icon_state = "otie"
	affected_bodyparts = HEAD | CHEST | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/sabresune
	name = "Sabresune"
	icon_state = "sabresune"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/orca
	name = "Orca"
	icon_state = "orca"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/hawk
	name = "Hawk"
	icon_state = "hawk"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/corvid
	name = "Corvid"
	icon_state = "corvid"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/eevee
	name = "Eevee"
	icon_state = "eevee"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/shark
	name = "Shark"
	icon_state = "shark"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/deer
	name = "Deer"
	icon_state = "deer"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/hyena
	name = "Hyena"
	icon_state = "hyena"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/dog
	name = "Dog"
	icon_state = "dog"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/bat
	name = "Bat"
	icon_state = "bat"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/tertiary
	icon = 'modular_skyrat/icons/mob/body_markings/tertiary_markings.dmi'
	default_color = DEFAULT_TERTIARY

/datum/body_marking/tertiary/redpanda
	name = "Red Panda Head"
	icon_state = "redpanda"
	affected_bodyparts = HEAD

/datum/body_marking/tertiary/shepherd
	name = "Shepherd Spot"
	icon_state = "redpanda"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/tertiary/wolf
	name = "Wolf Spot"
	icon_state = "wolf"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/fox
	name = "Fox Sock"
	icon_state = "fox"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/goat
	name = "Goat Hoof"
	icon_state = "goat"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/raccoon
	name = "Raccoon Spot"
	icon_state = "raccoon"
	affected_bodyparts = HEAD | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/bovine
	name = "Bovine Spot"
	icon_state = "bovine"
	affected_bodyparts = HEAD | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/possum
	name = "Possum Sock"
	icon_state = "possum"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/tiger
	name = "Tiger Stripe"
	icon_state = "tiger"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/otter
	name = "Otter Head"
	icon_state = "otter"
	affected_bodyparts = HEAD

/datum/body_marking/tertiary/otie
	name = "Otie Spot"
	icon_state = "otie"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/hawk
	name = "Hawk Talon"
	icon_state = "hawk"
	affected_bodyparts = LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/corvid
	name = "Corvid Talon"
	icon_state = "corvid"
	affected_bodyparts = LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/deer
	name = "Deer Hoof"
	icon_state = "deer"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/hyena
	name = "Hyena Side"
	icon_state = "hyena"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/tertiary/dog
	name = "Dog Spot"
	icon_state = "dog"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/bat
	name = "Bat Mark"
	icon_state = "bat"
	affected_bodyparts = CHEST
