#define FUNGUS_STAGE_ONE 1
#define FUNGUS_STAGE_TWO 2
#define FUNGUS_STAGE_THREE 3
#define FUNGUS_STAGE_FOUR 4
#define FUNGUS_STAGE_MAX 5

/**
 * A wall eating mushroom.
 *
 * This mushroom spreads to walls and eats em up! It can be removed with a welder. If left unchecked it will eat the whole wall.
 */
/datum/component/wall_fungus
	/// How far has the fungus progressed on the affected wall? Percentage.
	var/progression_percent = 0
	/// How many percent do we increase each subsystem fire?
	var/progression_step_amount = 0.5
	/// What stage are we at?
	var/progression_stage = FUNGUS_STAGE_ONE
	/// Our overlay icon file
	var/overlay_icon_file = 'modular_skyrat/modules/wall_fungus/icons/wall_fungus_overlay.dmi'
	/// How likely are we to spread to another wall?
	var/spread_chance = 1
	/// How far can we spread?
	var/spread_distance = 3 // Tiles
	/// How likely are we to drop a shroom upon destruction?
	var/drop_chance = 30

/datum/component/wall_fungus/Initialize(override_progression_step_amount, override_spread_chance, override_spread_distance, override_drop_chance)
	if(!iswallturf(parent))
		return COMPONENT_INCOMPATIBLE

	// This stuff enables badminery.
	if(override_progression_step_amount)
		progression_step_amount = override_progression_step_amount
	if(override_spread_chance)
		spread_chance = override_progression_step_amount
	if(override_spread_distance)
		spread_distance = override_spread_distance
	if(override_drop_chance)
		drop_chance = override_drop_chance

	var/turf/closed/wall/parent_wall = parent

	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(apply_fungus_overlay)) // We need to do this here so that the wall shows the infection immediately.

	parent_wall.update_icon(UPDATE_OVERLAYS)

	START_PROCESSING(SSobj, src)

/datum/component/wall_fungus/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_WELDER), PROC_REF(secondary_tool_act))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(examine))
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))

/datum/component/wall_fungus/Destroy(force, silent)
	var/turf/closed/wall/parent_wall = parent
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(parent, list(COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_WELDER), COMSIG_PARENT_EXAMINE, COMSIG_ATOM_UPDATE_OVERLAYS))
	parent_wall.update_icon(UPDATE_OVERLAYS)
	return ..()

/datum/component/wall_fungus/process(seconds_per_tick)
	var/turf/closed/wall/parent_wall = parent
	if(prob(spread_chance * seconds_per_tick))
		spread_to_nearby_wall()

	if(progression_stage > FUNGUS_STAGE_MAX)
		collapse_parent_structure()
		return

	progression_percent += progression_step_amount * seconds_per_tick

	if(progression_percent >= 100)
		progression_percent = 0
		progression_stage++
		spread_to_nearby_wall()
		parent_wall.update_icon(UPDATE_OVERLAYS)

/datum/component/wall_fungus/proc/on_attack_hand(datum/source, mob/living/user)
	SIGNAL_HANDLER

	if(progression_stage < FUNGUS_STAGE_THREE)
		return

	collapse_parent_structure()


/// We kill the wall once we have progressed far enough.
/datum/component/wall_fungus/proc/collapse_parent_structure()
	var/turf/closed/wall/parent_wall = parent
	STOP_PROCESSING(SSobj, src)
	parent_wall.balloon_alert_to_viewers("collapses!")
	parent_wall.dismantle_wall()
	qdel(src)

/datum/component/wall_fungus/proc/spread_to_nearby_wall()
	var/turf/closed/wall/parent_wall = parent
	var/list/walls_to_pick_from = list()
	for(var/turf/closed/wall/iterating_wall in RANGE_TURFS(3, parent_wall))
		if(iterating_wall.GetComponent(/datum/component/wall_fungus))
			continue

		walls_to_pick_from += iterating_wall

	if(!length(walls_to_pick_from))
		return // sad times

	var/turf/closed/wall/picked_wall = pick(walls_to_pick_from)

	picked_wall.AddComponent(/datum/component/wall_fungus, progression_step_amount, spread_chance, spread_distance, drop_chance)

/// Gives people an idea of how badly the wall is infected.
/datum/component/wall_fungus/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/turf/closed/wall/parent_wall = parent
	switch(progression_stage)
		if(FUNGUS_STAGE_ONE)
			examine_list += span_green("[parent_wall] is infected with some kind of fungus!")
		if(FUNGUS_STAGE_TWO)
			examine_list += span_green("[parent_wall] is infected with some kind of fungus, its structure weakened!")
		if(FUNGUS_STAGE_THREE)
			examine_list += span_green("[parent_wall] is infected with some kind of fungus, its structure seriously weakened!")
		if(FUNGUS_STAGE_THREE)
			examine_list += span_green("[parent_wall] is infected with some kind of fungus, its falling apart!")
	examine_list += span_green("Perhaps you could <b>burn</b> it off?")

/datum/component/wall_fungus/proc/apply_fungus_overlay(atom/parent_atom, list/overlays)
	SIGNAL_HANDLER
	overlays +=  mutable_appearance(overlay_icon_file, "fungus_stage_[progression_stage]")

/datum/component/wall_fungus/proc/secondary_tool_act(atom/source, mob/user, obj/item/item)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_tool_use), source, user, item)
	return COMPONENT_BLOCK_TOOL_ATTACK

/// Handles removal of the fungus from a wall.
/datum/component/wall_fungus/proc/handle_tool_use(atom/source, mob/user, obj/item/item)
	var/turf/closed/wall/parent_wall = parent
	switch(item.tool_behaviour)
		if(TOOL_WELDER)
			if(!item.tool_start_check(user, 1))
				return

			user.balloon_alert(user, "burning off fungus...")

			if(!item.use_tool(source, user, (1 * progression_stage) SECONDS, 1, volume = 100))
				return

			user.balloon_alert(user, "burned off fungus")
			if(prob(drop_chance))
				new /obj/item/food/grown/mushroom/wall(parent_wall)
			qdel(src)


#undef FUNGUS_STAGE_ONE
#undef FUNGUS_STAGE_TWO
#undef FUNGUS_STAGE_THREE
#undef FUNGUS_STAGE_FOUR
#undef FUNGUS_STAGE_MAX
