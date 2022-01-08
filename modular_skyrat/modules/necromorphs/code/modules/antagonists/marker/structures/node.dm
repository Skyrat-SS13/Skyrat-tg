/obj/structure/marker/special/node
	name = "marker node"
	icon = 'icons/mob/blob.dmi'
	icon_state = "blob_node_overlay"
	desc = "A large, pulsating yellow mass."
	max_integrity = MARKER_NODE_MAX_HP
	health_regen = MARKER_NODE_HP_REGEN
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 65, ACID = 90)
	point_return = MARKER_REFUND_NODE_COST
	claim_range = MARKER_NODE_CLAIM_RANGE
	pulse_range = MARKER_NODE_PULSE_RANGE
	expand_range = MARKER_NODE_EXPAND_RANGE
	resistance_flags = LAVA_PROOF
	max_spores = MARKER_NODE_MAX_SLASHERS
	ignore_syncmesh_share = TRUE

/obj/structure/marker/special/node/Initialize()
	GLOB.marker_nodes += src
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/marker/special/node/scannerreport()
	return "Gradually expands and sustains nearby marker spores and markerbernauts."

/obj/structure/marker/special/node/update_icon()
	color = null
	return ..()

/obj/structure/marker/special/node/update_overlays()
	. = ..()
	var/mutable_appearance/marker_overlay = mutable_appearance('icons/mob/blob.dmi', "blob")
	. += marker_overlay
	. += mutable_appearance('icons/mob/blob.dmi', "blob_node_overlay")

/obj/structure/marker/special/node/creation_action()
	if(overmind)
		overmind.node_markers += src

/obj/structure/marker/special/node/Destroy()
	GLOB.marker_nodes -= src
	STOP_PROCESSING(SSobj, src)
	if(overmind)
		overmind.node_markers -= src
	return ..()

/obj/structure/marker/special/node/process(delta_time)
	if(overmind)
		pulse_area(overmind, claim_range, pulse_range, expand_range)
		//reinforce_area(delta_time)
		produce_spores()
