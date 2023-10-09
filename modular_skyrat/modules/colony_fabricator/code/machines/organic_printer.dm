#define RND_CATEGORY_AKHTER_CLOTHING "Equipment"

/obj/machinery/biogenerator/organic_printer
	name = "organic materials printer"
	desc = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		reagents and items of use that a fabricator can't make. While the exact designs these machines have differs from \
		location to location, and upon who designed them, this one should be able to at the very least provide you with \
		some clothing, basic food supplies, and whatever else you may require."
	icon = 'modular_skyrat/modules/food_replicator/icons/biogenerator.dmi'
	circuit = null
	anchored = FALSE
	efficiency = 1.25
	productivity = 0.75
	show_categories = list(
		RND_CATEGORY_NRI_FOOD,
		RND_CATEGORY_NRI_MEDICAL,
		RND_CATEGORY_NRI_CLOTHING,
	)

/obj/machinery/biogenerator/organic_printer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/repackable, repacked_type, 5 SECONDS)
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/biogenerator/organic_printer/RefreshParts()
	. = ..()
	efficiency = 1.25
	productivity = 0.75

/obj/machinery/biogenerator/organic_printer/default_deconstruction_crowbar()
	return

/obj/machinery/biogenerator/organic_printer/spawns_anchored
	anchored = TRUE
