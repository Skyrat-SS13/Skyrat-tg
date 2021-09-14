/turf/closed/wall/concrete
	name = "concrete wall"
	desc = "A dense slab of reinforced stone, not much will get through this."
	icon = 'modular_skyrat/modules/overmap/icons/concrete_wall.dmi'
	icon_state = "concrete_wall-0"
	base_icon_state = "concrete_wall"
	girder_type = /obj/structure/girder/reinforced
	hardness = 10
	explosion_block = 2
	rad_insulation = RAD_HEAVY_INSULATION

/turf/closed/wall/concrete/deconstruction_hints(mob/user)
	return "<span class='notice'>Nothing's going to cut that.</span>"

/turf/closed/wall/concrete/try_decon(obj/item/I, mob/user, turf/T)
	if(I.tool_behaviour == TOOL_WELDER)
		to_chat(user, "<span class='warning'>This wall is way too hard to cut through!</span>")
	return FALSE
