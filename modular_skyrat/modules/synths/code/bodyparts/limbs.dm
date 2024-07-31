/*
/ Synthetic Species Limbs.
/ Modularizes the Synth limbs off of the /robot/ limb side to no longer interfere with augments.
/ Ensure Augment list does not populate these, they will not be balanced for indidivual limb gain.
*/


/// Damage to LIMB modifier defines
#define SYNTH_BRUTE_MODIFIER 1.0
#define SYNTH_BURN_MODIFIER 1.0

/// Exmaine text for Synth limb damage
#define SYNTH_LIGHT_BRUTE_MSG "marred"
#define SYNTH_MEDIUM_BRUTE_MSG "dented"
#define SYNTH_HEAVY_BRUTE_MSG "falling apart"

#define SYNTH_LIGHT_BURN_MSG "scorched"
#define SYNTH_MEDIUM_BURN_MSG "charred"
#define SYNTH_HEAVY_BURN_MSG "smoldering"

// Synth bois!
/obj/item/bodypart/head/synth
	name = "android head"
	desc = "A standard base for an androids head, filled with various cameras and sensors with an optional slot for a posi-interface."
	inhand_icon_state = "buildpipe"
	icon_static = BODYPART_ICON_IPC
	icon = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "synth_head"
	is_dimorphic = FALSE
	should_draw_greyscale = TRUE
	icon_greyscale = BODYPART_ICON_IPC
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = NONE
	dmg_overlay_type = "robotic"

	brute_modifier = SYNTH_BRUTE_MODIFIER
	burn_modifier = SYNTH_BURN_MODIFIER

	light_brute_msg = SYNTH_LIGHT_BRUTE_MSG
	medium_brute_msg = SYNTH_MEDIUM_BRUTE_MSG
	heavy_brute_msg = SYNTH_HEAVY_BRUTE_MSG

	light_burn_msg = SYNTH_LIGHT_BURN_MSG
	medium_burn_msg = SYNTH_MEDIUM_BURN_MSG
	heavy_burn_msg = SYNTH_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC)

	damage_examines = list(
		BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT,
		BURN = ROBOTIC_BURN_EXAMINE_TEXT,
	)

	head_flags = HEAD_ALL_FEATURES
	bodypart_flags = BODYPART_UNHUSKABLE

/datum/design/synth_head
	name = "Android Head Base"
	id = "synth_head"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/bodypart/head/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/// Synth Chest, custom EMP effects go here to avoid stacking multiple. If they're alive they'll always have this, the rest go to organs.
// Restrict to Synths only to avoid Mind related issues
/obj/item/bodypart/chest/synth
	name = "android torso"
	desc = "A heavily customized robotic torso designed for androids, an armored core in the center holds their logic core."
	inhand_icon_state = "buildpipe"
	icon_static = BODYPART_ICON_IPC
	icon = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "synth_chest"
	is_dimorphic = FALSE
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = NONE
	dmg_overlay_type = "robotic"

	brute_modifier = SYNTH_BRUTE_MODIFIER
	burn_modifier = SYNTH_BURN_MODIFIER

	light_brute_msg = SYNTH_LIGHT_BRUTE_MSG
	medium_brute_msg = SYNTH_MEDIUM_BRUTE_MSG
	heavy_brute_msg = SYNTH_HEAVY_BRUTE_MSG

	light_burn_msg = SYNTH_LIGHT_BURN_MSG
	medium_burn_msg = SYNTH_MEDIUM_BURN_MSG
	heavy_burn_msg = SYNTH_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC)

	damage_examines = list(
		BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT,
		BURN = ROBOTIC_BURN_EXAMINE_TEXT
	)
	bodypart_flags = BODYPART_UNHUSKABLE

	wing_types = list(
		/obj/item/organ/external/wings/functional/robotic,
	)

/datum/design/synth_chest
	name = "Android Torso Base"
	id = "synth_chest"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.25,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/bodypart/chest/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/bodypart/chest/synth/proc/check_limbs()
	SIGNAL_HANDLER

	var/all_robotic = TRUE
	for(var/obj/item/bodypart/part in owner.bodyparts)
		all_robotic = all_robotic && IS_ROBOTIC_LIMB(part)

	if(all_robotic)
		owner.add_traits(list(
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_RESISTHIGHPRESSURE,
		))
	else
		owner.remove_traits(list(
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_RESISTHIGHPRESSURE,
		))

/// Add: Slowdown, Confusion - Think Watchers Gaze flash
/obj/item/bodypart/chest/synth/emp_effect(severity, protection)
	. = ..()
	if(!. || isnull(owner))
		return

	switch(severity)
		if(EMP_HEAVY)
			owner.set_jitter_if_lower(SYNTH_BAD_EFFECT_DURATION * SYNTH_HEAVY_EMP_MULTIPLIER)
			owner.set_dizzy_if_lower(SYNTH_BAD_EFFECT_DURATION * SYNTH_HEAVY_EMP_MULTIPLIER)
			owner.set_derpspeech_if_lower(SYNTH_BAD_EFFECT_DURATION * SYNTH_HEAVY_EMP_MULTIPLIER)
			owner.set_confusion_if_lower(SYNTH_BAD_EFFECT_DURATION * 0.5)

		if(EMP_LIGHT)
			owner.set_jitter_if_lower(SYNTH_BAD_EFFECT_DURATION)
			owner.set_dizzy_if_lower(SYNTH_BAD_EFFECT_DURATION)
			owner.set_derpspeech_if_lower(SYNTH_BAD_EFFECT_DURATION)
			owner.set_confusion_if_lower(SYNTH_BAD_EFFECT_DURATION * 0.25)


/obj/item/bodypart/arm/left/synth
	name = "android left arm"
	desc = "A custom limb designed for androids, customizable to a degree your wallet agrees with."
	limb_id = SPECIES_SYNTH
	attack_verb_simple = list("slapped", "punched")
	inhand_icon_state = "buildpipe"
	icon_static = BODYPART_ICON_IPC
	icon = BODYPART_ICON_IPC
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "synth_l_arm"
	is_dimorphic = FALSE
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = NONE
	dmg_overlay_type = "robotic"

	brute_modifier = SYNTH_BRUTE_MODIFIER
	burn_modifier = SYNTH_BURN_MODIFIER

	light_brute_msg = SYNTH_LIGHT_BRUTE_MSG
	medium_brute_msg = SYNTH_MEDIUM_BRUTE_MSG
	heavy_brute_msg = SYNTH_HEAVY_BRUTE_MSG

	light_burn_msg = SYNTH_LIGHT_BURN_MSG
	medium_burn_msg = SYNTH_MEDIUM_BURN_MSG
	heavy_burn_msg = SYNTH_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(
		BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT,
		BURN = ROBOTIC_BURN_EXAMINE_TEXT,
	)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE

/datum/design/synth_l_arm
	name = "Android Left Arm Base"
	id = "synth_l_arm"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/bodypart/arm/left/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/bodypart/arm/right/synth
	name = "android right arm"
	desc = "A custom limb designed for androids, customizable to a degree your wallet agrees with."
	attack_verb_simple = list("slapped", "punched")
	inhand_icon_state = "buildpipe"
	icon_static = BODYPART_ICON_IPC
	icon = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "synth_r_arm"
	is_dimorphic = FALSE
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = NONE
	dmg_overlay_type = "robotic"

	brute_modifier = SYNTH_BRUTE_MODIFIER
	burn_modifier = SYNTH_BURN_MODIFIER

	disabling_threshold_percentage = 1

	light_brute_msg = SYNTH_LIGHT_BRUTE_MSG
	medium_brute_msg = SYNTH_MEDIUM_BRUTE_MSG
	heavy_brute_msg = SYNTH_HEAVY_BRUTE_MSG

	light_burn_msg = SYNTH_LIGHT_BURN_MSG
	medium_burn_msg = SYNTH_MEDIUM_BURN_MSG
	heavy_burn_msg = SYNTH_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(
		BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT,
		BURN = ROBOTIC_BURN_EXAMINE_TEXT,
	)
	bodypart_flags = BODYPART_UNHUSKABLE

/datum/design/synth_r_arm
	name = "Android Right Arm Base"
	id = "synth_r_arm"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/bodypart/arm/right/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/bodypart/leg/left/synth
	name = "android left leg"
	desc = "A custom leg designed for androids, customizable to a degree your wallet agrees with."
	attack_verb_simple = list("kicked", "stomped")
	inhand_icon_state = "buildpipe"
	icon_static = BODYPART_ICON_IPC
	icon = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "synth_l_leg"
	is_dimorphic = FALSE
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	digitigrade_type = /obj/item/bodypart/leg/left/synth/digitigrade
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = NONE
	dmg_overlay_type = "robotic"

	brute_modifier = SYNTH_BRUTE_MODIFIER
	burn_modifier = SYNTH_BURN_MODIFIER

	disabling_threshold_percentage = 1

	light_brute_msg = SYNTH_LIGHT_BRUTE_MSG
	medium_brute_msg = SYNTH_MEDIUM_BRUTE_MSG
	heavy_brute_msg = SYNTH_HEAVY_BRUTE_MSG

	light_burn_msg = SYNTH_LIGHT_BURN_MSG
	medium_burn_msg = SYNTH_MEDIUM_BURN_MSG
	heavy_burn_msg = SYNTH_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(
		BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT,
		BURN = ROBOTIC_BURN_EXAMINE_TEXT,
	)
	bodypart_flags = BODYPART_UNHUSKABLE

/datum/design/synth_l_leg
	name = "Android Plantigrade Left Leg Base"
	id = "synth_l_leg"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/bodypart/leg/left/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/bodypart/leg/right/synth
	name = "android right leg"
	desc = "A custom leg designed for androids, customizable to a degree your wallet agrees with."
	attack_verb_simple = list("kicked", "stomped")
	inhand_icon_state = "buildpipe"
	icon_static = BODYPART_ICON_IPC
	icon = BODYPART_ICON_IPC
	limb_id = SPECIES_SYNTH
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "synth_r_leg"
	is_dimorphic = FALSE
	icon_greyscale = BODYPART_ICON_IPC
	should_draw_greyscale = TRUE
	digitigrade_type = /obj/item/bodypart/leg/right/synth/digitigrade
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = NONE
	dmg_overlay_type = "robotic"

	brute_modifier = SYNTH_BRUTE_MODIFIER
	burn_modifier = SYNTH_BURN_MODIFIER

	disabling_threshold_percentage = 1

	light_brute_msg = SYNTH_LIGHT_BRUTE_MSG
	medium_brute_msg = SYNTH_MEDIUM_BRUTE_MSG
	heavy_brute_msg = SYNTH_HEAVY_BRUTE_MSG

	light_burn_msg = SYNTH_LIGHT_BURN_MSG
	medium_burn_msg = SYNTH_MEDIUM_BURN_MSG
	heavy_burn_msg = SYNTH_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(
		BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT,
		BURN = ROBOTIC_BURN_EXAMINE_TEXT,
	)
	bodypart_flags = BODYPART_UNHUSKABLE

/datum/design/synth_r_leg
	name = "Android Plantigrade Right Leg Base"
	id = "synth_r_leg"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/bodypart/leg/right/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/bodypart/leg/left/synth/digitigrade
	icon_greyscale = BODYPART_ICON_SYNTHLIZARD
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/left/synth/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/datum/design/synth_l_d_leg
	name = "Android Digitigrade Left Leg Base"
	id = "synth_l_d_leg"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/bodypart/leg/left/synth/digitigrade
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/obj/item/bodypart/leg/right/synth/digitigrade
	icon_greyscale = BODYPART_ICON_SYNTHLIZARD
	limb_id = BODYPART_ID_DIGITIGRADE
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = BODYPART_ID_DIGITIGRADE

/obj/item/bodypart/leg/right/synth/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/datum/design/synth_r_d_leg
	name = "Android Digitigrade Right Leg Base"
	id = "synth_r_d_leg"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/bodypart/leg/right/synth/digitigrade
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_CHASSIS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

#undef SYNTH_BRUTE_MODIFIER
#undef SYNTH_BURN_MODIFIER

#undef SYNTH_LIGHT_BRUTE_MSG
#undef SYNTH_MEDIUM_BRUTE_MSG
#undef SYNTH_HEAVY_BRUTE_MSG

#undef SYNTH_LIGHT_BURN_MSG
#undef SYNTH_MEDIUM_BURN_MSG
#undef SYNTH_HEAVY_BURN_MSG
