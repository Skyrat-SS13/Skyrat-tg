#define FUNGUS_STAGE_ONE 1
#define FUNGUS_STAGE_TWO 2
#define FUNGUS_STAGE_MAX 3

/datum/component/wall_fungus
	/// How far has the fungus progressed on the affected wall? Percentage.
	var/progression_percent = 0
	/// How many percent do we increase each subsystem fire?
	var/progression_step_amount = 1
	/// What stage are we at?
	var/progression_stage = FUNGUS_STAGE_ONE
	/// Our overlay icon file
	var/overlay_icon_file = 'modular_skyrat/modules/wall_fungus/icons/wall_fungus_overlay.dmi'
	/// How likely are we to spread to another wall?
	var/spread_chance = 5
	/// How far can we spread?
	var/spread_distance = 3 // Tiles
	/// A reference to our parent wall.
	var/turf/closed/wall/parent_wall

/datum/component/wall_fungus/Initialize()
	if(!iswallturf(parent))
		return COMPONENT_INCOMPATIBLE

	parent_wall = parent

	parent_wall.update_overlays()

	START_PROCESSING(SSobj, src)

/datum/component/wall_fungus/Destroy(force, silent)
	parent_wall?.update_overlays()
	return ..()

/datum/component/wall_fungus/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(apply_fungus_overlay))
	RegisterSignal(parent, COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_WELDER), PROC_REF(secondary_tool_act))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(examine))

/datum/component/wall_fungus/process(delta_time)
	if(prob(spread_chance * delta_time))
		spread_to_nearby_wall()

	if(progression_stage >= FUNGUS_STAGE_MAX)
		collapse_parent_structure()
		return

	progression_percent += progression_step_amount * delta_time

	if(progression_percent >= 100)
		progression_stage++
		parent_wall.update_overlays()

/// We kill the wall once we have progressed far enough.
/datum/component/wall_fungus/proc/collapse_parent_structure()
	STOP_PROCESSING(SSobj, src)
	parent_wall.dismantle_wall()
	// When we're deleted, we null this, so that we don't try to interact with a deleted wall.
	parent_wall = null
	qdel(src)

/datum/component/wall_fungus/proc/spread_to_nearby_wall()
	var/list/walls_to_pick_from = list()
	for(var/turf/closed/wall/iterating_wall in RANGE_TURFS(3, parent_wall))
		walls_to_pick_from += iterating_wall

	var/turf/closed/wall/picked_wall = pick(walls_to_pick_from)

	picked_wall.AddComponent(/datum/component/wall_fungus)

/// Gives people an idea of how badly the wall is infected.
/datum/component/wall_fungus/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_green("[parent_wall] is infected with some kind of fungus!")

/datum/component/wall_fungus/proc/apply_fungus_overlay(atom/parent_atom, list/overlays)
	SIGNAL_HANDLER
	overlays += image(overlay_icon_file, "fungus_stage_[progression_stage]")

/datum/component/wall_fungus/proc/secondary_tool_act(atom/source, mob/user, obj/item/item)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_tool_use), source, user, item)
	return COMPONENT_BLOCK_TOOL_ATTACK

/datum/component/wall_fungus/proc/handle_tool_use(atom/source, mob/user, obj/item/item)
	switch(item.tool_behaviour)
		if(TOOL_WELDER)
			if(!item.tool_start_check(user, amount=5))
				return

			user.balloon_alert(user, "burning off fungus...")

			if(!item.use_tool(source, user, 5 SECONDS))
				return
			user.balloon_alert(user, "burned off fungus")
			qdel(src)


#undef FUNGUS_STAGE_ONE
#undef FUNGUS_STAGE_TWO
#undef FUNGUS_STAGE_MAX
