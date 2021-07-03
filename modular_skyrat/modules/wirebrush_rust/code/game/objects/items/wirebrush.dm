/obj/item/wirebrush
	name = "wirebrush"
	desc = "A tool that is used to scrub the rust thoroughly off walls. Not for hair or fur!"
	icon = 'modular_skyrat/modules/wirebrush_rust/icons/obj/wirebrush.dmi'
	icon_state = "wirebrush"
	///variable that determines how long it takes to "clean" (read: replace(?)) rusted walls.
	var/clean_speed = 30 //3 seconds

/obj/item/wirebrush/proc/attempt_clean(c_target, c_user, c_path)
	var/turf/rustedTurf = c_target
	if(!do_after(c_user, clean_speed, target = rustedTurf))
		to_chat(c_user, span_warning("You stop cleaning, leaving the [rustedTurf] still rusty!"))
		return
	rustedTurf.ChangeTurf(c_path)
	playsound(c_user, 'modular_skyrat/modules/wirebrush_rust/sound/items/wirebrush.ogg', 100, TRUE)
	to_chat(c_user, span_notice("You clean \the [rustedTurf]."))
	return

/obj/item/wirebrush/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(get_dist(target, user) > 1)
		return
	if(!isturf(target))
		return
	if(istype(target, /turf/open/floor/plating/rust))
		attempt_clean(target, user, /turf/open/floor/plating)
	else if(istype(target, /turf/closed/wall/rust))
		attempt_clean(target, user, /turf/closed/wall)
	else if(istype(target, /turf/closed/wall/r_wall/rust))
		attempt_clean(target, user, /turf/closed/wall/r_wall)
	else
		to_chat(user, span_warning("You may only use this tool on walls or floors with rust!"))

/obj/item/wirebrush/advanced
	name = "advanced wirebrush"
	desc = "A tool that is slightly better than its basic version; cleans much faster. Not for hair or fur!"
	icon_state = "wirebrush_adv"

	clean_speed = 0 //no wait time essentially
