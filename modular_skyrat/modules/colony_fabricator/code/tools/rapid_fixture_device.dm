// Rapid wallmount creation device

/obj/item/construction/rapid_fixture_device
	name = "Rapid Wall Mounting Device"
	desc = "A device used to rapidly create wallmounts. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon = 'icons/obj/tools.dmi'
	icon_state = "rld"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
	)
	matter = 200
	max_matter = 200
	slot_flags = ITEM_SLOT_BELT
	has_ammobar = FALSE
	banned_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS | RCD_UPGRADE_SILO_LINK | RCD_UPGRADE_FURNISHING | RCD_UPGRADE_ANTI_INTERRUPT | RCD_UPGRADE_NO_FREQUENT_USE_COOLDOWN
	/// What type of mount should we be ready to place?
	var/mount_to_place
	/// The matter cost of making a new wallmount of whatever type
	var/build_cost = 10
	/// How long do we take to construct?
	var/construction_delay = 0.5 SECONDS
	/// Icons for choosing which type of mount to place
	var/static/list/construction_options = list(
		/obj/item/wallframe/airalarm,
		/obj/item/wallframe/apc,
		/obj/item/wallframe/camera,
		/obj/item/wallframe/firealarm,
		/obj/item/wallframe/extinguisher_cabinet,
		/obj/item/wallframe/light_switch,
		/obj/item/wallframe/button,
		/obj/item/wallframe/intercom,
		/obj/item/wallframe/newscaster,
		/obj/item/wallframe/requests_console,
		/obj/item/wallframe/digital_clock,
	)
	/// Holds all of the radial options for the above construction options
	var/list/radial_options
	/// Associates names from the radial options to a path to construct
	var/list/radial_name_to_path

/obj/item/construction/rapid_fixture_device/Initialize(mapload)
	. = ..()
	populate_radial_choice_lists()

/obj/item/construction/rapid_fixture_device/proc/populate_radial_choice_lists()
	if(!length(radial_options) || !length(radial_name_to_path))
		for(var/obj/thing as anything in construction_options)
			radial_name_to_path[initial(thing.name)] = thing
			radial_options[initial(thing.name)] = image(icon = initial(thing.icon), icon_state = initial(thing.icon_state))

/obj/item/construction/rapid_fixture_device/attack_self(mob/user)
	. = ..()

	var/choice = show_radial_menu(
		user,
		src,
		radial_options,
		custom_check = CALLBACK(src, PROC_REF(check_menu), user),
		require_near = TRUE,
		tooltips = TRUE,
	)

	if(!check_menu(user))
		return
	if(!choice)
		return

	mount_to_place = radial_name_to_path[choice]

/obj/item/construction/rapid_fixture_device/afterattack(atom/atom_we_attacked, mob/user)
	. = ..()
	if(!range_check(atom_we_attacked,user))
		return
	var/turf/start = get_turf(src)
	if(!checkResource(build_cost, user))
		return FALSE
	var/beam = user.Beam(atom_we_attacked,icon_state="light_beam", time = construction_delay)
	playsound(loc, 'sound/machines/click.ogg', 50, TRUE)
	playsound(loc, 'sound/effects/light_flicker.ogg', 50, FALSE)

	if(!do_after(user, construction_delay, target = atom_we_attacked))
		qdel(beam)
		return FALSE
	if(!checkResource(build_cost, user))
		return FALSE
	if(!iswallturf(atom_we_attacked))
		return FALSE

	var/turf/open/winner = null
	var/winning_dist = null
	var/skip = FALSE
	for(var/direction in GLOB.cardinals)
		var/turf/target_turf = get_step(atom_we_attacked, direction)
		skip = FALSE

		for(mount_to_place in target_turf)
			skip = TRUE
			break
		if(skip)
			continue
		if(!(isspaceturf(target_turf) || TURF_SHARES(target_turf)))
			continue

		var/x0 = target_turf.x
		var/y0 = target_turf.y
		var/contender = CHEAP_HYPOTENUSE(start.x, start.y, x0, y0)

		if(!winner)
			winner = target_turf
			winning_dist = contender
		else if(contender < winning_dist) // lower is better
			winner = target_turf
			winning_dist = contender

	if(!winner)
		balloon_alert(user, "no valid target!")
		return FALSE

	if(!useResource(build_cost, user))
		return FALSE

	activate()

	var/obj/item/wallframe/new_mount = new mount_to_place(get_turf(winner))
	var/turf/target_wall = atom_we_attacked
	new_mount.attach(target_wall, user)
	return TRUE
