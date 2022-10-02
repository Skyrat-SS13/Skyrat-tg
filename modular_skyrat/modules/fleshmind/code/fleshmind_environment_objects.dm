/**
 * fleshmind basetype(abstract)
 */
/obj/structure/fleshmind
	icon = 'modular_skyrat/modules/fleshmind/icons/fleshmind_structures.dmi'
	icon_state = "infected_machine"
	anchored = TRUE
	/// Our faction
	var/faction_types = list(FACTION_FLESHMIND)
	/// A reference to our controller.
	var/datum/fleshmind_controller/our_controller
	/// The minimum core level for us to spawn at
	var/required_controller_level = CONTROLLER_LEVEL_1
	/// A list of possible rewards for destroying this thing.
	var/list/possible_rewards

/obj/structure/fleshmind/Destroy()
	our_controller = null
	if(possible_rewards)
		var/thing_to_spawn = pick(possible_rewards)
		new thing_to_spawn(get_turf(src))
	return ..()

/**
 * Deletion cleanup
 *
 */
/obj/structure/fleshmind/proc/controller_destroyed(datum/fleshmind_controller/dying_controller, force)
	SIGNAL_HANDLER

	our_controller = null

/**
 * Wireweed
 *
 * These are the arteries of the fleshmind, they are required for spreading and support machine life.
 */
/obj/structure/fleshmind/wireweed
	name = "wireweed"
	desc = "A strange pulsating mass of organic wires."
	icon = 'modular_skyrat/modules/fleshmind/icons/wireweed_floor.dmi'
	icon_state = "wires-0"
	base_icon_state = "wires"
	anchored = TRUE
	layer = BELOW_OPEN_DOOR_LAYER
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WIREWEED)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WIREWEED)
	max_integrity = 40
	/// The chance we have to ensnare a mob
	var/ensnare_chance = 15
	/// The amount of damage we do when attacking something.
	var/object_attack_damage = 150
	/// Are we active?
	var/active = FALSE
	/// Are we a vent burrow?
	var/vent_burrow = FALSE
	/// ZOnes we passively replace
	var/list/replacement_zones = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/robot,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_leg/robot,
	)

/obj/structure/fleshmind/wireweed/Initialize(mapload, starting_alpha = 255, datum/fleshmind_controller/incoming_controller)
	. = ..()
	alpha = starting_alpha
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	our_controller = incoming_controller

/obj/structure/fleshmind/wireweed/examine(mob/user)
	. = ..()


/obj/structure/fleshmind/wireweed/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	tool.play_tool_sound(src)
	balloon_alert(user, "cutting...")
	if(do_after(user, WIREWEED_WIRECUTTER_KILL_TIME, src))
		if(QDELETED(src))
			return
		balloon_alert(user, "cut!")
		tool.play_tool_sound(src)
		qdel(src)

/obj/structure/fleshmind/wireweed/update_icon(updates)
	. = ..()
	if((updates & UPDATE_SMOOTHING) && (smoothing_flags & (SMOOTH_BITMASK)))
		if(!vent_burrow)
			QUEUE_SMOOTH(src)
		QUEUE_SMOOTH_NEIGHBORS(src)

/obj/structure/fleshmind/wireweed/update_icon_state()
	. = ..()
	if(vent_burrow)
		icon_state = "vent_burrow"

/obj/structure/fleshmind/wireweed/emp_act(severity)
	. = ..()
	switch(severity)
		if(EMP_LIGHT)
			take_damage(20)
		if(EMP_HEAVY)
			take_damage(40)


/obj/structure/fleshmind/wireweed/update_overlays()
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

/obj/structure/fleshmind/wireweed/proc/visual_finished()
	SIGNAL_HANDLER
	alpha = 255

/obj/structure/fleshmind/wireweed/proc/on_entered(datum/source, atom/movable/moving_atom)
	SIGNAL_HANDLER
	if(!isliving(moving_atom))
		return
	var/mob/living/entered_mob = moving_atom
	if(!faction_check(entered_mob.faction, faction_types))
		return
	if(prob(WIREWEED_HEAL_CHANCE))
		entered_mob.heal_overall_damage(WIREWEED_HEAL_AMOUNT, WIREWEED_HEAL_AMOUNT)
		to_chat(entered_mob, span_green("[src] heals you as you cross over it!"))
	if(ishuman(entered_mob) && prob(WIREWEED_REPLACE_BODYPART_CHANCE))
		var/mob/living/carbon/human/human_mob = moving_atom
		for(var/zone as anything in replacement_zones)
			if(human_mob.get_bodypart(zone))
				continue
			var/bodypart_type = replacement_zones[zone]
			var/obj/item/bodypart/new_bodypart = new bodypart_type()
			new_bodypart.replace_limb(human_mob, TRUE)
			human_mob.update_body(TRUE)
			to_chat(human_mob, span_green("[src] shoots a mechanical limb right into your missing limb!"))

/obj/effect/temp_visual/wireweed_spread
	icon = 'modular_skyrat/modules/fleshmind/icons/wireweed_floor.dmi'
	icon_state = "spread_anim"
	duration = 1.7 SECONDS
