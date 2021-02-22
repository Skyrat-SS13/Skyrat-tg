/*
	The scry spell allows temporary viewing of a remote location which doesn't have corruption
	It lasts for one minute, and can be cast onto blackspace
*/
/datum/signal_ability/scry
	name = "Scry"
	id = "scry"
	desc = "Reveals a targeted area in a 6 tile radius for a duration of 1 minute. Creates a spooky ethereal glow there too."
	target_string = "any blackspace outside the necrovision network"
	energy_cost = 20
	require_corruption = FALSE
	require_necrovision = FALSE
	autotarget_range = 0

	targeting_method	=	TARGET_CLICK


//Because obscuring overlays block clicks, we have to override here to do things
/datum/signal_ability/scry/target_click(var/mob/user, var/atom/target, var/params)
	var/client/C  = user.get_client()
	if (!C)
		return FALSE //This cannot be

	target = get_turf_at_mouse(params, C)
	return select_target(user, target)

/datum/signal_ability/scry/on_cast(var/mob/user, var/atom/target, var/list/data)
	new /obj/effect/scry_eye(target)
	link_necromorphs_to(SPAN_NOTICE("[user] cast Scry at LINK"), target)


//An invisible object that allows the necrovision to see around it. Deletes itself after 1 minute
/obj/effect/scry_eye
	visualnet_range = 6
	var/lifespan = 1 MINUTE

/obj/effect/scry_eye/Initialize()
	.=..()
	GLOB.necrovision.add_source(src, TRUE, TRUE)	//Add it as a vision source

	set_light(1, 1, 6, 2, COLOR_NECRO_YELLOW)
	QDEL_IN(src, lifespan)

//Prevent it getting blown up
/obj/effect/scry_eye/ex_act()
	return null

/obj/effect/scry_eye/get_visualnet_tiles(var/datum/visualnet/network)

	return trange(visualnet_range, src)