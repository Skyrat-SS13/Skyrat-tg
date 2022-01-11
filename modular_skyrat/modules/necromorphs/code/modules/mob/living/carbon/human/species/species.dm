/datum/species
	//Audio vars
	var/step_volume = 30	//Base volume of ALL footstep sounds for this mob
	var/step_range = -1		//Base volume of ALL footstep sounds for this mob. Each point of range adds or subtracts two tiles from the actual audio distance
	var/step_priority = 0	//Base priority of species-specific footstep sounds. Zero disables them
	var/pain_audio_threshold = 0	//If a mob takes damage equal to this portion of its total health, (and audio files exist), it will scream in pain
	var/list/species_audio = list()	//An associative list of lists, in the format SOUND_TYPE = list(sound_1, sound_2)
		//In addition, the list of sounds supports weighted picking (default weight 1 if unspecified).
		//For example: (sound_1, sound_2 = 0.5) will result in sound_2 being played half as often as sound_1
	var/list/speech_chance                    // The likelihood of a speech sound playing.
	var/list/species_audio_volume = list()		//An associative list, in the format SOUND_TYPE = VOLUME_XXX. Values set here will override the volume of species audio files

/datum/species/proc/setup_defense(var/mob/living/carbon/human/H)

//Species level audio wrappers
//--------------------------------
/datum/species/proc/get_species_audio(var/audio_type)
	var/list/L = species_audio[audio_type]
	return null

/datum/species/proc/play_species_audio(var/atom/source, audio_type, vol as num, vary, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)
	var/soundin = get_species_audio(audio_type)
	if (soundin)
		playsound(source, soundin, vol, vary, extrarange, falloff, is_global, frequency, is_ambiance)
		return TRUE
	return FALSE


// /mob/living/carbon/human/play_species_audio(var/atom/source, audio_type, var/volume = VOLUME_MID, var/vary = TRUE, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)

// 	if (species.species_audio_volume[audio_type])
// 		volume = species.species_audio_volume[audio_type]
// 	return species.play_species_audio(arglist(args.Copy()))

// /mob/proc/get_species_audio()
// 	return

// /mob/living/carbon/human/get_species_audio(var/audio_type)
// 	return species.get_species_audio(arglist(args.Copy()))

/*

// THIS WAS /datum/species/ in Baycode


/datum/species/necromorph

	var/description = ""
	var/long_desc	=	""								 // An entire pageful of information. Generated at runtime from various variables and procs, check the description section below and override those
	var/variant = ""
	var/is_necromorph = TRUE
	var/icon/default_icon

	var/damage_overlays = 'icons/mob/human_races/species/human/damage_overlay.dmi'
	var/damage_mask =     'icons/mob/human_races/species/human/damage_mask.dmi'
	var/blood_mask =      'icons/mob/human_races/species/human/blood_mask.dmi'

	var/icon_template = 'icons/mob/human_races/species/template.dmi' // Used for mob icon generation for non-32x32 species.
	var/pixel_offset_x = 0                    // Used for offsetting large icons.
	var/pixel_offset_y = 0                    // Used for offsetting large icons.

	//Audio vars
	var/step_volume = 30	//Base volume of ALL footstep sounds for this mob
	var/step_range = -1		//Base volume of ALL footstep sounds for this mob. Each point of range adds or subtracts two tiles from the actual audio distance
	var/step_priority = 0	//Base priority of species-specific footstep sounds. Zero disables them
	var/pain_audio_threshold = 0	//If a mob takes damage equal to this portion of its total health, (and audio files exist), it will scream in pain
	var/list/species_audio = list()	//An associative list of lists, in the format SOUND_TYPE = list(sound_1, sound_2)
		//In addition, the list of sounds supports weighted picking (default weight 1 if unspecified).
		//For example: (sound_1, sound_2 = 0.5) will result in sound_2 being played half as often as sound_1
	var/list/speech_chance                    // The likelihood of a speech sound playing.
	var/list/species_audio_volume = list()		//An associative list, in the format SOUND_TYPE = VOLUME_XXX. Values set here will override the volume of species audio files

	// Health and Defense
	var/total_health = 120                   // Point at which the mob will enter crit.
	var/healing_factor	=	0.07				//Base damage healed per organ, per tick
	var/burn_heal_factor = 1				//When healing burns passively, the heal amount is multiplied by this
	var/max_heal_threshold	=	0.6			//Wounds can only autoheal if the damage is less than this * max_damage
	var/wound_remnant_time = 10 MINUTES	//How long fully-healed wounds stay visible before vanishing
	var/limb_health_factor	=	1	//Multiplier on max health of limbs
	var/pain_shock_threshold	=	50	//The mob starts going into shock when total pain reaches this value
	var/stability = 1	//Multiplier on resistance to physical forces. Higher value makes someone harder to knock down with forcegun/etc
	var/lasting_damage_factor = 0	//If nonzero, the mob suffers lasting damage equal to this percentage of all incoming damage

	var/list/locomotion_limbs = list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)	//What limbs does this species use to move? It goes slower when these are missing/broken/splinted
	var/can_vomit = TRUE		//Whether this mob can vomit, added to disable it on necromorphs

	var/obj/effect/decal/cleanable/blood/tracks/move_trail = /obj/effect/decal/cleanable/blood/tracks/footprints // What marks are left when walking

	/*--------------------------
		ORGAN HANDLING
	--------------------------*/


	var/list/has_limbs = list(
		BP_CHEST =  list("path" = /obj/item/organ/external/chest, "height" = new /vector2(1.25,1.65)),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin, "height" = new /vector2(1,1.25)),
		BP_HEAD =   list("path" = /obj/item/organ/external/head, "height" = new /vector2(1.65,1.85)),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm, "height" = new /vector2(0.9,1.60)),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right, "height" = new /vector2(0.9,1.60)),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg, "height" = new /vector2(0.1,1)),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right, "height" = new /vector2(0.1,1)),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand, "height" = new /vector2(0.8,0.9)),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right, "height" = new /vector2(0.8,0.9)),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot, "height" = new /vector2(0,0.1)),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right, "height" = new /vector2(0,0.1))
		)



	var/list/override_limb_types 	// Used for species that only need to change one or two entries in has_limbs.

	//Stores organs that this species will use to defend itself from incoming strikes
	//An associative list of sublists, with the key being a category
	var/list/defensive_limbs = list(UPPERBODY = list(BP_L_ARM, BP_L_HAND, BP_R_ARM, BP_R_HAND), //Arms and hands are used to shield the face and body
	LOWERBODY = list(BP_L_LEG, BP_R_LEG))	//Legs, but not feet, are used to guard the groin

/datum/species/necromorph
	name = "Necromorph"
	name_plural =  "Necromorphs"
	blurb = "Mutated and reanimated corpses, reshaped into horrific new forms by a recombinant extraterrestrial infection. \
	The resulting creatures are extremely aggressive and will attack any uninfected organism on sight."

	var/marker_spawnable = TRUE	//Set this to true to allow the marker to spawn this type of necro. Be sure to unset it on the enhanced version unless desired
	var/preference_settable = TRUE
	biomass = 80	//This var is defined for all species
	var/require_total_biomass = 0	//If set, this can only be spawned when total biomass is above this value
	var/biomass_reclamation	=	1	//The marker recovers cost*reclamation
	var/biomass_reclamation_time	=	8 MINUTES	//How long does it take for all of the reclaimed biomass to return to the marker? This is a pseudo respawn timer
	var/spawn_method = SPAWN_POINT	//What method of spawning from marker should be used? At a point or manual placement? check _defines/necromorph.dm
	var/major_vessel = TRUE	//If true, we can fill this mob from the necroqueue
	var/spawner_spawnable = FALSE	//If true, a nest can be upgraded to autospawn this unit
	var/necroshop_item_type = /datum/necroshop_item //Give this a subtype if you want to have special behaviour for when this necromorph is spawned from the necroshop
	var/global_limit = 0	//0 = no limit
	var/ventcrawl = FALSE //Can this necromorph type ventcrawl?
	var/ventcrawl_time = 4.5 SECONDS
	lasting_damage_factor = 0.2	//Necromorphs take lasting damage based on incoming hits

	var/single_icon = TRUE
	icon_template = 'icons/mob/necromorph/48x48necros.dmi'
	var/icon_normal = "slasher_d"
	icon_lying = "slasher_d_lying"
	var/icon_dead = "slasher_d_dead"

	//Icon details. null out all of these, maybe someday they can be done
	deform 			=   null
	preview_icon 	= 	null
	husk_icon 		=   null
	damage_overlays =   null
	damage_mask 	=   null
	blood_mask 		=   null

	//Biology
	blood_color = COLOR_BLOOD_NECRO
	can_vomit = FALSE

	//Defense
	total_health = 80
	healing_factor = 0	//Necromorphs don't naturally heal, but they will be able to heal through certain situational effects
	limb_health_factor = 0.60	//Limbs easier to cut off
	wound_remnant_time = 0 //No cuts sitting around forever
	burn_mod = 1.3	//Takes more damage from burn attacks
	weaken_mod = 0.75	//Get back up faster
	blood_oxy = FALSE
	reagent_tag = IS_NECROMORPH
	stability = 0.8
	max_heal_threshold	=	1	//The few necros who can regenerate, are not constrained by wound size

	var/list/initial_health_values	//This list is populated once for each species, when a necromorph of that type is created
	//It stores the starting max health values of each limb this necromorph has
	//It is an associative list in the format organ_tag = initial health

	var/torso_damage_mult	=	0.25
	/*
		For the purpose of determining whether or not the necromorph has taken enough damage to be killed:
			Damage to the chest and groin is treated as being multiplied by this,
	*/

	var/dismember_mult = 1.2
	/*
		For the purpose of determining whether or not the necromorph has taken enough damage to be killed:
			A limb which is completely severed counts as its max damage multiplied by this
	*/

	//Audio
	step_volume = 60 //Necromorphs can't wear shoes, so their base footstep volumes are louder
	step_range = 1
	pain_audio_threshold = 0.10
	speech_chance = 100

	has_organ = list(    // which required-organ checks are conducted.
	BP_HEART =    /obj/item/organ/internal/heart/undead,
	BP_LUNGS =    /obj/item/organ/internal/lungs/undead,
	BP_LIVER =    /obj/item/organ/internal/liver/undead,
	BP_KIDNEYS =  /obj/item/organ/internal/kidneys/undead,
	BP_BRAIN =    /obj/item/organ/internal/brain/undead,
	BP_EYES =     /obj/item/organ/internal/eyes
	)

	locomotion_limbs = list(BP_L_LEG, BP_R_LEG)

	has_limbs = list(
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(1,1.65)),
	BP_HEAD =   list("path" = /obj/item/organ/external/head/simple, "height" = new /vector2(1.65,1.85)),
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/simple, "height" = new /vector2(0.8,1.60)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/simple, "height" = new /vector2(0.8,1.60)),
	BP_L_LEG =  list("path" = /obj/item/organ/external/leg/simple, "height" = new /vector2(0,1)),
	BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/simple, "height" = new /vector2(0,1))
	)

	defensive_limbs = list(UPPERBODY = list(BP_L_ARM, BP_R_ARM), //Arms and hands are used to shield the face and body
	LOWERBODY = list(BP_L_LEG, BP_R_LEG))


	//Necromorphs can't grab people or pick things up unless otherwise noted
	grasping_limbs = list()

	organ_substitutions = list(BP_L_HAND = BP_L_ARM,
	BP_R_HAND = BP_R_ARM,
	BP_L_FOOT = BP_L_LEG,
	BP_R_FOOT = BP_R_LEG)


	// Bump vars
	var/bump_flag = HUMAN	// What are we considered to be when bumped? these flags are in defines/mobs.dm
	var/push_flags = ~HEAVY	// What can we push?
	var/swap_flags = ~HEAVY	// What can we swap place with?
	var/density_lying = FALSE	//Is this mob dense while lying down?
	var/opacity = FALSE		//Does this mob block vision?

	var/pass_flags = 0
	var/breathing_sound = 'sound/voice/monkey.ogg'



/datum/species/necromorph/psychosis_vulnerable()
	return FALSE

/datum/species/necromorph/onDestroy(var/mob/living/carbon/human/H)
	SSnecromorph.major_vessels -= H

/datum/species/necromorph/get_icobase(var/mob/living/carbon/human/H)
	return icon_template //We don't need to duplicate the same dmi path twice

/datum/species/necromorph/add_inherent_verbs(mob/living/carbon/human/H)
	.=..()
	add_verb(H, list(/mob/proc/necro_evacuate, /mob/proc/prey_sightings, /datum/proc/help))
	//Ventcrawling necromorphs are handled here. Don't give this to non living mobs...
	if(ventcrawl && isliving(H))
		add_verb(H, list(/mob/living/proc/ventcrawl, /mob/living/proc/necro_burst_vent))
		//And if we want to set a custom ventcrawl delay....
		H.ventcrawl_time = (src.ventcrawl_time) ? src.ventcrawl_time : H.ventcrawl_time
	//H.verbs |= /mob/proc/message_unitologists
	make_scary(H)

/datum/species/necromorph/proc/make_scary(mob/living/carbon/human/H)
	//H.set_traumatic_sight(TRUE) //All necrmorphs are scary. Some are more scary than others though

/datum/species/necromorph/setup_interaction(var/mob/living/carbon/human/H)
	.=..()
	H.set_attack_intent(I_HURT)	//Don't start in help intent, we want to kill things
	H.faction = FACTION_NECROMORPH
	SSnecromorph.major_vessels += H

//Populate the initial health values
/datum/species/necromorph/create_organs(var/mob/living/carbon/human/H)
	.=..()
	if (!initial_health_values)
		initial_health_values = list()
		for (var/organ_tag in H.organs_by_name)
			var/obj/item/organ/external/E	= H.organs_by_name[organ_tag]
			initial_health_values[organ_tag] = E.max_damage

	if (biomass)
		add_massive_atom(H)

//Necromorphs die when they've taken enough total damage to all their limbs.
/datum/species/necromorph/handle_death_check(var/mob/living/carbon/human/H)

	var/damage = get_weighted_total_limb_damage(H)
	if (damage >= H.max_health)
		return TRUE

	return FALSE

/datum/species/necromorph/handle_death(var/mob/living/carbon/human/H)
	//We just died? Lets start getting absorbed by the marker
	if (!SSnecromorph.marker)	//Gotta have one
		return
	if (H.biomass)
		SSnecromorph.marker.add_biomass_source(H, H.biomass*biomass_reclamation, biomass_reclamation_time, /datum/biomass_source/reclaim)
		remove_massive_atom(H)
	SSnecromorph.major_vessels -= H

/datum/species/necromorph/proc/get_weighted_total_limb_damage(var/mob/living/carbon/human/H, var/return_list)
	var/total = 0
	var/blocked = 0
	if (!initial_health_values)
		return 0 //Not populated? welp

	for (var/organ_tag in initial_health_values)
		var/obj/item/organ/external/E	= H.organs_by_name[organ_tag]
		var/subtotal = 0
		if (!E || E.is_stump())
			//Its not here!

			subtotal = initial_health_values[organ_tag] * dismember_mult
			blocked += subtotal
		else
			//Its here
			subtotal = E.damage

			//Is it a torso part?
			if ((E.organ_tag in BP_TORSO))
				subtotal *= torso_damage_mult


		//And now add to total
		total += subtotal

	var/lasting = H.getLastingDamage()
	blocked += lasting
	total += lasting

	if (return_list)
		return list("damage" = total, "blocked" = blocked)

	return total

/datum/species/necromorph/can_autoheal(var/mob/living/carbon/human/H, var/dam_type, var/datum/wound/W)
	if (healing_factor > 0)
		return TRUE
	else
		return FALSE
*/


/mob/proc/play_species_audio()
	return
