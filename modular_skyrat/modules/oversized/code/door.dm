/obj/machinery/door/Initialize(mapload)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERING = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	return ..()


/obj/machinery/door/proc/on_entered(datum/source, atom/movable/crossed_atom)
	SIGNAL_HANDLER
	if(HAS_TRAIT(crossed_atom, TRAIT_OVERSIZED) && ishuman(crossed_atom))
		var/mob/living/carbon/human/crossing_human = crossed_atom
		if(crossing_human.m_intent != MOVE_INTENT_WALK && !crossing_human.resting)
			//We gonna bamf you, you tall fucker
			var/affecting = crossing_human.get_bodypart(BODY_ZONE_HEAD)
			crossing_human.apply_damage(15, BRUTE, affecting)
			crossing_human.Knockdown(20)
			crossing_human.visible_message(span_warning("[crossing_human] slams their head into the frame of [src] with a sickening thud!"), \
				span_userdanger("You slam your head against [src]!")
			)
			playsound(src, 'sound/effects/bang.ogg')
