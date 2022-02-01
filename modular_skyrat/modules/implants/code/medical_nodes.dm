/datum/techweb_node/cyber_implants
	design_ids = list("ci-nutriment", "ci-scanner", "ci-breather", "ci-gloweyes", "ci-welding", "ci-medhud", "ci-sechud", "ci-diaghud", "ci-botany", "ci-janitor", "ci-lighter")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/adv_cyber_implants
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/combat_cyber_implants
	design_ids = list("ci-nv", "ci-antidrop", "ci-antistun", "ci-antisleep", "ci-thrusters", "ci-mantis", "ci-flash")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 12000)

/datum/techweb_node/combat_optics
	id = "combat_optics"
	display_name = "Advanced Optical Combat Implants"
	description = "Game-changing replacements for the human eye. WARNING: Unadapted brains are highly vulnerable to electromagnetic feedback."
	prereq_ids = list("adv_cyber_implants","weaponry","NVGtech","high_efficiency", "combat_cyber_implants")
	design_ids = list("ci-xray", "ci-thermals")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 63000) //requires a solid ~20 minutes of uninterrupted passive research point gain plus experiments
	required_experiments = list(/datum/experiment/explosion/maxcap,
		/datum/experiment/scanning/points/machinery_tiered_scan/tier2_lathes,
		/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_capacitors,
		/datum/experiment/scanning/points/machinery_pinpoint_scan/tier3_microlaser,
		)
