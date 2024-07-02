
// NEW NODES

/datum/techweb_node/adv_vision
	id = TECHWEB_NODE_ADVANCED_VISION
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prereq_ids = list(TECHWEB_NODE_COMBAT_IMPLANTS, TECHWEB_NODE_ALIEN_SURGERY)
	design_ids = list(
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/borg_shapeshifter
	id = TECHWEB_NODE_BORG_SHAPESHIFTER
	display_name = "Illegal Cyborg Addition"
	description = "Some sort of experimental tool that was once used by an rival company."
	prereq_ids = list(TECHWEB_NODE_SYNDICATE_BASIC)
	design_ids = list("borg_shapeshifter_module")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/ayy_cyber_implants
	id = TECHWEB_NODE_AYY_CYBER_IMPLANTS
	display_name = "Alien Cybernetic Implants"
	description = "The best in cybernetic implants."
	prereq_ids = list(TECHWEB_NODE_ALIEN_SURGERY, TECHWEB_NODE_ALIEN_ENGI)
	design_ids = list(
		"ci-surgery-alien",
		"ci-toolset-alien",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

// MODULAR ADDITIONS AND REMOVALS

//Base Nodes
/datum/techweb_node/atmos/New()
	design_ids += list(
		"vox_gas_filter",
	)
	return ..()

/datum/techweb_node/construction/New()
	design_ids += list(
		"polarizer",
		"rcd_loaded",
		"rcd_ammo",
	)
	return ..()

/datum/techweb_node/office_equip/New()
	design_ids += list(
		"gbp_machine",
	)
	return ..()

/datum/techweb_node/augmentation/New()
	design_ids += list(
		"affection_module",
		"borg_upgrade_artistic",
	)
	return ..()

/datum/techweb_node/cafeteria_equip/New()
	design_ids += list(
		"bowl",
		"drinking_glass",
		"shot_glass",
	)
	return ..()

/datum/techweb_node/medbay_equip/New()
	design_ids += list(
		"hospital_gown",
		"anesthetic_machine",
		"smartdartgun",
	)
	return ..()

/datum/techweb_node/augmentation/New()
	design_ids += list(
		"synth_eyes",
		"synth_tongue",
		"synth_liver",
		"synth_lungs",
		"synth_stomach",
		"synth_ears",
		"synth_heart",
	)
	return ..()

/////////////////////////Biotech/////////////////////////

/datum/techweb_node/medbay_equip_adv/New()
	design_ids += list(
		"monkey_helmet",
		"brute2medicell",
		"burn2medicell",
		"toxin2medicell",
		"oxy2medicell",
		"relocatemedicell",
		"tempmedicell",
		"bodymedicell",
		"clotmedicell",
	)
	return ..()

/////////////////////////EMP tech/////////////////////////

/datum/techweb_node/energy_manipulation/New()
	design_ids += list(
		"gownmedicell",
		"bedmedicell",
		"tray_goggles_prescription",
	)
	return ..()

////////////////////////Computer tech////////////////////////

/datum/techweb_node/consoles/New()
	design_ids += list(
		"time_clock_frame",
	)
	return ..()

/datum/techweb_node/hud/New()
	design_ids += list(
		"health_hud_prescription",
		"security_hud_prescription",
		"diagnostic_hud_prescription",
		"science_hud_prescription",
		"health_hud_aviator",
		"security_hud_aviator",
		"diagnostic_hud_aviator",
		"meson_hud_aviator",
		"science_hud_aviator",
		"health_hud_projector",
		"security_hud_projector",
		"diagnostic_hud_projector",
		"meson_hud_projector",
		"science_hud_projector",
		"permit_glasses",
		"nifsoft_money_sense",
		"nifsoft_hud_kit",
		"nifsoft_hud_science",
		"nifsoft_hud_meson",
		"nifsoft_hud_medical",
		"nifsoft_hud_security",
		"nifsoft_hud_diagnostic",
		"nifsoft_hud_cargo",
	)
	return ..()

////////////////////////Medical////////////////////////

/datum/techweb_node/cytology/New()
	design_ids += list(
		"self_actualization_device",
	)
	return ..()

/datum/techweb_node/cyber/cyber_organs/New()
	design_ids += list(
		"cybernetic_tongue",
		"cybernetic_tongue_lizard",
	)
	return ..()

// Modularly removes x-ray and thermals from here, it's in adv_vision instead
/datum/techweb_node/cyber/cyber_organs_adv/New()
	design_ids -= list(
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)
	return ..()

////////////////////////Tools////////////////////////

/datum/techweb_node/hydroponics/New()
	design_ids += list(
		"salvemedicell",
	)
	return ..()

/datum/techweb_node/sec_equip/New()
	design_ids += list(
		"nifsoft_remover",
	)
	return ..()

/////////////////////////weaponry tech/////////////////////////

/datum/techweb_node/basic_arms/New()
	design_ids += list(
		"ammoworkbench_disk_lethal",
	)
	return ..()

/datum/techweb_node/riot_supression/New()
	design_ids += list(
		"ammo_workbench",
	)
	return ..()

/datum/techweb_node/electric_weapons/New()
	design_ids += list(
		"medigun_speed",
	)
	return ..()

////////////////////////Alien technology////////////////////////

/datum/techweb_node/alien_surgery/New()
	design_ids += list(
		"brute3medicell",
		"burn3medicell",
		"oxy3medicell",
		"toxin3medicell",
	)
	return ..()

/////////////////////////engineering tech/////////////////////////

/datum/techweb_node/fusion/New()
	design_ids += list(
		"engine_goggles_prescription",
	)
	return ..()

/datum/techweb_node/exp_tools/New()
	design_ids += list(
		"multi_cell_charger",
	)
	return ..()

/datum/techweb_node/plumbing/New()
	design_ids += list(
		"plumbing_eng",
	)
	return ..()

/datum/techweb_node/mining/New()
	design_ids += list(
		"mesons_prescription",
	)
	return ..()

/////////////////////////robotics tech/////////////////////////

/datum/techweb_node/robotics/New()
	design_ids += list(
		"borg_upgrade_snacks",
		"mini_soulcatcher",
	)
	return ..()

/datum/techweb_node/passive_implants/New()
	design_ids += list(
		"soulcatcher_device",
		"rsd_interface",
	)
	return ..()

/datum/techweb_node/borg_utility/New()
	design_ids += list(
		"borg_upgrade_clamp",
		"borg_upgrade_cargo_tele",
		"borg_upgrade_forging",
		"borg_upgrade_brush",
		"borg_upgrade_shrink",
	)
	return ..()

/datum/techweb_node/borg_engi/New()
	design_ids += list(
		"advanced_materials",
		"borg_upgrade_welding",
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	design_ids += list(
		"borg_upgrade_surgicaltools",
	)

	design_ids -= list(
		"borg_upgrade_pinpointer",
	)
	return ..()

/datum/techweb_node/borg_service/New()
	design_ids += list(
		"borg_upgrade_botany"
	)
	return ..()

/datum/techweb_node/borg_mining/New()
	design_ids += list(
		"borg_upgrade_welding",
	)
	return ..()
