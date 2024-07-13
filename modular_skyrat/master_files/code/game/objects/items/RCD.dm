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

// Check for drains - we only want one per tile
/obj/item/construction/plumbing/canPlace(turf/destination)
	if(ispath(blueprint, /obj/structure/drain))
		for(var/obj/structure/drain/other_drain in destination.contents)
			if(istype(other_drain))
				return FALSE
	return ..()

// Drain deconstruction
/obj/item/construction/plumbing/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/structure/drain))
		return ..()
	var/obj/structure/drain/drain_target = interacting_with
	if(do_after(user, 2 SECONDS, target = interacting_with))
		drain_target.deconstruct() //Let's not substract matter
		playsound(get_turf(src), 'sound/machines/click.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/construction/plumbing/mining
	name = "mining plumbing constructor"
	desc = "A type of plumbing constructor designed to harvest from geysers and collect their fluids."
	icon_state = "plumberer_mining"
	var/static/list/mining_design_types = list(
		//category 1 Synthesizers i.e devices which creates , reacts & destroys chemicals
		"Synthesizers" = list(
			/obj/machinery/plumbing/grinder_chemical = 30,
			/obj/machinery/plumbing/liquid_pump = 35, //extracting chemicals from ground is one way of creation
			/obj/machinery/plumbing/disposer = 10,
			/obj/machinery/plumbing/buffer = 10, //creates chemicals as it waits for other buffers containing other chemicals and when mixed creates new chemicals
		),

		//category 2 distributors i.e devices which inject , move around , remove chemicals from the network
		"Distributors" = list(
			/obj/machinery/duct = 1,
			/obj/machinery/plumbing/layer_manifold = 5,
			/obj/machinery/plumbing/input = 5,
			/obj/machinery/plumbing/filter = 5,
			/obj/machinery/plumbing/splitter = 5,
			/obj/machinery/plumbing/sender = 20,
			/obj/machinery/plumbing/output = 5,
		),

		//category 3 Storage i.e devices which stores & makes the processed chemicals ready for consumption
		"Storage" = list(
			/obj/machinery/plumbing/tank = 20,
			/obj/machinery/plumbing/acclimator = 10,
			/obj/machinery/plumbing/bottler = 50,
			/obj/machinery/iv_drip/plumbing = 20
		),

		//category 4 liquids
		"Liquids" = list(
			/obj/structure/drain = 5,
		),
	)

/obj/item/construction/plumbing/mining/Initialize(mapload)
	. = ..()
	plumbing_design_types = mining_design_types

