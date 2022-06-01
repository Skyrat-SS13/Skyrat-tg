/**
 * Corrupted flesh basetype(abstract)
 */
/obj/structure/corrupted_flesh
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_structures.dmi'
	icon_state = "infected_machine"
	anchored = TRUE
	/// Our faction
	var/faction_types = list(FACTION_CORRUPTED_FLESH)
	/// A reference to our controller.
	var/datum/corrupted_flesh_controller/our_controller
	/// The minimum core level for us to spawn at
	var/required_controller_level = CONTROLLER_LEVEL_1
	/// A list of possible rewards for destroying this thing.
	var/list/possible_rewards

/obj/structure/corrupted_flesh/Destroy()
	our_controller = null
	if(possible_rewards)
		var/thing_to_spawn = pick(possible_rewards)
		new thing_to_spawn(get_turf(src))
	return ..()

/**
 * Deletion cleanup
 *
 */
/obj/structure/corrupted_flesh/proc/controller_destroyed(datum/corrupted_flesh_controller/dying_controller, force)
	SIGNAL_HANDLER

	our_controller = null

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
	layer = TABLE_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WIREWEED)
	canSmoothWith = list(SMOOTH_GROUP_WIREWEED, SMOOTH_GROUP_WALLS)
	/// The chance we have to ensnare a mob
	var/ensnare_chance = 15
	/// The amount of damage we do when attacking something.
	var/object_attack_damage = 40
	/// Are we active?
	var/active = FALSE
	/// Are we a vent burrow?
	var/vent_burrow = FALSE

/obj/structure/corrupted_flesh/wireweed/Initialize(mapload, starting_alpha = 255)
	. = ..()
	alpha = starting_alpha
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/corrupted_flesh/wireweed/update_icon(updates)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & (SMOOTH_BITMASK)))
		if(!vent_burrow)
			QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)

/obj/structure/corrupted_flesh/wireweed/update_icon_state()
	. = ..()
	if(vent_burrow)
		icon_state = "vent_burrow"

/obj/structure/corrupted_flesh/wireweed/update_overlays()
	. = ..()
	if(active)
		. += "active"
	for(var/wall_dir in GLOB.cardinals)
		var/turf/new_turf = get_step(src, wall_dir)
		if(new_turf && new_turf.density) // Assume we are a wall!
			var/image/new_wall_overlay = image(icon, icon_state = "wall_hug", dir = wall_dir)
			switch(wall_dir) //offset to make it be on the wall rather than on the floor
				if(NORTH)
					new_wall_overlay.pixel_y = 32
				if(SOUTH)
					new_wall_overlay.pixel_y = -32
				if(EAST)
					new_wall_overlay.pixel_x = 32
				if(WEST)
					new_wall_overlay.pixel_x = -32
			. += new_wall_overlay

/obj/structure/corrupted_flesh/wireweed/proc/visual_finished()
	SIGNAL_HANDLER
	alpha = 255

/obj/structure/corrupted_flesh/wireweed/proc/on_entered(datum/source, atom/movable/moving_atom)
	if(istype(moving_atom, /mob/living/simple_animal) && prob(ensnare_chance))
		var/mob/living/simple_animal/captured_mob = moving_atom
		captured_mob.visible_message(span_danger("[src] ensnares [captured_mob] with some wires!"), span_userdanger("[src] ensnares you!"))
		buckle_mob(captured_mob)


/obj/effect/temp_visual/wireweed_spread
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/wireweed_floor.dmi'
	icon_state = "spread_anim"
	duration = 1.7 SECONDS
