/obj/machinery/fat_sucker
	name = "lipid extractor"
	desc = "Safely and efficiently extracts excess fat from a subject."
	icon = 'icons/obj/machines/fat_sucker.dmi'
	icon_state = "fat"
	circuit = /obj/item/circuitboard/machine/fat_sucker
	state_open = FALSE
	density = TRUE
	req_access = list(ACCESS_KITCHEN)
	var/processing = FALSE
	var/start_at = NUTRITION_LEVEL_WELL_FED
	var/stop_at = NUTRITION_LEVEL_STARVING
	var/free_exit = TRUE //set to false to prevent people from exiting before being completely stripped of fat
	var/bite_size = 7.5 //amount of nutrients we take per second
	var/nutrients //amount of nutrients we got build up
	var/nutrient_to_meat = 90 //one slab of meat gives about 52 nutrition
	var/datum/looping_sound/microwave/soundloop //100% stolen from microwaves
	var/breakout_time = 600

	var/next_fact = 10 //in ticks, so about 20 seconds
	var/static/list/fat_facts = list(\
	"Fats are triglycerides made up of a combination of different building blocks; glycerol and fatty acids.", \
	"Adults should get a recommended 20-35% of their energy intake from fat.", \
	"Being overweight or obese puts you at an increased risk of chronic diseases, such as cardiovascular diseases, metabolic syndrome, type 2 diabetes and some types of cancers.", \
	"Not all fats are bad. A certain amount of fat is an essential part of a healthy balanced diet. " , \
	"Saturated fat should form no more than 11% of your daily calories.", \
	"Unsaturated fat, that is monounsaturated fats, polyunsaturated fats and omega-3 fatty acids, is found in plant foods and fish." \
	)

/obj/machinery/fat_sucker/Initialize(mapload)
	. = ..()
	soundloop = new(src,  FALSE)
	update_appearance()

/obj/machinery/fat_sucker/Destroy()
	QDEL_NULL(soundloop)
	. = ..()

/obj/machinery/fat_sucker/RefreshParts()
	. = ..()
	var/rating = 0
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		rating += micro_laser.tier
	bite_size = initial(bite_size) + rating * 2.5
	nutrient_to_meat = initial(nutrient_to_meat) - rating * 5

/obj/machinery/fat_sucker/examine(mob/user)
	. = ..()
	. += {"[span_notice("Alt-Click to toggle the safety hatch.")]
				[span_notice("Removing [bite_size] nutritional units per operation.")]
				[span_notice("Requires [nutrient_to_meat] nutritional units per meat slab.")]"}

/obj/machinery/fat_sucker/close_machine(mob/user, density_to_set = TRUE)
	if(panel_open)
		to_chat(user, span_warning("You need to close the maintenance hatch first!"))
		return
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(occupant)
		if(!iscarbon(occupant))
			occupant.forceMove(drop_location())
			set_occupant(null)
			return
		to_chat(occupant, span_notice("You enter [src]."))
		addtimer(CALLBACK(src, PROC_REF(start_extracting)), 20, TIMER_OVERRIDE|TIMER_UNIQUE)
		update_appearance()

/obj/machinery/fat_sucker/open_machine(mob/user, density_to_set = FALSE)
	make_meat()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(processing)
		stop()
	..()

/obj/machinery/fat_sucker/container_resist_act(mob/living/user)
	if(!free_exit || state_open)
		to_chat(user, span_notice("The emergency release is not responding! You start pushing against the hull!"))
		user.changeNext_move(CLICK_CD_BREAKOUT)
		user.last_special = world.time + CLICK_CD_BREAKOUT
		user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
			span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"), \
			span_hear("You hear a metallic creaking from [src]."))
		if(do_after(user, breakout_time, target = src, hidden = TRUE))
			if(!user || user.stat != CONSCIOUS || user.loc != src || state_open)
				return
			free_exit = TRUE
			user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
				span_notice("You successfully break out of [src]!"))
			open_machine()
		return
	open_machine()

/obj/machinery/fat_sucker/interact(mob/user)
	if(state_open)
		close_machine()
	else if(!processing || free_exit)
		open_machine()
	else
		to_chat(user, span_warning("The safety hatch has been disabled!"))

/obj/machinery/fat_sucker/click_alt(mob/living/user)
	if(user == occupant)
		to_chat(user, span_warning("You can't reach the controls from inside!"))
		return CLICK_ACTION_BLOCKING
	if(!(obj_flags & EMAGGED) && !allowed(user))
		to_chat(user, span_warning("You lack the required access."))
		return CLICK_ACTION_BLOCKING
	free_exit = !free_exit
	to_chat(user, span_notice("Safety hatch [free_exit ? "unlocked" : "locked"]."))
	return CLICK_ACTION_SUCCESS

/obj/machinery/fat_sucker/update_overlays()
	. = ..()

	if(!state_open)
		if(processing)
			. += "[icon_state]_door_on"
			. += "[icon_state]_stack"
			. += "[icon_state]_smoke"
			. += "[icon_state]_green"
		else
			. += "[icon_state]_door_off"
			if(occupant)
				if(powered())
					. += "[icon_state]_stack"
					. += "[icon_state]_yellow"
			else
				. += "[icon_state]_red"
	else if(powered())
		. += "[icon_state]_red"
	if(panel_open)
		. += "[icon_state]_panel"

/obj/machinery/fat_sucker/process(seconds_per_tick)
	if(!processing)
		return
	if(!powered() || !occupant || !iscarbon(occupant))
		open_machine()
		return

	var/mob/living/carbon/C = occupant
	if(C.nutrition <= stop_at)
		open_machine()
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)
		return
	C.adjust_nutrition(-bite_size * seconds_per_tick)
	nutrients += bite_size * seconds_per_tick

	if(next_fact <= 0)
		next_fact = initial(next_fact)
		say(pick(fat_facts))
		playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)
	else
		next_fact--
	use_energy(active_power_usage * seconds_per_tick)

/obj/machinery/fat_sucker/proc/start_extracting()
	if(state_open || !occupant || processing || !powered())
		return
	if(iscarbon(occupant))
		var/mob/living/carbon/C = occupant
		if(C.nutrition > start_at)
			processing = TRUE
			soundloop.start()
			update_appearance()
			set_light(2, 1, "#ff0000")
		else
			say("Subject not fat enough.")
			playsound(src, 'sound/machines/buzz-sigh.ogg', 40, FALSE)
			overlays += "[icon_state]_red" //throw a red light icon over it, to show that it won't work

/obj/machinery/fat_sucker/proc/stop()
	processing = FALSE
	soundloop.stop()
	set_light(0, 0)

/obj/machinery/fat_sucker/proc/make_meat()
	if(occupant && iscarbon(occupant))
		var/mob/living/carbon/C = occupant
		if(C.type_of_meat)
			if(nutrients >= nutrient_to_meat * 2)
				C.put_in_hands(new /obj/item/food/cookie, del_on_fail = TRUE)
			while(nutrients >= nutrient_to_meat)
				nutrients -= nutrient_to_meat
				var/atom/meat = new C.type_of_meat (drop_location())
				meat.set_custom_materials(list(GET_MATERIAL_REF(/datum/material/meat/mob_meat, C) = SHEET_MATERIAL_AMOUNT * 4))
			while(nutrients >= nutrient_to_meat / 3)
				nutrients -= nutrient_to_meat / 3
				var/atom/meat = new /obj/item/food/meat/rawcutlet/plain (drop_location())
				meat.set_custom_materials(list(GET_MATERIAL_REF(/datum/material/meat/mob_meat, C) = round(SHEET_MATERIAL_AMOUNT * (4/3))))
			nutrients = 0

/obj/machinery/fat_sucker/screwdriver_act(mob/living/user, obj/item/I)
	. = TRUE
	if(..())
		return
	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return
	if(state_open)
		to_chat(user, span_warning("[src] must be closed to [panel_open ? "close" : "open"] its maintenance hatch!"))
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_appearance()
		return
	return FALSE

/obj/machinery/fat_sucker/crowbar_act(mob/living/user, obj/item/I)
	if(default_deconstruction_crowbar(I))
		return TRUE

/obj/machinery/fat_sucker/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	start_at = 100
	stop_at = 0
	to_chat(user, span_notice("You remove the access restrictions and lower the automatic ejection threshold!"))
	obj_flags |= EMAGGED
	return TRUE
