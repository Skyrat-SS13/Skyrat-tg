/*
/obj/item/chrono_eraser
code\game\objects\items\chrono_eraser.dm
*/
#define CHRONO_FRAME_COUNT 22

/datum/smite/thanossnap
	name = "Snap"
	var/desc = "An aura of time-bluespace energy."
	var/mob/living/captured = null
	var/mutable_appearance/mob_underlay
	var/timetokill = 30
	var/RPpos = null
	var/parent

/datum/smite/thanossnap/effect(client/user, mob/living/target)
	. = ..()
	if(target && isliving(target))
		target.forceMove(src)
		captured = target
		var/icon/mob_snapshot = getFlatIcon(target)
		var/icon/cached_icon = new()
		for(var/i in 1 to CHRONO_FRAME_COUNT)
			var/icon/removing_frame = icon('icons/obj/chronos.dmi', "erasing", SOUTH, i)
			var/icon/mob_icon = icon(mob_snapshot)
			mob_icon.Blend(removing_frame, ICON_MULTIPLY)
			cached_icon.Insert(mob_icon, "frame[i]")

		mob_underlay = mutable_appearance(cached_icon, "frame1")
		target.update_appearance()


		desc = initial(desc) + "<br>[span_info("It appears to contain [target.name].")]"
	START_PROCESSING(SSobj, src)
	return ..()

/datum/smite/thanossnap/update_overlays(atom/A)
	. = ..()
	var/ttk_frame = 1 - (timetokill / initial(timetokill))
	ttk_frame = clamp(CEILING(ttk_frame * CHRONO_FRAME_COUNT, 1), 1, CHRONO_FRAME_COUNT)
	if(ttk_frame != RPpos)
		RPpos = ttk_frame
		A.underlays -= mob_underlay
		mob_underlay.icon_state = "frame[RPpos]"
		A.underlays += mob_underlay

/datum/smite/thanossnap/process(delta_time)
	if(captured)
		if(timetokill > initial(timetokill))
			qdel(src)
		else if(timetokill <= 0)
			to_chat(captured, span_boldnotice("As the last essence of your being is erased from time, you are taken back to your most enjoyable memory. You feel happy..."))
			qdel(captured)
			qdel(src)
		else
			captured.Unconscious(80)
			if(captured.loc != src)
				captured.forceMove(src)
			captured.update_appearance()
			timetokill += delta_time
	else
		qdel(src)


#undef CHRONO_FRAME_COUNT
