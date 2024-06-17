/datum/techweb_node/cyber_implants
	design_ids = list(
		"ci-nutriment",
		"ci-scanner",
		"ci-breather",
		"ci-gloweyes",
		"ci-welding",
		"ci-medhud",
		"ci-sechud",
		"ci-diaghud",
		"ci-botany",
		"ci-janitor",
		"ci-lighter",
		"ci-razor",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/adv_cyber_implants
	design_ids = list("ci-nv", "ci-nutrimentplus", "ci-surgery", "ci-toolset")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/techweb_node/cyber/cyber_organs_adv/New()
	design_ids += list("ci-antidrop", "ci-antistun", "ci-antisleep", "ci-thrusters", "ci-mantis", "ci-flash", "ci-reviver")
	return ..()

