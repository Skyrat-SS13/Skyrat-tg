/obj/item/construction/rcd/arcd/mattermanipulator
	name = "matter manipulator"
	desc = "A strange, familiar yet distinctly different analogue to the Nanotrasen standard RCD. Works at range, and can deconstruct reinforced walls. Reload using metal, glass, or plasteel."
	icon = 'modular_skyrat/master_files/icons/obj/tools.dmi'
	icon_state = "rcd"
	worn_icon_state = "RCD"
	ranged = TRUE
	canRturf = TRUE
	max_matter = 500
	matter = 500
	canRturf = TRUE
	upgrade = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS | RCD_UPGRADE_FURNISHING

/// add the drain design to the plumbing RCD designs list
/obj/item/construction/plumbing/set_plumbing_designs()
	. = ..()
	plumbing_design_types += list(
		/obj/structure/drain = 5,
	)

///overridden to account for special case for the drain which is a structure
/obj/item/construction/plumbing/get_category(obj/recipe)
	if(ispath(recipe, /obj/structure/drain))
		return "Liquids"
	else
		return ..()

/obj/item/construction/plumbing/mining
	name = "mining plumbing constructor"
	desc = "A type of plumbing constructor designed to harvest from geysers and collect their fluids."
	icon_state = "plumberer_mining"

/obj/item/construction/plumbing/mining/set_plumbing_designs()
	plumbing_design_types = list(
		/obj/machinery/duct = 1,
		/obj/machinery/plumbing/input = 5,
		/obj/machinery/plumbing/output = 5,
		/obj/machinery/plumbing/tank = 20,
		/obj/machinery/plumbing/buffer = 10,
		/obj/machinery/plumbing/layer_manifold = 5,
		// Above are the most common machinery which is shown on the first cycle. Keep new additions below THIS line, unless they're probably gonna be needed alot
		/obj/machinery/plumbing/acclimator = 10,
		/obj/machinery/plumbing/bottler = 50,
		/obj/machinery/plumbing/disposer = 10,
		/obj/machinery/plumbing/filter = 5,
		/obj/machinery/plumbing/grinder_chemical = 30,
		/obj/machinery/plumbing/liquid_pump = 35,
		/obj/machinery/plumbing/splitter = 5,
		/obj/machinery/plumbing/sender = 20,
		/obj/structure/drain = 5,
	)
