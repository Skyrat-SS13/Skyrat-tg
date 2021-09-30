GLOBAL_LIST_EMPTY(cargo_marks)

/obj/item/cargo_teleporter
	name = "cargo teleporter"
	desc = "An item that can set down a set number of markers, allowing them to teleport items within a tile to the set markers."
	icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	icon_state = "cargo_tele"
	///the list of markers spawned by this item
	var/list/marker_children = list()

	COOLDOWN_DECLARE(use_cooldown)

/obj/item/cargo_teleporter/examine(mob/user)
	. = ..()
	. += span_notice("Attack itself to set down the markers!")
	. += span_notice("ALT-CLICK to remove all markers!")

/obj/item/cargo_teleporter/Destroy()
	if(length(marker_children))
		for(var/obj/effect/decal/cleanable/cargo_mark/destroy_children in marker_children)
			destroy_children.parent_item = null
			qdel(destroy_children)
	. = ..()

/obj/item/cargo_teleporter/attack_self(mob/user, modifiers)
	if(length(marker_children) >= 3)
		to_chat(user, span_warning("You may only have three spawned markers from [src]!"))
		return
	to_chat(user, span_notice("You place a cargo marker below your feet."))
	var/obj/effect/decal/cleanable/cargo_mark/spawned_marker = new /obj/effect/decal/cleanable/cargo_mark(get_turf(src))
	playsound(src, 'sound/machines/click.ogg', 50)
	spawned_marker.parent_item = src
	marker_children += spawned_marker

/obj/item/cargo_teleporter/AltClick(mob/user)
	if(length(marker_children))
		for(var/obj/effect/decal/cleanable/cargo_mark/destroy_children in marker_children)
			destroy_children.parent_item = null
			qdel(destroy_children)

/obj/item/cargo_teleporter/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return ..()
	if(!COOLDOWN_FINISHED(src, use_cooldown))
		to_chat(user, span_warning("[src] is still on cooldown!"))
		return
	var/choice = tgui_input_list(user, "Select which cargo mark to teleport the items to?", "Cargo Mark Selection", GLOB.cargo_marks)
	if(!choice)
		return ..()
	var/turf/moving_turf = get_turf(choice)
	var/area/checking_moveturf = get_area(moving_turf)
	if(checking_moveturf.area_flags & NOTELEPORT)
		return
	var/turf/target_turf = get_turf(target)
	var/area/checking_targetturf = get_area(target_turf)
	if(checking_targetturf.area_flags & NOTELEPORT)
		return
	var/looping_counter = 0
	for(var/check_content in target_turf.contents)
		if(looping_counter >= 11)
			break
		looping_counter++
		if(!ismovable(check_content))
			continue
		var/atom/movable/movable_content = check_content
		if(isliving(movable_content))
			continue
		if(movable_content.anchored)
			continue
		if(!do_after(user, 1 SECONDS, target = target))
			break
		movable_content.forceMove(moving_turf)
		playsound(movable_content, 'sound/magic/Disable_Tech.ogg', 50, 1)
	new /obj/effect/decal/cleanable/ash(target_turf)
	COOLDOWN_START(src, use_cooldown, 15 SECONDS)

/datum/design/cargo_teleporter
	name = "Cargo Teleporter"
	desc = "A wonderful item that can set markers and teleport things to those markers."
	id = "cargotele"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/cargo_teleporter
	materials = list(/datum/material/iron = 500, /datum/material/plastic = 500, /datum/material/uranium = 500)
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/techweb_node/cargo_teleporter
	id = "cargoteleporter"
	display_name = "Cargo Teleporter"
	description = "We can teleport items across long distances, as long as they are not blocked."
	prereq_ids = list("bluespace_basic", "engineering")
	design_ids = list(
		"cargotele",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/obj/effect/decal/cleanable/cargo_mark
	name = "cargo mark"
	desc = "A mark left behind by a cargo teleporter, which allows targeted teleportation."
	icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	icon_state = "marker"
	///the reference to the item that spawned the cargo mark
	var/obj/item/cargo_teleporter/parent_item

	light_range = 1.6
	light_color = COLOR_VIVID_YELLOW

/obj/effect/decal/cleanable/cargo_mark/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/cargo_teleporter))
		to_chat(user, span_notice("You remove [src] using [W]."))
		playsound(src, 'sound/machines/click.ogg', 50)
		qdel(src)
		return
	return ..()

/obj/effect/decal/cleanable/cargo_mark/Destroy()
	if(parent_item)
		parent_item.marker_children -= src
	GLOB.cargo_marks -= src
	. = ..()

/obj/effect/decal/cleanable/cargo_mark/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	var/area/src_area = get_area(src)
	name = "[src_area.name] ([rand(100000,999999)])"
	GLOB.cargo_marks += src
