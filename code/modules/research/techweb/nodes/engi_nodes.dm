// Parts root node
/datum/techweb_node/parts
	id = "parts"
	starting_node = TRUE
	display_name = "Essential Stock Parts"
	description = "Foundational components that form the backbone of station operations, encompassing a range of essential equipment necessary for day-to-day functionality."
	design_ids = list(
		"micro_servo",
		"basic_battery",
		"basic_capacitor",
		"basic_cell",
		"basic_matter_bin",
		"basic_micro_laser",
		"basic_scanning",
		"high_battery",
		"high_cell",
		"miniature_power_cell",
		"condenser",
		"igniter",
		"infrared_emitter",
		"prox_sensor",
		"signaler",
		"timer",
		"voice_analyzer",
		"health_sensor",
		"sflash",
	)

/datum/techweb_node/parts_upg
	id = "parts_upg"
	display_name = "Upgraded Parts"
	description = "Offering enhanced capabilities beyond their basic counterparts."
	prereq_ids = list("parts", "energy_manipulation")
	design_ids = list(
		"rped",
		"high_micro_laser",
		"adv_capacitor",
		"nano_servo",
		"adv_matter_bin",
		"adv_scanning",
		"super_battery",
		"super_cell",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/parts_adv
	id = "parts_adv"
	display_name = "Advanced Parts"
	description = "The most finely tuned and accurate stock parts."
	prereq_ids = list("parts_upg")
	design_ids = list(
		"ultra_micro_laser",
		"super_capacitor",
		"pico_servo",
		"super_matter_bin",
		"phasic_scanning",
		"hyper_battery",
		"hyper_cell",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	required_experiments = list(/datum/experiment/scanning/points/machinery_tiered_scan/tier2_any)


/datum/techweb_node/parts_bluespace
	id = "parts_bluespace"
	display_name = "Bluespace Parts"
	description = "Integrating the latest in bluespace technology, these advanced components not only enhance functionality but also open up new possibilities for the station's technological capabilities."
	prereq_ids = list("parts_adv", "bluespace_travel")
	design_ids = list(
		"bs_rped",
		"quadultra_micro_laser",
		"quadratic_capacitor",
		"femto_servo",
		"bluespace_matter_bin",
		"triphasic_scanning",
		"bluespace_battery",
		"bluespace_cell",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
	discount_experiments = list(/datum/experiment/scanning/points/machinery_tiered_scan/tier3_any = TECHWEB_TIER_4_POINTS)

/datum/techweb_node/telecomms
	id = "telecomms"
	display_name = "Telecommunications Technology"
	description = "A comprehensive suite of machinery for station-wide communication setups, ensuring seamless connectivity and operational coordination."
	prereq_ids = list("parts_bluespace")
	design_ids = list(
		"comm_monitor",
		"comm_server",
		"message_monitor",
		"s_hub",
		"s_messaging",
		"s_server",
		"s_processor",
		"s_relay",
		"s_bus",
		"s_broadcaster",
		"s_receiver",
		"s_amplifier",
		"s_analyzer",
		"s_ansible",
		"s_crystal",
		"s_filter",
		"s_transmitter",
		"s_treatment",
		"gigabeacon",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

// Engineering root node
/datum/techweb_node/construction
	id = "construction"
	starting_node = TRUE
	display_name = "Construction"
	description = "Tools and essential machinery used for station maintenance and expansion."
	design_ids = list(
		"circuit_imprinter_offstation",
		"circuit_imprinter",
		"solarcontrol",
		"solar_panel",
		"solar_tracker",
		"power_control",
		"airalarm_electronics",
		"airlock_board",
		"firealarm_electronics",
		"firelock_board",
		"trapdoor_electronics",
		"blast",
		"tile_sprayer",
		"airlock_painter",
		"decal_painter",
		"rwd",
		"cable_coil",
		"welding_helmet",
		"welding_tool",
		"tscanner",
		"analyzer",
		"multitool",
		"wrench",
		"crowbar",
		"screwdriver",
		"wirecutters",
		"light_bulb",
		"light_tube",
		"intercom_frame",
		"newscaster_frame",
		"status_display_frame",
		"circuit",
		"circuitgreen",
		"circuitred",
		"tram_floor_dark",
		"tram_floor_light",
		"tram_controller",
		"tram_display",
		"crossing_signal",
		"guideway_sensor",
	)

/datum/techweb_node/energy_manipulation
	id = "energy_manipulation"
	display_name = "Energy Manipulation"
	description = "Harnessing the raw power of lightning arcs through sophisticated energy control methods."
	prereq_ids = list("construction")
	design_ids = list(
		"apc_control",
		"powermonitor",
		"smes",
		"emitter",
		"grounding_rod",
		"tesla_coil",
		"cell_charger",
		"recharger",
		"inducer",
		"inducerengi",
		"welding_goggles",
		"tray_goggles",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/holographics
	id = "holographics"
	display_name = "Holographics"
	description = "Use of holographic technology for signage and barriers."
	prereq_ids = list("energy_manipulation")
	design_ids = list(
		"forcefield_projector",
		"holosign",
		"holosignsec",
		"holosignengi",
		"holosignatmos",
		"holosignrestaurant",
		"holosignbar",
		"holobarrier_jani",
		"holobarrier_med",
		"holopad",
		"vendatray",
		"holodisk",
		"modular_shield_generator",
		"modular_shield_node",
		"modular_shield_relay",
		"modular_shield_charger",
		"modular_shield_well",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/hud
	id = "hud"
	display_name = "Integrated HUDs"
	description = "Initially developed for assistants to learn the nuances of different professions through augmented reality."
	prereq_ids = list("holographics", "cyber_implants")
	design_ids = list(
		"health_hud",
		"diagnostic_hud",
		"security_hud",
		"mod_visor_medhud",
		"mod_visor_diaghud",
		"mod_visor_sechud",
		"ci-medhud",
		"ci-diaghud",
		"ci-sechud",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/night_vision
	id = "night_vision"
	display_name = "Night Vision Technology"
	description = "There are whispers that Nanotrasen pushed for this technology to extend shift durations, ensuring productivity around the clock."
	prereq_ids = list("hud")
	design_ids = list(
		"diagnostic_hud_night",
		"health_hud_night",
		"night_visision_goggles",
		"nvgmesons",
		"nv_scigoggles",
		"security_hud_night",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)
