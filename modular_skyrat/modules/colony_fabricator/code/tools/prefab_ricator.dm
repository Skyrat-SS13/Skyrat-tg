/obj/item/rsf/colony_lathe
	name = "\improper Rapid-Prefab-Fabricator"
	desc = "A device used to rapidly deploy structures for 'temporary' construction. \
		While these <b>are</b> supposed to be temporary, they are a common sight in many \
		old structures in many long-standing colonies across known space."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	inhand_icon_state = "analyzer"
	matter = 200
	max_matter = 200
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	cost_by_item = list(
		/turf/open/floor/plating = 1,
		/obj/structure/railing = 1,
		/obj/structure/lattice/catwalk/colony_lathe = 1,
		/turf/closed/wall/prefab_plastic = 5,
		/obj/machinery/door/poddoor/shutters/colony_fabricator/preopen = 20,
		/obj/machinery/door/airlock/colony_prefab = 10,
	)
	matter_by_item = list(
		/obj/item/rcd_ammo = 100,
	)
	action_type = "Fabricating"
	/// How long our do_after is if we're building walls or doors
	var/blocker_do_after = 3 SECONDS
	/// The list of open turfs we can place platings on
	var/static/list/turfs_we_can_plate = list(
		/turf/open/chasm,
		/turf/open/lava,
		/turf/open/misc,
		/turf/open/openspace,
		/turf/open/space,
	)
	/// The types that the blocker_do_after will be applied to
	var/static/list/things_we_delay_placing = list(
		/turf/closed,
		/obj/machinery/door,
	)
	/// List of stuff that we rotate the same way that the user is turned when we place
	var/static/list/stuff_we_rotate = list(
		/obj/structure/railing,
	)

/obj/item/rsf/colony_lathe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/rsf/colony_lathe/afterattack(atom/attacking_atom, mob/user, proximity)
	if(cooldown > world.time)
		return
	. = ..()
	if(!proximity)
		return .
	. |= AFTERATTACK_PROCESSED_ITEM
	var/dir_we_use = user.dir
	if(!is_allowed(attacking_atom, user, dir_we_use))
		return .
	if(is_type_in_list(to_dispense, things_we_delay_placing))
		if(!do_after(user, blocker_do_after))
			return .
	if(use_matter(dispense_cost, user))//If we can charge that amount of charge, we do so and return true
		playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
		if(isturf(to_dispense))
			var/turf/turf_we_work_on = get_turf(attacking_atom)
			turf_we_work_on.place_on_top(to_dispense)
		else
			var/atom/meme = new to_dispense(get_turf(attacking_atom))
			if(is_type_in_list(meme, stuff_we_rotate))
				meme.setDir(dir_we_use)
		cooldown = world.time + cooldowndelay
	return .

/obj/item/rsf/colony_lathe/is_allowed(atom/to_check, mob/user, dir_we_use)
	if(is_type_in_list(to_dispense, list(/turf/open/floor/plating, /obj/structure/lattice,)))
		if(!is_type_in_list(get_turf(to_check), turfs_we_can_plate))
			user.balloon_alert(user, "must be viable terrain to plate")
			return FALSE
		return TRUE
	if(is_type_in_list(to_dispense, list(/turf/closed/wall, /obj/machinery/door)))
		var/turf/target_turf = get_turf(to_check)
		if(istype(target_turf, /turf/open/floor))
			user.balloon_alert(user, "must be placed on constructed floor")
			return FALSE
		if(target_turf.is_blocked_turf(TRUE))
			user.balloon_alert(user, "location must not be blocked")
			return FALSE
		return TRUE
	if(istype(to_dispense, /obj/structure/railing))
		if(!valid_build_direction(get_turf(to_check), dir_we_use, FALSE))
			user.balloon_alert(user, "railing direction blocked")
			return FALSE
		var/turf/railing_target = get_turf(to_check)
		if(railing_target.is_blocked_turf(TRUE))
			user.balloon_alert(user, "location must not be blocked")
			return FALSE
		if(is_type_in_typecache(railing_target, GLOB.turfs_without_ground))
			user.balloon_alert(user, "must be placed on solid ground")
			return FALSE
		return TRUE
	return FALSE
