/datum/wires/syndicatebomb
	holder_type = /obj/machinery/syndicatebomb
	proper_name = "Syndicate Explosive Device"
	randomize = TRUE

/datum/wires/syndicatebomb/New(atom/holder)
	wires = list(
		WIRE_BOOM, WIRE_BOOM2, WIRE_UNBOLT,
		WIRE_ACTIVATE, WIRE_DELAY, WIRE_PROCEED
	)
	..()

/datum/wires/syndicatebomb/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/syndicatebomb/P = holder
	if(P.open_panel)
		return TRUE

/datum/wires/syndicatebomb/on_pulse(wire)
	var/obj/machinery/syndicatebomb/B = holder
	switch(wire)
		if(WIRE_BOOM,WIRE_BOOM2)
			if(B.active)
				holder.visible_message(span_danger("[icon2html(B, viewers(holder))] An alarm sounds! It's go-"))
				B.explode_now = TRUE
				if(!istype(B.payload, /obj/machinery/syndicatebomb/training))
					tell_admins(B)
					// Cursed usr use but no easy way to get the pulser
					if(isliving(usr))
						add_memory_in_range(B, 7, /datum/memory/bomb_defuse_failure, protagonist = usr, antagonist = B)

			else
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] Nothing happens."))

		if(WIRE_UNBOLT)
			holder.visible_message(span_notice("[icon2html(B, viewers(holder))] The bolts spin in place for a moment."))

		if(WIRE_DELAY)
			if(B.delayedbig)
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] Nothing happens."))
			else
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] The bomb chirps."))
				playsound(B, 'sound/machines/chime.ogg', 30, TRUE)
				B.detonation_timer += 300
				if(B.active)
					B.delayedbig = TRUE

		if(WIRE_PROCEED)
			holder.visible_message(span_danger("[icon2html(B, viewers(holder))] The bomb buzzes ominously!"))
			playsound(B, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			var/seconds = B.seconds_remaining()
			if(seconds >= 61) // Long fuse bombs can suddenly become more dangerous if you tinker with them.
				B.detonation_timer = world.time + 600
			else if(seconds >= 21)
				B.detonation_timer -= 100
			else if(seconds >= 11) // Both to prevent negative timers and to have a little mercy.
				B.detonation_timer = world.time + 100

		if(WIRE_ACTIVATE)
			if(!B.active)
				holder.visible_message(span_danger("[icon2html(B, viewers(holder))] You hear the bomb start ticking!"))
				B.activate()
				B.update_appearance()
			else if(B.delayedlittle)
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] Nothing happens."))
			else
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] The bomb seems to hesitate for a moment."))
				B.detonation_timer += 100
				B.delayedlittle = TRUE

/datum/wires/syndicatebomb/on_cut(wire, mend, source)
	var/obj/machinery/syndicatebomb/B = holder
	switch(wire)
		if(WIRE_BOOM,WIRE_BOOM2)
			if(!mend && B.active)
				holder.visible_message(span_danger("[icon2html(B, viewers(holder))] An alarm sounds! It's go-"))
				B.explode_now = TRUE
				if(!istype(B.payload, /obj/machinery/syndicatebomb/training))
					tell_admins(B)
					if(isliving(source))
						log_combat(source, holder, "cut the detonation wire for")
						add_memory_in_range(B, 7, /datum/memory/bomb_defuse_failure, protagonist = source, antagonist = B)

		if(WIRE_UNBOLT)
			if(!mend && B.anchored)
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] The bolts lift out of the ground!"))
				playsound(B, 'sound/effects/stealthoff.ogg', 30, TRUE)
				B.set_anchored(FALSE)

		if(WIRE_PROCEED)
			if(!mend && B.active)
				holder.visible_message(span_danger("[icon2html(B, viewers(holder))] The digital display on the device deactivates."))
				B.examinable_countdown = FALSE


		if(WIRE_ACTIVATE)
			if(!mend && B.active)
				var/bomb_time_left = B.seconds_remaining()
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] The timer stops! The bomb has been defused!"))
				B.active = FALSE
				B.delayedlittle = FALSE
				B.delayedbig = FALSE
				B.examinable_countdown = TRUE
				B.update_appearance()
				if(isliving(usr))
					add_memory_in_range(B, 7, /datum/memory/bomb_defuse_success, protagonist = usr, antagonist = B, bomb_time_left = bomb_time_left)

/datum/wires/syndicatebomb/proc/tell_admins(obj/machinery/syndicatebomb/B)
	var/turf/T = get_turf(B)
	log_game("\A [B] was detonated via boom wire at [AREACOORD(T)].")
	message_admins("A [B.name] was detonated via boom wire at [ADMIN_VERBOSEJMP(T)].")
