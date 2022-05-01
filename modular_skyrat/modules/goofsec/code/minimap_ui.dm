#define BOUND_MIN_X 1
#define BOUND_MIN_Y 2
#define BOUND_MAX_X 3
#define BOUND_MAX_Y 4

#define COORD_X 1
#define COORD_Y 2

/datum/asset/simple/minimap
	var/name = "minimap"

/datum/asset/simple/minimap/register()
	for(var/datum/game_map/GM as anything in SSminimap.minimaps)
		var/asset = GM.generated_map
		if (!asset)
			to_chat(world, span_warning("No minimap found for [GM.name]!"))
			continue
		asset = fcopy_rsc(asset) //dedupe
		var/asset_name = SANITIZE_FILENAME("minimap.[GM.name].png")
		var/datum/asset_cache_item/ACI = SSassets.transport.register_asset(asset_name, asset)
		ACI.keep_local_name = TRUE
		assets[asset_name] = ACI

/datum/game_map
	var/name
	var/datum/space_level/zlevel
	var/icon/generated_map
	var/list/bounds
	var/icon_size = 8
	var/max_size = 2000

	var/list/coord_data
	var/current_map_url
	var/current_map_md5

/datum/game_map/New(var/datum/space_level/zlevel)
	. = ..()
	src.zlevel = zlevel
	name = replacetext(lowertext(zlevel.name), " ", "_")

/datum/game_map/proc/get_map_bounds()
	var/z_value = zlevel.z_value
	var/minx = world.maxx
	var/miny = world.maxy
	var/maxx = 1
	var/maxy = 1

	for(var/turf/turf_to_check as anything in block(locate(1, 1, z_value), locate(world.maxx, world.maxy, z_value)))
		if(turf_to_check.type == world.turf)
			continue
		minx = min(minx, turf_to_check.x)
		miny = min(miny, turf_to_check.y)
		maxx = max(maxx, turf_to_check.x)
		maxy = max(maxy, turf_to_check.y)

	while(icon_size > 0 && (maxx * icon_size > max_size || maxy * icon_size > max_size))
		icon_size--

	bounds = list(
		BOUND_MIN_X = minx,
		BOUND_MIN_Y = miny,
		BOUND_MAX_X = maxx,
		BOUND_MAX_Y = maxy
	)

/datum/game_map/proc/generate_map()
	// First, we hash the .dmm for the map. This'll tell us if we need to regen.
	var/first_map
	if(istext(SSmapping.config.map_file))
		first_map = SSmapping.config.map_file
	else if(islist(SSmapping.config.map_file))
		first_map = SSmapping.config.map_file[1] // fuck it, use the first map
	var/map_hash = md5filepath("_maps\\[SSmapping.config.map_path]\\[first_map]")
	var/minimap_path = "data\\minimaps\\minimap.[map_hash].[zlevel.z_value].png"
	if(!fexists(minimap_path))
		to_chat(world, span_notice("Generating Z-level [zlevel.z_value]..."))
		generated_map = icon('modular_skyrat/modules/goofsec/icons/minimap_template.dmi', "template")
		var/z_value = zlevel.z_value
		get_map_bounds()
		generated_map.Scale(bounds[BOUND_MAX_X]*icon_size, bounds[BOUND_MAX_Y]*icon_size)

		for(var/turf/turf_to_render as anything in block(\
			locate(bounds[BOUND_MIN_X], bounds[BOUND_MIN_Y], z_value),\
			locate(bounds[BOUND_MAX_X], bounds[BOUND_MAX_Y], z_value)))
			if(turf_to_render.turf_flags & TURF_MINIMAP_HIDE)
				continue

			var/icon/I = getFlatIcon(turf_to_render)
			I.Scale(icon_size, icon_size)
			generated_map.Blend(I, ICON_UNDERLAY,\
				(turf_to_render.x - bounds[BOUND_MIN_X])*icon_size,\
				(turf_to_render.y - bounds[BOUND_MIN_Y])*icon_size)

			for(var/A in turf_to_render)
				var/atom/movable/AM = A
				if((AM.flags_1 & SHOW_ON_MINIMAP_1) && AM.loc == turf_to_render)
					I = getFlatIcon(AM)
					if(!I)
						continue
					I.Scale(\
						icon_size*(I.Width()/world.icon_size), \
						icon_size*(I.Height()/world.icon_size))

					generated_map.Blend(I, ICON_OVERLAY,\
						(turf_to_render.x - bounds[BOUND_MIN_X])*icon_size,\
						(turf_to_render.y - bounds[BOUND_MIN_Y])*icon_size)
			CHECK_TICK

		generated_map = icon(generated_map, frame=1)
		to_chat(world, span_notice("Saving minimap to disk..."))
		fcopy(generated_map, minimap_path)
		to_chat(world, span_notice("Done!"))
	else
		to_chat(world, span_notice("Z-level [zlevel.z_value] already generated!"))
		get_map_bounds()
		generated_map = icon(minimap_path, frame=1)
		to_chat(world, span_notice("Loaded Z-level [zlevel.z_value] minimap from disk!"))
	var/datum/asset_transport/AS = SSassets.transport
	var/asset_md5 = md5filepath(minimap_path)
	var/datum/asset_cache_item/ACI = new(asset_md5, minimap_path)
	ACI.namespace = "minimaps"
	if(istype(AS, /datum/asset_transport/webroot))
		var/datum/asset_transport/webroot/WR = AS
		WR.save_asset_to_webroot(ACI)
	else
		AS.register_asset(asset_md5, ACI)
		current_map_md5 = asset_md5
	current_map_url = AS.get_asset_url(null, ACI)

	// fcopy(generated_map, "[MINIMAP_FILE_DIR][name].dmi")

GLOBAL_LIST_INIT(jobs_to_icon, list(
	"Officer" = "user-secret",
	"Arrest" = "mask",
	"Suspected" = "eye",
	"Tracking" = "bullseye"
))

/datum/game_map/proc/get_data(var/atom/movable/A, var/name, var/icon, var/color)
	return list(list(
		"ref" = REF(A),
		"name" = name,
		"coord" = get_coord(A),
		"icon" = icon,
		"color" = color,
		"width" = A.bound_width/world.icon_size,
		"height" = A.bound_height/world.icon_size,
	))

/datum/game_map/proc/update_map()
	coord_data = list()
	for(var/mob/living/carbon/human/H as anything in GLOB.human_list)
		if(H.z != zlevel.z_value)
			continue
		var/icon_assigned = FALSE
		var/obj/item/clothing/under/uniform = H.w_uniform
		if(!uniform || uniform.has_sensor <= NO_SENSORS || !uniform.sensor_mode || uniform.sensor_mode < SENSOR_COORDS)
			continue
		var/datum/job/job_ref = SSjob.GetJob(H.job)
		if(!job_ref)
			continue
		if((job_ref.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY) && !icon_assigned)
			coord_data += get_data(H, H.name, GLOB.jobs_to_icon["Officer"], "#0026ff")
			icon_assigned = TRUE
			continue
		var/perpname = H.get_face_name(H.get_id_name(""))
		if(perpname && GLOB.data_core)
			var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.security)
			if(R)
				switch(R.fields["criminal"])
					if("*Arrest*")
						icon_assigned = TRUE
						coord_data += get_data(H, perpname, GLOB.jobs_to_icon["Arrest"], "#ff0000")
						continue
					if("Suspected")
						icon_assigned = TRUE
						coord_data += get_data(H, perpname, GLOB.jobs_to_icon["Suspected"], "#ff7b00")
						continue
	for (var/obj/item/implant/tracking/W in GLOB.tracked_implants)
		if(!isliving(W.imp_in))
			continue
		if(W.imp_in.z != zlevel.z_value)
			continue

		coord_data += get_data(W.imp_in, W.imp_in.name, GLOB.jobs_to_icon["Tracking"], "#fbff00")

/datum/game_map/proc/set_generated_map(var/F)
	get_map_bounds()
	generated_map = icon(F)

/datum/game_map/proc/get_coord(var/atom/A)
	. = list(A.x, A.y)


	.[COORD_X] -= bounds[BOUND_MIN_X]-1
	.[COORD_Y] -= bounds[BOUND_MIN_Y]-1


#undef BOUND_MIN_X
#undef BOUND_MIN_Y
#undef BOUND_MAX_X
#undef BOUND_MAX_Y
#undef COORD_X
#undef COORD_Y
