
// NEW NODES

/datum/techweb_node/adv_vision
	id = "adv_vision"
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prereq_ids = list("combat_cyber_implants", "alien_bio")
	design_ids = list(
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)

/datum/techweb_node/borg_shapeshifter
	id = "borg_shapeshifter"
	display_name = "Illegal Cyborg Addition"
	description = "Some sort of experimental tool that was once used by an rival company."
	prereq_ids = list("syndicate_basic")
	design_ids = list("borg_shapeshifter_module")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)


// MODULAR ADDITIONS AND REMOVALS

//Base Nodes
/datum/techweb_node/base/New()
	design_ids += list(
		"polarizer",
		"vox_gas_filter",
	)
	return ..()

/datum/techweb_node/cyborg/New()
	design_ids += list(
		"affection_module",
	)
	return ..()

/datum/techweb_node/basic_tools/New()
	design_ids += list(
		"bowl",
		"drinking_glass",
		"shot_glass",
	)
	return ..()

/datum/techweb_node/basic_medical/New()
	design_ids += list(
		"hospital_gown",
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

/datum/techweb_node/adv_biotech/New()
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

/datum/techweb_node/biotech/New()
	design_ids += list(
		"anesthetic_machine",
		"smartdartgun",
	)
	return ..()

/////////////////////////EMP tech/////////////////////////

/datum/techweb_node/emp_basic/New()
	design_ids += list(
		"gownmedicell",
		"bedmedicell",
	)
	return ..()

////////////////////////Computer tech////////////////////////

/datum/techweb_node/comptech/New()
	design_ids += list(
		"time_clock_frame",
	)
	return ..()

/datum/techweb_node/integrated_hud/New()
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

/datum/techweb_node/genetics/New()
	design_ids += list(
		"self_actualization_device",
	)
	return ..()

/datum/techweb_node/cyber_organs/New()
	design_ids += list(
		"cybernetic_tongue",
		"cybernetic_tongue_lizard",
	)
	return ..()

// Modularly removes x-ray and thermals from here, it's in adv_vision instead
/datum/techweb_node/combat_cyber_implants/New()
	. = ..()
	design_ids -= list(
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)

////////////////////////Tools////////////////////////

/datum/techweb_node/botany/New()
	design_ids += list(
		"salvemedicell",
	)
	return ..()

/datum/techweb_node/sec_basic/New()
	. = ..()
	design_ids += list(
		"nifsoft_remover",
	)
	return ..()

/////////////////////////weaponry tech/////////////////////////

/datum/techweb_node/weaponry/New()
	design_ids += list(
		"ammoworkbench_disk_lethal",
	)
	return ..()

/datum/techweb_node/adv_weaponry/New()
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

/datum/techweb_node/alien_bio/New()
	design_ids += list(
		"brute3medicell",
		"burn3medicell",
		"oxy3medicell",
		"toxin3medicell",
	)
	return ..()

/////////////////////////engineering tech/////////////////////////

/datum/techweb_node/adv_engi/New()
	design_ids += list(
		"engine_goggles_prescription",
		"mesons_prescription",
		"multi_cell_charger",
		"tray_goggles_prescription",
		"plumbing_eng",
	)
	return ..()

/////////////////////////robotics tech/////////////////////////

/datum/techweb_node/robotics/New()
	design_ids += list(
		"borg_upgrade_snacks",
		"mini_soulcatcher",
	)
	return ..()

/datum/techweb_node/neural_programming/New()
	design_ids += list(
		"soulcatcher_device",
		"rsd_interface",
	)
	return ..()

/datum/techweb_node/cyborg_upg_util/New()
	design_ids += list(
		"borg_upgrade_clamp",
		"borg_upgrade_brush",
	)
	return ..()

/datum/techweb_node/cyborg_upg_engiminer/New()
	design_ids += list(
		"advanced_materials",
		"inducer_module",
	)
	return ..()

/datum/techweb_node/cyborg_upg_med/New()
	design_ids += list(
		"borg_upgrade_surgicaltools",
	)

	design_ids -= list(
		"borg_upgrade_pinpointer",
	)
	return ..()

/datum/techweb_node/basic_mining/New()
	design_ids += list(
		"borg_upgrade_welding",
	)
	return ..()
