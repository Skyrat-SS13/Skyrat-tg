//Research WEB

/datum/techweb_node/xenoarchtools
	id = "xenoarchtools"
	display_name = "Xenoarchaeology Tools"
	description = "Xenoarchaeology tools that are used for xenoarchaeology, who knew."
	prereq_ids = list("base")
	design_ids = list("hammercm1","hammercm2","hammercm3","hammercm4","hammercm5","hammercm6","hammercm15","hammerbrush","xenomeasure","xenobelt","xenorockback","xenominingscanner")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)

/datum/techweb_node/xenoarchmachines
	id = "xenoarchmachines"
	display_name = "Xenoarchaeology Machines"
	description = "Machines that are used to complete your task as Xenoarchaeologists."
	prereq_ids = list("xenoarchtools")
	design_ids = list("xenoarchscanner","xenoarchopenner","xenoarchrecycler")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500)

/datum/techweb_node/advxenoarch
	id = "advxenoarch"
	display_name = "Advanced Xenoarchaeology Tools"
	description = "Tools that can make your excavation and recovering of artifacts easier."
	prereq_ids = list("xenoarchtools")
	design_ids = list("hammercmadv","hammerbrushadv","xenorockbackadv")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
