GLOBAL_LIST(gang_tags)

/obj/item/toy/crayon/proc/can_claim_for_gang(mob/user, atom/target, datum/antagonist/gang/user_gang)
	var/area/area_gotten = get_area(target)
	if(!area_gotten || (!is_station_level(area_gotten.z)))
		to_chat(user, span_warning("[area_gotten] is unsuitable for tagging."))
		return FALSE

	var/spraying_over = FALSE
	for(var/obj/effect/decal/cleanable/crayon/gang/graffiti in target)
		spraying_over = TRUE
		break

	for(var/obj/machinery/power/apc in target)
		to_chat(user, span_warning("You can't tag an APC."))
		return FALSE

	var/obj/effect/decal/cleanable/crayon/gang/occupying_gang = territory_claimed(area_gotten, user)
	if(occupying_gang && !spraying_over)
		to_chat(user, span_danger(occupying_gang.my_gang == user_gang.my_gang ? "[area_gotten] has already been tagged by our gang!" : "[area_gotten] has already been tagged by a gang! You must find and spray over the old tag instead!"))
		return FALSE

	// stolen from oldgang lmao
	return TRUE

/obj/item/toy/crayon/proc/tag_for_gang(mob/user, atom/target, datum/antagonist/gang/user_gang)
	for(var/obj/effect/decal/cleanable/crayon/gang/old_marking in target)
		qdel(old_marking)
		break

	var/area/territory = get_area(target)

	var/obj/effect/decal/cleanable/crayon/gang/tag = new /obj/effect/decal/cleanable/crayon/gang(target)
	tag.my_gang = user_gang.my_gang
	tag.icon_state = "[user_gang.gang_id]_tag"
	tag.name = "[tag.my_gang.name] gang tag"
	tag.desc = "Looks like someone's claimed this area for [tag.my_gang.name]."
	to_chat(user, span_notice("You tagged [territory] for [tag.my_gang.name]!"))

/obj/item/toy/crayon/proc/territory_claimed(area/territory, mob/user)
	for(var/obj/effect/decal/cleanable/crayon/gang/graffiti in GLOB.gang_tags)
		if(get_area(graffiti) == territory)
			return graffiti

/obj/effect/decal/cleanable/crayon/gang
	name = "Leet Like Jeff K gang tag"
	desc = "Looks like someone's claimed this area for Leet Like Jeff K."
	icon = 'modular_skyrat/modules/families/icons/tags.dmi'
	layer = BELOW_MOB_LAYER
	/// What team gang datum am I hooked to during Families?
	var/datum/team/gang/my_gang

/obj/effect/decal/cleanable/crayon/gang/Initialize(mapload, main, type, e_name, graf_rot, alt_icon = null)
	. = ..()
	LAZYADD(GLOB.gang_tags, src)

/obj/effect/decal/cleanable/crayon/gang/Destroy()
	LAZYREMOVE(GLOB.gang_tags, src)
	return ..()
