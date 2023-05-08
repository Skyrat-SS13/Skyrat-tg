/obj/machinery/griddle/primitive
	name = "stone griddle"
	desc = "Even before the advent of electricity, the usage of pans is for pansies. This one even has a cutout for putting soup pots on. Still, no pans allowed."
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/stone_kitchen_machines.dmi'
	use_power = FALSE

	max_items = 6 // Max items is slightly reduced because there's a spot for a soup pot to be put on

	/// List of three preset material soup pots to pick from
	var/static/list/soup_pot_types_to_use = list(
		/obj/item/reagent_containers/cup/soup_pot/material/fake_copper,
		/obj/item/reagent_containers/cup/soup_pot/material/fake_brass,
		/obj/item/reagent_containers/cup/soup_pot/material/fake_tin,
	)

/obj/machinery/griddle/primitive/Initialize(mapload)
	. = ..()

	/// A random soup pot type we pick from the given list of possible types
	var/random_soup_pot = pick(soup_pot_types_to_use)
	AddComponent(/datum/component/stove, container_x = -5, container_y = 14, spawn_container = new random_soup_pot)
