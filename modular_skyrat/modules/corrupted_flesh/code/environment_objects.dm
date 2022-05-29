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

/obj/structure/corrupted_flesh/wireweed/update_icon(updates)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & (SMOOTH_BITMASK)))
		QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)


