/obj/machinery/primitive_stove
	name = "stone stove"
	desc = "You think you'll stick to just putting pots on this, the grill part looks very unsanitary."
	icon = 'modular_skyrat/modules/primitive_cooking_additions/icons/stone_kitchen_machines.dmi'
	icon_state = "stove_off"
	base_icon_state = "stove"
	density = TRUE
	pass_flags_self = PASSMACHINE | LETPASSTHROW
	layer = BELOW_OBJ_LAYER
	use_power = FALSE
	circuit = null
	resistance_flags = FIRE_PROOF

	/// A list of the different soup pots we can spawn with
	var/static/list/random_soup_pot_types = list(
		/obj/item/reagent_containers/cup/soup_pot/material/fake_copper,
		/obj/item/reagent_containers/cup/soup_pot/material/fake_brass,
		/obj/item/reagent_containers/cup/soup_pot/material/fake_tin,
	)

/obj/machinery/primitive_stove/Initialize(mapload)
	. = ..()

	var/random_chosen_soup_pot_type = pick(random_soup_pot_types)

	AddComponent(/datum/component/stove/primitive, container_x = -7, container_y = 7, spawn_container = new random_chosen_soup_pot_type)

/// Stove component subtype with changed visuals and not much else
/datum/component/stove/primitive
	flame_color = "#ff9900"

/datum/component/stove/primitive/on_overlay_update(obj/machinery/source, list/overlays)
	update_smoke()

	var/obj/real_parent = parent

	if(!on)
		real_parent.icon_state = "[real_parent.base_icon_state]_off" // Not an overlay but do you really want me to override a second proc? I don't
		real_parent.set_light(0, 0)
		return

	real_parent.icon_state = "[real_parent.base_icon_state]_on"
	real_parent.set_light(3, 1, LIGHT_COLOR_FIRE)

	overlays += emissive_appearance(real_parent.icon, "[real_parent.base_icon_state]_on_fire_emissive", real_parent, alpha = real_parent.alpha)

	if(!container)
		overlays += emissive_appearance(real_parent.icon, "[real_parent.base_icon_state]_on_hole_emissive", real_parent, alpha = real_parent.alpha)

	// Flames around the pot
	var/mutable_appearance/flames = mutable_appearance(real_parent.icon, "[real_parent.base_icon_state]_on_flame", alpha = real_parent.alpha)
	flames.color = flame_color
	overlays += flames
	overlays += emissive_appearance(real_parent.icon, "[real_parent.base_icon_state]_on_flame", real_parent, alpha = real_parent.alpha)
