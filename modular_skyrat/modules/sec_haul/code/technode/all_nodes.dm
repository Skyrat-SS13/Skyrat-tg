// RESEARCH NODES
//Weaponry Research

/datum/techweb_node/magazineresearch
	id = "storedmunition_tech"
	display_name = "Ballisitic Research"
	description = "In the wake of the NRI Border Conflict, there was a drive to advances our armament, learn how sol does it."
	prereq_ids = list("exotic_ammo")
	design_ids = list(
		"sol40_riflstandardemag",
		"solgrenade_extmag",
		"sol35_shortextmag",
		"ca_flech",
		"ca_flechmagnesium",
		"s12g_slug",
		"s12c_antitide",
		"s12g_buckshot"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/magazineresearch_romfed
	id = "storedmunition_tech_two"
	display_name = "Advanced Ballistic Research"
	description = "Catching up to the modern world in technological advancement, our enemies are everywhere and they are durable."
	prereq_ids = list("explosives","storedmunition_tech")
	design_ids = list(
		"sol_rifle_carbine_gun",
		"s12g_flechette",
		"s12g_db"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

/datum/techweb_node/basic_arms/New()
	design_ids += "sol35_shortmag"
	design_ids += "c10mm_r"
	design_ids += "c10mm_rihdf"
	design_ids += "s12c_fslug"
	design_ids += "ammoworkbench_disk_lethal"
	design_ids += "ammo_workbench"
	design_ids += "s12g_huntingslug"

/datum/techweb_node/magazineresearch_heavy
	id = "storedmunition_tech_three"
	display_name = "Romulus Technology"
	description = "The same technology used in the Sol 2351 Campaign.It is highly classified and resource intensive."
	prereq_ids = list("syndicate_basic","storedmunition_tech_two")
	design_ids = list(
		"sol40_rifldrummag",
		"m9mm_mag_ext_hp",
		"m9mm_mag_ext",
		"m9mm_mag_ext_b",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)

/datum/techweb_node/sec_equip/New()
	design_ids += "m45_mag"
	design_ids += "s12g_rubber"
	design_ids += "s12g_bslug"
	design_ids += "c457_casing"
	design_ids += "sol40_riflemag"
	design_ids += "m9mm_mag_rubber"
	design_ids += "c10mm_rl"
	. = ..()

/datum/techweb_node/riot_supression/New()
	design_ids += "s12g_hornet"
	design_ids += "s12g_br"
	design_ids += "m9mm_mag_ihdf"
	design_ids += "ca_flechballpoint"
	design_ids += "m9mm_mag"
	design_ids += "c10mm_rincin"
	design_ids += "s12g_antitide"
	. = ..()

/datum/techweb_node/exotic_ammo/New()
	design_ids += "s12g_incinslug"
	design_ids += "ca_flechripper"
	design_ids += "sol_bolt_to_rifle"
	design_ids += "c10mm_rhp"
	design_ids += "c10mm_rap"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	design_ids += "s12g_magnum"
	design_ids += "s12g_express"
	design_ids += "s12g_ion"
	. = ..()

/datum/techweb_node/electric_weapons/New()
	design_ids += "s12g_laser"
	. = ..()
