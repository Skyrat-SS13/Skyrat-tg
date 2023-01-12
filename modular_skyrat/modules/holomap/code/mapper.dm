/obj/item/device/mapping_unit
	name = "mapping unit"
	desc = "A portable mapping unit, capable of locating other similar units on a map. Also has a short-range sonar mapping system."
	description_info = "Use the device in your hand to add the mapping HUD to your screen. You can then power it on and change mapping modes.\
	<br>The device will show other powered-on mapping units on the map, as well as activated mapping beacons, but only of the same 'type' mapping unit.\
	<br>Normal mapping units can only display other normal beacons and mapping units, ERT mapping units can display other ERT, etc."
	icon_state = "mapping_unit"
	item_state = null
	w_class = ITEMSIZE_SMALL

	//Holomap stuff
	var/marker_prefix = "basic"
	var/base_prefix = "basic"
	var/map_color = null
	var/mapper_filter = HOLOMAP_FILTER_STATIONMAP

	var/list/prefix_update_head
	var/list/prefix_update_rig

	// These are local because they are different for every holochip.
	// The maps and icons are all pixel_x and pixel_y'd so we're in the center.
	var/list/map_image_cache = list()
	var/list/icon_image_cache = list()

	var/pinging = FALSE
	var/updating = FALSE
	var/global/icon/mask_icon
	var/obj/screen/mapper/extras_holder/extras_holder
	var/hud_frame_hint

	var/datum/mini_hud/mapper/hud_datum
	var/obj/screen/movable/mapper_holder/hud_item

	var/obj/item/weapon/cell/cell
	var/cell_type = /obj/item/weapon/cell/device
	var/power_usage = 0.5 // Usage per map scan (doubled for ping mode)
	var/uses_power = 1 // If it uses power at all

	var/list/debug_mappers_list
	var/list/debug_beacons_list

/obj/item/device/mapping_unit/deathsquad
	name = "deathsquad mapping unit"
	icon_state = "mapping_unit_ds"
	marker_prefix = "ds"
	mapper_filter = HOLOMAP_FILTER_DEATHSQUAD
	//map_color = "#0B74B4"
	hud_frame_hint = "_ds"

/obj/item/device/mapping_unit/operative
	name = "nuclear operative mapping unit"
	icon_state = "mapping_unit_op"
	marker_prefix = "op"
	mapper_filter = HOLOMAP_FILTER_NUKEOPS
	//map_color = "#13B40B"
	hud_frame_hint = "_op"

/obj/item/device/mapping_unit/ert
	name = "emergency response team mapping unit"
	icon_state = "mapping_unit_ert"
	marker_prefix = "ert"
	mapper_filter = HOLOMAP_FILTER_ERT
	//map_color = "#5FFF28"
	hud_frame_hint = "_ert"

	prefix_update_head = list(
		"/obj/item/clothing/head/helmet/ert/command" = "ertc",
		"/obj/item/clothing/head/helmet/ert/security" = "erts",
		"/obj/item/clothing/head/helmet/ert/engineer" = "erte",
		"/obj/item/clothing/head/helmet/ert/medical" = "ertm",
	)

	prefix_update_rig = list(
		"/obj/item/weapon/rig/ert" = "ertc",
		"/obj/item/weapon/rig/ert/security" = "erts",
		"/obj/item/weapon/rig/ert/engineer" = "erte",
		"/obj/item/weapon/rig/ert/medical" = "ertm"
	)

/obj/item/device/mapping_unit/Initialize()
	. = ..()
	base_prefix = marker_prefix

	if(!mask_icon)
		mask_icon = icon('icons/effects/64x64.dmi', "mapper_mask")

	extras_holder = new()

	var/obj/screen/mapper/marker/mark = new()
	mark.icon = 'icons/effects/64x64.dmi'
	mark.icon_state = "mapper_none"
	mark.layer = 10
	icon_image_cache["bad"] = mark

	var/obj/screen/mapper/map/tmp = new()
	var/icon/canvas = icon(HOLOMAP_ICON, "blank")
	canvas.Crop(1,1,world.maxx,world.maxy)
	canvas.DrawBox("#A7BE97",1,1,world.maxx,world.maxy)
	tmp.icon = icon
	map_image_cache["bad"] = tmp

	if(uses_power && cell_type)
		cell = new cell_type(src)

	debug_mappers_list = mapping_units
	debug_beacons_list = mapping_beacons

/obj/item/device/mapping_unit/Destroy()
	mapping_units -= src

	last_run()

	map_image_cache.Cut()
	icon_image_cache.Cut()
	qdel_null(extras_holder)

	return ..()

/obj/item/device/mapping_unit/dropped(mob/dropper)
	if(loc != dropper) // Not just a juggle
		hide_device()

/obj/item/device/mapping_unit/attack_self(mob/user)
	if(user.stat != CONSCIOUS)
		return

	if(!ishuman(user))
		to_chat(user, "<span class='warning'>Only humanoids can use this device.</span>")
		return

	var/mob/living/carbon/human/H = user

	if(!ishuman(loc) || user != loc)
		to_chat(H, "<span class='warning'>This device needs to be on your person.</span>")

	if(hud_datum?.main_hud)
		hide_device()
		to_chat(H, "<span class='notice'>You put \the [src] away.</span>")
	else
		show_device(H)
		to_chat(H, "<span class='notice'>You hold \the [src] where you can see it.</span>")

/obj/item/device/mapping_unit/attack_hand(mob/user)
	if(cell && user.get_inactive_hand() == src) // click with empty off hand
		to_chat(user,"<span class='notice'>You eject \the [cell] from \the [src].</span>")
		user.put_in_hands(cell)
		cell = null
		if(updating)
			stop_updates()
	else
		return ..()

/obj/item/device/mapping_unit/attackby(obj/W, mob/user)
	if(istype(W,cell_type) && !cell)
		cell = W
		cell.update_icon() //Why doesn't a cell do this already? :|
		user.unEquip(cell)
		cell.forceMove(src)
		to_chat(user,"<span class='notice'>You insert \the [cell] into \the [src].</span>")


/obj/item/device/mapping_unit/proc/first_run(mob/user)
	hud_datum = new(user.hud_used, src)
	hud_item = hud_datum.screenobjs[1]

/obj/item/device/mapping_unit/proc/show_device(mob/user)
	if(!hud_datum)
		first_run(user)
	else
		hud_datum.apply_to_hud(user.hud_used)

/obj/item/device/mapping_unit/proc/start_updates()
	mapping_units += src
	updating = TRUE
	START_PROCESSING(SSobj, src)
	process()



/obj/item/device/mapping_unit/proc/stop_updates()
	mapping_units -= src
	STOP_PROCESSING(SSobj, src)
	updating = FALSE
	if(hud_item)
		hud_item.off(FALSE)

/obj/item/device/mapping_unit/proc/hide_device()
	hud_datum?.unapply_to_hud()

/obj/item/device/mapping_unit/proc/last_run()
	stop_updates()
	if(!QDELETED(hud_datum))
		qdel(hud_datum)
	hud_datum = null
	hud_item = null


/obj/item/device/mapping_unit/process()
	if(!updating || (uses_power && !cell))
		stop_updates()
		return

	if(uses_power)
		var/power_to_use = pinging ? power_usage*2 : power_usage
		if(cell.use(power_to_use) != power_to_use) // we weren't able to use our full power_usage amount!
			visible_message("<span class='warning'>\The [src] flickers before going dull.</span>")
			stop_updates()
			return

	if(!hud_item || !hud_datum)
		log_error("Mapping device tried to update with missing hud_item or hud_datum")
		stop_updates()
		last_run()
		return

	update_holomap()

#define HOLOMAP_ERROR	0
#define HOLOMAP_YOU		1
#define HOLOMAP_OTHER	2
#define HOLOMAP_DEAD	3

/obj/item/device/mapping_unit/proc/update_holomap()
	var/turf/T = get_turf(src)
	if(!T)//nullspace begone!
		stop_updates()
		return

	var/T_x = T.x // Used many times, just grab it to avoid derefs
	var/T_y = T.y
	var/T_z = T.z

	var/obj/screen/mapper/map/bgmap
	var/list/extras = list()

	var/map_cache_key = "[T_z]"
	var/badmap = FALSE
	if(!pinging && using_map && !(T_z in using_map.mappable_levels))
		map_cache_key = "bad"
		badmap = TRUE

	// Cache miss
	if(!(map_cache_key in map_image_cache))
		var/mutable_appearance/map_app = new()
		map_app.appearance_flags = PIXEL_SCALE
		map_app.plane = PLANE_HOLOMAP
		map_app.layer = HUD_LAYER
		map_app.color = map_color

		if(!SSholomaps.holomaps["[T_z]"])
			var/obj/screen/mapper/map/baddo = map_image_cache["bad"]
			map_app.icon = icon(baddo.icon)
			badmap = TRUE
		// SSholomaps did map it and we're allowed to see it
		else
			map_app.icon = icon(SSholomaps.holomaps["[T.z]"])

			// Apply markers
			for(var/marker in holomap_markers)
				var/datum/holomap_marker/holomarker = holomap_markers[marker]
				if(holomarker.z == T_z && holomarker.filter & mapper_filter)
					var/image/markerImage = image(holomarker.icon,holomarker.id)
					markerImage.plane = FLOAT_PLANE
					markerImage.layer = FLOAT_LAYER
					markerImage.appearance_flags = RESET_COLOR|PIXEL_SCALE
					markerImage.pixel_x = holomarker.x+holomarker.offset_x
					markerImage.pixel_y = holomarker.y+holomarker.offset_y
					map_app.add_overlay(markerImage)

			var/obj/screen/mapper/map/tmp = new()
			tmp.appearance = map_app
			map_image_cache[map_cache_key] = tmp

	bgmap = map_image_cache[map_cache_key]

	// The holomap moves around, the user is always in the center. This slides the holomap.
	var/offset_x = bgmap.offset_x
	var/offset_y = bgmap.offset_y
	extras_holder.pixel_x = bgmap.pixel_x = -1*T_x + offset_x
	extras_holder.pixel_y = bgmap.pixel_y = -1*T_y + offset_y

	// Populate other mapper icons
	for(var/obj/item/device/mapping_unit/HC as anything in mapping_units)
		if(HC.mapper_filter != mapper_filter)
			continue
		var/mob_indicator = HOLOMAP_ERROR
		var/turf/TU = get_turf(HC)
		// Mapper not on a turf or elsewhere
		if(!TU || (TU.z != T_z))
			continue

		// We're the marker
		if(HC == src)
			mob_indicator = HOLOMAP_YOU

		// The marker is held by a borg
		else if(isrobot(HC.loc))
			var/mob/living/silicon/robot/R = HC.loc
			if(R.stat == DEAD)
				mob_indicator = HOLOMAP_DEAD
			else
				mob_indicator = HOLOMAP_OTHER

		// The marker is worn by a human
		else if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			if(H.stat == DEAD)
				mob_indicator = HOLOMAP_DEAD
			else
				mob_indicator = HOLOMAP_OTHER

		// It's not attached to anything useful
		else
			mob_indicator = HOLOMAP_DEAD

		// Ask it to update it's icon based on helmet (or whatever)
		HC.update_marker()

		// Generate the icon and apply it to the list of images to show the client
		if(mob_indicator != HOLOMAP_ERROR)

			// This is so specific because the icons are pixel_x and pixel_y only relative to OUR view of where THEY are relative to us
			var/marker_cache_key = "\ref[HC]_[HC.marker_prefix]_[mob_indicator]"

			if(!(marker_cache_key in icon_image_cache))
				var/obj/screen/mapper/marker/mark = new()
				mark.icon_state = "[HC.marker_prefix][mob_indicator]"
				icon_image_cache[marker_cache_key] = mark
				switch(mob_indicator)
					if(HOLOMAP_YOU)
						mark.layer = 3 // Above the other markers
					if(HOLOMAP_DEAD)
						mark.layer = 2
					else
						mark.layer = 1

			var/obj/screen/mapper/marker/mark = icon_image_cache[marker_cache_key]
			handle_marker(mark,TU.x,TU.y)
			extras += mark

	// Marker beacon items
	for(var/obj/item/device/holomap_beacon/HB as anything in mapping_beacons)
		if(HB.mapper_filter != mapper_filter)
			continue

		var/turf/TB = get_turf(HB)
		// Marker beacon not on a turf or elsewhere
		if(!TB || (TB.z != T_z))
			continue

		var/marker_cache_key = "\ref[HB]_marker"
		if(!(marker_cache_key in icon_image_cache))
			var/obj/screen/mapper/marker/mark = new()
			mark.icon_state = "beacon"
			mark.layer = 1
			icon_image_cache[marker_cache_key] = mark

		var/obj/screen/mapper/marker/mark = icon_image_cache[marker_cache_key]
		handle_marker(mark,TB.x,TB.y)
		extras += mark

	if(badmap)
		var/obj/O = icon_image_cache["bad"]
		O.pixel_x = T_x - offset_x
		O.pixel_y = T_y - offset_y
		extras += O

	extras_holder.filters = filter(type = "alpha", icon = mask_icon, x = T_x-(offset_x*0.5), y = T_y-(offset_y*0.5))
	extras_holder.vis_contents = extras

	hud_item.update(bgmap, extras_holder, badmap ? FALSE : pinging)

/obj/item/device/mapping_unit/proc/update_marker()
	marker_prefix = base_prefix
	if (prefix_update_head)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			var/obj/item/helmet = H.get_equipped_item(slot_head)
			if(helmet && ("[helmet.type]" in prefix_update_head))
				marker_prefix = prefix_update_head["[helmet.type]"]
				return
	if (prefix_update_rig)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			var/obj/item/weapon/rig = H.get_rig()
			if(rig && ("[rig.type]" in prefix_update_rig))
				marker_prefix = prefix_update_rig["[rig.type]"]
				return

/obj/item/device/mapping_unit/proc/handle_marker(var/atom/movable/marker,var/TU_x,var/TU_y)
	marker.pixel_x = TU_x - 8 //16x16 icons, so to center.
	marker.pixel_y = TU_y - 8
	animate(marker, alpha = 0, time = 5, easing = SINE_EASING)
	animate(alpha = 255, time = 2, easing = SINE_EASING)

/obj/item/device/holomap_beacon
	name = "holomap beacon"
	desc = "When active, the beacon will show itself on mapping units of the same type."
	icon_state = "holochip"
	w_class = ITEMSIZE_TINY
	var/mapper_filter = HOLOMAP_FILTER_STATIONMAP
	var/in_list = FALSE

/obj/item/device/holomap_beacon/Initialize()
	. = ..()
	if(in_list) // mapped in turned on
		in_list = TRUE
		mapping_beacons += src
		icon_state = initial(icon_state) + in_list ? "_on" : ""

/obj/item/device/holomap_beacon/attack_self(mob/user)
	if(!in_list)
		in_list = TRUE
		mapping_beacons += src
	else
		in_list = FALSE
		mapping_beacons -= src
	icon_state = "[initial(icon_state)][in_list ? "_on" : ""]"
	to_chat(user,SPAN_NOTICE("The [src] is now [in_list ? "broadcasting" : "disabled"]."))

/obj/item/device/holomap_beacon/Destroy()
	if(in_list)
		mapping_beacons -= src
	return ..()

/obj/item/device/holomap_beacon/deathsquad
	name = "deathsquad holomap beacon"
	icon_state = "holochip_ds"
	mapper_filter = HOLOMAP_FILTER_DEATHSQUAD

/obj/item/device/holomap_beacon/operative
	name = "operative holomap beacon"
	icon_state = "holochip_op"
	mapper_filter = HOLOMAP_FILTER_NUKEOPS

/obj/item/device/holomap_beacon/ert
	name = "ert holomap beacon"
	icon_state = "holochip_ert"
	mapper_filter = HOLOMAP_FILTER_ERT


#undef HOLOMAP_ERROR
#undef HOLOMAP_YOU
#undef HOLOMAP_OTHER
#undef HOLOMAP_DEAD


/datum/holomap_marker
	var/x
	var/y
	var/z
	var/offset_x = -8
	var/offset_y = -8
	var/filter
	var/id // used for icon_state of the marker on maps
	var/icon = 'modular_skyrat/modules/holomap/icons/holomap_markers.dmi'
	var/color //used by path rune markers

/obj/effect/landmark/holomarker
	var/filter = HOLOMAP_FILTER_STATIONMAP
	var/id = "generic"

/obj/effect/landmark/holomarker/Initialize()
	. = ..()
	var/datum/holomap_marker/holomarker = new()
	holomarker.id = id
	holomarker.filter = filter
	holomarker.x = src.x
	holomarker.y = src.y
	holomarker.z = src.z
	GLOB.holomap_markers["[id]_\ref[src]"] = holomarker
