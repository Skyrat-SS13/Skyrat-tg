// RESEARCH NODES
//Weaponry Research

/datum/techweb_node/magazineresearch
	id = "storedmunition_tech"
	display_name = "Military Grade Munition Research"
	description = "In the wake of the NRI Border Conflict, there was a drive to advances our armament, learn how sol does it."
	prereq_ids = list("exotic_ammo")
	design_ids = list(
		"s12g_slug",
		"sol40_riflstandardemag",
		"solgrenade_extmag",
		"sol40_riflemag"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/magazineresearch_romfed
	id = "storedmunition_tech_two"
	display_name = "Romulus Technology Research"
	description = "Romulus is a major Industrial powerhouse in the outerrim, but they also faced logistical difficulties, learn how they lasted."
	prereq_ids = list("explosives","storedmunition_tech")
	design_ids = list(
		"sol_rifle_carbine_gun",
		"s12g_flechette",
		"s12g_db",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)

/datum/techweb_node/basic_arms/New()
	design_ids += "sol35_shortextmag"

/datum/techweb_node/magazineresearch_heavy
	id = "storedmunition_tech_three"
	display_name = "Hostile Environment Risk Control Weaponry Research"
	description = "The same technology used in the Sol 2351 Campaign, Highly classified."
	prereq_ids = list("syndicate_basic","storedmunition_tech_two")
	design_ids = list(
		"sol40_rifldrummag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 25000)  //Unreasonably expensive and locked behind multiple tier of research, you can have abit of powercreep as a treat

/datum/techweb_node/sec_equip/New()
	design_ids += "sol35_shortmag"
	design_ids += "m45_mag"
	design_ids += "s12g_hornet"
	design_ids += "s12g_rubber"
	design_ids += "s12g_bslug"
	design_ids += "s12g_incinslug"
	design_ids += "s12g_buckshot"
	design_ids += "c457_casing"
	. = ..()

/datum/techweb_node/syndicate_basic/New()
	design_ids += "s12g_magnum"
	design_ids += "s12g_express"
	design_ids += "s12g_antitide"
	. = ..()
