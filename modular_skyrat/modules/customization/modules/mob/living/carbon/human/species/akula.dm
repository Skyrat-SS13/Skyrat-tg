/// How long the akula will stay wet for, AKA how long their species buff will last without being sustained by h2o
#define DRY_UP_TIME 10 MINUTES

/datum/species/akula
	name = "Akula"
	id = SPECIES_AKULA
	offset_features = list(
		OFFSET_GLASSES = list(0,1),
		OFFSET_EARS = list(0,2),
		OFFSET_FACEMASK = list(0,2),
		OFFSET_HEAD = list(0,1),
		OFFSET_HAIR = list(0,1),
	)
	eyes_icon = 'modular_skyrat/modules/organs/icons/akula_eyes.dmi'
	mutanteyes = /obj/item/organ/internal/eyes/akula
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	outfit_important_for_life = /datum/outfit/akula
	payday_modifier = 0.75
	liked_food = SEAFOOD | RAW
	disliked_food = CLOTH | DAIRY
	toxic_food = TOXIC
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)
	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/akula/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1,4)
	switch(random)
		if(1)
			main_color = "#1CD3E5"
			secondary_color = "#6AF1D6"
			tertiary_color = "#CCF6E2"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = secondary_color
	human_mob.dna.features["mcolor3"] = tertiary_color

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#1CD3E5"
	var/secondary_color = "#6AF1D6"
	var/tertiary_color = "#CCF6E2"
	akula.dna.features["mcolor"] = main_color
	akula.dna.features["mcolor2"] = secondary_color
	akula.dna.features["mcolor3"] = tertiary_color
	akula.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Akula", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	akula.update_mutant_bodyparts(TRUE)
	akula.update_body(TRUE)

/obj/item/organ/internal/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = HAIR_LAYER-0.1

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/akula/get_species_description()
	return placeholder_description

/datum/species/akula/get_species_lore()
	return list(placeholder_lore)

/datum/species/akula/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.akula_outfit)
		equipping.equipOutfit(job.akula_outfit, visuals_only)
	else
		give_important_for_life(equipping)

// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/akula/on_species_gain(mob/living/carbon/akula, datum/species/old_species, pref_load)
	. = ..()
	RegisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), akula)
	// lets give 15 wet_stacks on initial
	akula.set_wet_stacks(15, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/akula/on_species_loss(mob/living/carbon/akula, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/akula/proc/wetted(mob/living/carbon/akula)
	SIGNAL_HANDLER
	if(!akula)
		return
	// Apply the slippery trait if its not there yet
	if(!HAS_TRAIT(akula, TRAIT_SLIPPERY))
		ADD_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)
	// Relieve the negative moodlet
	akula.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), akula), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/akula/proc/dried(mob/living/carbon/akula)
	if(!akula)
		return
	// A -1 moodlet which will not go away until the user gets wet
	akula.add_mood_event("dry_skin", /datum/mood_event/dry_skin)
	REMOVE_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)

/// A simple overwrite which calls parent to listen to wet_stacks
/datum/status_effect/fire_handler/wet_stacks/tick(delta_time)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_SLICK_SKIN) && stacks >= 10)
		SEND_SIGNAL(owner, COMSIG_MOB_TRIGGER_WET_SKIN)

#undef DRY_UP_TIME
