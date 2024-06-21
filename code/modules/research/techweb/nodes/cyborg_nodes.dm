/datum/techweb_node/augmentation
	id = "augmentation"
	starting_node = TRUE
	display_name = "Augmentation"
	description = "For those who prefer shiny metal over squishy flesh."
	prereq_ids = list("robotics")
	design_ids = list(
		"borg_chest",
		"borg_head",
		"borg_l_arm",
		"borg_l_leg",
		"borg_r_arm",
		"borg_r_leg",
		"cybernetic_eyes",
		"cybernetic_eyes_moth",
		"cybernetic_ears",
		"cybernetic_lungs",
		"cybernetic_stomach",
		"cybernetic_liver",
		"cybernetic_heart",
	)

/datum/techweb_node/cybernetics
	id = "cybernetics"
	display_name = "Cybernetics"
	description = "Sapient robots with preloaded tool modules and programmable laws."
	prereq_ids = list("augmentation")
	design_ids = list(
		"robocontrol",
		"borgupload",
		"cyborgrecharger",
		"borg_suit",
		"mmi_posi",
		"mmi",
		"mmi_m",
		"advanced_l_arm",
		"advanced_r_arm",
		"advanced_l_leg",
		"advanced_r_leg",
		"borg_upgrade_rename",
		"borg_upgrade_restart",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/borg_service
	id = "borg_service"
	display_name = "Service Cyborg Upgrades"
	description = "Let them do the cookin' by the book."
	prereq_ids = list("cybernetics")
	design_ids = list(
		"borg_upgrade_rolling_table",
		"borg_upgrade_condiment_synthesizer",
		"borg_upgrade_silicon_knife",
		"borg_upgrade_service_apparatus",
		"borg_upgrade_drink_apparatus",
		"borg_upgrade_service_cookbook",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/borg_mining
	id = "borg_mining"
	display_name = "Mining Cyborg Upgrades"
	description = "To mine places too dangerous for humans."
	prereq_ids = list("cybernetics")
	design_ids = list(
		"borg_upgrade_lavaproof",
		"borg_upgrade_holding",
		"borg_upgrade_diamonddrill",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/borg_medical
	id = "borg_medical"
	display_name = "Medical Cyborg Upgrades"
	description = "Let them follow Asimov's First Law."
	prereq_ids = list("borg_service", "surgery_adv")
	design_ids = list(
		"borg_upgrade_pinpointer",
		"borg_upgrade_beakerapp",
		"borg_upgrade_defibrillator",
		"borg_upgrade_expandedsynthesiser",
		"borg_upgrade_piercinghypospray",
		"borg_upgrade_surgicalprocessor",
		"borg_upgrade_surgicalomnitool",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/borg_utility
	id = "borg_utility"
	display_name = "Untility Cyborg Upgrades"
	description = "Let them wipe our floors for us."
	prereq_ids = list("borg_service", "sanitation")
	design_ids = list(
		"borg_upgrade_advancedmop",
		"borg_upgrade_broomer",
		"borg_upgrade_expand",
		"borg_upgrade_prt",
		"borg_upgrade_selfrepair",
		"borg_upgrade_thrusters",
		"borg_upgrade_trashofholding",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/borg_utility/New()
	. = ..()
	if(!CONFIG_GET(flag/disable_secborg))
		design_ids += "borg_upgrade_disablercooler"

/datum/techweb_node/borg_engi
	id = "borg_engi"
	display_name = "Engineering Cyborg Upgrades"
	description = "To slack even more."
	prereq_ids = list("borg_mining", "parts_upg")
	design_ids = list(
		"borg_upgrade_rped",
		"borg_upgrade_engineeringomnitool",
		"borg_upgrade_circuitapp",
		"borg_upgrade_inducer",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

// Implants root node
/datum/techweb_node/passive_implants
	id = "passive_implants"
	display_name = "Passive Implants"
	description = "Implants designed to operate seamlessly without active user input, enhancing various physiological functions or providing continuous benefits."
	prereq_ids = list("augmentation")
	design_ids = list(
		"skill_station",
		"implant_trombone",
		"implant_chem",
		"implant_tracking",
		"implant_exile",
		"implant_beacon",
		"implant_bluespace",
		"implantcase",
		"implanter",
		"locator",
		"c38_trac",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/cyber/cyber_implants
	id = "cyber_implants"
	display_name = "Cybernetic Implants"
	description = "Advanced technological enhancements integrated into the body, offering improved physical capabilities."
	prereq_ids = list("passive_implants", "cybernetics")
	design_ids = list(
		"ci-breather",
		"ci-nutriment",
		"ci-thrusters",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/cyber/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		research_costs[TECHWEB_POINT_TYPE_GENERIC] /= 2

/datum/techweb_node/cyber/combat_implants
	id = "combat_implants"
	display_name = "Combat Implants"
	description = "To make sure that you can wake the f*** up, samurai."
	prereq_ids = list("cyber_implants")
	design_ids = list(
		"ci-reviver",
		"ci-antidrop",
		"ci-antistun",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)

/datum/techweb_node/cyber/integrated_toolsets
	id = "integrated_toolsets"
	display_name = "Integrated Toolsets"
	description = "Decades of contraband smuggling by assistants have led to the development of a full toolbox that fits seamlessly into your arm."
	prereq_ids = list("combat_implants", "exp_tools")
	design_ids = list(
		"ci-nutrimentplus",
		"ci-toolset",
		"ci-surgery",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

/datum/techweb_node/cyber/cyber_organs
	id = "cyber_organs"
	display_name = "Cybernetic Organs"
	description = "We have the technology to rebuild him."
	prereq_ids = list("cybernetics")
	design_ids = list(
		"cybernetic_eyes_improved",
		"cybernetic_eyes_improved_moth",
		"cybernetic_ears_u",
		"cybernetic_lungs_tier2",
		"cybernetic_stomach_tier2",
		"cybernetic_liver_tier2",
		"cybernetic_heart_tier2",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/cyber/cyber_organs_upgraded
	id = "cyber_organs_upgraded"
	display_name = "Upgraded Cybernetic Organs"
	description = "We have the technology to upgrade him."
	prereq_ids = list("cyber_organs")
	design_ids = list(
		"ci-gloweyes",
		"ci-welding",
		"ci-gloweyes-moth",
		"ci-welding-moth",
		"cybernetic_ears_whisper",
		"cybernetic_lungs_tier3",
		"cybernetic_stomach_tier3",
		"cybernetic_liver_tier3",
		"cybernetic_heart_tier3",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	required_experiments = list(/datum/experiment/scanning/people/augmented_organs)

/datum/techweb_node/cyber/cyber_organs_adv
	id = "cyber_organs_adv"
	display_name = "Advanced Cybernetic Organs"
	description = "Cutting-edge cybernetic organs offering enhanced sensory capabilities, making it easier than ever to detect ERP."
	prereq_ids = list("cyber_organs_upgraded", "night_vision")
	design_ids = list(
		"cybernetic_ears_xray",
		"ci-thermals",
		"ci-xray",
		"ci-thermals-moth",
		"ci-xray-moth",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
