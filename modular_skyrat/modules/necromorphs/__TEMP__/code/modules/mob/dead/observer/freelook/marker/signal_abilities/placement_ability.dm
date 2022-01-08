
/datum/signal_ability/placement
	energy_cost = 300
	targeting_method	=	TARGET_PLACEMENT
	base_type = /datum/signal_ability/placement
	autotarget_range = 0
	placement_snap = TRUE



	require_corruption = TRUE

/datum/signal_ability/placement/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/atom/movable/A = new placement_atom(target)
	if (LAZYACCESS(data, "direction"))
		A.set_dir(data["direction"])
	return A





/*
	Corruption Node Variant
*/
//Variant for placing corruption nodes
/datum/signal_ability/placement/corruption
	base_type = /datum/signal_ability/placement/corruption
	target_string = "any corrupted tile"
	marker_active_required = TRUE
	LOS_block	=	TRUE

//We'll copy the long description from corruption nodes
/datum/signal_ability/placement/corruption/New()
	.=..()
	if (ispath(placement_atom, /obj/structure/corruption_node))
		var/obj/structure/corruption_node/C = new placement_atom()
		C.biomass = 0
		desc = "<hr>[C.get_long_description()]"
		qdel(C)


/datum/signal_ability/placement/corruption/on_cast(var/mob/user, var/atom/target, var/list/data)
	.=..()
	var/obj/structure/corruption_node/C = .
	if (istype(C))
		C.biomass = 0







/*----------------------------------
	The actual clickhandler
-----------------------------------*/
//Special clickhandler variant used to place ability items
/datum/click_handler/placement/ability
	var/require_corruption = FALSE
	var/LOS_block = TRUE

/datum/click_handler/placement/ability/placement_blocked(var/turf/candidate)
	.=..()
	if (!.)
		if (require_corruption && !turf_corrupted(candidate))
			return "This can only be placed on corrupted tiles."

		for (var/obj/structure/corruption_node/CN in candidate)
			if (CN.placement_location == src.placement_location)
				return "Only one corruption node can be placed per tile."

		if (LOS_block)
			var/mob/M = candidate.is_seen_by_crew()
			if (M)
				return "Placement here is blocked, because [M] can see this tile. Must be placed out of sight"

/datum/click_handler/placement/ability/spawn_result(var/turf/site)
	//We should have done all necessary checks here, so we are clear to proceed
	call_on_place.Invoke(site, list("direction"=dir))	//User is already included as the first argument when the callback was created. Site and data will be 2 and 3









/proc/create_ability_placement_handler(var/mob/_user, var/_result, var/_handler_type = /datum/click_handler/placement, var/snap = FALSE, var/require_corruption = FALSE, var/LOS_block = TRUE, var/datum/callback/C)
	if (!istype(_user))
		return

	var/datum/click_handler/placement/ability/P = _user.PushClickHandler(_handler_type, C)

	P.result_path = _result
	P.snap_to_grid = snap
	P.require_corruption = require_corruption
	P.LOS_block = LOS_block

	P.generate_preview_image(P.result_path)
	P.start_placement()


	winset(_user, "mapwindow.map", "focus=true")
	return P