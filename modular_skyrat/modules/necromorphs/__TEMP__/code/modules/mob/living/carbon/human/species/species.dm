/*
	Datum-based species. Should make for much cleaner and easier to maintain race code.
*/

/datum/species

	// Descriptors and strings.
	var/name                                             // Species name.
	var/name_plural                                      // Pluralized name (since "[name]s" is not always valid)
	var/long_desc	=	""								 // An entire pageful of information. Generated at runtime from various variables and procs, check the description section below and override those
	var/blurb = "A completely nondescript species."      // A brief lore summary for use in the chargen screen.
	var/cyborg_noun = "Cyborg"

	// Icon/appearance vars.
	var/icobase =      'icons/mob/human_races/species/human/body.dmi'          // Normal icon set.
	var/deform =       'icons/mob/human_races/species/human/deformed_body.dmi' // Mutated icon set.
	var/preview_icon = 'icons/mob/human_races/species/human/preview.dmi'
	var/husk_icon =    'icons/mob/human_races/species/default_husk.dmi'

	var/mob_type = /mob/living/carbon/human	//The mob we spawn in order to create a member of this species instantly
	var/health_doll_offset	= WORLD_ICON_SIZE+8	//For this species, the hud health doll is offset this many pixels to the right.
	//This default value is fine for humans and anything roughly the same width as a human, larger creatures will require different numbers
	//The value required depends not only on overall icon size, but also on the empty space on -both- sides of the sprite. Trial and error is the best way to find the right number

	var/icon/default_icon	//Constructed at runtime, this stores an icon which represents a typical member of this species with all values at default. This is mainly for use in UIs and reference

	//This icon_lying var pulls several duties
	//First, if its non-null, it indicates this species has some kind of special behaviour when lying down. This will trigger extra updates and things
	//Secondly, it is the string suffix added to organ iconstates
	//Thirdly, in single icon mode, it is the icon state for lying down
	var/icon_lying = null
	var/lying_rotation = 90 //How much to rotate the icon when lying down
	var/layer = BASE_HUMAN_LAYER
	var/layer_lying	=	LYING_HUMAN_LAYER

	// Damage overlay and masks.
	var/damage_overlays = 'icons/mob/human_races/species/human/damage_overlay.dmi'
	var/damage_mask =     'icons/mob/human_races/species/human/damage_mask.dmi'
	var/blood_mask =      'icons/mob/human_races/species/human/blood_mask.dmi'


	var/blood_color = COLOR_BLOOD_HUMAN               // Red.
	var/flesh_color = "#ffc896"               // Pink.
	var/blood_oxy = 1
	var/base_color                            // Used by changelings. Should also be used for icon previes..
	var/limb_blend = ICON_ADD
	var/tail                                  // Name of tail state in species effects icon file.
	var/tail_animation                        // If set, the icon to obtain tail animation states from.
	var/tail_blend = ICON_ADD
	var/tail_hair

	var/list/hair_styles
	var/list/facial_hair_styles

	var/organs_icon		//species specific internal organs icons

	var/default_h_style = "Bald"
	var/default_f_style = "Shaved"
	var/default_g_style = "None"

	var/race_key = 0                          // Used for mob icon cache string.
	var/icon_template = 'icons/mob/human_races/species/template.dmi' // Used for mob icon generation for non-32x32 species.
	var/pixel_offset_x = 0                    // Used for offsetting large icons.
	var/pixel_offset_y = 0                    // Used for offsetting large icons.
	var/antaghud_offset_x = 0                 // As above, but specifically for the antagHUD indicator.
	var/antaghud_offset_y = 0                 // As above, but specifically for the antagHUD indicator.

	var/mob_size	= MOB_MEDIUM
	var/strength    = STR_MEDIUM
	var/can_pull_mobs = MOB_PULL_SAME
	var/can_pull_size = ITEM_SIZE_NO_CONTAINER
	var/show_ssd = "fast asleep"
	var/virus_immune
	var/biomass	=	80	//How much biomass does it cost to spawn this (for necros) and how much does it yield when absorbed by a marker
		//This is in kilograms, and is thus approximately the mass of an average human male adult
	var/mass = 80	//Actual mass of the resulting mob




	var/light_sensitive                       // Ditto, but requires sunglasses to fix
	var/blood_volume = SPECIES_BLOOD_DEFAULT  // Initial blood volume.
	var/hunger_factor = DEFAULT_HUNGER_FACTOR // Multiplier for hunger.
	var/taste_sensitivity = TASTE_NORMAL      // How sensitive the species is to minute tastes.

	var/min_age = 17
	var/max_age = 70

	// Language/culture vars.
	var/default_language = LANGUAGE_GALCOM    // Default language is used when 'say' is used without modifiers.
	var/language = LANGUAGE_GALCOM            // Default racial language, if any.
	var/list/secondary_langs = list()         // The names of secondary languages that are available to this species.
	var/assisted_langs = list()               // The languages the species can't speak without an assisted organ.
	var/num_alternate_languages = 0           // How many secondary languages are available to select at character creation
	var/name_language = LANGUAGE_GALCOM       // The language to use when determining names for this species, or null to use the first name/last name generator
	var/additional_langs                      // Any other languages the species always gets.

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


	// Combat vars.
	var/list/unarmed_types = list(           // Possible unarmed attacks that the mob will use in combat,
		/datum/unarmed_attack,
		/datum/unarmed_attack/bite
		)
	var/list/unarmed_attacks = null           // populated at runtime, don't touch
	var/evasion = 10						//Base chance for projectile attacks to miss this mob
	var/modifier_verbs						//A list of key modifiers and procs, in the format Key = list(proc path, priority, arg1, arg2, arg3... etc)
	var/reach = 1	//How many tiles away can this mob grab and hit things. Only partly implemented
	//Any number of extra arguments allowed. Only key and proc path are mandatory. Default priority is 1 and will be used if none is supplied.
	//Key must be one of the KEY_XXX defines in defines/client.dm



	var/list/natural_armour_values            // Armour values used if naked.
	var/brute_mod =      1                    // Physical damage multiplier.
	var/burn_mod =       1                    // Burn damage multiplier.
	var/oxy_mod =        1                    // Oxyloss modifier
	var/toxins_mod =     1                    // Toxloss modifier
	var/radiation_mod =  1                    // Radiation modifier
	var/flash_mod =      1                    // Stun from blindness modifier.
	var/metabolism_mod = 1                    // Reagent metabolism modifier
	var/stun_mod =       1                    // Stun period modifier.
	var/paralysis_mod =  1                    // Paralysis period modifier.
	var/weaken_mod =     1                    // Weaken period modifier.
	var/can_obliterate	=	TRUE			  // If false, this mob won't be deleted when gibbed. Though all their limbs will still be blasted off

	// Death vars.
	var/meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/human
	var/remains_type = /obj/item/remains/xeno
	var/gibbed_anim = "gibbed-h"
	var/dusted_anim = "dust-h"

	var/death_message = "seizes up and falls limp, their eyes dead and lifeless..."
	var/knockout_message = "collapses, having been knocked unconscious."
	var/halloss_message = "slumps over, too weak to continue fighting..."
	var/halloss_message_self = "The pain is too severe for you to keep going..."

	var/limbs_are_nonsolid
	var/spawns_with_stack = 0
	// Environment tolerance/life processes vars.
	var/reagent_tag                                             // Used for metabolizing reagents.
	var/breath_pressure = 16                                    // Minimum partial pressure safe for breathing, kPa
	var/breath_type = "oxygen"                                  // Non-oxygen gas breathed, if any.
	var/poison_types = list(MATERIAL_PHORON = TRUE, "chlorine" = TRUE) // Noticeably poisonous air - ie. updates the toxins indicator on the HUD.
	var/exhale_type = "carbon_dioxide"                          // Exhaled gas type.
	var/max_pressure_diff = 60                                  // Maximum pressure difference that is safe for lungs
	var/cold_level_1 = 243                                      // Cold damage level 1 below this point. -30 Celsium degrees
	var/cold_level_2 = 200                                      // Cold damage level 2 below this point.
	var/cold_level_3 = 120                                      // Cold damage level 3 below this point.
	var/heat_level_1 = 360                                      // Heat damage level 1 above this point.
	var/heat_level_2 = 400                                      // Heat damage level 2 above this point.
	var/heat_level_3 = 1000                                     // Heat damage level 3 above this point.
	var/passive_temp_gain = 0		                            // Species will gain this much temperature every second
	var/hazard_high_pressure = HAZARD_HIGH_PRESSURE             // Dangerously high pressure.
	var/warning_high_pressure = WARNING_HIGH_PRESSURE           // High pressure warning.
	var/warning_low_pressure = WARNING_LOW_PRESSURE             // Low pressure warning.
	var/hazard_low_pressure = HAZARD_LOW_PRESSURE               // Dangerously low pressure.
	var/body_temperature = 310.15	                            // Species will try to stabilize at this temperature.
	                                                            // (also affects temperature processing)
	var/heat_discomfort_level = 315                             // Aesthetic messages about feeling warm.
	var/cold_discomfort_level = 285                             // Aesthetic messages about feeling chilly.
	var/list/heat_discomfort_strings = list(
		"You feel sweat drip down your neck.",
		"You feel uncomfortably warm.",
		"Your skin prickles in the heat."
		)
	var/list/cold_discomfort_strings = list(
		"You feel chilly.",
		"You shiver suddenly.",
		"Your chilly flesh stands out in goosebumps."
		)

	// HUD data vars.
	var/datum/hud_data/hud
	var/hud_type
	var/health_hud_intensity = 1

	var/grab_type = GRAB_NORMAL		// The species' default grab type.

	//Movement
	var/slowdown = 0              // Passive movement speed malus (or boost, if negative)
	// Move intents. Earlier in list == default for that type of movement.
	var/list/move_intents = list(/decl/move_intent/walk, /decl/move_intent/run, /decl/move_intent/stalk)

	var/slow_turning = FALSE		//If true, mob goes on move+click cooldown when rotating in place, and can't turn+move in the same step
	var/list/locomotion_limbs = list(BP_L_LEG, BP_R_LEG, BP_L_FOOT, BP_R_FOOT)	//What limbs does this species use to move? It goes slower when these are missing/broken/splinted
	var/lying_speed_factor = 0.25	//Our speed is multiplied by this when crawling


	//Interaction
	var/limited_click_arc = 0	  //If nonzero, the mob is limited to clicking on things in X degrees arc infront of it. Best combined with slow turning. Recommended values, 45 or 90
	var/list/grasping_limbs = list(BP_R_HAND, BP_L_HAND)	//What limbs does this mob use for interacting with objects?
	var/bodytype	=	null	//Used in get_bodytype which determines what clothes the mob can wear. If null, the species name is used instead


	//Vision
	var/view_offset = 0			  //How far forward the mob's view is offset, in pixels.
	var/view_range = 7		  //Mob's vision radius, in tiles. It gets buggy with values below 7, but anything 7+ is flawless
	var/darksight_range = 2       // Native darksight distance.
	var/darksight_tint = DARKTINT_NONE // How shadows are tinted.
	var/vision_flags = SEE_SELF               // Same flags as glasses.
	var/short_sighted                         // Permanent weldervision.

	// Body/form vars.
	var/list/inherent_verbs 	  // Species-specific verbs.
	var/has_fine_manipulation = 1 // Can use small items.
	var/can_pickup	=	TRUE	  // Can pickup items at all
	var/siemens_coefficient = 1   // The lower, the thicker the skin and better the insulation.
	var/species_flags = 0         // Various specific features.
	var/appearance_flags = 0      // Appearance/display related features.
	var/spawn_flags = 0           // Flags that specify who can spawn as this species
	var/primitive_form            // Lesser form, if any (ie. monkey for humans)
	var/greater_form              // Greater form, if any, ie. human for monkeys.
	var/holder_type
	var/gluttonous                // Can eat some mobs. Values can be GLUT_TINY, GLUT_SMALLER, GLUT_ANYTHING, GLUT_ITEM_TINY, GLUT_ITEM_NORMAL, GLUT_ITEM_ANYTHING, GLUT_PROJECTILE_VOMIT
	var/stomach_capacity = 5      // How much stuff they can stick in their stomach
	var/rarity_value = 1          // Relative rarity/collector value for this species.
	                              // Determines the organs that the species spawns with and

	var/vision_organ              // If set, this organ is required for vision. Defaults to "eyes" if the species has them.
	var/breathing_organ           // If set, this organ is required for breathing. Defaults to "lungs" if the species has them.
	var/can_vomit = TRUE		//Whether this mob can vomit, added to disable it on necromorphs

	var/obj/effect/decal/cleanable/blood/tracks/move_trail = /obj/effect/decal/cleanable/blood/tracks/footprints // What marks are left when walking

	var/list/skin_overlays = list()





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

	// The list for the bioprinter to print based on species
	var/list/bioprint_products = list(
		BP_HEART    = list(/obj/item/organ/internal/heart,      25),
		BP_LUNGS    = list(/obj/item/organ/internal/lungs,      25),
		BP_KIDNEYS  = list(/obj/item/organ/internal/kidneys,    20),
		BP_EYES     = list(/obj/item/organ/internal/eyes,       20),
		BP_LIVER    = list(/obj/item/organ/internal/liver,      25),
		BP_GROIN    = list(/obj/item/organ/external/groin,      80),
		BP_L_ARM    = list(/obj/item/organ/external/arm,        65),
		BP_R_ARM    = list(/obj/item/organ/external/arm/right,  65),
		BP_L_LEG    = list(/obj/item/organ/external/leg,        65),
		BP_R_LEG    = list(/obj/item/organ/external/leg/right,  65),
		BP_L_FOOT   = list(/obj/item/organ/external/foot,       40),
		BP_R_FOOT   = list(/obj/item/organ/external/foot/right, 40),
		BP_L_HAND   = list(/obj/item/organ/external/hand,       40),
		BP_R_HAND   = list(/obj/item/organ/external/hand/right, 40)
		)

	var/list/override_organ_types // Used for species that only need to change one or two entries in has_organ

	var/list/has_organ = list(    // which required-organ checks are conducted.
		BP_HEART =    /obj/item/organ/internal/heart,
		BP_LUNGS =    /obj/item/organ/internal/lungs,
		BP_LIVER =    /obj/item/organ/internal/liver,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys,
		BP_BRAIN =    /obj/item/organ/internal/brain,
		BP_APPENDIX = /obj/item/organ/internal/appendix,
		BP_EYES =     /obj/item/organ/internal/eyes
		)

	//Stores organs that this species will use to defend itself from incoming strikes
	//An associative list of sublists, with the key being a category
	var/list/defensive_limbs = list(UPPERBODY = list(BP_L_ARM, BP_L_HAND, BP_R_ARM, BP_R_HAND), //Arms and hands are used to shield the face and body
	LOWERBODY = list(BP_L_LEG, BP_R_LEG))	//Legs, but not feet, are used to guard the groin

	//Used for species which have alternate organs in place of some default. For example, the leaper which has a tail instead of legs
	//This list should be in the format BP_ORIGINAL_ORGAN_TAG = BP_REPLACEMENT_ORGAN_TAG
	var/list/organ_substitutions = list()

	// The basic skin colours this species uses
	var/list/base_skin_colours

	var/list/genders = list(MALE, FEMALE)

	// Bump vars
	var/bump_flag = HUMAN	// What are we considered to be when bumped? these flags are in defines/mobs.dm
	var/push_flags = ~HEAVY	// What can we push?
	var/swap_flags = ~HEAVY	// What can we swap place with?
	var/density_lying = FALSE	//Is this mob dense while lying down?
	var/opacity = FALSE		//Does this mob block vision?

	var/pass_flags = 0
	var/breathing_sound = 'sound/voice/monkey.ogg'
	var/list/equip_adjust = list()
	var/list/equip_overlays = list()

	var/list/base_auras

	var/sexybits_location	//organ tag where they are located if they can be kicked for increased pain

	var/list/prone_overlay_offset = list(0, 0) // amount to shift overlays when lying
	var/job_skill_buffs = list()				// A list containing jobs (/datum/job), with values the extra points that job recieves.

	var/disarm_cooldown = 0

/*
These are all the things that can be adjusted for equipping stuff and
each one can be in the NORTH, SOUTH, EAST, and WEST direction. Specify
the direction to shift the thing and what direction.

example:
	equip_adjust = list(
		slot_back_str = list(NORTH = list(SOUTH = 12, EAST = 7), EAST = list(SOUTH = 2, WEST = 12))
			)

This would shift back items (backpacks, axes, etc.) when the mob
is facing either north or east.
When the mob faces north the back item icon is shifted 12 pixes down and 7 pixels to the right.
When the mob faces east the back item icon is shifted 2 pixels down and 12 pixels to the left.

The slots that you can use are found in items_clothing.dm and are the inventory slot string ones, so make sure
	you use the _str version of the slot.
*/

/datum/species/New()

	if(hud_type)
		hud = new hud_type()
	else
		hud = new()

	// Modify organ lists if necessary.
	if(islist(override_limb_types))
		for(var/ltag in override_limb_types)
			if (override_limb_types[ltag])
				if (islist(override_limb_types[ltag]))
					has_limbs[ltag] = override_limb_types[ltag]
				else
					has_limbs[ltag] = list("path" = override_limb_types[ltag])
			else
				has_limbs.Remove(ltag)

	if(islist(override_organ_types))
		for(var/ltag in override_organ_types)
			if (override_organ_types[ltag])
				has_organ[ltag] = list("path" = override_organ_types[ltag])
			else
				has_organ.Remove(ltag)

	//If the species has eyes, they are the default vision organ
	if(!vision_organ && has_organ[BP_EYES])
		vision_organ = BP_EYES
	//If the species has lungs, they are the default breathing organ
	if(!breathing_organ && has_organ[BP_LUNGS])
		breathing_organ = BP_LUNGS

	unarmed_attacks = list()
	for(var/u_type in unarmed_types)
		unarmed_attacks += new u_type()




	//Build organ descriptors
	for(var/limb_type in has_limbs)
		var/list/organ_data = has_limbs[limb_type]
		var/obj/item/organ/limb_path = organ_data["path"]
		organ_data["descriptor"] = initial(limb_path.name)



/datum/species/proc/onDestroy(var/mob/living/carbon/human/H)
	return

/*
	Setup Procs:
	Copying over vars to the mob, and doing any initial calculations
*/
/datum/species/proc/setup_defense(var/mob/living/carbon/human/H)
	H.pain_shock_threshold = pain_shock_threshold
	H.max_health = total_health
	H.push_threshold_factor *= stability
	H.knockdown_threshold_factor *= stability
	H.stagger_threshold_factor *= stability

/datum/species/proc/setup_interaction(var/mob/living/carbon/human/H)
	H.limited_click_arc = limited_click_arc
	H.opacity = opacity
	H.reach = reach
	H.set_attack_intent(H.a_intent || initial(H.a_intent) || I_HURT)

/datum/species/proc/setup_movement(var/mob/living/carbon/human/H)
	H.slow_turning = slow_turning
	H.evasion = evasion

/datum/species/proc/setup_vision(var/mob/living/carbon/human/H)
	H.view_offset = view_offset
	H.view_range = view_range

	if (darksight_tint != DARKTINT_NONE)
		H.set_darksight_color(darksight_tint)

		//-1 range is a special value that means fullscreen
		if (darksight_range == -1)
			H.set_darksight_range(view_range)
		else
			H.set_darksight_range(darksight_range)




/datum/species/proc/sanitize_name(var/name)
	return sanitizeName(name)

/datum/species/proc/equip_survival_gear(var/mob/living/carbon/human/H,var/extendedtank = 1)
	var/list/survival_things = list()
	if (extendedtank)
		survival_things += /obj/item/weapon/storage/box/engineer
	else
		survival_things += /obj/item/weapon/storage/box/survival

	H.mass_equip_to_storage(survival_things)

/datum/species/proc/create_organs(var/mob/living/carbon/human/H) //Handles creation of mob organs.

	H.mob_size = mob_size
	H.can_pull_mobs = src.can_pull_mobs
	H.can_pull_size = src.can_pull_size
	H.mass = src.mass
	H.biomass = src.biomass
	for(var/obj/item/organ/organ in H.contents)
		if((organ in H.organs) || (organ in H.internal_organs))
			qdel(organ)

	if(H.organs)                  H.organs.Cut()
	if(H.internal_organs)         H.internal_organs.Cut()
	if(H.organs_by_name)          H.organs_by_name.Cut()
	if(H.internal_organs_by_name) H.internal_organs_by_name.Cut()

	H.organs = list()
	H.internal_organs = list()
	H.organs_by_name = list()
	H.internal_organs_by_name = list()

	for(var/limb_type in has_limbs)
		var/list/organ_data = has_limbs[limb_type]
		var/limb_path = organ_data["path"]
		var/obj/item/organ/O = new limb_path(H)
		O.max_damage *= limb_health_factor
		if (O.organ_tag in locomotion_limbs)
			O.locomotion = TRUE

		//The list may contain height data
		var/vector2/organ_height = organ_data["height"]
		if (organ_height && istype(O, /obj/item/organ/external))
			var/obj/item/organ/external/E = O
			E.limb_height = organ_height.Copy()

	for(var/organ_tag in has_organ)
		var/organ_type = has_organ[organ_tag]
		var/obj/item/organ/O = new organ_type(H)
		if(organ_tag != O.organ_tag)
			warning("[O.type] has a default organ tag \"[O.organ_tag]\" that differs from the species' organ tag \"[organ_tag]\". Updating organ_tag to match.")
			O.organ_tag = organ_tag
		H.internal_organs_by_name[organ_tag] = O

	for(var/name in H.organs_by_name)
		H.organs |= H.organs_by_name[name]

	for(var/name in H.internal_organs_by_name)
		H.internal_organs |= H.internal_organs_by_name[name]

	for(var/obj/item/organ/O in (H.organs|H.internal_organs))
		O.owner = H
		post_organ_rejuvenate(O)

	H.sync_organ_dna()

/datum/species/proc/should_have_organ(var/organ_tag)
	return has_organ[organ_tag]

/datum/species/proc/hug(var/mob/living/carbon/human/H,var/mob/living/target)

	var/t_him = "them"
	switch(target.gender)
		if(MALE)
			t_him = "him"
		if(FEMALE)
			t_him = "her"

	H.visible_message("<span class='notice'>[H] hugs [target] to make [t_him] feel better!</span>", \
					"<span class='notice'>You hug [target] to make [t_him] feel better!</span>")

/datum/species/proc/add_base_auras(var/mob/living/carbon/human/H)
	if(base_auras)
		for(var/type in base_auras)
			H.add_aura(new type(H))

/datum/species/proc/remove_base_auras(var/mob/living/carbon/human/H)
	if(base_auras)
		var/list/bcopy = base_auras.Copy()
		for(var/a in H.auras)
			var/obj/aura/A = a
			if(is_type_in_list(a, bcopy))
				bcopy -= A.type
				H.remove_aura(A)
				qdel(A)

/datum/species/proc/remove_inherent_verbs(mob/living/carbon/human/H)
	if(inherent_verbs)
		remove_verb(H, inherent_verbs)

	if (modifier_verbs)
		for (var/hotkey in modifier_verbs)
			var/list/L = modifier_verbs[hotkey]
			H.remove_modclick_verb(hotkey, L[1])

	remove_verb(H, /mob/living/carbon/human/proc/toggle_darkvision)

/datum/species/proc/add_inherent_verbs(mob/living/carbon/human/H)
	if(inherent_verbs)
		add_verb(H, inherent_verbs)

	if (modifier_verbs)
		for (var/hotkey in modifier_verbs)
			var/list/L = modifier_verbs[hotkey]
			var/list/input_args = list(hotkey, L[1])
			if (L.len >= 2)
				input_args.Add(L[2])
				if (L.len >= 3)
					input_args.Add(list(L.Copy(3)))

			//We use input_args here since we're doing voodoo with passing arguments.
			//Modclick takes key type, function name, function priority, and a list of extra arguments
			H.add_modclick_verb(arglist(input_args))

	if (darksight_tint != DARKTINT_NONE)
		add_verb(H, /mob/living/carbon/human/proc/toggle_darkvision)



/datum/species/proc/handle_post_spawn(var/mob/living/carbon/human/H) //Handles anything not already covered by basic species assignment.
	add_inherent_verbs(H)
	add_base_auras(H)
	H.mob_bump_flag = bump_flag
	H.mob_swap_flags = swap_flags
	H.mob_push_flags = push_flags
	H.pass_flags = pass_flags

/datum/species/proc/handle_pre_spawn(var/mob/living/carbon/human/H)
	return

/datum/species/proc/handle_death(var/mob/living/carbon/human/H) //Handles any species-specific death events (such as dionaea nymph spawns).
	return

/datum/species/proc/handle_death_check(var/mob/living/carbon/human/H)
	return FALSE

/datum/species/proc/handle_new_grab(var/mob/living/carbon/human/H, var/obj/item/grab/G)
	return

// Only used for alien plasma weeds atm, but could be used for Dionaea later.
/datum/species/proc/handle_environment_special(var/mob/living/carbon/human/H)
	return

/datum/species/proc/handle_movement_delay_special(var/mob/living/carbon/human/H)
	return 0

// Used to update alien icons for aliens.
/datum/species/proc/handle_login_special(var/mob/living/carbon/human/H)
	if (H.l_general)
		H.set_darksight_color(darksight_tint)
		//-1 range is a special value that means fullscreen
		if (darksight_range == -1)
			H.set_darksight_range(view_range)
		else
			H.set_darksight_range(darksight_range)
	return

// As above.
/datum/species/proc/handle_logout_special(var/mob/living/carbon/human/H)
	return

// Builds the HUD using species-specific icons and usable slots.
/datum/species/proc/build_hud(var/mob/living/carbon/human/H)
	return

//Used by xenos understanding larvae and dionaea understanding nymphs.
/datum/species/proc/can_understand(var/mob/other)
	return

/datum/species/proc/can_overcome_gravity(var/mob/living/carbon/human/H)
	return FALSE

// Used for any extra behaviour when falling and to see if a species will fall at all.
/datum/species/proc/can_fall(var/mob/living/carbon/human/H)
	return TRUE

// Used to override normal fall behaviour. Use only when the species does fall down a level.
/datum/species/proc/handle_fall_special(var/mob/living/carbon/human/H, var/turf/landing)
	return FALSE

// Called when using the shredding behavior.
/datum/species/proc/can_shred(var/mob/living/carbon/human/H, var/ignore_intent)

	if((!ignore_intent && H.a_intent != I_HURT) || H.pulling_punches)
		return 0

	for(var/datum/unarmed_attack/attack in unarmed_attacks)
		if(!attack.is_usable(H))
			continue
		if(attack.shredding)
			return 1

	return 0

// Called in life() when the mob has no client.
/datum/species/proc/handle_npc(var/mob/living/carbon/human/H)
	return

/datum/species/proc/handle_vision(var/mob/living/carbon/human/H)
	H.update_sight()
	H.set_sight(H.sight|get_vision_flags(H)|H.equipment_vision_flags)




	if(H.stat == DEAD)
		return 1

	if(!H.druggy)
		if(H.equipment_see_invis)
			H.set_see_invisible(min(H.see_invisible, H.equipment_see_invis))

	if(H.equipment_tint_total >= TINT_BLIND)
		H.eye_blind = max(H.eye_blind, 1)

	if(!H.client)//no client, no screen to update
		return 1

	H.set_fullscreen(H.eye_blind && !H.equipment_prescription, "blind", /atom/movable/screen/fullscreen/blind)
	H.set_fullscreen(H.stat == UNCONSCIOUS, "blackout", /atom/movable/screen/fullscreen/blackout)

	if(CONFIG_GET(flag/welder_vision))
		H.set_fullscreen(H.equipment_tint_total, "welder", /atom/movable/screen/fullscreen/impaired, H.equipment_tint_total)
	var/how_nearsighted = get_how_nearsighted(H)
	H.set_fullscreen(how_nearsighted, "nearsighted", /atom/movable/screen/fullscreen/oxy, how_nearsighted)
	H.set_fullscreen(H.eye_blurry, "blurry", /atom/movable/screen/fullscreen/blurry)
	H.set_fullscreen(H.druggy, "high", /atom/movable/screen/fullscreen/high)

	for(var/overlay in H.equipment_overlays)
		H.client.screen |= overlay

	return 1

/datum/species/proc/get_how_nearsighted(var/mob/living/carbon/human/H)
	var/prescriptions = short_sighted
	if(H.disabilities & NEARSIGHTED)
		prescriptions += 7
	if(H.equipment_prescription)
		prescriptions -= H.equipment_prescription

	var/light = light_sensitive
	if(light)
		if(H.eyecheck() > FLASH_PROTECTION_NONE)
			light = 0
		else
			var/turf_brightness = 1
			var/turf/T = get_turf(H)
			if(T && T.lighting_overlay)
				turf_brightness = min(1, T.get_lumcount())
			if(turf_brightness < 0.33)
				light = 0
			else
				light = round(light * turf_brightness)
				if(H.equipment_light_protection)
					light -= H.equipment_light_protection
	return Clamp(max(prescriptions, light), 0, 7)

/datum/species/proc/set_default_hair(var/mob/living/carbon/human/H)
	H.h_style = H.species.default_h_style
	H.f_style = H.species.default_f_style
	H.g_style = H.species.default_g_style
	H.update_hair()

/datum/species/proc/get_blood_name()
	return "blood"



//Mostly for toasters
/datum/species/proc/handle_limbs_setup(var/mob/living/carbon/human/H)
	return FALSE

// Impliments different trails for species depending on if they're wearing shoes.
/datum/species/proc/get_move_trail(var/mob/living/carbon/human/H)
	if( H.shoes || ( H.wear_suit && (H.wear_suit.body_parts_covered & FEET) ) )
		var/obj/item/clothing/shoes = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) ? H.wear_suit : H.shoes // suits take priority over shoes
		return shoes.move_trail
	else
		return move_trail

/datum/species/proc/update_skin(var/mob/living/carbon/human/H)
	return

/datum/species/proc/disarm_attackhand(var/mob/living/carbon/human/attacker, var/mob/living/carbon/human/target)
	attacker.do_attack_animation(target)

	if(target.w_uniform)
		target.w_uniform.add_fingerprint(attacker)
	var/obj/item/organ/external/affecting = target.get_organ(ran_zone(attacker.hud_used.zone_sel.selecting))

	var/list/holding = list(target.get_active_hand() = 40, target.get_inactive_hand() = 20)

	//See if they have any guns that might go off
	for(var/obj/item/weapon/gun/W in holding)
		if(W && prob(holding[W]))
			var/list/turfs = list()
			for(var/turf/T in view())
				turfs += T
			if(turfs.len)
				var/turf/shoot_to = pick(turfs)
				target.visible_message("<span class='danger'>[target]'s [W] goes off during the struggle!</span>")
				return W.afterattack(shoot_to,target)

	var/skill_mod = 10 * attacker.get_skill_difference(SKILL_COMBAT, target)
	var/state_mod = attacker.melee_accuracy_mods() - target.melee_accuracy_mods()

	var/randn = rand(1, 100) - skill_mod + state_mod
	if(!(species_flags & SPECIES_FLAG_NO_SLIP) && randn <= 25)
		var/armor_check = target.run_armor_check(affecting, "melee")
		target.apply_effect(3, WEAKEN, armor_check)
		playsound(target.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
		if(armor_check < 100)
			target.visible_message("<span class='danger'>[attacker] has pushed [target]!</span>")
		else
			target.visible_message("<span class='warning'>[attacker] attempted to push [target]!</span>")
		return

	if(randn <= 60)
		//See about breaking grips or pulls
		if(target.break_all_grabs(attacker))
			playsound(target.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			return

		//Actually disarm them
		for(var/obj/item/I in holding)
			if(I && target.unEquip(I))
				target.visible_message("<span class='danger'>[attacker] has disarmed [target]!</span>")
				playsound(target.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
				return

	playsound(target.loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
	target.visible_message("<span class='danger'>[attacker] attempted to disarm \the [target]!</span>")

/datum/species/proc/disfigure_msg(var/mob/living/carbon/human/H) //Used for determining the message a disfigured face has on examine. To add a unique message, just add this onto a specific species and change the "return" message.
	var/datum/gender/T = gender_datums[H.get_gender()]
	return "<span class='danger'>[T.His] face is horribly mangled!</span>\n"

/datum/species/proc/max_skin_tone()
	if(appearance_flags & HAS_SKIN_TONE_GRAV)
		return 100
	if(appearance_flags & HAS_SKIN_TONE_SPCR)
		return 165
	return 220

/datum/species/proc/get_hair_styles()
	var/list/L = LAZYACCESS(hair_styles, type)
	if(!L)
		L = list()
		LAZYSET(hair_styles, type, L)
		for(var/hairstyle in GLOB.hair_styles_list)
			var/datum/sprite_accessory/S = GLOB.hair_styles_list[hairstyle]
			if(!(get_bodytype() in S.species_allowed))
				continue
			ADD_SORTED(L, hairstyle, /proc/cmp_text_asc)
			L[hairstyle] = S
	return L

/datum/species/proc/get_gradient_styles()
	var/list/L = list()
	L = list()
	for(var/grad in GLOB.hair_gradient_styles_list)
		var/datum/sprite_accessory/S = GLOB.hair_gradient_styles_list[grad]
		if(!(get_bodytype() in S.species_allowed))
			continue
		ADD_SORTED(L, grad, /proc/cmp_text_asc)
		L[grad] = S
	return L

/datum/species/proc/get_facial_hair_styles(var/gender)
	var/list/facial_hair_styles_by_species = LAZYACCESS(facial_hair_styles, type)
	if(!facial_hair_styles_by_species)
		facial_hair_styles_by_species = list()
		LAZYSET(facial_hair_styles, type, facial_hair_styles_by_species)

	var/list/facial_hair_style_by_gender = facial_hair_styles_by_species[gender]
	if(!facial_hair_style_by_gender)
		facial_hair_style_by_gender = list()
		LAZYSET(facial_hair_styles_by_species, gender, facial_hair_style_by_gender)

		for(var/facialhairstyle in GLOB.facial_hair_styles_list)
			var/datum/sprite_accessory/S = GLOB.facial_hair_styles_list[facialhairstyle]
			if(gender == MALE && S.gender == FEMALE)
				continue
			if(gender == FEMALE && S.gender == MALE)
				continue
			if(!(get_bodytype() in S.species_allowed))
				continue
			ADD_SORTED(facial_hair_style_by_gender, facialhairstyle, /proc/cmp_text_asc)
			facial_hair_style_by_gender[facialhairstyle] = S

	return facial_hair_style_by_gender

/datum/species/proc/get_description()
	var/list/damage_types = list(
		"physical trauma" = brute_mod,
		"burns" = burn_mod,
		"lack of air" = oxy_mod,
		"poison" = toxins_mod
	)
	var/dat = list()
	dat += "<center><h2>[name] \[<a href='?src=\ref[src];show_species=1'>change</a>\]</h2></center><hr/>"
	dat += "<table padding='8px'>"
	dat += "<tr>"
	dat += "<td width = 400>[blurb]</td>"
	dat += "<td width = 200 align='center'>"
	if(preview_icon)
		usr << browse_rsc(icon(icon = preview_icon, icon_state = ""), "species_preview_[name].png")
		dat += "<img src='species_preview_[name].png' width='64px' height='64px'><br/><br/>"
	dat += "<b>Language:</b> [language]<br/>"
	dat += "<small>"
	if(spawn_flags & SPECIES_CAN_JOIN)
		dat += "</br><b>Often present among humans.</b>"
	if(spawn_flags & SPECIES_IS_WHITELISTED)
		dat += "</br><b>Whitelist restricted.</b>"
	if(!has_organ[BP_HEART])
		dat += "</br><b>Does not have blood.</b>"
	if(!has_organ[breathing_organ])
		dat += "</br><b>Does not breathe.</b>"
	if(species_flags & SPECIES_FLAG_NO_SCAN)
		dat += "</br><b>Does not have DNA.</b>"
	if(species_flags & SPECIES_FLAG_NO_PAIN)
		dat += "</br><b>Does not feel pain.</b>"
	if(species_flags & SPECIES_FLAG_NO_MINOR_CUT)
		dat += "</br><b>Has thick skin/scales.</b>"
	if(species_flags & SPECIES_FLAG_NO_SLIP)
		dat += "</br><b>Has excellent traction.</b>"
	if(species_flags & SPECIES_FLAG_NO_POISON)
		dat += "</br><b>Immune to most poisons.</b>"
	if(appearance_flags & HAS_A_SKIN_TONE)
		dat += "</br><b>Has a variety of skin tones.</b>"
	if(appearance_flags & HAS_SKIN_COLOR)
		dat += "</br><b>Has a variety of skin colours.</b>"
	if(appearance_flags & HAS_EYE_COLOR)
		dat += "</br><b>Has a variety of eye colours.</b>"
	if(species_flags & SPECIES_FLAG_IS_PLANT)
		dat += "</br><b>Has a plantlike physiology.</b>"
	if(slowdown)
		dat += "</br><b>Moves [slowdown > 0 ? "slower" : "faster"] than most.</b>"
	for(var/kind in damage_types)
		if(damage_types[kind] > 1)
			dat += "</br><b>Vulnerable to [kind].</b>"
		else if(damage_types[kind] < 1)
			dat += "</br><b>Resistant to [kind].</b>"
	dat += "</br><b>They breathe [gas_data.name[breath_type]].</b>"
	dat += "</br><b>They exhale [gas_data.name[exhale_type]].</b>"
	dat += "</br><b>[capitalize(english_list(poison_types))] [LAZYLEN(poison_types) == 1 ? "is" : "are"] poisonous to them.</b>"
	dat += "</small></td>"
	dat += "</tr>"
	dat += "</table><hr/>"
	return jointext(dat, null)

/mob/living/carbon/human/verb/check_species()
	set name = "Check Species Information"
	set category = "IC"
	set src = usr

	show_browser(src, species.get_description(), "window=species;size=700x400")

/datum/species/proc/skills_from_age(age)	//Converts an age into a skill point allocation modifier. Can be used to give skill point bonuses/penalities not depending on job.
	switch(age)
		if(0 to 22) 	. = -4
		if(23 to 30) 	. = 0
		if(31 to 45)	. = 4
		else			. = 8

/datum/species/proc/post_organ_rejuvenate(var/obj/item/organ/org)
	return


/datum/species/proc/get_grasping_limb(var/mob/living/carbon/human/H, var/side)
	//True side means left, false is right
	var/obj/item/organ/external/temp
	if (!side)
		temp = H.organs_by_name[BP_R_HAND]
		if (!temp)//If no hand, maybe there's tentacle arms
			temp = H.organs_by_name[BP_R_ARM]
	else
		temp = H.organs_by_name[BP_L_HAND]
		if (!temp)
			temp = H.organs_by_name[BP_L_ARM]

	if (temp && (temp.limb_flags & ORGAN_FLAG_CAN_GRASP))
		return temp

	return null



//Descriptions and documentation
//----------------------------------------
//These are formatted for display in UI windows

/datum/species/proc/get_long_description()
	if (long_desc)
		return long_desc
	.="<b>Health</b>: [get_healthstring()]<br>"
	.+="<b>Biomass</b>: [biomass]kg<br>"
	.+="<b>Evasion</b>: [evasion]%<br>"
	.+="<b>Movespeed</b>: [get_speed_descriptor()]<br><br>"
	.+= get_blurb()
	.+="<br><hr>"
	.+=	get_unarmed_description()
	.+="<br><br><hr>"
	.+= get_ability_descriptions()
	long_desc = .

//This proc exists to be overridden by ubermorph
/datum/species/proc/get_healthstring()
	return "[total_health]"


//This is an awful means to cope with an awful system. Speed/movement code needs redesigned
/datum/species/proc/get_speed_descriptor()
	switch (slowdown)
		if (-10 to -2)
			return "Very fast"
		if (-2 to 0)
			return "Fast"
		if (0 to 2)
			return "Average"
		if (2 to 4)
			return "Slow"
		if (4 to INFINITY)
			return "Very Slow"

//This is a proc so that enhanced necros can get their parent blurb
/datum/species/proc/get_blurb()
	return blurb

//Shows information for the basic attacks of this species
/datum/species/proc/get_unarmed_description()
	for (var/U in unarmed_types)
		var/datum/unarmed_attack/A = new U
		.+= "<b>Basic Attack</b>: [A.name]<br>"
		.+= "[A.delay ? "<b>Interval</b>: [A.delay * 0.1] seconds" : ""]<br>"
		.+= "<b>Damage</b>: [A.damage]"
		if (A.tags.len)
			.+= ",  [english_list(A.tags)]"
		.+= "<br>"
		.+= A.desc
		return 	//We'll only show description for the primary attack, not any weak fallbacks


/datum/species/proc/get_ability_descriptions()
	return ""

//Should this species be affected by traumatic sights? Necromorphs aren't, for example.

/datum/species/proc/psychosis_vulnerable()
	return TRUE


/*
	Species level damage handling
----------------------------------------

All of the below procs are a species version of a living or human damage proc, passing in all the same vars.
These procs should return their entire args list. Best just to return parent in any overrides, parent will handle it
*/


//Apply_damage
//This is useful for changing damagetypes, tweaking flags, or retargeting the attack to a specific organ
//Note, it is recommended not to override the damage value here, but instead to do that in handle_organ_external_damage.
	//This is because apply_damage will eventually call that anyways for brute/burn damage
	//Plus there are a variety of damage methods (like explosions) which will completely bypass apply_damage, and use organ damage directly
/datum/species/proc/handle_apply_damage(var/mob/user, var/damage, var/damagetype, var/def_zone, var/blocked, var/damage_flags, var/obj/used_weapon, var/obj/item/organ/external/given_organ)
	return args.Copy(2)


//Override damage values here as a one stop catch-all solution
/datum/species/proc/handle_organ_external_damage(var/obj/item/organ/external/organ, brute, burn, damage_flags, used_weapon)
	GLOB.damage_hit_event.raise_event(organ.owner, organ, brute, burn, damage_flags, used_weapon)

	var/mob/living/L = organ.owner
	//Here we'll handle pain audio
	if (pain_audio_threshold)
		var/total_damage = brute+burn
		if (total_damage >= (total_health * pain_audio_threshold))
			if (!L.incapacitated(INCAPACITATION_KNOCKOUT) && L.check_audio_cooldown(SOUND_PAIN)) //Must be conscious to scream
				play_species_audio(L, SOUND_PAIN, 60, 1)
				L.set_audio_cooldown(SOUND_PAIN, 3 SECONDS)

	if (lasting_damage_factor)
		L.adjustLastingDamage((brute+burn) * lasting_damage_factor)
		brute *= (1 - lasting_damage_factor)
		burn *= (1 - lasting_damage_factor)

	return args.Copy(2)

//Does animations for regenerating a limb
/datum/species/proc/regenerate_limb(var/mob/living/carbon/human/H, var/limb, var/duration)
	var/regen_icon = get_icobase()
	var/image/LR = image(regen_icon, H, "[limb]_regen")
	LR.plane = H.plane
	LR.layer = H.layer -0.1 //Slightly below the layer of the mob, so that the healthy limb will draw over it
	flick_overlay(LR, GLOB.clients, duration + 2)


//Can this species defend itself against blows using its limbs?
//This is a proc so it can be overridden for special case behaviour
/datum/species/proc/can_defend(var/mob/living/carbon/human/H, var/datum/strike/strike)
	return !(species_flags & SPECIES_FLAG_NO_BLOCK)
/*
	Called just after a limb is severed
*/
/datum/species/proc/handle_amputated(var/mob/living/carbon/human/H, var/obj/item/organ/external/E, var/clean, var/disintegrate, var/ignore_children, var/silent)
	return

//Ported from upstream bay
/datum/species/proc/check_no_slip(var/mob/living/carbon/human/H)
	if(can_overcome_gravity(H))
		return TRUE
	return (species_flags & SPECIES_FLAG_NO_SLIP)


/datum/species/proc/can_autoheal(var/mob/living/carbon/human/H, var/dam_type, var/datum/wound/W)


	if(dam_type == BRUTE && (H.getBruteLoss() > H.max_health / 2))
		return FALSE
	else if(dam_type == BURN && (H.getFireLoss() > H.max_health / 2))
		return FALSE

	if (W && !W.can_autoheal())
		return FALSE

	return TRUE



//Species level audio wrappers
//--------------------------------
/datum/species/proc/get_species_audio(var/audio_type)
	var/list/L = species_audio[audio_type]
	if (L)
		return pickweight(L)
	return null

/datum/species/proc/play_species_audio(var/atom/source, audio_type, vol as num, vary, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)
	var/soundin = get_species_audio(audio_type)
	if (soundin)
		playsound(source, soundin, vol, vary, extrarange, falloff, is_global, frequency, is_ambiance)
		return TRUE
	return FALSE


/mob/proc/play_species_audio()
	return

/mob/living/carbon/human/play_species_audio(var/atom/source, audio_type, var/volume = VOLUME_MID, var/vary = TRUE, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)

	if (species.species_audio_volume[audio_type])
		volume = species.species_audio_volume[audio_type]
	return species.play_species_audio(arglist(args.Copy()))

/mob/proc/get_species_audio()
	return

/mob/living/carbon/human/get_species_audio(var/audio_type)
	return species.get_species_audio(arglist(args.Copy()))
