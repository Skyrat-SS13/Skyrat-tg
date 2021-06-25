/obj/item/wirebrush
	name = "wirebrush"
	desc = "A tool that is used to scrub the rust thoroughly off walls. Not for hair or fur!"
	icon = 'modular_skyrat/modules/wirebrush_rust/icons/obj/wirebrush.dmi'
	icon_state = "wirebrush"
	///variable that determines how long it takes to "clean" (read: replace(?)) rusted walls.
	var/clean_speed = 30 //3 seconds

/obj/item/wirebrush/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(istype(target, /turf/open/floor/plating/rust))
		if(!do_after(user, clean_speed, target = target))
			to_chat(user, span_warning("You stop cleaning, leaving the wall still rusty!"))
			return
		var/turf/open/floor/plating/rustedTurf = target
		rustedTurf.ChangeTurf(/turf/open/floor/plating)
		playsound(user, 'modular_skyrat/modules/wirebrush_rust/sound/items/wirebrush.ogg', 100, TRUE)
		to_chat(user, span_notice("You clean \the [rustedTurf]."))
		return
	if(istype(target, /turf/closed/wall/rust))
		if(!do_after(user, clean_speed, target = target))
			to_chat(user, span_warning("You stop cleaning, leaving the wall still rusty!"))
			return
		var/turf/closed/wall/rustedTurf = target
		rustedTurf.ChangeTurf(/turf/closed/wall)
		playsound(user, 'modular_skyrat/modules/wirebrush_rust/sound/items/wirebrush.ogg', 100, TRUE)
		to_chat(user, span_notice("You clean \the [rustedTurf]."))
		return
	if(istype(target, /turf/closed/wall/r_wall/rust))
		if(!do_after(user, clean_speed, target = target))
			to_chat(user, span_warning("You stop cleaning, leaving the wall still rusty!"))
			return
		var/turf/closed/wall/rustedTurf = target
		rustedTurf.ChangeTurf(/turf/closed/wall/r_wall)
		playsound(user, 'modular_skyrat/modules/wirebrush_rust/sound/items/wirebrush.ogg', 100, TRUE)
		to_chat(user, span_notice("You clean \the [rustedTurf]."))
		return
	to_chat(user, span_warning("You may only use this tool on walls or floors with rust!"))

/obj/item/wirebrush/advanced
	name = "advanced wirebrush"
	desc = "A tool that is slightly better than its basic version; cleans much faster. Not for hair or fur!"
	icon_state = "wirebrush_adv"

	clean_speed = 0 //no wait time essentially
