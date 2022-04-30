/datum/species/vox
	// Bird-like humanoids
	name = "Vox"
	id = SPECIES_VOX
	eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
	say_mod = "skrees"
	default_color = "#00FF00"
	can_augment = FALSE
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutantlungs = /obj/item/organ/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/brain/vox
	breathid = "n2"
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = "Vox Tail",
		"legs" = "Digitigrade Legs",
		"snout" = "Vox Snout",
		"spines" = ACC_RANDOM
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT | FRIED
	payday_modifier = 0.75
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	learnable_languages = list(/datum/language/common, /datum/language/vox, /datum/language/schechi)
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	
		// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)
	
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/vox,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = VOX_HEAD_ICON,
		LOADOUT_ITEM_MASK = VOX_MASK_ICON,
		LOADOUT_ITEM_SUIT = VOX_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = VOX_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  VOX_HANDS_ICON,
		LOADOUT_ITEM_SHOES = VOX_FEET_ICON,
		LOADOUT_ITEM_GLASSES = VOX_EYES_ICON,
		LOADOUT_ITEM_BELT = VOX_BELT_ICON,
		LOADOUT_ITEM_MISC = VOX_BACK_ICON,
		LOADOUT_ITEM_EARS = VOX_EARS_ICON
	)

/datum/species/vox/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	var/datum/outfit/vox/O = new /datum/outfit/vox
	equipping.equipOutfit(O, visuals_only)
	equipping.internal = equipping.get_item_for_held_index(2)
	equipping.update_internals_hud_icon(1)

/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()

	var/randname = vox_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/vox/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	returned["mcolor"] = pick("#77DD88", "#77DDAA", "#77CCDD", "#77DDCC")
	returned["mcolor2"] = pick("#EEDD88", "#EECC88")
	returned["mcolor3"] = pick("#222222", "#44EEFF", "#44FFBB", "#8844FF", "#332233")
	return returned

/datum/species/vox/get_random_body_markings(list/passed_features)
	var/name = pick(list("Vox", "Vox Hive", "Vox Nightling", "Vox Heart", "Vox Tiger"))
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/vox/get_custom_worn_icon(item_slot, obj/item/item)
	// snowflakey but vox legs weird.
	if(item_slot == LOADOUT_ITEM_SHOES)
		var/obj/item/bodypart/leg = bodypart_overrides[BODY_ZONE_L_LEG] || bodypart_overrides[BODY_ZONE_R_LEG]
		if(initial(leg?.limb_id) != "digitigrade")
			// normal legs, force using human shoes
			return item.worn_icon || item.icon

	return item.worn_icon_vox

/datum/species/vox/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_vox = icon

/datum/species/vox/get_species_description()
	return placeholder_description

/datum/species/vox/get_species_lore()
	return list(placeholder_lore)
