/**
 * Corrupted flesh basetype(abstract)
 */
/obj/structure/corrupted_flesh
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_structures.dmi'
	icon_state = "infected_machine"
	anchored = TRUE
	/// A reference to our controller.
	var/datum/weakref/our_controller
	/// Do we require wireweed to be on our location? If so, and there is no weed, we take damage passively.
	var/requires_wireweed = TRUE
	/// Do we add the corruption component?
	var/uses_component = TRUE

	/// Component toggles, used to determine how the component is added.
	var/component_react_to_damage = TRUE
	var/component_use_overlays = TRUE
	var/component_update_name = TRUE
	var/component_update_light = TRUE
	var/component_update_examine = TRUE
	var/component_handle_ui_interaction = TRUE
	var/component_handle_destruction = TRUE
	var/component_updates_power_use = TRUE

/obj/structure/corrupted_flesh/Initialize(mapload)
	. = ..()
	if(uses_component)
		AddComponent(/datum/component/corruption, \
			component_react_to_damage, \
			component_use_overlays, \
			component_update_name, \
			component_update_light, \
			component_update_examine, \
			component_handle_ui_interaction, \
			component_handle_destruction, \
			component_updates_power_use \
		)

/**
 * Wireweed
 *
 * These are the arteries of the corrupted flesh, they are required for spreading and support machine life.
 */
/obj/structure/corrupted_flesh/wireweed
	name = "wireweed"
	desc = "A strange pulsating mass of organic wires."
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/wireweed_floor.dmi'
	icon_state = "wires-0"
	base_icon_state = "wires"
	anchored = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WIREWEED)
	canSmoothWith = list(SMOOTH_GROUP_WIREWEED)
	uses_component = FALSE

/obj/structure/corrupted_flesh/wireweed/update_icon(updates)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & (SMOOTH_BITMASK)))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)


