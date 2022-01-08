/obj/item/organ/external
	name = "external"


	// Strings
	var/broken_description             // fracture string if any.
	var/damage_state = "00"            // Modifier used for generating the on-mob damage overlay for this limb.

	// Damage vars.
	var/brute_dam = 0                  // Actual current brute damage.
	var/brute_ratio = 0                // Ratio of current brute damage to max damage.
	var/burn_dam = 0                   // Actual current burn damage.
	var/burn_ratio = 0                 // Ratio of current burn damage to max damage.
	var/last_dam = -1                  // used in healing/processing calculations.
	var/pain = 0                       // How much the limb hurts.
	var/pain_disability_threshold      // Point at which a limb becomes unusable due to pain.
//	var/defensive_group	= UPPERBODY	   // If set, this dictates which set of limbs will be used in an attempt to shield this bodypart from attack. Should only be set on core parts, not limbs
	var/block_reduction = 3			   // When this limb is used to block a strike, this flat number is subtracted from the damage of the incoming hit


	// Physics
//	var/vector2/limb_height = new /vector2(0,1)	//Height is a range of where the limb extends vertically. The first value is the lower bound, second is the upper
	//Height values assume the mob is in its normal pose standing on the ground
	//All height values are in metres, and also tiles. A turf is 1 metre by 1 metre


	//Retraction handling
	var/retracted	=	FALSE			//	Is this limb retracted into its parent?  If true, the limb is not rendered and all hits are passed to parent
	var/retract_timer					//	A timer handle used for temporary retractions or extensions

	// A bitfield for a collection of limb behavior flags.
//	var/limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_BREAK

	// Appearance vars.
	var/icon_name = null               // Icon state base.
	var/body_part = null               // Part flag
	var/icon_position = 0              // Used in mob overlay layering calculations.
	var/model                          // Used when caching robolimb icons.
	var/force_icon                     // Used to force override of species-specific limb icons (for prosthetics).
	var/icon/mob_icon                  // Cached icon for use in mob overlays.
	var/s_tone                         // Skin tone.
	var/s_base = ""                    // Skin base.
	var/list/s_col                     // skin colour
	var/s_col_blend = ICON_ADD         // How the skin colour is applied.
	var/list/h_col                     // hair colour
	var/body_hair                      // Icon blend for body hair if any.
	var/list/markings = list()         // Markings (body_markings) to apply to the icon
	var/best_direction	=	EAST		//When severed, draw the icon facing in this direction
//	blocksound = 'sound/effects/impacts/block.ogg'

	// Wound and structural data.
	var/wound_update_accuracy = 1      // how often wounds should be updated, a higher number means less often
	var/list/wounds = list()           // wound datum list.
	var/number_wounds = 0              // number of wounds, which is NOT wounds.len!
	var/obj/item/organ/external/parent // Master-limb.
	var/list/children                  // Sub-limbs.
	var/list/internal_organs = list()  // Internal organs of this body part
	var/list/implants = list()         // Currently implanted objects.
	var/base_miss_chance = 0          // Chance of missing.
	var/genetic_degradation = 0
//	biomass = 2	//By default, external organs are worth 2kg of biomass. Hella inaccurate, could find more exact values


	//Forensics stuff
	var/list/autopsy_data = list()    // Trauma data for forensics.

	// Joint/state stuff.
	var/joint = "joint"                // Descriptive string used in dislocation.
	var/amputation_point               // Descriptive string used in amputation.
	var/dislocated = 0                 // If you target a joint, you can dislocate the limb, causing temporary damage to the organ.
	var/encased                        // Needs to be opened with a saw to access the organs.
	var/artery_name = "artery"         // Flavour text for cartoid artery, aorta, etc.
	var/arterial_bleed_severity = 1    // Multiplier for bleeding in a limb.
	var/tendon_name = "tendon"         // Flavour text for Achilles tendon, etc.
	var/cavity_name = "cavity"

	// Surgery vars.
	var/cavity_max_w_class = 0
	var/hatch_state = 0
	var/stage = 0
	var/cavity = 0
	var/atom/movable/applied_pressure
	var/atom/movable/splinted

	// HUD element variable, see organ_icon.dm get_damage_hud_image()
	var/image/hud_damage_image


//Giant limbs
//---------------
//Used by brute, these limbs have 4x the health, and half the evasion values
/obj/item/organ/necromorph/external/head/giant
//	max_damage = 260
//	min_broken_damage = 140
//	base_miss_chance = 10

/obj/item/organ/necromorph/external/chest/giant
//	min_broken_damage = 180
//	limb_flags = ORGAN_FLAG_HEALS_OVERKILL //| ORGAN_FLAG_GENDERED_ICON 	//No gendered icon
//
/obj/item/organ/necromorph/external/groin/giant
//	max_damage = 180
//	min_broken_damage = 90
//
/obj/item/organ/necromorph/external/arm/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 6
//
/obj/item/organ/necromorph/external/arm/right/giant
//	max_damage = 180
//	min_broken_damage = 100
//
/obj/item/organ/necromorph/external/leg/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 4
//
/obj/item/organ/necromorph/external/leg/right/giant
//	max_damage = 180
//	min_broken_damage = 100
//

/obj/item/organ/necromorph/external/foot/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 7.5
//
/obj/item/organ/necromorph/external/foot/right/giant
//	max_damage = 180
//	min_broken_damage = 100

/obj/item/organ/necromorph/external/hand/giant
//	max_damage = 180
//	min_broken_damage = 100
//	base_miss_chance = 7.5

/obj/item/organ/necromorph/external/hand/right/giant
//	max_damage = 180
//	min_broken_damage = 100


///obj/item/organ/necromorph/external/head/ubermorph
//	glowing_eyes = FALSE
//	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_HEALS_OVERKILL
//	var/eye_icon = 'icons/mob/necromorph/ubermorph.dmi'

/* /obj/item/organ/necromorph/external/head/ubermorph/replaced(var/mob/newowner)
	.=..()


	//Lets do a little animation for the eyes lighting up
	var/image/LR = image(eye_icon, newowner, "eyes_anim")
	LR.plane = EFFECTS_ABOVE_LIGHTING_PLANE
	LR.layer = EYE_GLOW_LAYER
	flick_overlay_source(LR, newowner, 3 SECONDS)

	//Activate the actual glow
	spawn(2.7 SECONDS)
		glowing_eyes = TRUE
		eye_icon_location = eye_icon
		owner.update_body(TRUE) */


/obj/item/organ/necromorph/external/head/simple/slasher_enhanced
//	normal_eyes = FALSE
//	glowing_eyes = TRUE
//	eye_icon_location = 'icons/mob/necromorph/slasher_enhanced.dmi'



//Torso Eyes and Brain
//-----------------------
//For mobs without a head, or whose head simply isn't considered a seperate bodypart in technical terms
///obj/item/organ/necromorph/internal/brain/undead/torso
//	parent_organ = BP_CHEST

///obj/item/organ/necromorph/internal/eyes/torso
//	parent_organ = BP_CHEST

///obj/item/organ/brain/necromorph

///obj/item/organ/eyes/necromorph

///obj/item/organ/lungs/necromorph

///obj/item/organ/heart/necromorph

///obj/item/organ/liver/necromorph

///obj/item/organ/tongue/necromorph

/obj/item/organ/tongue/necromorph
	name = "internal vocal sacs"
	desc = "An Strange looking sac."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "tongue"
	taste_sensitivity = 5
	var/static/list/languages_possible_necromorph = typecacheof(list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/machine,
		/datum/language/slime,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/vox,
		/datum/language/dwarf,
		/datum/language/nekomimetic,
//		/datum/language/necromorph,
	))
/obj/item/organ/heart/necromorph
	name = "necromorphian Heart"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "heart"

/obj/item/organ/brain/necromorph
	name = "spongy brain"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "brain2"

/obj/item/organ/eyes/night_vision/necromorph
	name = "undead eyes"
	desc = "Somewhat counterintuitively, these half-rotten eyes actually have superior vision to those of a living human."
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE

/obj/item/organ/lungs/necromorph
	name = "necromorph lungs"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	icon_state = "lungs"
	safe_co2_max = 40

	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BRUTE


	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/liver/necromorph
	name = "necromorph liver"
	icon_state = "liver"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/necromorph_organ.dmi'
	alcohol_tolerance = 5
	toxTolerance = 10 //can shrug off up to 10u of toxins.
	toxLethality = 0.8 * LIVER_DEFAULT_TOX_LETHALITY //20% less damage than a normal liver

/obj/item/organ/external/arm/blade/
	name = "hydraulic pump engine"
	desc = "An electronic device that handles the hydraulic pumps, powering one's robotic limbs."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "l_arm"
//	limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/right
	icon_state = "r_arm"
/obj/item/organ/external/arm/blade/slasher
//	limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/slasher/right
