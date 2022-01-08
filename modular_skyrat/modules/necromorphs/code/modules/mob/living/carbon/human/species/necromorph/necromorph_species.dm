/*
	Necromorph Species Base. Parent to all Necromorph Varients.
*/
/datum/species/necromorph
	name = SPECIES_NECROMORPH
	id = SPECIES_NECROMORPH
	sexes = TRUE
	can_have_genitals = FALSE
	default_color = "#FFF"
	var/info_text = "You are a <span class='danger'>Vampire</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	//var/biomass = 100
	limbs_id = "slasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher.dmi'
	eyes_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher_enhanced_eyes.dmi'
	//single_icon
	exotic_blood = /datum/reagent/copper
	reagent_flags = PROCESS_ORGANIC
	always_customizable = FALSE
	nojumpsuit = 1
	flavor_text = "Necromorphs are mutated corpses, reshaped into horrific new forms by a recombinant extraterrestrial infection derived from a genetic code etched into the skin of the Markers. The resulting creatures are extremely aggressive and will attack any uninfected organism on sight. The sole purpose of all Necromorphs is to acquire more bodies to convert and spread the infection. They are believed by some to be the heralds of humanity's ascension, but on a more practical level, they are the extremely dangerous result of exposure to the enigmatic devices known as the Markers."
//	var/info_text = "As an <span class='danger'>Iron Golem</span>, you don't have any special traits."
	//not_digitigrade = TRUE
	//meat = null
	//learnable_languages = list(/datum/language/common, /datum/language/calcic)

	var/list/locomotion_limbs = list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)	//What limbs does this species use to move? It goes slower when these are missing/broken/splinted
	var/can_vomit = TRUE		//Whether this mob can vomit, added to disable it on necromorphs
	var/obj/effect/decal/cleanable/blood/tracks/move_trail = /obj/effect/decal/cleanable/blood/tracks// What marks are left when walking
//	var/breathing_sound = 'sound/voice/monkey.ogg'

	// Damage overlay and masks.
	//	var/damage_overlays = 'icons/mob/human_races/species/human/damage_overlay.dmi'
	//	var/damage_mask =     'icons/mob/human_races/species/human/damage_mask.dmi'
	//	var/blood_mask =      'icons/mob/human_races/species/human/blood_mask.dmi'


	// //Audio vars
	// var/step_volume = 30	//Base volume of ALL footstep sounds for this mob
	// var/step_range = -1		//Base volume of ALL footstep sounds for this mob. Each point of range adds or subtracts two tiles from the actual audio distance
	// var/step_priority = 0	//Base priority of species-specific footstep sounds. Zero disables them
	// var/pain_audio_threshold = 0	//If a mob takes damage equal to this portion of its total health, (and audio files exist), it will scream in pain
	// var/list/species_audio = list()	//An associative list of lists, in the format SOUND_TYPE = list(sound_1, sound_2)
	// 	//In addition, the list of sounds supports weighted picking (default weight 1 if unspecified).
	// 	//For example: (sound_1, sound_2 = 0.5) will result in sound_2 being played half as often as sound_1
	// var/list/speech_chance                    // The likelihood of a speech sound playing.
	// var/list/species_audio_volume = list()		//An associative list, in the format SOUND_TYPE = VOLUME_XXX. Values set here will override the volume of species audio files

	var/list/defensive_limbs = list(UPPERBODY = list(BP_L_ARM, BP_L_HAND, BP_R_ARM, BP_R_HAND), //Arms and hands are used to shield the face and body
	LOWERBODY = list(BP_L_LEG, BP_R_LEG))	//Legs, but not feet, are used to guard the groin

//	var/icon_template = 'icons/mob/human_races/species/template.dmi' // Used for mob icon generation for non-32x32 species.
	var/pixel_offset_x = 0                    // Used for offsetting large icons.
	var/pixel_offset_y = 0                    // Used for offsetting large icons.

/////////////////////////////////////////////////////////////////////////////
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		NO_UNDERWEAR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOMETABOLISM,
		TRAIT_GENELESS,
		TRAIT_TOXIMMUNE,
		TRAIT_OXYIMMUNE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID


/////////////////////////////////////////////////////////////////////////////
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'

	burnmod = 1.5 // Every 0.1% is 10% above the base.
	brutemod = 1.6
	coldmod = 1.2
	heatmod = 2
	siemens_coeff = 1.4 //Not more because some shocks will outright crit you, which is very unfun

	bodytemp_normal = (BODYTEMP_NORMAL + 70)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD
	bodytemp_cold_damage_limit = (T20C - 10)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

/////////////////////////////////////////////////////////////////////////////
////////////////////////// ORGANS FOR ALL SUBTYPES //////////////////////////
/////////////////////////////////////////////////////////////////////////////

	mutant_organs = list(
		/obj/item/organ/brain/necromorph,
		/obj/item/organ/eyes/night_vision/necromorph,
		/obj/item/organ/lungs/necromorph,
		/obj/item/organ/heart/necromorph,
		/obj/item/organ/liver/necromorph,
		/obj/item/organ/tongue/necromorph
	)
	mutanteyes = /obj/item/organ/eyes/night_vision
	mutanttongue = /obj/item/organ/tongue/zombie

	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)


/////////////////////////////////////////////////////////////////////////////

//	limbs_id = "necromorph"

	//Single iconstates. These are somewhat of a hack for unfinished mobs
	// var/single_icon = FALSE
	// var/icon_normal = "slasher_d"
	// var/icon_dead = "slasher_d_dead"
//	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/xeno_parts_greyscale.dmi'
	damage_overlay_type = "xeno"

/////////////////////////////////////////////////////////////////////////////

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph
	)

	mutant_bodyparts = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph
	)
/////////////////////////////////////////////////////////////////////////////


// //Species level audio wrappers
// //--------------------------------
// /datum/species/proc/get_species_audio(var/audio_type)
// 	var/list/L = species_audio[audio_type]
// 	if (L)
// 		return pickweight(L)
// 	return null

// /datum/species/proc/play_species_audio(var/atom/source, audio_type, vol as num, vary, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)
// 	var/soundin = get_species_audio(audio_type)
// 	if (soundin)
// 		playsound(source, soundin, vol, vary, extrarange, falloff, is_global, frequency, is_ambiance)
// 		return TRUE
// 	return FALSE


// /mob/proc/play_species_audio()
// 	return

// /mob/living/carbon/human/play_species_audio(var/atom/source, audio_type, var/volume = VOLUME_MID, var/vary = TRUE, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)

// 	if (species.species_audio_volume[audio_type])
// 		volume = species.species_audio_volume[audio_type]
// 	return species.play_species_audio(arglist(args.Copy()))

// /mob/proc/get_species_audio()
// 	return

// /mob/living/carbon/human/get_species_audio(var/audio_type)
// 	return species.get_species_audio(arglist(args.Copy()))
