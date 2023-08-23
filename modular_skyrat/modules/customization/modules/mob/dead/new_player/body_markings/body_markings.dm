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
	///The color the marking defaults to, important for randomisations. either a hex color ie."#FFFFFF" or a define like DEFAULT_PRIMARY
	var/default_color
	///Which bodyparts does the marking affect in BITFLAGS!! (HEAD, CHEST, ARM_LEFT, ARM_RIGHT, HAND_LEFT, HAND_RIGHT, LEG_RIGHT, LEG_LEFT)
	var/affected_bodyparts
	///Which species is this marking recommended to. Important for randomisations.
	var/recommended_species = list(SPECIES_MAMMAL)
	///If this is on the color customization will show up despite the pref settings, it will also cause the marking to not reset colors to match the defaults
	var/always_color_customizable
	///Whether the body marking sprite is the same for both sexes or not. Only relevant for chest right now.
	var/gendered = TRUE

/datum/body_marking/New()
	if(!default_color)
		default_color = "#FFFFFF"

/datum/body_marking/proc/get_default_color(list/features, datum/species/pref_species) //Needs features for the color information
	var/list/colors
	switch(default_color)
		if(DEFAULT_PRIMARY)
			colors = sanitize_hexcolor(features["mcolor"])
		if(DEFAULT_SECONDARY)
			colors = sanitize_hexcolor(features["mcolor2"])
		if(DEFAULT_TERTIARY)
			colors = sanitize_hexcolor(features["mcolor3"])
		if(DEFAULT_SKIN_OR_PRIMARY)
			if(pref_species && !(TRAIT_USES_SKINTONES in pref_species.inherent_traits))
				colors = sanitize_hexcolor(features["skin_color"])
			else
				colors = sanitize_hexcolor(features["mcolor"])
		else
			colors = default_color

	return colors

//Use this one for things with pre-set default colors, I guess
/datum/body_marking/other
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/other_markings.dmi'
	recommended_species = null

/datum/body_marking/other/drake_bone
	name = "Drake Bone"
	icon_state = "drakebone"
	default_color = "#CCCCCC"
	affected_bodyparts = CHEST | HAND_LEFT | HAND_RIGHT
	gendered = FALSE

/datum/body_marking/other/tonage
	name = "Body Tonage"
	icon_state = "tonage"
	default_color = "#555555"
	affected_bodyparts = CHEST
	gendered = FALSE

/datum/body_marking/other/flushed_cheeks
	name = "Flushed Cheeks"
	icon_state = "flushed_cheeks"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/cyclops
	name = "Cyclopean Eye"
	icon_state = "cyclops"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/blank_face
	name = "Blank round face (use with monster mouth)"
	icon_state = "blankface"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/monster_mouth
	name = "Monster Mouth"
	icon_state = "monster"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/nose_blemish
	name = "Nose Blemish"
	icon_state = "nose_blemish"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/brows
	name = "Brows"
	icon_state = "brows"
	affected_bodyparts = HEAD

/datum/body_marking/other/eyeliner
	name = "Eyeliner"
	icon_state = "eyeliner"
	affected_bodyparts = HEAD

/datum/body_marking/other/weight
	name = "Body Weight"
	icon_state = "weight"
	default_color = DEFAULT_PRIMARY
	affected_bodyparts = CHEST

/datum/body_marking/other/pilot
	name = "Pilot"
	icon_state = "pilot"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT

/datum/body_marking/other/pilot_jaw
	name = "Pilot Jaw"
	icon_state = "pilot_jaw"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/drake_eyes
	name = "Drake Eyes"
	icon_state = "drakeeyes"
	default_color = "#FF0000"
	affected_bodyparts = HEAD
	always_color_customizable = TRUE

/datum/body_marking/other/bands
	name = "Color Bands"
	icon_state = "bands"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/other/bands_foot
	name = "Color Bands (Foot)"
	icon_state = "bands_foot"
	affected_bodyparts = LEG_RIGHT | LEG_LEFT

/datum/body_marking/other/anklet
	name = "Anklet"
	icon_state = "anklet"
	affected_bodyparts = LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/secondary_markings.dmi'
	default_color = DEFAULT_SECONDARY

/datum/body_marking/secondary/teshari
	name = "Teshari"
	icon_state = "teshari"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT

/datum/body_marking/secondary/teshari_plain
	name = "Teshari Plain"
	icon_state = "teshari_plain"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/teshari_coat
	name = "Teshari Coat"
	icon_state = "teshari_coat"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/teshari_underfluff
	name = "Teshari Underfluff"
	icon_state = "teshari_underfluff"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/teshari_short
	name = "Teshari Short"
	icon_state = "teshari_short"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/teshari_feathers_male
	name = "Teshari Feathers (Male)"
	icon_state = "teshari_feathers_male"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/teshari_feathers_female
	name = "Teshari Feathers (Female)"
	icon_state = "teshari_feathers_female"
	recommended_species = list(SPECIES_TESHARI)
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

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

/datum/body_marking/secondary/leopard1
	name = "Leopard"
	icon_state = "leopard1"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/leopard2
	name = "Leopard (alt)"
	icon_state = "leopard2"
	affected_bodyparts = CHEST

/datum/body_marking/secondary/skunk
	name = "Skunk"
	icon_state = "skunk"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/panther
	name = "Panther"
	icon_state = "panther"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/tiger
	name = "Tiger Spot"
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

/datum/body_marking/secondary/floof
	name = "Floof"
	icon_state = "floof"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/rat
	name = "Rat Paw"
	icon_state = "rat"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/scolipede
	name = "Scolipede"
	icon_state = "scolipede"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/guilmon
	name = "Guilmon"
	icon_state = "guilmon"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/xeno
	name = "Xeno"
	icon_state = "xeno"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT
	recommended_species = list(SPECIES_XENO)

/datum/body_marking/secondary/datashark
	name = "Datashark"
	icon_state = "datashark"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/belly
	name = "Belly"
	icon_state = "belly"
	affected_bodyparts = CHEST

/datum/body_marking/secondary/bellyslim
	name = "Belly Slim"
	icon_state = "bellyslim"
	affected_bodyparts = HEAD | CHEST | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/bellyslimalt
	name = "Belly Slim Alternative"
	icon_state = "bellyslim_alt"
	affected_bodyparts = CHEST

/datum/body_marking/secondary/bellyandbutt
	name = "Belly and Butt"
	icon_state = "bellyandbutt"
	affected_bodyparts = CHEST

/datum/body_marking/secondary/butt
	name = "Butt"
	icon_state = "butt"
	affected_bodyparts = CHEST

/datum/body_marking/secondary/handsfeet
	name = "Hands Feet"
	icon_state = "handsfeet"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/frog
	name = "Frog"
	icon_state = "frog"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/bee
	name = "Bee"
	icon_state = "bee"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/gradient
	name = "Gradient"
	icon_state = "gradient"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/secondary/harlequin
	name = "Harlequin"
	icon_state = "harlequin"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | HAND_LEFT | LEG_LEFT

/datum/body_marking/secondary/harlequin_reversed
	name = "Harlequin Reversed"
	icon_state = "harlequin_reversed"
	affected_bodyparts = HEAD | CHEST | ARM_RIGHT | HAND_RIGHT | LEG_RIGHT

/datum/body_marking/secondary/plain
	name = "Plain"
	icon_state = "plain"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/tertiary_markings.dmi'
	default_color = DEFAULT_TERTIARY

/datum/body_marking/tertiary/redpanda
	name = "Red Panda Head"
	icon_state = "redpanda"
	affected_bodyparts = HEAD

/datum/body_marking/tertiary/shepherd
	name = "Shepherd Spot"
	icon_state = "shepherd"
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

/datum/body_marking/tertiary/floofer
	name = "Floofer Sock"
	icon_state = "floofer"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT | HAND_LEFT | HAND_RIGHT

/datum/body_marking/tertiary/rat
	name = "Rat Spot"
	icon_state = "rat"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/sloth
	name = "Sloth Head"
	icon_state = "sloth"
	affected_bodyparts = HEAD

/datum/body_marking/tertiary/scolipede
	name = "Scolipede Spikes"
	icon_state = "scolipede"
	affected_bodyparts = CHEST

/datum/body_marking/tertiary/guilmon
	name = "Guilmon Mark"
	icon_state = "guilmon"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tertiary/xeno
	name = "Xeno Head"
	icon_state = "xeno"
	affected_bodyparts = HEAD
	recommended_species = list(SPECIES_XENO)

/datum/body_marking/tertiary/dtiger
	name = "Dark Tiger Body"
	icon_state = "dtiger"
	affected_bodyparts = CHEST

/datum/body_marking/tertiary/ltiger
	name = "Light Tiger Body"
	icon_state = "ltiger"
	affected_bodyparts = CHEST

/datum/body_marking/tertiary/lbelly
	name = "Light Belly"
	icon_state = "lbelly"
	affected_bodyparts = CHEST


/datum/body_marking/tattoo
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/tattoo_markings.dmi'
	recommended_species = null
	default_color = "#112222" //slightly faded ink.
	always_color_customizable = TRUE
	gendered = FALSE

/datum/body_marking/tattoo/heart
	name = "Tattoo - Heart"
	icon_state = "tat_heart"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT

/datum/body_marking/tattoo/heart_groin
	name = "Tattoo - Heart (Groin)"
	icon_state = "tat_heart_groin"
	affected_bodyparts = CHEST

/datum/body_marking/tattoo/hive
	name = "Tattoo - Hive"
	icon_state = "tat_hive"
	affected_bodyparts = CHEST
	gendered = TRUE

/datum/body_marking/tattoo/nightling
	name = "Tattoo - Nightling"
	icon_state = "tat_nightling"
	affected_bodyparts = CHEST

/datum/body_marking/tattoo/circuit
	name = "Tattoo - Circuit"
	icon_state = "tat_campbell"
	affected_bodyparts = ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tattoo/silverburgh //dunno what this is.
	name = "Tattoo - Silverburgh"
	icon_state = "tat_silverburgh"
	affected_bodyparts = LEG_RIGHT | LEG_LEFT

/datum/body_marking/tattoo/tiger
	name = "Tattoo - Tiger"
	icon_state = "tat_tiger"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_RIGHT | LEG_LEFT
	gendered = TRUE

/datum/body_marking/tattoo/tiger_groin
	name = "Tattoo - Tiger (Groin)"
	icon_state = "tat_tiger_groin"
	affected_bodyparts = CHEST

/datum/body_marking/tattoo/tiger_foot
	name = "Tattoo - Tiger (Foot)"
	icon_state = "tat_tiger_foot"
	affected_bodyparts = LEG_RIGHT | LEG_LEFT

/datum/body_marking/tattoo/infinity
	name = "Tattoo - Infinity"
	icon_state = "tat_infinity"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | LEG_RIGHT | LEG_LEFT

/datum/body_marking/tattoo/butterfly
	name = "Tattoo - Butterfly"
	icon_state = "tat_butterfly"
	affected_bodyparts = CHEST
