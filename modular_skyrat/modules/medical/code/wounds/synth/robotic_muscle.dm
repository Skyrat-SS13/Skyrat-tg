/datum/wound/muscle/robotic
	sound_effect = 'sound/effects/wounds/crack1.ogg'

/datum/wound_pregen_data/muscle/robotic
	required_limb_biostate = (BIO_ROBOTIC)
	require_any_biostate = FALSE

/datum/wound/muscle/robotic/moderate
	name = "Worn Servo"
	desc = "A servo has been overworked, and will operate with reduced efficiency until rested."
	treat_text = "A tight splint on the affected limb, as well as plenty of rest and sleep."
	examine_desc = "appears to be moving sluggishly"
	occur_text = "jitters for a moment before moving sluggishly"
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.5
	limp_slowdown = 2
	limp_chance = 30
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/muscle/robotic/moderate
	regen_ticks_needed = 90

/datum/wound_pregen_data/muscle/robotic/servo
	abstract = FALSE

	wound_path_to_generate = /datum/wound/muscle/robotic/moderate
	threshold_minimum = 35

/datum/wound/muscle/robotic/severe
	name = "Severed Hydraulic"
	sound_effect = 'sound/effects/wounds/crack2.ogg'
	desc = "A critical hydraulic has been severed, causing complete limb dysfunction."
	treat_text = "A tight splint on the affected limb, as well as plenty of rest and sleep."
	examine_desc = "is totally limp, with hydraulic fluid leaking out"
	occur_text = "sprays out a jet of hydraulic fluid before going totally limp"
	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 5
	limp_chance = 40
	threshold_penalty = 35
	disabling = TRUE
	status_effect_type = /datum/status_effect/wound/muscle/robotic/severe
	regen_ticks_needed = 150

/datum/wound_pregen_data/muscle/robotic/hydraulic
	abstract = FALSE

	wound_path_to_generate = /datum/wound/muscle/robotic/severe
	threshold_minimum = 80

